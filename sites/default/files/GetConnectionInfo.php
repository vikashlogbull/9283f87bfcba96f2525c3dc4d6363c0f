<?php 
require_once "UtilityClass.php";

class SiteDBDetails extends UtilityClass {
 	
	public function GetSiteDBDetails($environmentid,$siteid,$subsiteid) {

		$db = $this->postgresDBConnection();		
		if (!$db) {
			return json_encode(array("title"=>"Not Found","status_code"=>404,"json_content"=>array('status' => 'ERROR', 'MsgDesc' => 'Failed: Could not connect to database on source server.')));
		}
		
		if($siteid != ""){
			$connectionInfoSQL =<<<EOF
				SELECT 
					x.db_username_secondary,
					x.db_password_secondary,
					x.drupalfolderpath,
					x.gitid,
					x.git_branch_id,
					x.xrefid,
					sr.externalip,
					sftp.username as sftp_username,
					sftp.password as sftp_password,
					sftp.accesstype as sftp_accesstype,
					d.database_name,
					ds.db_external_hostname,
					ds.db_port,
					g.git_url AS private_git_url,
					g.git_username AS private_git_username,
					g.repo_name AS private_git_repo_name,
					g.github_token AS private_git_token,
					gb.hook_is_set AS private_hook_is_set,
					gb.branch_name as private_git_branch,
					gb.connected_to
				FROM 
					epm_xref_site_environment AS x  
				LEFT JOIN 
					epm_database AS d  
				ON 
					d.id = x.database_id
				LEFT JOIN 
					epm_database_server AS ds  
				ON 
					ds.id = d.database_server_id
				LEFT JOIN 
					epm_server AS sr  
				ON 
					sr.serverid = x.serverid
				LEFT JOIN 
					epm_sftp_ssh_accessdetails AS sftp  
				ON 
					sftp.sitexrefid = x.xrefid
				LEFT JOIN 
					epm_git AS g  
				ON 
					g.git_id = x.gitid
				LEFT JOIN 
					epm_git_branch AS gb  
				ON 
					gb.id = x.git_branch_id
				WHERE 
					x.siteid = $siteid AND
					x.environmentid = $environmentid AND
					lower(sftp.accesstype) = 'sftp'
EOF;
		}
		else {
			$connectionInfoSQL =<<<EOF
				SELECT 
					x.db_username_secondary,
					x.db_password_secondary,
					x.subsite_path as drupalfolderpath,
					x.gitid,
					x.git_branch_id,
					xs.xrefid,
					sr.externalip,
					sftp.username as sftp_username,
					sftp.password as sftp_password,
					sftp.accesstype as sftp_accesstype,
					d.database_name,
					ds.db_external_hostname,
					ds.db_port,
					g.git_url AS private_git_url,
					g.git_username AS private_git_username,
					g.repo_name AS private_git_repo_name,
					g.github_token AS private_git_token,
					gb.hook_is_set AS private_hook_is_set,
					gb.branch_name as private_git_branch,
					gb.connected_to
				FROM 
					epm_xref_subsite_environment AS x  
				LEFT JOIN 
					epm_database AS d  
				ON 
					d.id = x.database_id
				LEFT JOIN 
					epm_database_server AS ds  
				ON 
					ds.id = d.database_server_id
				LEFT JOIN 
					epm_server AS sr  
				ON 
					sr.serverid = x.serverid
				LEFT JOIN 
					epm_sub_site AS ss  
				ON 
					ss.subsiteid = x.subsite_id
				LEFT JOIN 
					epm_xref_site_environment AS xs  
				ON 
					xs.siteid = ss.siteid 
				AND
					xs.environmentid = x.environment_id
				LEFT JOIN 
					epm_sftp_ssh_accessdetails AS sftp  
				ON 
					sftp.sitexrefid = xs.xrefid
				LEFT JOIN 
					epm_git AS g  
				ON 
					g.git_id = x.gitid
				LEFT JOIN 
					epm_git_branch AS gb  
				ON 
					gb.id = x.git_branch_id
				WHERE 
					x.subsite_id = $subsiteid AND
					x.environment_id = $environmentid AND
					lower(sftp.accesstype) = 'sftp'
EOF;
		}

		$return = array();
		$connectionInfoResult 	= pg_query($db, $connectionInfoSQL);
		if(pg_num_rows($connectionInfoResult)==0)
			return json_encode(array("title"=>"Not Found","status_code"=>404,"json_content"=>array('status' => 'ERROR', 'MsgDesc' => 'Failed! Unable to get the site details from database.')));
		
		$connectionInfoData = pg_fetch_assoc($connectionInfoResult);
		$xrefid = $connectionInfoData["xrefid"];
		
		$sshInfoSQL =<<<EOF
			SELECT 
				username as ssh_username,
				password as ssh_password 
			FROM 
				epm_sftp_ssh_accessdetails 
			WHERE 
				sitexrefid = $xrefid AND 
				lower(accesstype) = 'ssh'
EOF;

		$sshInfoResult 	= pg_query($db, $sshInfoSQL);
		if(pg_num_rows($sshInfoResult)>0){
			$sshInfoData = pg_fetch_assoc($sshInfoResult);
			$return["ssh_command_line"] = "sshpass -p ".trim($sshInfoData["ssh_password"])." ssh ".trim($sshInfoData["ssh_username"])."@".trim($connectionInfoData["externalip"]);
		}
		else {
			$return["ssh_command_line"] = "";
		}
		
		$return["sftp_username"] = trim($connectionInfoData["sftp_username"]);
		$return["sftp_password"] = trim($connectionInfoData["sftp_password"]);
		$return["sftp_hostname"] = trim($connectionInfoData["externalip"]);
		$return["sftp_port"] 	 = 21;

		/*Fetching DB Details -- Start*/			
		$drupalfolderpath 	= trim($connectionInfoData["drupalfolderpath"]);			
		if($drupalfolderpath == "" || $drupalfolderpath == "/")
			$sites_directory 	= "/";
		else 
			$sites_directory 	= (substr($drupalfolderpath, -1) == "/") ? $drupalfolderpath : $drupalfolderpath."/";
		
		$siteSettingsFilePath	= trim($sites_directory)."/sites/default/settings.php";
		$siteSettingsFilePath	= str_replace(" ","",str_replace(array("//","\\"),"/",$siteSettingsFilePath));

		$DBDetails = array();
		if(file_exists($siteSettingsFilePath)){
			if($file = file($siteSettingsFilePath)){									
				foreach( $file as $line ) {
					if($line[0] === "$"){											
						$DBTitle = strstr($line, '=', true);		
						$match = "$"."databases['default']['default']";											
						if(trim($DBTitle) == $match){
							$DBString = substr(strstr($line, '='), 1, -1);
							$DBArray = explode("(",$DBString);
							$DBArray = explode(")",$DBArray[1]);
							$DBArray = explode(",",$DBArray[0]);
							
							foreach($DBArray as $val){
								$DBElement = explode("=>",$val);
								$DBDetails[trim(trim($DBElement[0]),"'")] = trim(trim($DBElement[1]),"'");
							}
						}
					}
				}
			}
		}
		
		if(isset($DBDetails["database"])) 
			$return["database_name"]		= trim($DBDetails["database"]);
		
		$return["database_username"]		= trim($connectionInfoData["db_username_secondary"]);
		$return["database_password"]		= trim($connectionInfoData["db_password_secondary"]);
		$return["database_host"]			= trim($connectionInfoData["db_external_hostname"]);
		$return["database_port"]			= trim($connectionInfoData["db_port"]);
		
		$return["database_command_line"] 	= "mysql -u ".trim($connectionInfoData["db_username_secondary"])." -p".trim($connectionInfoData["db_password_secondary"])." -h ".trim($connectionInfoData["db_external_hostname"])." -P ".trim($connectionInfoData["db_port"])." ".trim($DBDetails["database"]);
		/*Fetching DB Details -- End*/


		/*
			> If hook is set on private git it means, when the user will update the public git, private git MASTER branch will automatically get updated
			> if hook is set on private git, we will display the public git info to the user
			> if hook is not set on private git Or *environment is not dev , than we will display the private git info
			> * = In case, hook is set then when user updates public git then only master branch of private git get updates, and master branch is only associated with Dev environment
		*/

		// If environment is dev and hook is set on private git, then we will return the public git info
		if($environmentid == 1 && trim($connectionInfoData["private_hook_is_set"]) == "True"){
			$publicGitBranchId = $connectionInfoData["connected_to"];				
			$publicGitInfoSQL =<<<EOF
				SELECT 
					g.git_url AS public_git_url,
					g.git_username AS public_git_username,
					g.repo_name AS public_git_repo_name,
					g.github_token AS public_git_token,
					gb.branch_name as public_git_branch
				FROM 
					epm_git_branch AS gb  
				LEFT JOIN 
					epm_git AS g  
				ON 
					g.git_id = gb.git_id
				WHERE 
					gb.id = $publicGitBranchId
EOF;
			$publicGitInfoResult 			= pg_query($db, $publicGitInfoSQL);
			$publicGitInfoData 				= pg_fetch_assoc($publicGitInfoResult);
			
			$return["git_ssh_clone_url"] 	= "git clone -b ".trim($publicGitInfoData["public_git_branch"])." https://".trim($publicGitInfoData["public_git_username"]).":".trim($publicGitInfoData["public_git_token"])."@github.com/".trim($publicGitInfoData["public_git_username"])."/".trim($publicGitInfoData["public_git_repo_name"]).".git";
		}
		// If environment is not Dev OR hook is not set on private git, then we will return the private git info 
		else{			
			$return["git_ssh_clone_url"] 	= "git clone -b ".trim($connectionInfoData["private_git_branch"])." https://".trim($connectionInfoData["private_git_username"]).":".trim($connectionInfoData["private_git_token"])."@github.com/".trim($connectionInfoData["private_git_username"])."/".trim($connectionInfoData["private_git_repo_name"]).".git";			
		}

		return json_encode(array("title"=>"Success","status_code"=>200,"json_content"=>$return));
	}
}

$environmentid	= (isset($_GET["environmentid"])) 	? $_GET["environmentid"] 	: "";	
$siteid 		= (isset($_GET["siteid"])) 			? $_GET["siteid"] 			: "";
$subsiteid 		= (isset($_GET["subsiteid"])) 		? $_GET["subsiteid"] 		: "";

if($environmentid != "" && ($siteid != "" || $subsiteid != "")){
	$siteDBDetails = new SiteDBDetails();
	echo $siteDBDetails->GetSiteDBDetails($environmentid,$siteid,$subsiteid);
}