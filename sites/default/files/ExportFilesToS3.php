<?php

require_once "AWS/S3.php";
require_once "UtilityClass.php";

class ExportFilesToS3 extends UtilityClass {
 	
	public function Export($environmentid, $siteid, $subsiteid, $is_backup) {

		// Making DB connection
		$db = $this->postgresDBConnection();
		if (!$db) {
			return 'Failed! Could not connect to database on source server.';
		}
		 
		if($subsiteid == ""){
			$siteSQL =<<<EOF
			SELECT 
				x.database_id,
				x.drupalfolderpath,
				c.awsbucketname,
				e.environmentname,
				s.sitename
			FROM 
				epm_xref_site_environment AS x 
			INNER JOIN 
				epm_sites AS s
			ON
				s.siteid=x.siteid
			INNER JOIN 
				epm_company AS c
			ON
				c.backendcompanyid=s.companyid
			INNER JOIN 
				epm_environment AS e
			ON
				x.environmentid=e.environmentid
			WHERE 
				x.siteid=$siteid AND 
				x.environmentid=$environmentid
EOF;
		}
		else {
			$siteSQL =<<<EOF
			SELECT 
				x.database_id,
				x.subsite_path AS drupalfolderpath,
				c.awsbucketname,
				e.environmentname,
				s.sitename
			FROM 
				epm_xref_subsite_environment AS x 
			INNER JOIN 
				epm_sub_site AS ss
			ON
				ss.subsiteid=x.subsite_id
			INNER JOIN 
				epm_sites AS s
			ON
				s.siteid=ss.siteid
			INNER JOIN 
				epm_company AS c
			ON
				c.backendcompanyid=s.companyid
			INNER JOIN 
				epm_environment AS e
			ON
				x.environment_id=e.environmentid
			WHERE 
				x.subsite_id=$subsiteid AND 
				x.environment_id=$environmentid
EOF;
		}
		
		$siteResult 		= pg_query($db, $siteSQL);
		
		if(pg_num_rows($siteResult)==0){
			return "Failed! Invalid Site ID.";
		}
		
		$siteData			= pg_fetch_assoc($siteResult);
		
		$database_id 		= trim($siteData["database_id"]);
		$BucketName			= trim($siteData["awsbucketname"]);
		$EnvironmentName	= trim($siteData["environmentname"]);	
		$SiteName			= trim($siteData["sitename"]);
		
		if($BucketName == ""){
			return "Failed! Bucket does not exist for the site company.";
		}
		if($EnvironmentName == ""){
			return "Failed! Invalid Environment Id.";
		}
		
		$drupalfolderpath 	= trim($siteData["drupalfolderpath"]);
		$drupalfolderpath 	= (substr($drupalfolderpath, -1) == "/") ? $drupalfolderpath : $drupalfolderpath."/";

		$SettingsDotPHPFile = $drupalfolderpath."sites/default/settings.php";

		$DBDetails = array();
		if(is_dir($drupalfolderpath) && file_exists($SettingsDotPHPFile)){
			$DBDetails = $this->ReadDBDetailsFromSettingsDotPHPFile($SettingsDotPHPFile);	
		}
		
		if(sizeof($DBDetails)==0 || $DBDetails["database"] == "" || $DBDetails["username"] == "" || $DBDetails["password"] == "" || $DBDetails["host"] == ""){
			if($database_id == "" || $database_id == 0){
				return "Failed! Could not connect to DB.";
			}
			$siteDBSQL =<<<EOF
			SELECT d.database_name,d.database_username,d.database_password,ds.db_external_hostname,ds.db_port,ds.db_type FROM epm_database AS d INNER JOIN epm_database_server AS ds ON ds.id=d.database_server_id WHERE d.id = '$database_id';
EOF;
			$siteDBResult	= pg_query($db, $siteDBSQL);
			$siteDBData 	= pg_fetch_assoc($siteDBResult);

			$database 	= $DBDetails["database"] 	= trim($siteDBData["database_name"]);
			$username 	= $DBDetails["username"] 	= trim($siteDBData["database_username"]);
			$password 	= $DBDetails["password"] 	= trim($siteDBData["database_password"]);
			$host 		= $DBDetails["host"] 		= trim($siteDBData["db_external_hostname"]);
			$port 		= $DBDetails["port"] 		= trim($siteDBData["db_port"]);
			$driver 	= $DBDetails["driver"] 		= strtolower(trim($siteDBData["db_type"]));
			$prefix 	= $DBDetails["prefix"] 		= "";
			
			$StepSettings = '$databases[\'default\'][\'default\']';
			$StepSettings .= ' = array(\'database\' => \''.$DBDetails["database"];
			$StepSettings .= '\',\'username\' => \''.$DBDetails["username"];
			$StepSettings .= '\',\'password\' => \''.$DBDetails["password"];
			$StepSettings .= '\',\'host\' => \''.$DBDetails["host"];
			$StepSettings .= '\',\'port\' => \''.$port.'\',\'driver\' => \''.$driver.'\',\'prefix\' => \''.$prefix.'\');';
			
			$site_owner_info = posix_getpwuid(fileowner($drupalfolderpath));
			$site_owner = $site_owner_info["name"];
			exec('sudo chown -R www-data:www-data '.$drupalfolderpath);
			
			exec("cp -r source_files/default.settings.php " . $drupalfolderpath."sites/default/settings.php");			
			$fileappendsetting = fopen($drupalfolderpath."sites/default/settings.php", 'a') or die('Unable to open file!');
			fwrite($fileappendsetting, "\n". $StepSettings);
			fclose($fileappendsetting);

			exec('sudo chown -R '.$site_owner.':'.$site_owner.' '.$drupalfolderpath);
		}

		if(sizeof($DBDetails)==0 || $DBDetails["database"] == "" || $DBDetails["username"] == "" || $DBDetails["password"] == "" || $DBDetails["host"] == ""){
			return "Failed! Could not connect to DB.";
		}
		
		$serverFolderPath = $this->ReadVariableTable($DBDetails,'file_public_path');
		
		if(unserialize($serverFolderPath) == ""){
			return "File path is not set.";
		}
		
		$FilesPath = str_replace("//","/",$drupalfolderpath.unserialize($serverFolderPath));

		$FilesPath = (substr($FilesPath,-1) == "/") ? $FilesPath : $FilesPath."/";
		
		if($this->is_dir_empty($FilesPath)){
			return 0;
			//return "Failed! files are empty.";
		}
		
		$FileZipName = $SiteName.'_'.$EnvironmentName.'_'.date("Y-m-d").'_'.date("h:i:s").'_'.date_default_timezone_get().'_files.zip';
		//$FileZipName = time().'_files.zip';		
		
		$site_owner_info = posix_getpwuid(fileowner($drupalfolderpath));
		$site_owner = $site_owner_info["name"];
		exec('sudo chown -R www-data:www-data '.$drupalfolderpath);
		exec("sudo chmod 777 ".$drupalfolderpath);
		exec("sudo chmod 777 ".$drupalfolderpath.'sites');
		exec("sudo chmod 777 ".$drupalfolderpath.'sites/default');
		exec("sudo chmod 777 ".$FilesPath);
		
		if(!$this->CreateZip($FilesPath,$FileZipName)){
			exec('sudo chown -R '.$site_owner.':'.$site_owner.' '.$drupalfolderpath);
			return "Failed! ZIP can not be created.";
		}
 
		$AWSDetailsSQL =<<<EOF
		SELECT * FROM epm_AWS_access_details;
EOF;
		$AWSDetailsResult	= pg_query($db, $AWSDetailsSQL);
		$AWSDetailsData 	= pg_fetch_assoc($AWSDetailsResult);		
		$S3BucketDetails 	= array("awsAccessKey"=>trim($AWSDetailsData["access_key"]),"awsSecretKey"=>trim($AWSDetailsData["secret_key"]));

		$AWSURI = $siteid."/";
		$AWSURI .= ($subsiteid != "") ? $subsiteid."/" : "";
		$AWSURI .= $EnvironmentName."/";
		$AWSURI .= "drup_file_archive/".$FileZipName;
		
		$AWSLinkArray = $this->UploadFilesOnS3Bucket($S3BucketDetails,$BucketName,$FileZipName, $AWSURI);
		
		exec('sudo chown -R '.$site_owner.':'.$site_owner.' '.$drupalfolderpath);
		@unlink($FileZipName);
		
		if(!is_array($AWSLinkArray)){
			return $error = $AWSLinkArray;
		}
		
		$file_path = $AWSLinkArray["AWSLink"];
		
		$FileDetails = $this->GetAWSFileDetails($S3BucketDetails,$BucketName, $AWSURI);
		
		if(!is_array($FileDetails)){
			return $error = $FileDetails;
		}
		
		$uploaded_timestamp = trim($FileDetails["time"]);
		$filesize 			= trim($FileDetails["size"]);

		if($subsiteid != ""){
			$SQL =<<<EOF
			INSERT INTO public.epm_site_export_details(subsiteid, environmentid, file_type, file_path,uploaded_timestamp,filesize,bucket_name,file_key, is_backup) VALUES ($subsiteid,$environmentid,'files','$file_path',$uploaded_timestamp,'$filesize','$BucketName','$AWSURI','$is_backup') returning id;
EOF;
		}
		else {
			$SQL =<<<EOF
			INSERT INTO public.epm_site_export_details(siteid, environmentid, file_type, file_path,uploaded_timestamp,filesize,bucket_name,file_key, is_backup) VALUES ($siteid,$environmentid,'files','$file_path',$uploaded_timestamp,'$filesize','$BucketName','$AWSURI','$is_backup') returning id;
EOF;
		}

		if($exportSQLResult = pg_query($db, $SQL)){
			$exportSQLData 		= pg_fetch_assoc($exportSQLResult);
			$exportid			= $exportSQLData["id"];
			return $exportid;
		}
		else {
			return "Failed! Error when inserting AWS File details into the local database";
		}
	}

