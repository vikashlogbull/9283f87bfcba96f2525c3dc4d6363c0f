<?php
require_once "UtilityClass.php";

class ExportFiles extends UtilityClass {
 	
	public function ExportFilesFromSourceServer($target_environmentid, $source_environmentid, $siteid, $sites_directory, $sourceServerID, $sourceServerIP) {

		// Making DB connection
		$db = $this->postgresDBConnection();
		if (!$db) {
			return "Could not connect to database on source server.";
		}	

		$siteSettingsFilePath = $sites_directory."sites/default/settings.php";		
		if (is_dir($sites_directory) && file_exists($siteSettingsFilePath) ){
			chmod($sites_directory,0777);
			$SourceServerDBDetails = $this->ReadDBDetailsFromSettingsDotPHPFile($siteSettingsFilePath);
			if(is_array($SourceServerDBDetails) && sizeof($SourceServerDBDetails)>0 && isset($SourceServerDBDetails["database"])){
				
				$SourceServerFolderPath = $this->ReadVariableTable($SourceServerDBDetails,'file_public_path');
				$SourceServerFolderPath = unserialize($SourceServerFolderPath);
				$SourceServerFolderPath = $sites_directory . $SourceServerFolderPath;				
				
				if(!$SourceServerFolderPath || $SourceServerFolderPath == ""){
					return "Failed! Could not find the source server files path.";
				}
				if(!is_dir($SourceServerFolderPath)){
					return "Failed! Files directory does not exist on source server.";
				}
				if($this->is_dir_empty($SourceServerFolderPath)){
					return "Failed! No files exist to clone.";
				}
				
				$SourceFileZipName = time().'_files.zip';
				
				$sitesDirectoryArray = explode("/",substr($sites_directory,0,-1));
				$sitesFolderName = end($sitesDirectoryArray);

				chmod($SourceServerFolderPath,0777);
				
				if(!$this->CreateZip($SourceServerFolderPath,$SourceFileZipName)){
					return "Failed! ZIP can not be created.";
				}

				if( isset($_SERVER['HTTPS'] ) ) {
					$SourceFileZipURL = "https://".$sourceServerIP.'/API/'.$SourceFileZipName;
				}
				else {
					$SourceFileZipURL = "http://".$sourceServerIP.'/API/'.$SourceFileZipName;
				}
			}
			else {
				return "Failed! Souce environment database not found.";
			}
		}
		else {
			return "Failed! Site does not exist in the given source environment.";
		}

		$targetServerSQL =<<<EOF
		SELECT epm_server.externalip, epm_server.serverid, epm_xref_site_environment.drupalfolderpath from epm_server JOIN epm_xref_site_environment ON epm_xref_site_environment.serverid = epm_server.serverid WHERE epm_xref_site_environment.siteid=$siteid AND epm_xref_site_environment.environmentid=$target_environmentid;
EOF;

		$targetServerResult = pg_query($db, $targetServerSQL);
		if(pg_num_rows($targetServerResult) == 0){
			@unlink($SourceFileZipName);
			return "Failed! No Server exist for the selected site and target environment.";
		}
		
		$targetServerData 	= pg_fetch_assoc($targetServerResult);
		$targetServerIP 	= trim($targetServerData["externalip"]);
		$targetServerID 	= trim($targetServerData["serverid"]);
		$drupalfolderpath 	= trim($targetServerData["drupalfolderpath"]);
		$sites_directory 	= (substr($drupalfolderpath, -1) == "/") ? $drupalfolderpath : $drupalfolderpath."/";

		$serverPath = "http://".$targetServerIP."/API/ImportFiles.php?target_environmentid=".$target_environmentid."&siteid=".$siteid."&sites_directory=".$sites_directory."&targetServerID=".$targetServerID."&targetServerIP=".$targetServerIP."&SourceFileZipPath=".$SourceFileZipURL;
		
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $serverPath); 
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
		$output = curl_exec($ch);
		if(curl_getinfo($ch, CURLINFO_HTTP_CODE) == 404) {
			@unlink($SourceFileZipName);
			return "Failed: Could not connect to target server.";
		}
		curl_close($ch);
		@unlink($SourceFileZipName);
		return $output;
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

$target_environmentid	= (isset($_GET["target_environmentid"])) 	? $_GET["target_environmentid"] 	: "";
$source_environmentid 	= (isset($_GET["source_environmentid"])) 	? $_GET["source_environmentid"] 	: "";
$siteid 				= (isset($_GET["siteid"])) 					? $_GET["siteid"] 					: "";
$sites_directory 		= (isset($_GET["sites_directory"])) 		? $_GET["sites_directory"] 			: "";
$sourceServerID 		= (isset($_GET["sourceServerID"])) 			? $_GET["sourceServerID"] 			: "";
$sourceServerIP 		= (isset($_GET["sourceServerIP"])) 			? $_GET["sourceServerIP"] 			: "";

if($target_environmentid != "" && $source_environmentid != "" && $siteid != "" && $sourceServerID != "" && $sourceServerIP != ""){
	$obj = new ExportFiles();
	echo $obj->ExportFilesFromSourceServer($target_environmentid, $source_environmentid, $siteid, $sites_directory, $sourceServerID, $sourceServerIP);
}