	/* creates a compressed zip file */
	public function CreateZip($folder,$destination) {
		
		// Get real path for our folder
		$rootPath = realpath($folder);

		// Initialize archive object
		$zip = new ZipArchive();
		$zip->open($destination, ZipArchive::CREATE | ZipArchive::OVERWRITE);

		// Create recursive directory iterator
		/** @var SplFileInfo[] $files */
		$files = new RecursiveIteratorIterator(
			new RecursiveDirectoryIterator($rootPath),
			RecursiveIteratorIterator::LEAVES_ONLY
		);

		foreach ($files as $name => $file)
		{
			// Skip directories (they would be added automatically)
			if (!$file->isDir())
			{
				// Get real and relative path for current file
				$filePath = $file->getRealPath();
				$relativePath = substr($filePath, strlen($rootPath) + 1);

				// Add current file to archive
				$zip->addFile($filePath, $relativePath);
			}
		}

		// Zip archive will be created only after closing object
		$zip->close();	
		return true;	
	}

	
	public function UploadFilesOnS3Bucket($S3BucketDetails,$BucketName,$FilesPath, $AWSURI){
		
		//instantiate the class
		$s3 = new S3($S3BucketDetails['awsAccessKey'], $S3BucketDetails['awsSecretKey']);
		if(!$s3){
			return "Failed! Could not connect with AWS";
		}
		
		$s3->putBucket($BucketName);
		
		//Upload to S3		
		if($fileInfo = $s3->putObjectFile($FilesPath, $BucketName, $AWSURI) )
		{
			return array('AWSLink'=>'http://'.$BucketName.'.s3.amazonaws.com/'.$AWSURI);
		}
		else {
			return "Failed! Could not connect to S3";
		}
	}
	
	public function GetAWSFileDetails($S3BucketDetails,$BucketName, $AWSURI){
		$s3 = new S3($S3BucketDetails['awsAccessKey'], $S3BucketDetails['awsSecretKey']);
		if(!$s3){
			return "Failed! Could not connect with AWS";
		}
		return $s3->getObjectInfo($BucketName, $AWSURI);
	}
	
	function is_dir_empty($dir) {
	  if (!is_readable($dir)) return NULL; 
	  $handle = opendir($dir);
	  while (false !== ($entry = readdir($handle))) {
		if ($entry != "." && $entry != "..") {
		  return FALSE;
		}
	  }
	  return TRUE;
	}	
}

$environmentid		= (isset($_GET["environmentid"])) 	? $_GET["environmentid"] 	: "";
$siteid 			= (isset($_GET["siteid"])) 			? $_GET["siteid"] 			: "";
$subsiteid 			= (isset($_GET["subsiteid"])) 		? $_GET["subsiteid"] 		: "";
$is_backup 			= (isset($_GET["is_backup"])) 		? $_GET["is_backup"] 		: 0;


if($environmentid != "" && $siteid != ""){
	$obj = new ExportFilesToS3();
	echo $obj->Export($environmentid, $siteid, $subsiteid,$is_backup);
}