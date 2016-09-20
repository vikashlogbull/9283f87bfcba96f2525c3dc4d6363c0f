



CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';


INSERT INTO actions VALUES
("comment_publish_action","comment","comment_publish_action","","Publish comment"),
("comment_save_action","comment","comment_save_action","","Save comment"),
("comment_unpublish_action","comment","comment_unpublish_action","","Unpublish comment"),
("node_make_sticky_action","node","node_make_sticky_action","","Make content sticky"),
("node_make_unsticky_action","node","node_make_unsticky_action","","Make content unsticky"),
("node_promote_action","node","node_promote_action","","Promote content to front page"),
("node_publish_action","node","node_publish_action","","Publish content"),
("node_save_action","node","node_save_action","","Save content"),
("node_unpromote_action","node","node_unpromote_action","","Remove content from front page"),
("node_unpublish_action","node","node_unpublish_action","","Unpublish content"),
("pathauto_node_update_action","node","pathauto_node_update_action","","Update node alias"),
("pathauto_taxonomy_term_update_action","taxonomy_term","pathauto_taxonomy_term_update_action","","Update taxonomy term alias"),
("pathauto_user_update_action","user","pathauto_user_update_action","","Update user alias"),
("system_block_ip_action","user","system_block_ip_action","","Ban IP address of current user"),
("user_block_user_action","user","user_block_user_action","","Block current user");




CREATE TABLE `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';






CREATE TABLE `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';






CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';


INSERT INTO block VALUES
("1","system","main","bartik","1","0","content","0","0","","","-1"),
("2","search","form","bartik","1","-1","sidebar_first","0","0","","","-1"),
("3","node","recent","seven","1","10","dashboard_main","0","0","","","-1"),
("4","user","login","bartik","1","0","sidebar_first","0","0","","","-1"),
("5","system","navigation","bartik","1","0","sidebar_first","0","0","","","-1"),
("6","system","powered-by","bartik","1","10","footer","0","0","","","-1"),
("7","system","help","bartik","1","0","help","0","0","","","-1"),
("8","system","main","seven","1","0","content","0","0","","","-1"),
("9","system","help","seven","1","0","help","0","0","","","-1"),
("10","user","login","seven","1","10","content","0","0","","","-1"),
("11","user","new","seven","1","0","dashboard_sidebar","0","0","","","-1"),
("12","search","form","seven","1","-10","dashboard_sidebar","0","0","","","-1"),
("13","comment","recent","bartik","0","0","-1","0","0","","","1"),
("14","node","syndicate","bartik","0","0","-1","0","0","","","-1"),
("15","node","recent","bartik","0","0","-1","0","0","","","1"),
("16","shortcut","shortcuts","bartik","0","0","-1","0","0","","","-1"),
("17","system","management","bartik","0","0","-1","0","0","","","-1"),
("18","system","user-menu","bartik","0","0","-1","0","0","","","-1"),
("19","system","main-menu","bartik","0","0","-1","0","0","","","-1"),
("20","user","new","bartik","0","0","-1","0","0","","","1"),
("21","user","online","bartik","0","0","-1","0","0","","","-1"),
("22","comment","recent","seven","1","0","dashboard_inactive","0","0","","","1"),
("23","node","syndicate","seven","0","0","-1","0","0","","","-1"),
("24","shortcut","shortcuts","seven","0","0","-1","0","0","","","-1"),
("25","system","powered-by","seven","0","10","-1","0","0","","","-1"),
("26","system","navigation","seven","0","0","-1","0","0","","","-1"),
("27","system","management","seven","0","0","-1","0","0","","","-1"),
("28","system","user-menu","seven","0","0","-1","0","0","","","-1"),
("29","system","main-menu","seven","0","0","-1","0","0","","","-1"),
("30","user","online","seven","1","0","dashboard_inactive","0","0","","","-1");




CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';






CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';






CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';






CREATE TABLE `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';






CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';






CREATE TABLE `cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';






CREATE TABLE `cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';






CREATE TABLE `cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Field module to store already built...';






CREATE TABLE `cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';






CREATE TABLE `cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';






CREATE TABLE `cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';






CREATE TABLE `cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';






CREATE TABLE `cache_metatag` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the generated meta tag output.';






CREATE TABLE `cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';






CREATE TABLE `cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';






CREATE TABLE `cache_token` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for token information.';






CREATE TABLE `cache_update` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Update module to store information...';






CREATE TABLE `cache_views` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';






CREATE TABLE `cache_views_data` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '1' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for views to store pre-rendered queries,...';






CREATE TABLE `ckeditor_input_format` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'Name of the CKEditor role',
  `format` varchar(128) NOT NULL DEFAULT '' COMMENT 'Drupal filter format ID',
  PRIMARY KEY (`name`,`format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores CKEditor input format assignments';


INSERT INTO ckeditor_input_format VALUES
("Advanced","filtered_html"),
("Full","full_html");




CREATE TABLE `ckeditor_settings` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'Name of the CKEditor profile',
  `settings` text COMMENT 'Profile settings',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores CKEditor profile settings';


INSERT INTO ckeditor_settings VALUES
("Advanced","a:27:{s:11:\"filebrowser\";s:4:\"none\";s:11:\"quickupload\";s:1:\"f\";s:2:\"ss\";s:1:\"2\";s:7:\"filters\";a:1:{s:11:\"filter_html\";i:1;}s:7:\"default\";s:1:\"t\";s:11:\"show_toggle\";s:1:\"t\";s:5:\"popup\";s:1:\"f\";s:7:\"toolbar\";s:596:\"\n[\n    [\'Source\'],\n    [\'Cut\',\'Copy\',\'Paste\',\'PasteText\',\'PasteFromWord\',\'-\',\'SpellChecker\', \'Scayt\'],\n    [\'Undo\',\'Redo\',\'Find\',\'Replace\',\'-\',\'SelectAll\'],\n    [\'Image\',\'Media\',\'Flash\',\'Table\',\'HorizontalRule\',\'Smiley\',\'SpecialChar\'],\n    [\'Maximize\', \'ShowBlocks\'],\n    \'/\',\n    [\'Format\'],\n    [\'Bold\',\'Italic\',\'Underline\',\'Strike\',\'-\',\'Subscript\',\'Superscript\',\'-\',\'RemoveFormat\'],\n    [\'NumberedList\',\'BulletedList\',\'-\',\'Outdent\',\'Indent\',\'Blockquote\'],\n    [\'JustifyLeft\',\'JustifyCenter\',\'JustifyRight\',\'JustifyBlock\',\'-\',\'BidiLtr\',\'BidiRtl\'],\n    [\'Link\',\'Unlink\',\'Anchor\',\'Linkit\']\n]\n    \";s:6:\"expand\";s:1:\"t\";s:5:\"width\";s:4:\"100%\";s:4:\"lang\";s:2:\"en\";s:9:\"auto_lang\";s:1:\"t\";s:18:\"language_direction\";s:7:\"default\";s:10:\"enter_mode\";s:1:\"p\";s:16:\"shift_enter_mode\";s:2:\"br\";s:11:\"font_format\";s:35:\"p;div;pre;address;h1;h2;h3;h4;h5;h6\";s:13:\"format_source\";s:1:\"t\";s:13:\"format_output\";s:1:\"t\";s:17:\"custom_formatting\";s:1:\"f\";s:10:\"formatting\";a:1:{s:25:\"custom_formatting_options\";a:4:{s:6:\"indent\";s:6:\"indent\";s:15:\"breakBeforeOpen\";s:15:\"breakBeforeOpen\";s:14:\"breakAfterOpen\";s:14:\"breakAfterOpen\";s:15:\"breakAfterClose\";s:15:\"breakAfterClose\";}}s:8:\"css_mode\";s:4:\"none\";s:8:\"css_path\";s:0:\"\";s:11:\"user_choose\";s:1:\"f\";s:20:\"ckeditor_load_method\";s:11:\"ckeditor.js\";s:22:\"ckeditor_load_time_out\";i:0;s:17:\"scayt_autoStartup\";s:1:\"f\";s:13:\"html_entities\";s:1:\"f\";}"),
("CKEditor Global Profile","a:1:{s:13:\"ckeditor_path\";s:33:\"//cdn.ckeditor.com/4.5.4/full-all\";}"),
("Full","a:27:{s:11:\"filebrowser\";s:4:\"none\";s:11:\"quickupload\";s:1:\"f\";s:2:\"ss\";s:1:\"2\";s:7:\"filters\";a:0:{}s:7:\"default\";s:1:\"t\";s:11:\"show_toggle\";s:1:\"t\";s:5:\"popup\";s:1:\"f\";s:7:\"toolbar\";s:709:\"\n[\n    [\'Source\'],\n    [\'Cut\',\'Copy\',\'Paste\',\'PasteText\',\'PasteFromWord\',\'-\',\'SpellChecker\', \'Scayt\'],\n    [\'Undo\',\'Redo\',\'Find\',\'Replace\',\'-\',\'SelectAll\'],\n    [\'Image\',\'Media\',\'Flash\',\'Table\',\'HorizontalRule\',\'Smiley\',\'SpecialChar\',\'Iframe\'],\n    \'/\',\n    [\'Bold\',\'Italic\',\'Underline\',\'Strike\',\'-\',\'Subscript\',\'Superscript\',\'-\',\'RemoveFormat\'],\n    [\'NumberedList\',\'BulletedList\',\'-\',\'Outdent\',\'Indent\',\'Blockquote\',\'CreateDiv\'],\n    [\'JustifyLeft\',\'JustifyCenter\',\'JustifyRight\',\'JustifyBlock\',\'-\',\'BidiLtr\',\'BidiRtl\',\'-\',\'Language\'],\n    [\'Link\',\'Unlink\',\'Anchor\',\'Linkit\'],\n    [\'DrupalBreak\'],\n    \'/\',\n    [\'Format\',\'Font\',\'FontSize\'],\n    [\'TextColor\',\'BGColor\'],\n    [\'Maximize\', \'ShowBlocks\']\n]\n    \";s:6:\"expand\";s:1:\"t\";s:5:\"width\";s:4:\"100%\";s:4:\"lang\";s:2:\"en\";s:9:\"auto_lang\";s:1:\"t\";s:18:\"language_direction\";s:7:\"default\";s:10:\"enter_mode\";s:1:\"p\";s:16:\"shift_enter_mode\";s:2:\"br\";s:11:\"font_format\";s:35:\"p;div;pre;address;h1;h2;h3;h4;h5;h6\";s:13:\"format_source\";s:1:\"t\";s:13:\"format_output\";s:1:\"t\";s:17:\"custom_formatting\";s:1:\"f\";s:10:\"formatting\";a:1:{s:25:\"custom_formatting_options\";a:4:{s:6:\"indent\";s:6:\"indent\";s:15:\"breakBeforeOpen\";s:15:\"breakBeforeOpen\";s:14:\"breakAfterOpen\";s:14:\"breakAfterOpen\";s:15:\"breakAfterClose\";s:15:\"breakAfterClose\";}}s:8:\"css_mode\";s:4:\"none\";s:8:\"css_path\";s:0:\"\";s:11:\"user_choose\";s:1:\"f\";s:20:\"ckeditor_load_method\";s:11:\"ckeditor.js\";s:22:\"ckeditor_load_time_out\";i:0;s:17:\"scayt_autoStartup\";s:1:\"f\";s:13:\"html_entities\";s:1:\"f\";}");




CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this comment.',
  PRIMARY KEY (`cid`),
  KEY `comment_status_pid` (`pid`,`status`),
  KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  KEY `comment_uid` (`uid`),
  KEY `comment_nid_language` (`nid`,`language`),
  KEY `comment_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.';






CREATE TABLE `ctools_css_cache` (
  `cid` varchar(128) NOT NULL COMMENT 'The CSS ID this cache object belongs to.',
  `filename` varchar(255) DEFAULT NULL COMMENT 'The filename this CSS is stored in.',
  `css` longtext COMMENT 'CSS being stored.',
  `filter` tinyint(4) DEFAULT NULL COMMENT 'Whether or not this CSS needs to be filtered.',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store CSS that must be non-volatile.';






CREATE TABLE `ctools_object_cache` (
  `sid` varchar(64) NOT NULL COMMENT 'The session ID this cache object belongs to.',
  `name` varchar(128) NOT NULL COMMENT 'The name of the object this cache is attached to.',
  `obj` varchar(128) NOT NULL COMMENT 'The type of the object this cache is attached to; this essentially represents the owner so that several sub-systems can use this cache.',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The time this cache was created or updated.',
  `data` longblob COMMENT 'Serialized data being stored.',
  PRIMARY KEY (`sid`,`obj`,`name`),
  KEY `updated` (`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store objects that are being...';






CREATE TABLE `date_format_locale` (
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';






CREATE TABLE `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';


INSERT INTO date_format_type VALUES
("long","Long","1"),
("medium","Medium","1"),
("short","Short","1");




CREATE TABLE `date_formats` (
  `dfid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';


INSERT INTO date_formats VALUES
("1","Y-m-d H:i","short","1"),
("2","m/d/Y - H:i","short","1"),
("3","d/m/Y - H:i","short","1"),
("4","Y/m/d - H:i","short","1"),
("5","d.m.Y - H:i","short","1"),
("6","m/d/Y - g:ia","short","1"),
("7","d/m/Y - g:ia","short","1"),
("8","Y/m/d - g:ia","short","1"),
("9","M j Y - H:i","short","1"),
("10","j M Y - H:i","short","1"),
("11","Y M j - H:i","short","1"),
("12","M j Y - g:ia","short","1"),
("13","j M Y - g:ia","short","1"),
("14","Y M j - g:ia","short","1"),
("15","D, Y-m-d H:i","medium","1"),
("16","D, m/d/Y - H:i","medium","1"),
("17","D, d/m/Y - H:i","medium","1"),
("18","D, Y/m/d - H:i","medium","1"),
("19","F j, Y - H:i","medium","1"),
("20","j F, Y - H:i","medium","1"),
("21","Y, F j - H:i","medium","1"),
("22","D, m/d/Y - g:ia","medium","1"),
("23","D, d/m/Y - g:ia","medium","1"),
("24","D, Y/m/d - g:ia","medium","1"),
("25","F j, Y - g:ia","medium","1"),
("26","j F Y - g:ia","medium","1"),
("27","Y, F j - g:ia","medium","1"),
("28","j. F Y - G:i","medium","1"),
("29","l, F j, Y - H:i","long","1"),
("30","l, j F, Y - H:i","long","1"),
("31","l, Y,  F j - H:i","long","1"),
("32","l, F j, Y - g:ia","long","1"),
("33","l, j F Y - g:ia","long","1"),
("34","l, Y,  F j - g:ia","long","1"),
("35","l, j. F Y - G:i","long","1");




CREATE TABLE `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


INSERT INTO field_config VALUES
("1","comment_body","text_long","text","1","field_sql_storage","field_sql_storage","1","0","a:6:{s:12:\"entity_types\";a:1:{i:0;s:7:\"comment\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}}","1","0","0"),
("2","body","text_with_summary","text","1","field_sql_storage","field_sql_storage","1","0","a:6:{s:12:\"entity_types\";a:1:{i:0;s:4:\"node\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}}","1","0","0"),
("3","field_tags","taxonomy_term_reference","taxonomy","1","field_sql_storage","field_sql_storage","1","0","a:6:{s:8:\"settings\";a:1:{s:14:\"allowed_values\";a:1:{i:0;a:2:{s:10:\"vocabulary\";s:4:\"tags\";s:6:\"parent\";i:0;}}}s:12:\"entity_types\";a:0:{}s:12:\"translatable\";b:0;s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:3:\"tid\";a:2:{s:5:\"table\";s:18:\"taxonomy_term_data\";s:7:\"columns\";a:1:{s:3:\"tid\";s:3:\"tid\";}}}s:7:\"indexes\";a:1:{s:3:\"tid\";a:1:{i:0;s:3:\"tid\";}}}","-1","0","0"),
("4","field_image","image","image","1","field_sql_storage","field_sql_storage","1","0","a:6:{s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:8:\"settings\";a:2:{s:10:\"uri_scheme\";s:6:\"public\";s:13:\"default_image\";b:0;}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"entity_types\";a:0:{}s:12:\"translatable\";b:0;s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}}}}","1","0","0");




CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;


INSERT INTO field_config_instance VALUES
("1","1","comment_body","comment","comment_node_page","a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}","0"),
("2","2","body","node","page","a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";i:-4;s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}","0"),
("3","1","comment_body","comment","comment_node_article","a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}","0"),
("4","2","body","node","article","a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";i:-4;s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}","0"),
("5","3","field_tags","node","article","a:6:{s:5:\"label\";s:4:\"Tags\";s:11:\"description\";s:63:\"Enter a comma-separated list of words to describe your content.\";s:6:\"widget\";a:4:{s:4:\"type\";s:21:\"taxonomy_autocomplete\";s:6:\"weight\";i:-4;s:8:\"settings\";a:2:{s:4:\"size\";i:60;s:17:\"autocomplete_path\";s:21:\"taxonomy/autocomplete\";}s:6:\"module\";s:8:\"taxonomy\";}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";i:10;s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}s:6:\"teaser\";a:5:{s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";i:10;s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:8:\"required\";b:0;}","0"),
("6","4","field_image","node","article","a:6:{s:5:\"label\";s:5:\"Image\";s:11:\"description\";s:40:\"Upload an image to go with this article.\";s:8:\"required\";b:0;s:8:\"settings\";a:9:{s:14:\"file_directory\";s:11:\"field/image\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";b:1;s:11:\"title_field\";s:0:\"\";s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:11:\"image_image\";s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}s:6:\"weight\";i:-1;s:6:\"module\";s:5:\"image\";}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:5:\"large\";s:10:\"image_link\";s:0:\"\";}s:6:\"weight\";i:-1;s:6:\"module\";s:5:\"image\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:6:\"medium\";s:10:\"image_link\";s:7:\"content\";}s:6:\"weight\";i:-1;s:6:\"module\";s:5:\"image\";}}}","0"),
("7","1","comment_body","comment","comment_node_webform","a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}","0");




CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';






CREATE TABLE `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';






CREATE TABLE `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';






CREATE TABLE `field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';






CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';






CREATE TABLE `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';






CREATE TABLE `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';






CREATE TABLE `field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';






CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';






CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';






CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';


INSERT INTO filter VALUES
("filtered_html","filter","filter_autop","2","1","a:0:{}"),
("filtered_html","filter","filter_html","1","1","a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}"),
("filtered_html","filter","filter_htmlcorrector","10","1","a:0:{}"),
("filtered_html","filter","filter_html_escape","-10","0","a:0:{}"),
("filtered_html","filter","filter_url","0","1","a:1:{s:17:\"filter_url_length\";i:72;}"),
("full_html","filter","filter_autop","1","1","a:0:{}"),
("full_html","filter","filter_html","-10","0","a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}"),
("full_html","filter","filter_htmlcorrector","10","1","a:0:{}"),
("full_html","filter","filter_html_escape","-10","0","a:0:{}"),
("full_html","filter","filter_url","0","1","a:1:{s:17:\"filter_url_length\";i:72;}"),
("plain_text","filter","filter_autop","2","1","a:0:{}"),
("plain_text","filter","filter_html","-10","0","a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}"),
("plain_text","filter","filter_htmlcorrector","10","0","a:0:{}"),
("plain_text","filter","filter_html_escape","0","1","a:0:{}"),
("plain_text","filter","filter_url","1","1","a:1:{s:17:\"filter_url_length\";i:72;}");




CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';


INSERT INTO filter_format VALUES
("filtered_html","Filtered HTML","1","1","0"),
("full_html","Full HTML","1","1","1"),
("plain_text","Plain text","1","1","10");




CREATE TABLE `flood` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';






CREATE TABLE `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';






CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';






CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';






CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';


INSERT INTO menu_custom VALUES
("main-menu","Main menu","The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar."),
("management","Management","The <em>Management</em> menu contains links for administrative tasks."),
("navigation","Navigation","The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules."),
("user-menu","User menu","The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.");




CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB AUTO_INCREMENT=393 DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';


INSERT INTO menu_links VALUES
("management","1","0","admin","admin","Administration","a:0:{}","system","0","0","1","0","9","1","0","1","0","0","0","0","0","0","0","0","0"),
("user-menu","2","0","user","user","User account","a:1:{s:5:\"alter\";b:1;}","system","0","0","0","0","-10","1","0","2","0","0","0","0","0","0","0","0","0"),
("navigation","3","0","comment/%","comment/%","Comment permalink","a:0:{}","system","0","0","1","0","0","1","0","3","0","0","0","0","0","0","0","0","0"),
("navigation","4","0","filter/tips","filter/tips","Compose tips","a:0:{}","system","1","0","1","0","0","1","0","4","0","0","0","0","0","0","0","0","0"),
("navigation","5","0","node/%","node/%","","a:0:{}","system","0","0","0","0","0","1","0","5","0","0","0","0","0","0","0","0","0"),
("navigation","6","0","node/add","node/add","Add content","a:0:{}","system","0","0","1","0","0","1","0","6","0","0","0","0","0","0","0","0","0"),
("management","7","1","admin/appearance","admin/appearance","Appearance","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"Select and configure your themes.\";}}","system","0","0","0","0","-6","2","0","1","7","0","0","0","0","0","0","0","0"),
("management","8","1","admin/config","admin/config","Configuration","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:20:\"Administer settings.\";}}","system","0","0","1","0","0","2","0","1","8","0","0","0","0","0","0","0","0"),
("management","9","1","admin/content","admin/content","Content","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:32:\"Administer content and comments.\";}}","system","0","0","1","0","-10","2","0","1","9","0","0","0","0","0","0","0","0"),
("user-menu","10","2","user/register","user/register","Create new account","a:0:{}","system","-1","0","0","0","0","2","0","2","10","0","0","0","0","0","0","0","0"),
("management","11","1","admin/dashboard","admin/dashboard","Dashboard","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View and customize your dashboard.\";}}","system","0","0","0","0","-15","2","0","1","11","0","0","0","0","0","0","0","0"),
("management","12","1","admin/help","admin/help","Help","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Reference for usage, configuration, and modules.\";}}","system","0","0","0","0","9","2","0","1","12","0","0","0","0","0","0","0","0"),
("management","13","1","admin/index","admin/index","Index","a:0:{}","system","-1","0","0","0","-18","2","0","1","13","0","0","0","0","0","0","0","0"),
("user-menu","14","2","user/login","user/login","Log in","a:0:{}","system","-1","0","0","0","0","2","0","2","14","0","0","0","0","0","0","0","0"),
("user-menu","15","0","user/logout","user/logout","Log out","a:0:{}","system","0","0","0","0","10","1","0","15","0","0","0","0","0","0","0","0","0"),
("management","16","1","admin/modules","admin/modules","Modules","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:26:\"Extend site functionality.\";}}","system","0","0","0","0","-2","2","0","1","16","0","0","0","0","0","0","0","0"),
("navigation","17","0","user/%","user/%","My account","a:0:{}","system","0","0","1","0","0","1","0","17","0","0","0","0","0","0","0","0","0"),
("management","18","1","admin/people","admin/people","People","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Manage user accounts, roles, and permissions.\";}}","system","0","0","0","0","-4","2","0","1","18","0","0","0","0","0","0","0","0"),
("management","19","1","admin/reports","admin/reports","Reports","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View reports, updates, and errors.\";}}","system","0","0","1","0","5","2","0","1","19","0","0","0","0","0","0","0","0"),
("user-menu","20","2","user/password","user/password","Request new password","a:0:{}","system","-1","0","0","0","0","2","0","2","20","0","0","0","0","0","0","0","0"),
("management","21","1","admin/structure","admin/structure","Structure","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Administer blocks, content types, menus, etc.\";}}","system","0","0","1","0","-8","2","0","1","21","0","0","0","0","0","0","0","0"),
("management","22","1","admin/tasks","admin/tasks","Tasks","a:0:{}","system","-1","0","0","0","-20","2","0","1","22","0","0","0","0","0","0","0","0"),
("navigation","23","0","comment/reply/%","comment/reply/%","Add new comment","a:0:{}","system","0","0","0","0","0","1","0","23","0","0","0","0","0","0","0","0","0"),
("navigation","24","3","comment/%/approve","comment/%/approve","Approve","a:0:{}","system","0","0","0","0","1","2","0","3","24","0","0","0","0","0","0","0","0"),
("navigation","25","4","filter/tips/%","filter/tips/%","Compose tips","a:0:{}","system","0","0","0","0","0","2","0","4","25","0","0","0","0","0","0","0","0"),
("navigation","26","3","comment/%/delete","comment/%/delete","Delete","a:0:{}","system","-1","0","0","0","2","2","0","3","26","0","0","0","0","0","0","0","0"),
("navigation","27","3","comment/%/edit","comment/%/edit","Edit","a:0:{}","system","-1","0","0","0","0","2","0","3","27","0","0","0","0","0","0","0","0"),
("navigation","28","0","taxonomy/term/%","taxonomy/term/%","Taxonomy term","a:0:{}","system","0","0","0","0","0","1","0","28","0","0","0","0","0","0","0","0","0"),
("navigation","29","3","comment/%/view","comment/%/view","View comment","a:0:{}","system","-1","0","0","0","-10","2","0","3","29","0","0","0","0","0","0","0","0"),
("management","30","18","admin/people/create","admin/people/create","Add user","a:0:{}","system","-1","0","0","0","0","3","0","1","18","30","0","0","0","0","0","0","0"),
("management","31","21","admin/structure/block","admin/structure/block","Blocks","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:79:\"Configure what block content appears in your site\'s sidebars and other regions.\";}}","system","0","0","1","0","0","3","0","1","21","31","0","0","0","0","0","0","0"),
("navigation","32","17","user/%/cancel","user/%/cancel","Cancel account","a:0:{}","system","0","0","1","0","0","2","0","17","32","0","0","0","0","0","0","0","0"),
("management","33","9","admin/content/comment","admin/content/comment","Comments","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:59:\"List and edit site comments and the comment approval queue.\";}}","system","0","0","0","0","0","3","0","1","9","33","0","0","0","0","0","0","0"),
("management","34","11","admin/dashboard/configure","admin/dashboard/configure","Configure available dashboard blocks","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Configure which blocks can be shown on the dashboard.\";}}","system","-1","0","0","0","0","3","0","1","11","34","0","0","0","0","0","0","0"),
("management","35","9","admin/content/node","admin/content/node","Content","a:0:{}","system","-1","0","0","0","-10","3","0","1","9","35","0","0","0","0","0","0","0"),
("management","36","8","admin/config/content","admin/config/content","Content authoring","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Settings related to formatting and authoring content.\";}}","system","0","0","1","0","-15","3","0","1","8","36","0","0","0","0","0","0","0"),
("management","37","21","admin/structure/types","admin/structure/types","Content types","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:92:\"Manage content types, including default status, front page promotion, comment settings, etc.\";}}","system","0","0","1","0","0","3","0","1","21","37","0","0","0","0","0","0","0"),
("management","38","11","admin/dashboard/customize","admin/dashboard/customize","Customize dashboard","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Customize your dashboard.\";}}","system","-1","0","0","0","0","3","0","1","11","38","0","0","0","0","0","0","0"),
("navigation","39","5","node/%/delete","node/%/delete","Delete","a:0:{}","system","-1","0","0","0","1","2","0","5","39","0","0","0","0","0","0","0","0"),
("management","40","8","admin/config/development","admin/config/development","Development","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Development tools.\";}}","system","0","0","1","0","-10","3","0","1","8","40","0","0","0","0","0","0","0"),
("navigation","41","17","user/%/edit","user/%/edit","Edit","a:0:{}","system","-1","0","0","0","0","2","0","17","41","0","0","0","0","0","0","0","0"),
("navigation","42","5","node/%/edit","node/%/edit","Edit","a:0:{}","system","-1","0","0","0","0","2","0","5","42","0","0","0","0","0","0","0","0"),
("management","43","19","admin/reports/fields","admin/reports/fields","Field list","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Overview of fields on all entity types.\";}}","system","0","0","0","0","0","3","0","1","19","43","0","0","0","0","0","0","0"),
("management","44","16","admin/modules/list","admin/modules/list","List","a:0:{}","system","-1","0","0","0","0","3","0","1","16","44","0","0","0","0","0","0","0"),
("management","45","18","admin/people/people","admin/people/people","List","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:50:\"Find and manage people interacting with your site.\";}}","system","-1","0","0","0","-10","3","0","1","18","45","0","0","0","0","0","0","0"),
("management","46","7","admin/appearance/list","admin/appearance/list","List","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Select and configure your theme\";}}","system","-1","0","0","0","-1","3","0","1","7","46","0","0","0","0","0","0","0"),
("management","47","8","admin/config/media","admin/config/media","Media","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:12:\"Media tools.\";}}","system","0","0","1","0","-10","3","0","1","8","47","0","0","0","0","0","0","0"),
("management","48","21","admin/structure/menu","admin/structure/menu","Menus","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:86:\"Add new menus to your site, edit existing menus, and rename and reorganize menu links.\";}}","system","0","0","1","0","0","3","0","1","21","48","0","0","0","0","0","0","0"),
("management","49","8","admin/config/people","admin/config/people","People","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:24:\"Configure user accounts.\";}}","system","0","0","1","0","-20","3","0","1","8","49","0","0","0","0","0","0","0"),
("management","50","18","admin/people/permissions","admin/people/permissions","Permissions","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}","system","-1","0","0","0","0","3","0","1","18","50","0","0","0","0","0","0","0"),
("management","51","19","admin/reports/dblog","admin/reports/dblog","Recent log messages","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"View events that have recently been logged.\";}}","system","0","0","0","0","-1","3","0","1","19","51","0","0","0","0","0","0","0"),
("management","52","8","admin/config/regional","admin/config/regional","Regional and language","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Regional settings, localization and translation.\";}}","system","0","0","1","0","-5","3","0","1","8","52","0","0","0","0","0","0","0"),
("navigation","53","5","node/%/revisions","node/%/revisions","Revisions","a:0:{}","system","-1","0","1","0","2","2","0","5","53","0","0","0","0","0","0","0","0"),
("management","54","8","admin/config/search","admin/config/search","Search and metadata","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Local site search, metadata and SEO.\";}}","system","0","0","1","0","-10","3","0","1","8","54","0","0","0","0","0","0","0"),
("management","55","7","admin/appearance/settings","admin/appearance/settings","Settings","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Configure default and theme specific settings.\";}}","system","-1","0","0","0","20","3","0","1","7","55","0","0","0","0","0","0","0"),
("management","56","19","admin/reports/status","admin/reports/status","Status report","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Get a status report about your site\'s operation and any detected problems.\";}}","system","0","0","0","0","-60","3","0","1","19","56","0","0","0","0","0","0","0"),
("management","57","8","admin/config/system","admin/config/system","System","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"General system related configuration.\";}}","system","0","0","1","0","-20","3","0","1","8","57","0","0","0","0","0","0","0"),
("management","58","21","admin/structure/taxonomy","admin/structure/taxonomy","Taxonomy","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:67:\"Manage tagging, categorization, and classification of your content.\";}}","system","0","0","1","0","0","3","0","1","21","58","0","0","0","0","0","0","0"),
("management","59","19","admin/reports/access-denied","admin/reports/access-denied","Top \'access denied\' errors","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:35:\"View \'access denied\' errors (403s).\";}}","system","0","0","0","0","0","3","0","1","19","59","0","0","0","0","0","0","0"),
("management","60","19","admin/reports/page-not-found","admin/reports/page-not-found","Top \'page not found\' errors","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"View \'page not found\' errors (404s).\";}}","system","0","0","0","0","0","3","0","1","19","60","0","0","0","0","0","0","0"),
("management","61","16","admin/modules/uninstall","admin/modules/uninstall","Uninstall","a:0:{}","system","-1","0","0","0","20","3","0","1","16","61","0","0","0","0","0","0","0"),
("management","62","8","admin/config/user-interface","admin/config/user-interface","User interface","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Tools that enhance the user interface.\";}}","system","0","0","1","0","-15","3","0","1","8","62","0","0","0","0","0","0","0"),
("navigation","63","5","node/%/view","node/%/view","View","a:0:{}","system","-1","0","0","0","-10","2","0","5","63","0","0","0","0","0","0","0","0"),
("navigation","64","17","user/%/view","user/%/view","View","a:0:{}","system","-1","0","0","0","-10","2","0","17","64","0","0","0","0","0","0","0","0"),
("management","65","8","admin/config/services","admin/config/services","Web services","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"Tools related to web services.\";}}","system","0","0","1","0","0","3","0","1","8","65","0","0","0","0","0","0","0"),
("management","66","8","admin/config/workflow","admin/config/workflow","Workflow","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Content workflow, editorial workflow tools.\";}}","system","0","0","0","0","5","3","0","1","8","66","0","0","0","0","0","0","0"),
("management","67","12","admin/help/block","admin/help/block","block","a:0:{}","system","-1","0","0","0","0","3","0","1","12","67","0","0","0","0","0","0","0"),
("management","68","12","admin/help/color","admin/help/color","color","a:0:{}","system","-1","0","0","0","0","3","0","1","12","68","0","0","0","0","0","0","0"),
("management","69","12","admin/help/comment","admin/help/comment","comment","a:0:{}","system","-1","0","0","0","0","3","0","1","12","69","0","0","0","0","0","0","0"),
("management","70","12","admin/help/contextual","admin/help/contextual","contextual","a:0:{}","system","-1","0","0","0","0","3","0","1","12","70","0","0","0","0","0","0","0"),
("management","71","12","admin/help/dashboard","admin/help/dashboard","dashboard","a:0:{}","system","-1","0","0","0","0","3","0","1","12","71","0","0","0","0","0","0","0"),
("management","72","12","admin/help/dblog","admin/help/dblog","dblog","a:0:{}","system","-1","0","0","0","0","3","0","1","12","72","0","0","0","0","0","0","0"),
("management","73","12","admin/help/field","admin/help/field","field","a:0:{}","system","-1","0","0","0","0","3","0","1","12","73","0","0","0","0","0","0","0"),
("management","74","12","admin/help/field_sql_storage","admin/help/field_sql_storage","field_sql_storage","a:0:{}","system","-1","0","0","0","0","3","0","1","12","74","0","0","0","0","0","0","0"),
("management","75","12","admin/help/field_ui","admin/help/field_ui","field_ui","a:0:{}","system","-1","0","0","0","0","3","0","1","12","75","0","0","0","0","0","0","0"),
("management","76","12","admin/help/file","admin/help/file","file","a:0:{}","system","-1","0","0","0","0","3","0","1","12","76","0","0","0","0","0","0","0"),
("management","77","12","admin/help/filter","admin/help/filter","filter","a:0:{}","system","-1","0","0","0","0","3","0","1","12","77","0","0","0","0","0","0","0"),
("management","78","12","admin/help/help","admin/help/help","help","a:0:{}","system","-1","0","0","0","0","3","0","1","12","78","0","0","0","0","0","0","0"),
("management","79","12","admin/help/image","admin/help/image","image","a:0:{}","system","-1","0","0","0","0","3","0","1","12","79","0","0","0","0","0","0","0"),
("management","80","12","admin/help/list","admin/help/list","list","a:0:{}","system","-1","0","0","0","0","3","0","1","12","80","0","0","0","0","0","0","0"),
("management","81","12","admin/help/menu","admin/help/menu","menu","a:0:{}","system","-1","0","0","0","0","3","0","1","12","81","0","0","0","0","0","0","0"),
("management","82","12","admin/help/node","admin/help/node","node","a:0:{}","system","-1","0","0","0","0","3","0","1","12","82","0","0","0","0","0","0","0"),
("management","83","12","admin/help/options","admin/help/options","options","a:0:{}","system","-1","0","0","0","0","3","0","1","12","83","0","0","0","0","0","0","0"),
("management","84","12","admin/help/system","admin/help/system","system","a:0:{}","system","-1","0","0","0","0","3","0","1","12","84","0","0","0","0","0","0","0"),
("management","85","12","admin/help/taxonomy","admin/help/taxonomy","taxonomy","a:0:{}","system","-1","0","0","0","0","3","0","1","12","85","0","0","0","0","0","0","0"),
("management","86","12","admin/help/text","admin/help/text","text","a:0:{}","system","-1","0","0","0","0","3","0","1","12","86","0","0","0","0","0","0","0"),
("management","87","12","admin/help/user","admin/help/user","user","a:0:{}","system","-1","0","0","0","0","3","0","1","12","87","0","0","0","0","0","0","0"),
("navigation","88","28","taxonomy/term/%/edit","taxonomy/term/%/edit","Edit","a:0:{}","system","-1","0","0","0","10","2","0","28","88","0","0","0","0","0","0","0","0"),
("navigation","89","28","taxonomy/term/%/view","taxonomy/term/%/view","View","a:0:{}","system","-1","0","0","0","0","2","0","28","89","0","0","0","0","0","0","0","0"),
("management","90","58","admin/structure/taxonomy/%","admin/structure/taxonomy/%","","a:0:{}","system","0","0","0","0","0","4","0","1","21","58","90","0","0","0","0","0","0"),
("management","91","49","admin/config/people/accounts","admin/config/people/accounts","Account settings","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:109:\"Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.\";}}","system","0","0","0","0","-10","4","0","1","8","49","91","0","0","0","0","0","0"),
("management","92","57","admin/config/system/actions","admin/config/system/actions","Actions","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}","system","0","0","1","0","0","4","0","1","8","57","92","0","0","0","0","0","0"),
("management","93","31","admin/structure/block/add","admin/structure/block/add","Add block","a:0:{}","system","-1","0","0","0","0","4","0","1","21","31","93","0","0","0","0","0","0"),
("management","94","37","admin/structure/types/add","admin/structure/types/add","Add content type","a:0:{}","system","-1","0","0","0","0","4","0","1","21","37","94","0","0","0","0","0","0"),
("management","95","48","admin/structure/menu/add","admin/structure/menu/add","Add menu","a:0:{}","system","-1","0","0","0","0","4","0","1","21","48","95","0","0","0","0","0","0"),
("management","96","58","admin/structure/taxonomy/add","admin/structure/taxonomy/add","Add vocabulary","a:0:{}","system","-1","0","0","0","0","4","0","1","21","58","96","0","0","0","0","0","0"),
("management","97","55","admin/appearance/settings/bartik","admin/appearance/settings/bartik","Bartik","a:0:{}","system","-1","0","0","0","0","4","0","1","7","55","97","0","0","0","0","0","0"),
("management","98","54","admin/config/search/clean-urls","admin/config/search/clean-urls","Clean URLs","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Enable or disable clean URLs for your site.\";}}","system","0","0","0","0","5","4","0","1","8","54","98","0","0","0","0","0","0"),
("management","99","57","admin/config/system/cron","admin/config/system/cron","Cron","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:40:\"Manage automatic site maintenance tasks.\";}}","system","0","0","0","0","20","4","0","1","8","57","99","0","0","0","0","0","0"),
("management","100","52","admin/config/regional/date-time","admin/config/regional/date-time","Date and time","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}","system","0","0","0","0","-15","4","0","1","8","52","100","0","0","0","0","0","0");
INSERT INTO menu_links VALUES
("management","101","19","admin/reports/event/%","admin/reports/event/%","Details","a:0:{}","system","0","0","0","0","0","3","0","1","19","101","0","0","0","0","0","0","0"),
("management","102","47","admin/config/media/file-system","admin/config/media/file-system","File system","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:68:\"Tell Drupal where to store uploaded files and how they are accessed.\";}}","system","0","0","0","0","-10","4","0","1","8","47","102","0","0","0","0","0","0"),
("management","103","55","admin/appearance/settings/garland","admin/appearance/settings/garland","Garland","a:0:{}","system","-1","0","0","0","0","4","0","1","7","55","103","0","0","0","0","0","0"),
("management","104","55","admin/appearance/settings/global","admin/appearance/settings/global","Global settings","a:0:{}","system","-1","0","0","0","-1","4","0","1","7","55","104","0","0","0","0","0","0"),
("management","105","49","admin/config/people/ip-blocking","admin/config/people/ip-blocking","IP address blocking","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Manage blocked IP addresses.\";}}","system","0","0","1","0","10","4","0","1","8","49","105","0","0","0","0","0","0"),
("management","106","47","admin/config/media/image-styles","admin/config/media/image-styles","Image styles","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:78:\"Configure styles that can be used for resizing or adjusting images on display.\";}}","system","0","0","1","0","0","4","0","1","8","47","106","0","0","0","0","0","0"),
("management","107","47","admin/config/media/image-toolkit","admin/config/media/image-toolkit","Image toolkit","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Choose which image toolkit to use if you have installed optional toolkits.\";}}","system","0","0","0","0","20","4","0","1","8","47","107","0","0","0","0","0","0"),
("management","108","44","admin/modules/list/confirm","admin/modules/list/confirm","List","a:0:{}","system","-1","0","0","0","0","4","0","1","16","44","108","0","0","0","0","0","0"),
("management","109","37","admin/structure/types/list","admin/structure/types/list","List","a:0:{}","system","-1","0","0","0","-10","4","0","1","21","37","109","0","0","0","0","0","0"),
("management","110","58","admin/structure/taxonomy/list","admin/structure/taxonomy/list","List","a:0:{}","system","-1","0","0","0","-10","4","0","1","21","58","110","0","0","0","0","0","0"),
("management","111","48","admin/structure/menu/list","admin/structure/menu/list","List menus","a:0:{}","system","-1","0","0","0","-10","4","0","1","21","48","111","0","0","0","0","0","0"),
("management","112","40","admin/config/development/logging","admin/config/development/logging","Logging and errors","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:154:\"Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.\";}}","system","0","0","0","0","-15","4","0","1","8","40","112","0","0","0","0","0","0"),
("management","113","40","admin/config/development/maintenance","admin/config/development/maintenance","Maintenance mode","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:62:\"Take the site offline for maintenance or bring it back online.\";}}","system","0","0","0","0","-10","4","0","1","8","40","113","0","0","0","0","0","0"),
("management","114","40","admin/config/development/performance","admin/config/development/performance","Performance","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:101:\"Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.\";}}","system","0","0","0","0","-20","4","0","1","8","40","114","0","0","0","0","0","0"),
("management","115","50","admin/people/permissions/list","admin/people/permissions/list","Permissions","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}","system","-1","0","0","0","-8","4","0","1","18","50","115","0","0","0","0","0","0"),
("management","116","33","admin/content/comment/new","admin/content/comment/new","Published comments","a:0:{}","system","-1","0","0","0","-10","4","0","1","9","33","116","0","0","0","0","0","0"),
("management","117","65","admin/config/services/rss-publishing","admin/config/services/rss-publishing","RSS publishing","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:114:\"Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.\";}}","system","0","0","0","0","0","4","0","1","8","65","117","0","0","0","0","0","0"),
("management","118","52","admin/config/regional/settings","admin/config/regional/settings","Regional settings","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:54:\"Settings for the site\'s default time zone and country.\";}}","system","0","0","0","0","-20","4","0","1","8","52","118","0","0","0","0","0","0"),
("management","119","50","admin/people/permissions/roles","admin/people/permissions/roles","Roles","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"List, edit, or add user roles.\";}}","system","-1","0","1","0","-5","4","0","1","18","50","119","0","0","0","0","0","0"),
("management","120","48","admin/structure/menu/settings","admin/structure/menu/settings","Settings","a:0:{}","system","-1","0","0","0","5","4","0","1","21","48","120","0","0","0","0","0","0"),
("management","121","55","admin/appearance/settings/seven","admin/appearance/settings/seven","Seven","a:0:{}","system","-1","0","0","0","0","4","0","1","7","55","121","0","0","0","0","0","0"),
("management","122","57","admin/config/system/site-information","admin/config/system/site-information","Site information","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:104:\"Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.\";}}","system","0","0","0","0","-20","4","0","1","8","57","122","0","0","0","0","0","0"),
("management","123","55","admin/appearance/settings/stark","admin/appearance/settings/stark","Stark","a:0:{}","system","-1","0","0","0","0","4","0","1","7","55","123","0","0","0","0","0","0"),
("management","124","36","admin/config/content/formats","admin/config/content/formats","Text formats","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:127:\"Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.\";}}","system","0","0","1","0","0","4","0","1","8","36","124","0","0","0","0","0","0"),
("management","125","33","admin/content/comment/approval","admin/content/comment/approval","Unapproved comments","a:0:{}","system","-1","0","0","0","0","4","0","1","9","33","125","0","0","0","0","0","0"),
("management","126","61","admin/modules/uninstall/confirm","admin/modules/uninstall/confirm","Uninstall","a:0:{}","system","-1","0","0","0","0","4","0","1","16","61","126","0","0","0","0","0","0"),
("navigation","127","41","user/%/edit/account","user/%/edit/account","Account","a:0:{}","system","-1","0","0","0","0","3","0","17","41","127","0","0","0","0","0","0","0"),
("management","128","124","admin/config/content/formats/%","admin/config/content/formats/%","","a:0:{}","system","0","0","1","0","0","5","0","1","8","36","124","128","0","0","0","0","0"),
("management","129","106","admin/config/media/image-styles/add","admin/config/media/image-styles/add","Add style","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Add a new image style.\";}}","system","-1","0","0","0","2","5","0","1","8","47","106","129","0","0","0","0","0"),
("management","130","90","admin/structure/taxonomy/%/add","admin/structure/taxonomy/%/add","Add term","a:0:{}","system","-1","0","0","0","0","5","0","1","21","58","90","130","0","0","0","0","0"),
("management","131","124","admin/config/content/formats/add","admin/config/content/formats/add","Add text format","a:0:{}","system","-1","0","0","0","1","5","0","1","8","36","124","131","0","0","0","0","0"),
("management","132","31","admin/structure/block/list/bartik","admin/structure/block/list/bartik","Bartik","a:0:{}","system","-1","0","0","0","-10","4","0","1","21","31","132","0","0","0","0","0","0"),
("management","133","92","admin/config/system/actions/configure","admin/config/system/actions/configure","Configure an advanced action","a:0:{}","system","-1","0","0","0","0","5","0","1","8","57","92","133","0","0","0","0","0"),
("management","134","48","admin/structure/menu/manage/%","admin/structure/menu/manage/%","Customize menu","a:0:{}","system","0","0","1","0","0","4","0","1","21","48","134","0","0","0","0","0","0"),
("management","135","90","admin/structure/taxonomy/%/edit","admin/structure/taxonomy/%/edit","Edit","a:0:{}","system","-1","0","0","0","-10","5","0","1","21","58","90","135","0","0","0","0","0"),
("management","136","37","admin/structure/types/manage/%","admin/structure/types/manage/%","Edit content type","a:0:{}","system","0","0","1","0","0","4","0","1","21","37","136","0","0","0","0","0","0"),
("management","137","100","admin/config/regional/date-time/formats","admin/config/regional/date-time/formats","Formats","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:51:\"Configure display format strings for date and time.\";}}","system","-1","0","1","0","-9","5","0","1","8","52","100","137","0","0","0","0","0"),
("management","138","31","admin/structure/block/list/garland","admin/structure/block/list/garland","Garland","a:0:{}","system","-1","0","0","0","0","4","0","1","21","31","138","0","0","0","0","0","0"),
("management","139","90","admin/structure/taxonomy/%/list","admin/structure/taxonomy/%/list","List","a:0:{}","system","-1","0","0","0","-20","5","0","1","21","58","90","139","0","0","0","0","0"),
("management","140","124","admin/config/content/formats/list","admin/config/content/formats/list","List","a:0:{}","system","-1","0","0","0","0","5","0","1","8","36","124","140","0","0","0","0","0"),
("management","141","106","admin/config/media/image-styles/list","admin/config/media/image-styles/list","List","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"List the current image styles on the site.\";}}","system","-1","0","0","0","1","5","0","1","8","47","106","141","0","0","0","0","0"),
("management","142","92","admin/config/system/actions/manage","admin/config/system/actions/manage","Manage actions","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}","system","-1","0","0","0","-2","5","0","1","8","57","92","142","0","0","0","0","0"),
("management","143","91","admin/config/people/accounts/settings","admin/config/people/accounts/settings","Settings","a:0:{}","system","-1","0","0","0","-10","5","0","1","8","49","91","143","0","0","0","0","0"),
("management","144","31","admin/structure/block/list/seven","admin/structure/block/list/seven","Seven","a:0:{}","system","-1","0","0","0","0","4","0","1","21","31","144","0","0","0","0","0","0"),
("management","145","31","admin/structure/block/list/stark","admin/structure/block/list/stark","Stark","a:0:{}","system","-1","0","0","0","0","4","0","1","21","31","145","0","0","0","0","0","0"),
("management","146","100","admin/config/regional/date-time/types","admin/config/regional/date-time/types","Types","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}","system","-1","0","1","0","-10","5","0","1","8","52","100","146","0","0","0","0","0"),
("navigation","147","53","node/%/revisions/%/delete","node/%/revisions/%/delete","Delete earlier revision","a:0:{}","system","0","0","0","0","0","3","0","5","53","147","0","0","0","0","0","0","0"),
("navigation","148","53","node/%/revisions/%/revert","node/%/revisions/%/revert","Revert to earlier revision","a:0:{}","system","0","0","0","0","0","3","0","5","53","148","0","0","0","0","0","0","0"),
("navigation","149","53","node/%/revisions/%/view","node/%/revisions/%/view","Revisions","a:0:{}","system","0","0","0","0","0","3","0","5","53","149","0","0","0","0","0","0","0"),
("management","150","138","admin/structure/block/list/garland/add","admin/structure/block/list/garland/add","Add block","a:0:{}","system","-1","0","0","0","0","5","0","1","21","31","138","150","0","0","0","0","0"),
("management","151","144","admin/structure/block/list/seven/add","admin/structure/block/list/seven/add","Add block","a:0:{}","system","-1","0","0","0","0","5","0","1","21","31","144","151","0","0","0","0","0"),
("management","152","145","admin/structure/block/list/stark/add","admin/structure/block/list/stark/add","Add block","a:0:{}","system","-1","0","0","0","0","5","0","1","21","31","145","152","0","0","0","0","0"),
("management","153","146","admin/config/regional/date-time/types/add","admin/config/regional/date-time/types/add","Add date type","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Add new date type.\";}}","system","-1","0","0","0","-10","6","0","1","8","52","100","146","153","0","0","0","0"),
("management","154","137","admin/config/regional/date-time/formats/add","admin/config/regional/date-time/formats/add","Add format","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Allow users to add additional date formats.\";}}","system","-1","0","0","0","-10","6","0","1","8","52","100","137","154","0","0","0","0"),
("management","155","134","admin/structure/menu/manage/%/add","admin/structure/menu/manage/%/add","Add link","a:0:{}","system","-1","0","0","0","0","5","0","1","21","48","134","155","0","0","0","0","0"),
("management","156","31","admin/structure/block/manage/%/%","admin/structure/block/manage/%/%","Configure block","a:0:{}","system","0","0","0","0","0","4","0","1","21","31","156","0","0","0","0","0","0"),
("navigation","157","32","user/%/cancel/confirm/%/%","user/%/cancel/confirm/%/%","Confirm account cancellation","a:0:{}","system","0","0","0","0","0","3","0","17","32","157","0","0","0","0","0","0","0"),
("management","158","136","admin/structure/types/manage/%/delete","admin/structure/types/manage/%/delete","Delete","a:0:{}","system","0","0","0","0","0","5","0","1","21","37","136","158","0","0","0","0","0"),
("management","159","105","admin/config/people/ip-blocking/delete/%","admin/config/people/ip-blocking/delete/%","Delete IP address","a:0:{}","system","0","0","0","0","0","5","0","1","8","49","105","159","0","0","0","0","0"),
("management","160","92","admin/config/system/actions/delete/%","admin/config/system/actions/delete/%","Delete action","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:17:\"Delete an action.\";}}","system","0","0","0","0","0","5","0","1","8","57","92","160","0","0","0","0","0"),
("management","161","134","admin/structure/menu/manage/%/delete","admin/structure/menu/manage/%/delete","Delete menu","a:0:{}","system","0","0","0","0","0","5","0","1","21","48","134","161","0","0","0","0","0"),
("management","162","48","admin/structure/menu/item/%/delete","admin/structure/menu/item/%/delete","Delete menu link","a:0:{}","system","0","0","0","0","0","4","0","1","21","48","162","0","0","0","0","0","0"),
("management","163","119","admin/people/permissions/roles/delete/%","admin/people/permissions/roles/delete/%","Delete role","a:0:{}","system","0","0","0","0","0","5","0","1","18","50","119","163","0","0","0","0","0"),
("management","164","128","admin/config/content/formats/%/disable","admin/config/content/formats/%/disable","Disable text format","a:0:{}","system","0","0","0","0","0","6","0","1","8","36","124","128","164","0","0","0","0"),
("management","165","136","admin/structure/types/manage/%/edit","admin/structure/types/manage/%/edit","Edit","a:0:{}","system","-1","0","0","0","0","5","0","1","21","37","136","165","0","0","0","0","0"),
("management","166","134","admin/structure/menu/manage/%/edit","admin/structure/menu/manage/%/edit","Edit menu","a:0:{}","system","-1","0","0","0","0","5","0","1","21","48","134","166","0","0","0","0","0"),
("management","167","48","admin/structure/menu/item/%/edit","admin/structure/menu/item/%/edit","Edit menu link","a:0:{}","system","0","0","0","0","0","4","0","1","21","48","167","0","0","0","0","0","0"),
("management","168","119","admin/people/permissions/roles/edit/%","admin/people/permissions/roles/edit/%","Edit role","a:0:{}","system","0","0","0","0","0","5","0","1","18","50","119","168","0","0","0","0","0"),
("management","169","106","admin/config/media/image-styles/edit/%","admin/config/media/image-styles/edit/%","Edit style","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Configure an image style.\";}}","system","0","0","1","0","0","5","0","1","8","47","106","169","0","0","0","0","0"),
("management","170","134","admin/structure/menu/manage/%/list","admin/structure/menu/manage/%/list","List links","a:0:{}","system","-1","0","0","0","-10","5","0","1","21","48","134","170","0","0","0","0","0"),
("management","171","48","admin/structure/menu/item/%/reset","admin/structure/menu/item/%/reset","Reset menu link","a:0:{}","system","0","0","0","0","0","4","0","1","21","48","171","0","0","0","0","0","0"),
("management","172","106","admin/config/media/image-styles/delete/%","admin/config/media/image-styles/delete/%","Delete style","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Delete an image style.\";}}","system","0","0","0","0","0","5","0","1","8","47","106","172","0","0","0","0","0"),
("management","173","106","admin/config/media/image-styles/revert/%","admin/config/media/image-styles/revert/%","Revert style","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Revert an image style.\";}}","system","0","0","0","0","0","5","0","1","8","47","106","173","0","0","0","0","0"),
("management","174","136","admin/structure/types/manage/%/comment/display","admin/structure/types/manage/%/comment/display","Comment display","a:0:{}","system","-1","0","0","0","4","5","0","1","21","37","136","174","0","0","0","0","0"),
("management","175","136","admin/structure/types/manage/%/comment/fields","admin/structure/types/manage/%/comment/fields","Comment fields","a:0:{}","system","-1","0","1","0","3","5","0","1","21","37","136","175","0","0","0","0","0"),
("management","176","156","admin/structure/block/manage/%/%/configure","admin/structure/block/manage/%/%/configure","Configure block","a:0:{}","system","-1","0","0","0","0","5","0","1","21","31","156","176","0","0","0","0","0"),
("management","177","156","admin/structure/block/manage/%/%/delete","admin/structure/block/manage/%/%/delete","Delete block","a:0:{}","system","-1","0","0","0","0","5","0","1","21","31","156","177","0","0","0","0","0"),
("management","178","137","admin/config/regional/date-time/formats/%/delete","admin/config/regional/date-time/formats/%/delete","Delete date format","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\"Allow users to delete a configured date format.\";}}","system","0","0","0","0","0","6","0","1","8","52","100","137","178","0","0","0","0"),
("management","179","146","admin/config/regional/date-time/types/%/delete","admin/config/regional/date-time/types/%/delete","Delete date type","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to delete a configured date type.\";}}","system","0","0","0","0","0","6","0","1","8","52","100","146","179","0","0","0","0"),
("management","180","137","admin/config/regional/date-time/formats/%/edit","admin/config/regional/date-time/formats/%/edit","Edit date format","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to edit a configured date format.\";}}","system","0","0","0","0","0","6","0","1","8","52","100","137","180","0","0","0","0"),
("management","181","169","admin/config/media/image-styles/edit/%/add/%","admin/config/media/image-styles/edit/%/add/%","Add image effect","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Add a new effect to a style.\";}}","system","0","0","0","0","0","6","0","1","8","47","106","169","181","0","0","0","0"),
("management","182","169","admin/config/media/image-styles/edit/%/effects/%","admin/config/media/image-styles/edit/%/effects/%","Edit image effect","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Edit an existing effect within a style.\";}}","system","0","0","1","0","0","6","0","1","8","47","106","169","182","0","0","0","0"),
("management","183","182","admin/config/media/image-styles/edit/%/effects/%/delete","admin/config/media/image-styles/edit/%/effects/%/delete","Delete image effect","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Delete an existing effect from a style.\";}}","system","0","0","0","0","0","7","0","1","8","47","106","169","182","183","0","0","0"),
("management","184","48","admin/structure/menu/manage/main-menu","admin/structure/menu/manage/%","Main menu","a:0:{}","menu","0","0","0","0","0","4","0","1","21","48","184","0","0","0","0","0","0"),
("management","185","48","admin/structure/menu/manage/management","admin/structure/menu/manage/%","Management","a:0:{}","menu","0","0","0","0","0","4","0","1","21","48","185","0","0","0","0","0","0"),
("management","186","48","admin/structure/menu/manage/navigation","admin/structure/menu/manage/%","Navigation","a:0:{}","menu","0","0","0","0","0","4","0","1","21","48","186","0","0","0","0","0","0"),
("management","187","48","admin/structure/menu/manage/user-menu","admin/structure/menu/manage/%","User menu","a:0:{}","menu","0","0","0","0","0","4","0","1","21","48","187","0","0","0","0","0","0"),
("navigation","188","0","search","search","Search","a:0:{}","system","1","0","0","0","0","1","0","188","0","0","0","0","0","0","0","0","0"),
("navigation","189","188","search/node","search/node","Content","a:0:{}","system","-1","0","0","0","-10","2","0","188","189","0","0","0","0","0","0","0","0"),
("navigation","190","188","search/user","search/user","Users","a:0:{}","system","-1","0","0","0","0","2","0","188","190","0","0","0","0","0","0","0","0"),
("navigation","191","189","search/node/%","search/node/%","Content","a:0:{}","system","-1","0","0","0","0","3","0","188","189","191","0","0","0","0","0","0","0"),
("navigation","192","17","user/%/shortcuts","user/%/shortcuts","Shortcuts","a:0:{}","system","-1","0","0","0","0","2","0","17","192","0","0","0","0","0","0","0","0"),
("management","193","19","admin/reports/search","admin/reports/search","Top search phrases","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"View most popular search phrases.\";}}","system","0","0","0","0","0","3","0","1","19","193","0","0","0","0","0","0","0"),
("navigation","194","190","search/user/%","search/user/%","Users","a:0:{}","system","-1","0","0","0","0","3","0","188","190","194","0","0","0","0","0","0","0"),
("management","195","12","admin/help/number","admin/help/number","number","a:0:{}","system","-1","0","0","0","0","3","0","1","12","195","0","0","0","0","0","0","0"),
("management","196","12","admin/help/overlay","admin/help/overlay","overlay","a:0:{}","system","-1","0","0","0","0","3","0","1","12","196","0","0","0","0","0","0","0"),
("management","197","12","admin/help/path","admin/help/path","path","a:0:{}","system","-1","0","0","0","0","3","0","1","12","197","0","0","0","0","0","0","0"),
("management","198","12","admin/help/rdf","admin/help/rdf","rdf","a:0:{}","system","-1","0","0","0","0","3","0","1","12","198","0","0","0","0","0","0","0"),
("management","199","12","admin/help/search","admin/help/search","search","a:0:{}","system","-1","0","0","0","0","3","0","1","12","199","0","0","0","0","0","0","0"),
("management","200","12","admin/help/shortcut","admin/help/shortcut","shortcut","a:0:{}","system","-1","0","0","0","0","3","0","1","12","200","0","0","0","0","0","0","0");
INSERT INTO menu_links VALUES
("management","201","54","admin/config/search/settings","admin/config/search/settings","Search settings","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:67:\"Configure relevance settings for search and other indexing options.\";}}","system","0","0","0","0","-10","4","0","1","8","54","201","0","0","0","0","0","0"),
("management","202","62","admin/config/user-interface/shortcut","admin/config/user-interface/shortcut","Shortcuts","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:29:\"Add and modify shortcut sets.\";}}","system","0","0","1","0","0","4","0","1","8","62","202","0","0","0","0","0","0"),
("management","203","54","admin/config/search/path","admin/config/search/path","URL aliases","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Change your site\'s URL paths by aliasing them.\";}}","system","0","0","1","0","-5","4","0","1","8","54","203","0","0","0","0","0","0"),
("management","204","203","admin/config/search/path/add","admin/config/search/path/add","Add alias","a:0:{}","system","-1","0","0","0","0","5","0","1","8","54","203","204","0","0","0","0","0"),
("management","205","202","admin/config/user-interface/shortcut/add-set","admin/config/user-interface/shortcut/add-set","Add shortcut set","a:0:{}","system","-1","0","0","0","0","5","0","1","8","62","202","205","0","0","0","0","0"),
("management","206","201","admin/config/search/settings/reindex","admin/config/search/settings/reindex","Clear index","a:0:{}","system","-1","0","0","0","0","5","0","1","8","54","201","206","0","0","0","0","0"),
("management","207","202","admin/config/user-interface/shortcut/%","admin/config/user-interface/shortcut/%","Edit shortcuts","a:0:{}","system","0","0","1","0","0","5","0","1","8","62","202","207","0","0","0","0","0"),
("management","208","203","admin/config/search/path/list","admin/config/search/path/list","List","a:0:{}","system","-1","0","0","0","-10","5","0","1","8","54","203","208","0","0","0","0","0"),
("management","209","207","admin/config/user-interface/shortcut/%/add-link","admin/config/user-interface/shortcut/%/add-link","Add shortcut","a:0:{}","system","-1","0","0","0","0","6","0","1","8","62","202","207","209","0","0","0","0"),
("management","210","203","admin/config/search/path/delete/%","admin/config/search/path/delete/%","Delete alias","a:0:{}","system","0","0","0","0","0","5","0","1","8","54","203","210","0","0","0","0","0"),
("management","211","207","admin/config/user-interface/shortcut/%/delete","admin/config/user-interface/shortcut/%/delete","Delete shortcut set","a:0:{}","system","0","0","0","0","0","6","0","1","8","62","202","207","211","0","0","0","0"),
("management","212","203","admin/config/search/path/edit/%","admin/config/search/path/edit/%","Edit alias","a:0:{}","system","0","0","0","0","0","5","0","1","8","54","203","212","0","0","0","0","0"),
("management","213","207","admin/config/user-interface/shortcut/%/edit","admin/config/user-interface/shortcut/%/edit","Edit set name","a:0:{}","system","-1","0","0","0","10","6","0","1","8","62","202","207","213","0","0","0","0"),
("management","214","202","admin/config/user-interface/shortcut/link/%","admin/config/user-interface/shortcut/link/%","Edit shortcut","a:0:{}","system","0","0","1","0","0","5","0","1","8","62","202","214","0","0","0","0","0"),
("management","215","207","admin/config/user-interface/shortcut/%/links","admin/config/user-interface/shortcut/%/links","List links","a:0:{}","system","-1","0","0","0","0","6","0","1","8","62","202","207","215","0","0","0","0"),
("management","216","214","admin/config/user-interface/shortcut/link/%/delete","admin/config/user-interface/shortcut/link/%/delete","Delete shortcut","a:0:{}","system","0","0","0","0","0","6","0","1","8","62","202","214","216","0","0","0","0"),
("shortcut-set-1","217","0","node/add","node/add","Add content","a:0:{}","menu","0","0","0","0","-20","1","0","217","0","0","0","0","0","0","0","0","0"),
("shortcut-set-1","218","0","admin/content","admin/content","Find content","a:0:{}","menu","0","0","0","0","-19","1","0","218","0","0","0","0","0","0","0","0","0"),
("main-menu","219","0","<front>","","Home","a:0:{}","menu","0","1","0","0","0","1","0","219","0","0","0","0","0","0","0","0","0"),
("navigation","220","6","node/add/article","node/add/article","Article","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:89:\"Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.\";}}","system","0","0","0","0","0","2","0","6","220","0","0","0","0","0","0","0","0"),
("navigation","221","6","node/add/page","node/add/page","Basic page","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:77:\"Use <em>basic pages</em> for your static content, such as an \'About us\' page.\";}}","system","0","0","0","0","0","2","0","6","221","0","0","0","0","0","0","0","0"),
("management","222","12","admin/help/toolbar","admin/help/toolbar","toolbar","a:0:{}","system","-1","0","0","0","0","3","0","1","12","222","0","0","0","0","0","0","0"),
("management","261","19","admin/reports/updates","admin/reports/updates","Available updates","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:82:\"Get a status report about available updates for your installed modules and themes.\";}}","system","0","0","0","0","-50","3","0","1","19","261","0","0","0","0","0","0","0"),
("management","262","7","admin/appearance/install","admin/appearance/install","Install new theme","a:0:{}","system","-1","0","0","0","25","3","0","1","7","262","0","0","0","0","0","0","0"),
("management","263","16","admin/modules/install","admin/modules/install","Install new module","a:0:{}","system","-1","0","0","0","25","3","0","1","16","263","0","0","0","0","0","0","0"),
("management","264","16","admin/modules/update","admin/modules/update","Update","a:0:{}","system","-1","0","0","0","10","3","0","1","16","264","0","0","0","0","0","0","0"),
("management","265","7","admin/appearance/update","admin/appearance/update","Update","a:0:{}","system","-1","0","0","0","10","3","0","1","7","265","0","0","0","0","0","0","0"),
("management","266","12","admin/help/update","admin/help/update","update","a:0:{}","system","-1","0","0","0","0","3","0","1","12","266","0","0","0","0","0","0","0"),
("management","267","261","admin/reports/updates/install","admin/reports/updates/install","Install new module or theme","a:0:{}","system","-1","0","0","0","25","4","0","1","19","261","267","0","0","0","0","0","0"),
("management","268","261","admin/reports/updates/update","admin/reports/updates/update","Update","a:0:{}","system","-1","0","0","0","10","4","0","1","19","261","268","0","0","0","0","0","0"),
("management","269","261","admin/reports/updates/list","admin/reports/updates/list","List","a:0:{}","system","-1","0","0","0","0","4","0","1","19","261","269","0","0","0","0","0","0"),
("management","270","261","admin/reports/updates/settings","admin/reports/updates/settings","Settings","a:0:{}","system","-1","0","0","0","50","4","0","1","19","261","270","0","0","0","0","0","0"),
("management","271","90","admin/structure/taxonomy/%/display","admin/structure/taxonomy/%/display","Manage display","a:0:{}","system","-1","0","0","0","2","5","0","1","21","58","90","271","0","0","0","0","0"),
("management","272","91","admin/config/people/accounts/display","admin/config/people/accounts/display","Manage display","a:0:{}","system","-1","0","0","0","2","5","0","1","8","49","91","272","0","0","0","0","0"),
("management","273","90","admin/structure/taxonomy/%/fields","admin/structure/taxonomy/%/fields","Manage fields","a:0:{}","system","-1","0","1","0","1","5","0","1","21","58","90","273","0","0","0","0","0"),
("management","274","91","admin/config/people/accounts/fields","admin/config/people/accounts/fields","Manage fields","a:0:{}","system","-1","0","1","0","1","5","0","1","8","49","91","274","0","0","0","0","0"),
("management","275","271","admin/structure/taxonomy/%/display/default","admin/structure/taxonomy/%/display/default","Default","a:0:{}","system","-1","0","0","0","-10","6","0","1","21","58","90","271","275","0","0","0","0"),
("management","276","272","admin/config/people/accounts/display/default","admin/config/people/accounts/display/default","Default","a:0:{}","system","-1","0","0","0","-10","6","0","1","8","49","91","272","276","0","0","0","0"),
("management","277","136","admin/structure/types/manage/%/display","admin/structure/types/manage/%/display","Manage display","a:0:{}","system","-1","0","0","0","2","5","0","1","21","37","136","277","0","0","0","0","0"),
("management","278","136","admin/structure/types/manage/%/fields","admin/structure/types/manage/%/fields","Manage fields","a:0:{}","system","-1","0","1","0","1","5","0","1","21","37","136","278","0","0","0","0","0"),
("management","279","271","admin/structure/taxonomy/%/display/full","admin/structure/taxonomy/%/display/full","Taxonomy term page","a:0:{}","system","-1","0","0","0","0","6","0","1","21","58","90","271","279","0","0","0","0"),
("management","280","272","admin/config/people/accounts/display/full","admin/config/people/accounts/display/full","User account","a:0:{}","system","-1","0","0","0","0","6","0","1","8","49","91","272","280","0","0","0","0"),
("management","281","273","admin/structure/taxonomy/%/fields/%","admin/structure/taxonomy/%/fields/%","","a:0:{}","system","0","0","0","0","0","6","0","1","21","58","90","273","281","0","0","0","0"),
("management","282","274","admin/config/people/accounts/fields/%","admin/config/people/accounts/fields/%","","a:0:{}","system","0","0","0","0","0","6","0","1","8","49","91","274","282","0","0","0","0"),
("management","283","277","admin/structure/types/manage/%/display/default","admin/structure/types/manage/%/display/default","Default","a:0:{}","system","-1","0","0","0","-10","6","0","1","21","37","136","277","283","0","0","0","0"),
("management","284","277","admin/structure/types/manage/%/display/full","admin/structure/types/manage/%/display/full","Full content","a:0:{}","system","-1","0","0","0","0","6","0","1","21","37","136","277","284","0","0","0","0"),
("management","285","277","admin/structure/types/manage/%/display/rss","admin/structure/types/manage/%/display/rss","RSS","a:0:{}","system","-1","0","0","0","2","6","0","1","21","37","136","277","285","0","0","0","0"),
("management","286","277","admin/structure/types/manage/%/display/search_index","admin/structure/types/manage/%/display/search_index","Search index","a:0:{}","system","-1","0","0","0","3","6","0","1","21","37","136","277","286","0","0","0","0"),
("management","287","277","admin/structure/types/manage/%/display/search_result","admin/structure/types/manage/%/display/search_result","Search result highlighting input","a:0:{}","system","-1","0","0","0","4","6","0","1","21","37","136","277","287","0","0","0","0"),
("management","288","277","admin/structure/types/manage/%/display/teaser","admin/structure/types/manage/%/display/teaser","Teaser","a:0:{}","system","-1","0","0","0","1","6","0","1","21","37","136","277","288","0","0","0","0"),
("management","289","278","admin/structure/types/manage/%/fields/%","admin/structure/types/manage/%/fields/%","","a:0:{}","system","0","0","0","0","0","6","0","1","21","37","136","278","289","0","0","0","0"),
("management","290","281","admin/structure/taxonomy/%/fields/%/delete","admin/structure/taxonomy/%/fields/%/delete","Delete","a:0:{}","system","-1","0","0","0","10","7","0","1","21","58","90","273","281","290","0","0","0"),
("management","291","281","admin/structure/taxonomy/%/fields/%/edit","admin/structure/taxonomy/%/fields/%/edit","Edit","a:0:{}","system","-1","0","0","0","0","7","0","1","21","58","90","273","281","291","0","0","0"),
("management","292","281","admin/structure/taxonomy/%/fields/%/field-settings","admin/structure/taxonomy/%/fields/%/field-settings","Field settings","a:0:{}","system","-1","0","0","0","0","7","0","1","21","58","90","273","281","292","0","0","0"),
("management","293","281","admin/structure/taxonomy/%/fields/%/widget-type","admin/structure/taxonomy/%/fields/%/widget-type","Widget type","a:0:{}","system","-1","0","0","0","0","7","0","1","21","58","90","273","281","293","0","0","0"),
("management","294","282","admin/config/people/accounts/fields/%/delete","admin/config/people/accounts/fields/%/delete","Delete","a:0:{}","system","-1","0","0","0","10","7","0","1","8","49","91","274","282","294","0","0","0"),
("management","295","282","admin/config/people/accounts/fields/%/edit","admin/config/people/accounts/fields/%/edit","Edit","a:0:{}","system","-1","0","0","0","0","7","0","1","8","49","91","274","282","295","0","0","0"),
("management","296","282","admin/config/people/accounts/fields/%/field-settings","admin/config/people/accounts/fields/%/field-settings","Field settings","a:0:{}","system","-1","0","0","0","0","7","0","1","8","49","91","274","282","296","0","0","0"),
("management","297","282","admin/config/people/accounts/fields/%/widget-type","admin/config/people/accounts/fields/%/widget-type","Widget type","a:0:{}","system","-1","0","0","0","0","7","0","1","8","49","91","274","282","297","0","0","0"),
("management","298","174","admin/structure/types/manage/%/comment/display/default","admin/structure/types/manage/%/comment/display/default","Default","a:0:{}","system","-1","0","0","0","-10","6","0","1","21","37","136","174","298","0","0","0","0"),
("management","299","174","admin/structure/types/manage/%/comment/display/full","admin/structure/types/manage/%/comment/display/full","Full comment","a:0:{}","system","-1","0","0","0","0","6","0","1","21","37","136","174","299","0","0","0","0"),
("management","300","175","admin/structure/types/manage/%/comment/fields/%","admin/structure/types/manage/%/comment/fields/%","","a:0:{}","system","0","0","0","0","0","6","0","1","21","37","136","175","300","0","0","0","0"),
("management","301","289","admin/structure/types/manage/%/fields/%/delete","admin/structure/types/manage/%/fields/%/delete","Delete","a:0:{}","system","-1","0","0","0","10","7","0","1","21","37","136","278","289","301","0","0","0"),
("management","302","289","admin/structure/types/manage/%/fields/%/edit","admin/structure/types/manage/%/fields/%/edit","Edit","a:0:{}","system","-1","0","0","0","0","7","0","1","21","37","136","278","289","302","0","0","0"),
("management","303","289","admin/structure/types/manage/%/fields/%/field-settings","admin/structure/types/manage/%/fields/%/field-settings","Field settings","a:0:{}","system","-1","0","0","0","0","7","0","1","21","37","136","278","289","303","0","0","0"),
("management","304","289","admin/structure/types/manage/%/fields/%/widget-type","admin/structure/types/manage/%/fields/%/widget-type","Widget type","a:0:{}","system","-1","0","0","0","0","7","0","1","21","37","136","278","289","304","0","0","0"),
("management","305","300","admin/structure/types/manage/%/comment/fields/%/delete","admin/structure/types/manage/%/comment/fields/%/delete","Delete","a:0:{}","system","-1","0","0","0","10","7","0","1","21","37","136","175","300","305","0","0","0"),
("management","306","300","admin/structure/types/manage/%/comment/fields/%/edit","admin/structure/types/manage/%/comment/fields/%/edit","Edit","a:0:{}","system","-1","0","0","0","0","7","0","1","21","37","136","175","300","306","0","0","0"),
("management","307","300","admin/structure/types/manage/%/comment/fields/%/field-settings","admin/structure/types/manage/%/comment/fields/%/field-settings","Field settings","a:0:{}","system","-1","0","0","0","0","7","0","1","21","37","136","175","300","307","0","0","0"),
("management","308","300","admin/structure/types/manage/%/comment/fields/%/widget-type","admin/structure/types/manage/%/comment/fields/%/widget-type","Widget type","a:0:{}","system","-1","0","0","0","0","7","0","1","21","37","136","175","300","308","0","0","0"),
("navigation","309","5","node/%/webform-results","node/%/webform-results","Results","a:0:{}","system","-1","0","0","0","2","2","0","5","309","0","0","0","0","0","0","0","0"),
("navigation","310","6","node/add/webform","node/add/webform","Webform","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:138:\"Create a new form or questionnaire accessible to users. Submission results and statistics are recorded and accessible to privileged users.\";}}","system","0","0","0","0","0","2","0","6","310","0","0","0","0","0","0","0","0"),
("navigation","311","5","node/%/webform","node/%/webform","Webform","a:0:{}","system","-1","0","0","0","1","2","0","5","311","0","0","0","0","0","0","0","0"),
("management","312","9","admin/content/webform","admin/content/webform","Webforms","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:54:\"View and edit all the available webforms on your site.\";}}","system","-1","0","0","0","0","3","0","1","9","312","0","0","0","0","0","0","0"),
("management","313","12","admin/help/webform","admin/help/webform","webform","a:0:{}","system","-1","0","0","0","0","3","0","1","12","313","0","0","0","0","0","0","0"),
("navigation","314","309","node/%/webform-results/analysis","node/%/webform-results/analysis","Analysis","a:0:{}","system","-1","0","0","0","5","3","0","5","309","314","0","0","0","0","0","0","0"),
("navigation","315","311","node/%/webform/configure","node/%/webform/configure","Form settings","a:0:{}","system","-1","0","0","0","5","3","0","5","311","315","0","0","0","0","0","0","0"),
("navigation","316","309","node/%/webform-results/submissions","node/%/webform-results/submissions","Submissions","a:0:{}","system","-1","0","0","0","4","3","0","5","309","316","0","0","0","0","0","0","0"),
("navigation","317","309","node/%/webform-results/table","node/%/webform-results/table","Table","a:0:{}","system","-1","0","0","0","6","3","0","5","309","317","0","0","0","0","0","0","0"),
("navigation","318","309","node/%/webform-results/clear","node/%/webform-results/clear","Clear","a:0:{}","system","-1","0","0","0","8","3","0","5","309","318","0","0","0","0","0","0","0"),
("navigation","319","311","node/%/webform/conditionals","node/%/webform/conditionals","Conditionals","a:0:{}","system","-1","0","0","0","1","3","0","5","311","319","0","0","0","0","0","0","0"),
("navigation","320","309","node/%/webform-results/download","node/%/webform-results/download","Download","a:0:{}","system","-1","0","0","0","7","3","0","5","309","320","0","0","0","0","0","0","0"),
("navigation","321","311","node/%/webform/emails","node/%/webform/emails","E-mails","a:0:{}","system","-1","0","0","0","4","3","0","5","311","321","0","0","0","0","0","0","0"),
("navigation","322","311","node/%/webform/components","node/%/webform/components","Form components","a:0:{}","system","-1","0","0","0","0","3","0","5","311","322","0","0","0","0","0","0","0"),
("management","323","36","admin/config/content/webform","admin/config/content/webform","Webform settings","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Global configuration of webform functionality.\";}}","system","0","0","0","0","0","4","0","1","8","36","323","0","0","0","0","0","0"),
("navigation","324","321","node/%/webform/emails/%","node/%/webform/emails/%","","a:0:{}","system","-1","0","0","0","0","4","0","5","311","321","324","0","0","0","0","0","0"),
("navigation","325","314","node/%/webform-results/analysis/%","node/%/webform-results/analysis/%","Analysis","a:0:{}","system","-1","0","0","0","0","4","0","5","309","314","325","0","0","0","0","0","0"),
("navigation","326","5","node/%/submission/%/delete","node/%/submission/%/delete","Delete","a:0:{}","system","-1","0","0","0","2","2","0","5","326","0","0","0","0","0","0","0","0"),
("navigation","327","5","node/%/submission/%/edit","node/%/submission/%/edit","Edit","a:0:{}","system","-1","0","0","0","1","2","0","5","327","0","0","0","0","0","0","0","0"),
("navigation","328","322","node/%/webform/components/%","node/%/webform/components/%","","a:0:{}","system","-1","0","0","0","0","4","0","5","311","322","328","0","0","0","0","0","0"),
("navigation","329","5","node/%/submission/%/view","node/%/submission/%/view","View","a:0:{}","system","-1","0","0","0","0","2","0","5","329","0","0","0","0","0","0","0","0"),
("navigation","330","325","node/%/webform-results/analysis/%/more","node/%/webform-results/analysis/%/more","In-depth analysis","a:0:{}","system","-1","0","0","0","0","5","0","5","309","314","325","330","0","0","0","0","0"),
("navigation","331","324","node/%/webform/emails/%/delete","node/%/webform/emails/%/delete","","a:0:{}","system","-1","0","0","0","0","5","0","5","311","321","324","331","0","0","0","0","0"),
("navigation","332","324","node/%/webform/emails/%/clone","node/%/webform/emails/%/clone","","a:0:{}","system","-1","0","0","0","0","5","0","5","311","321","324","332","0","0","0","0","0"),
("navigation","333","328","node/%/webform/components/%/delete","node/%/webform/components/%/delete","","a:0:{}","system","-1","0","0","0","0","5","0","5","311","322","328","333","0","0","0","0","0"),
("navigation","334","328","node/%/webform/components/%/clone","node/%/webform/components/%/clone","","a:0:{}","system","-1","0","0","0","0","5","0","5","311","322","328","334","0","0","0","0","0"),
("management","335","12","admin/help/ckeditor","admin/help/ckeditor","ckeditor","a:0:{}","system","-1","0","0","0","0","3","0","1","12","335","0","0","0","0","0","0","0"),
("management","336","36","admin/config/content/ckeditor","admin/config/content/ckeditor","CKEditor","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Configure the rich text editor.\";}}","system","0","0","0","0","0","4","0","1","8","36","336","0","0","0","0","0","0"),
("management","337","12","admin/help/metatag","admin/help/metatag","metatag","a:0:{}","system","-1","0","0","0","0","3","0","1","12","337","0","0","0","0","0","0","0"),
("management","338","12","admin/help/token","admin/help/token","token","a:0:{}","system","-1","0","0","0","0","3","0","1","12","338","0","0","0","0","0","0","0");
INSERT INTO menu_links VALUES
("management","339","54","admin/config/search/metatags","admin/config/search/metatags","Metatag","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:27:\"Configure Metatag defaults.\";}}","system","0","0","0","0","0","4","0","1","8","54","339","0","0","0","0","0","0"),
("management","340","339","admin/config/search/metatags/bulk-revert","admin/config/search/metatags/bulk-revert","Bulk revert","a:0:{}","system","-1","0","0","0","40","5","0","1","8","54","339","340","0","0","0","0","0"),
("management","341","339","admin/config/search/metatags/config","admin/config/search/metatags/config","Defaults","a:0:{}","system","-1","0","1","0","-10","5","0","1","8","54","339","341","0","0","0","0","0"),
("management","342","339","admin/config/search/metatags/settings","admin/config/search/metatags/settings","Settings","a:0:{}","system","-1","0","0","0","30","5","0","1","8","54","339","342","0","0","0","0","0"),
("management","343","341","admin/config/search/metatags/config/%","admin/config/search/metatags/config/%","","a:0:{}","system","0","0","1","0","0","6","0","1","8","54","339","341","343","0","0","0","0"),
("management","344","341","admin/config/search/metatags/config/add","admin/config/search/metatags/config/add","Add default meta tags","a:0:{}","system","-1","0","0","0","0","6","0","1","8","54","339","341","344","0","0","0","0"),
("management","345","271","admin/structure/taxonomy/%/display/token","admin/structure/taxonomy/%/display/token","Tokens","a:0:{}","system","-1","0","0","0","1","6","0","1","21","58","90","271","345","0","0","0","0"),
("management","346","272","admin/config/people/accounts/display/token","admin/config/people/accounts/display/token","Tokens","a:0:{}","system","-1","0","0","0","1","6","0","1","8","49","91","272","346","0","0","0","0"),
("management","347","343","admin/config/search/metatags/config/%/delete","admin/config/search/metatags/config/%/delete","Delete","a:0:{}","system","0","0","0","0","0","7","0","1","8","54","339","341","343","347","0","0","0"),
("management","348","343","admin/config/search/metatags/config/%/disable","admin/config/search/metatags/config/%/disable","Disable","a:0:{}","system","0","0","0","0","0","7","0","1","8","54","339","341","343","348","0","0","0"),
("management","349","343","admin/config/search/metatags/config/%/edit","admin/config/search/metatags/config/%/edit","Edit","a:0:{}","system","-1","0","0","0","-10","7","0","1","8","54","339","341","343","349","0","0","0"),
("management","350","343","admin/config/search/metatags/config/%/enable","admin/config/search/metatags/config/%/enable","Enable","a:0:{}","system","0","0","0","0","0","7","0","1","8","54","339","341","343","350","0","0","0"),
("management","351","343","admin/config/search/metatags/config/%/export","admin/config/search/metatags/config/%/export","Export","a:0:{}","system","-1","0","0","0","10","7","0","1","8","54","339","341","343","351","0","0","0"),
("management","352","343","admin/config/search/metatags/config/%/revert","admin/config/search/metatags/config/%/revert","Revert","a:0:{}","system","-1","0","0","0","0","7","0","1","8","54","339","341","343","352","0","0","0"),
("management","353","277","admin/structure/types/manage/%/display/token","admin/structure/types/manage/%/display/token","Tokens","a:0:{}","system","-1","0","0","0","5","6","0","1","21","37","136","277","353","0","0","0","0"),
("management","354","174","admin/structure/types/manage/%/comment/display/token","admin/structure/types/manage/%/comment/display/token","Tokens","a:0:{}","system","-1","0","0","0","1","6","0","1","21","37","136","174","354","0","0","0","0"),
("management","355","57","admin/config/system/securepages","admin/config/system/securepages","Secure Pages","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:57:\"Configure which pages are and are not to be viewed in SSL\";}}","system","0","0","0","0","0","4","0","1","8","57","355","0","0","0","0","0","0"),
("management","356","12","admin/help/redirect","admin/help/redirect","redirect","a:0:{}","system","-1","0","0","0","0","3","0","1","12","356","0","0","0","0","0","0","0"),
("management","357","60","admin/reports/page-not-found/redirect","admin/reports/page-not-found/redirect","Fix 404 pages with URL redirects","a:0:{}","system","-1","0","0","0","0","4","0","1","19","60","357","0","0","0","0","0","0"),
("management","358","54","admin/config/search/redirect","admin/config/search/redirect","URL redirects","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Redirect users from one URL to another.\";}}","system","0","0","1","0","0","4","0","1","8","54","358","0","0","0","0","0","0"),
("management","359","358","admin/config/search/redirect/add","admin/config/search/redirect/add","Add redirect","a:0:{}","system","-1","0","0","0","0","5","0","1","8","54","358","359","0","0","0","0","0"),
("management","360","358","admin/config/search/redirect/404","admin/config/search/redirect/404","Fix 404 pages","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Add redirects for 404 pages.\";}}","system","-1","0","0","0","20","5","0","1","8","54","358","360","0","0","0","0","0"),
("management","361","358","admin/config/search/redirect/list","admin/config/search/redirect/list","List","a:0:{}","system","-1","0","0","0","-10","5","0","1","8","54","358","361","0","0","0","0","0"),
("management","362","358","admin/config/search/redirect/settings","admin/config/search/redirect/settings","Settings","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Configure behavior for URL redirects.\";}}","system","-1","0","0","0","50","5","0","1","8","54","358","362","0","0","0","0","0"),
("management","363","358","admin/config/search/redirect/delete/%","admin/config/search/redirect/delete/%","Delete redirect","a:0:{}","system","0","0","0","0","0","5","0","1","8","54","358","363","0","0","0","0","0"),
("management","364","358","admin/config/search/redirect/edit/%","admin/config/search/redirect/edit/%","Edit redirect","a:0:{}","system","0","0","0","0","0","5","0","1","8","54","358","364","0","0","0","0","0"),
("management","365","12","admin/help/page_title","admin/help/page_title","page_title","a:0:{}","system","-1","0","0","0","0","3","0","1","12","365","0","0","0","0","0","0","0"),
("navigation","366","0","admin/reports/page-title","admin/reports/page-title","Page Title List","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"List all nodes with their Page Titles\";}}","system","0","0","0","0","0","1","0","366","0","0","0","0","0","0","0","0","0"),
("management","367","54","admin/config/search/page-title","admin/config/search/page-title","Page titles","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:76:\"Configure the page titles for your site (the title in the &lt;head&gt; tag).\";}}","system","0","0","0","0","0","4","0","1","8","54","367","0","0","0","0","0","0"),
("management","368","12","admin/help/globalredirect","admin/help/globalredirect","globalredirect","a:0:{}","system","-1","0","0","0","0","3","0","1","12","368","0","0","0","0","0","0","0"),
("management","369","57","admin/config/system/globalredirect","admin/config/system/globalredirect","Global Redirect","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:63:\"Chose which features you would like enabled for Global Redirect\";}}","system","0","0","0","0","0","4","0","1","8","57","369","0","0","0","0","0","0"),
("management","370","54","admin/config/search/search404","admin/config/search/search404","Search 404 settings","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:69:\"Configure searching for keywords from URLs that result in 404 errors.\";}}","system","0","0","0","0","0","4","0","1","8","54","370","0","0","0","0","0","0"),
("management","371","12","admin/help/xmlsitemap","admin/help/xmlsitemap","xmlsitemap","a:0:{}","system","-1","0","0","0","0","3","0","1","12","371","0","0","0","0","0","0","0"),
("management","372","54","admin/config/search/xmlsitemap","admin/config/search/xmlsitemap","XML sitemap","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:92:\"Configure your site\'s XML sitemaps to help search engines find and index pages on your site.\";}}","system","0","0","1","0","0","4","0","1","8","54","372","0","0","0","0","0","0"),
("management","373","372","admin/config/search/xmlsitemap/list","admin/config/search/xmlsitemap/list","List","a:0:{}","system","-1","0","0","0","-10","5","0","1","8","54","372","373","0","0","0","0","0"),
("management","374","372","admin/config/search/xmlsitemap/rebuild","admin/config/search/xmlsitemap/rebuild","Rebuild links","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:21:\"Rebuild the site map.\";}}","system","-1","0","0","0","20","5","0","1","8","54","372","374","0","0","0","0","0"),
("management","375","372","admin/config/search/xmlsitemap/settings","admin/config/search/xmlsitemap/settings","Settings","a:0:{}","system","-1","0","1","0","10","5","0","1","8","54","372","375","0","0","0","0","0"),
("management","376","372","admin/config/search/xmlsitemap/add","admin/config/search/xmlsitemap/add","Add new XML sitemap","a:1:{s:5:\"modal\";b:1;}","system","-1","0","0","0","0","5","0","1","8","54","372","376","0","0","0","0","0"),
("management","377","372","admin/config/search/xmlsitemap/edit/%","admin/config/search/xmlsitemap/edit/%","Edit XML sitemap","a:0:{}","system","0","0","0","0","0","5","0","1","8","54","372","377","0","0","0","0","0"),
("management","378","372","admin/config/search/xmlsitemap/delete/%","admin/config/search/xmlsitemap/delete/%","Delete XML sitemap","a:0:{}","system","0","0","0","0","0","5","0","1","8","54","372","378","0","0","0","0","0"),
("management","379","375","admin/config/search/xmlsitemap/settings/%/%","admin/config/search/xmlsitemap/settings/%/%","","a:0:{}","system","0","0","0","0","0","6","0","1","8","54","372","375","379","0","0","0","0"),
("management","380","12","admin/help/pathauto","admin/help/pathauto","pathauto","a:0:{}","system","-1","0","0","0","0","3","0","1","12","380","0","0","0","0","0","0","0"),
("management","381","203","admin/config/search/path/update_bulk","admin/config/search/path/update_bulk","Bulk generate","a:0:{}","system","-1","0","0","0","30","5","0","1","8","54","203","381","0","0","0","0","0"),
("management","382","203","admin/config/search/path/delete_bulk","admin/config/search/path/delete_bulk","Delete aliases","a:0:{}","system","-1","0","0","0","40","5","0","1","8","54","203","382","0","0","0","0","0"),
("management","383","203","admin/config/search/path/patterns","admin/config/search/path/patterns","Patterns","a:0:{}","system","-1","0","0","0","10","5","0","1","8","54","203","383","0","0","0","0","0"),
("management","384","203","admin/config/search/path/settings","admin/config/search/path/settings","Settings","a:0:{}","system","-1","0","0","0","20","5","0","1","8","54","203","384","0","0","0","0","0"),
("management","385","12","admin/help/sendgrid_integration","admin/help/sendgrid_integration","sendgrid_integration","a:0:{}","system","-1","0","0","0","0","3","0","1","12","385","0","0","0","0","0","0","0"),
("management","386","57","admin/config/system/composer-manager","admin/config/system/composer-manager","Composer Manager","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:122:\"View the status of packages managed by Composer and configure the location of the composer.json file and verdor directory.\";}}","system","0","0","0","0","0","4","0","1","8","57","386","0","0","0","0","0","0"),
("management","387","57","admin/config/system/mailsystem","admin/config/system/mailsystem","Mail System","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"Configure per-module Mail System settings.\";}}","system","0","0","0","0","0","4","0","1","8","57","387","0","0","0","0","0","0"),
("management","388","65","admin/config/services/sendgrid","admin/config/services/sendgrid","SendGrid Settings","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:29:\"SendGrid Integration Settings\";}}","system","0","0","0","0","1","4","0","1","8","65","388","0","0","0","0","0","0"),
("management","389","388","admin/config/services/sendgrid/default","admin/config/services/sendgrid/default","Administer SendGrid Integration","a:0:{}","system","-1","0","0","0","0","5","0","1","8","65","388","389","0","0","0","0","0"),
("management","390","386","admin/config/system/composer-manager/packages","admin/config/system/composer-manager/packages","Packages","a:0:{}","system","-1","0","0","0","-10","5","0","1","8","57","386","390","0","0","0","0","0"),
("management","391","388","admin/config/services/sendgrid/test","admin/config/services/sendgrid/test","SendGrid Test Email Send","a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:35:\"Send a test email through sendgrid.\";}}","system","-1","0","0","0","50","5","0","1","8","65","388","391","0","0","0","0","0"),
("management","392","386","admin/config/system/composer-manager/settings","admin/config/system/composer-manager/settings","Settings","a:0:{}","system","-1","0","0","0","0","5","0","1","8","57","386","392","0","0","0","0","0");




CREATE TABLE `menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.',
  PRIMARY KEY (`path`),
  KEY `fit` (`fit`),
  KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';


INSERT INTO menu_router VALUES
("admin","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","1","1","0","","admin","Administration","t","","","a:0:{}","6","","","9","modules/system/system.admin.inc"),
("admin/appearance","","","user_access","a:1:{i:0;s:17:\"administer themes\";}","system_themes_page","a:0:{}","","3","2","0","","admin/appearance","Appearance","t","","","a:0:{}","6","Select and configure your themes.","left","-6","modules/system/system.admin.inc"),
("admin/appearance/default","","","user_access","a:1:{i:0;s:17:\"administer themes\";}","system_theme_default","a:0:{}","","7","3","0","","admin/appearance/default","Set default theme","t","","","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("admin/appearance/disable","","","user_access","a:1:{i:0;s:17:\"administer themes\";}","system_theme_disable","a:0:{}","","7","3","0","","admin/appearance/disable","Disable theme","t","","","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("admin/appearance/enable","","","user_access","a:1:{i:0;s:17:\"administer themes\";}","system_theme_enable","a:0:{}","","7","3","0","","admin/appearance/enable","Enable theme","t","","","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("admin/appearance/install","","","update_manager_access","a:0:{}","drupal_get_form","a:2:{i:0;s:27:\"update_manager_install_form\";i:1;s:5:\"theme\";}","","7","3","1","admin/appearance","admin/appearance","Install new theme","t","","","a:0:{}","388","","","25","modules/update/update.manager.inc"),
("admin/appearance/list","","","user_access","a:1:{i:0;s:17:\"administer themes\";}","system_themes_page","a:0:{}","","7","3","1","admin/appearance","admin/appearance","List","t","","","a:0:{}","140","Select and configure your theme","","-1","modules/system/system.admin.inc"),
("admin/appearance/settings","","","user_access","a:1:{i:0;s:17:\"administer themes\";}","drupal_get_form","a:1:{i:0;s:21:\"system_theme_settings\";}","","7","3","1","admin/appearance","admin/appearance","Settings","t","","","a:0:{}","132","Configure default and theme specific settings.","","20","modules/system/system.admin.inc"),
("admin/appearance/settings/bartik","","","_system_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","drupal_get_form","a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:6:\"bartik\";}","","15","4","1","admin/appearance/settings","admin/appearance","Bartik","t","","","a:0:{}","132","","","0","modules/system/system.admin.inc"),
("admin/appearance/settings/garland","","","_system_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","drupal_get_form","a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:7:\"garland\";}","","15","4","1","admin/appearance/settings","admin/appearance","Garland","t","","","a:0:{}","132","","","0","modules/system/system.admin.inc"),
("admin/appearance/settings/global","","","user_access","a:1:{i:0;s:17:\"administer themes\";}","drupal_get_form","a:1:{i:0;s:21:\"system_theme_settings\";}","","15","4","1","admin/appearance/settings","admin/appearance","Global settings","t","","","a:0:{}","140","","","-1","modules/system/system.admin.inc"),
("admin/appearance/settings/seven","","","_system_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","drupal_get_form","a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:5:\"seven\";}","","15","4","1","admin/appearance/settings","admin/appearance","Seven","t","","","a:0:{}","132","","","0","modules/system/system.admin.inc"),
("admin/appearance/settings/stark","","","_system_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","drupal_get_form","a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:5:\"stark\";}","","15","4","1","admin/appearance/settings","admin/appearance","Stark","t","","","a:0:{}","132","","","0","modules/system/system.admin.inc"),
("admin/appearance/update","","","update_manager_access","a:0:{}","drupal_get_form","a:2:{i:0;s:26:\"update_manager_update_form\";i:1;s:5:\"theme\";}","","7","3","1","admin/appearance","admin/appearance","Update","t","","","a:0:{}","132","","","10","modules/update/update.manager.inc"),
("admin/compact","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_compact_page","a:0:{}","","3","2","0","","admin/compact","Compact mode","t","","","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("admin/config","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_config_page","a:0:{}","","3","2","0","","admin/config","Configuration","t","","","a:0:{}","6","Administer settings.","","0","modules/system/system.admin.inc"),
("admin/config/content","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","7","3","0","","admin/config/content","Content authoring","t","","","a:0:{}","6","Settings related to formatting and authoring content.","left","-15","modules/system/system.admin.inc"),
("admin/config/content/ckeditor","","","user_access","a:1:{i:0;s:19:\"administer ckeditor\";}","ckeditor_admin_main","a:0:{}","","15","4","0","","admin/config/content/ckeditor","CKEditor","t","","","a:0:{}","6","Configure the rich text editor.","","0","sites/all/modules/ckeditor/includes/ckeditor.admin.inc"),
("admin/config/content/ckeditor/add","","","user_access","a:1:{i:0;s:19:\"administer ckeditor\";}","drupal_get_form","a:2:{i:0;s:27:\"ckeditor_admin_profile_form\";i:1;s:3:\"add\";}","","31","5","0","","admin/config/content/ckeditor/add","Add a new CKEditor profile","t","","","a:0:{}","0","Configure the rich text editor.","","0","sites/all/modules/ckeditor/includes/ckeditor.admin.inc"),
("admin/config/content/ckeditor/addg","","","user_access","a:1:{i:0;s:19:\"administer ckeditor\";}","drupal_get_form","a:2:{i:0;s:34:\"ckeditor_admin_global_profile_form\";i:1;s:3:\"add\";}","","31","5","0","","admin/config/content/ckeditor/addg","Add the CKEditor Global profile","t","","","a:0:{}","0","Configure the rich text editor.","","0","sites/all/modules/ckeditor/includes/ckeditor.admin.inc"),
("admin/config/content/ckeditor/clone/%","a:1:{i:5;s:21:\"ckeditor_profile_load\";}","","user_access","a:1:{i:0;s:19:\"administer ckeditor\";}","drupal_get_form","a:3:{i:0;s:33:\"ckeditor_admin_profile_clone_form\";i:1;s:5:\"clone\";i:2;i:5;}","","62","6","0","","admin/config/content/ckeditor/clone/%","Clone the CKEditor profile","t","","","a:0:{}","0","Configure the rich text editor.","","0","sites/all/modules/ckeditor/includes/ckeditor.admin.inc"),
("admin/config/content/ckeditor/delete/%","a:1:{i:5;s:21:\"ckeditor_profile_load\";}","","user_access","a:1:{i:0;s:19:\"administer ckeditor\";}","drupal_get_form","a:2:{i:0;s:34:\"ckeditor_admin_profile_delete_form\";i:1;i:5;}","","62","6","0","","admin/config/content/ckeditor/delete/%","Delete the CKEditor profile","t","","","a:0:{}","0","Configure the rich text editor.","","0","sites/all/modules/ckeditor/includes/ckeditor.admin.inc"),
("admin/config/content/ckeditor/edit/%","a:1:{i:5;s:21:\"ckeditor_profile_load\";}","","user_access","a:1:{i:0;s:19:\"administer ckeditor\";}","drupal_get_form","a:3:{i:0;s:27:\"ckeditor_admin_profile_form\";i:1;s:4:\"edit\";i:2;i:5;}","","62","6","0","","admin/config/content/ckeditor/edit/%","Edit the CKEditor profile","t","","","a:0:{}","0","Configure the rich text editor.","","0","sites/all/modules/ckeditor/includes/ckeditor.admin.inc"),
("admin/config/content/ckeditor/editg","","","user_access","a:1:{i:0;s:19:\"administer ckeditor\";}","drupal_get_form","a:2:{i:0;s:34:\"ckeditor_admin_global_profile_form\";i:1;s:4:\"edit\";}","","31","5","0","","admin/config/content/ckeditor/editg","Edit the CKEditor Global profile","t","","","a:0:{}","0","Configure the rich text editor.","","0","sites/all/modules/ckeditor/includes/ckeditor.admin.inc"),
("admin/config/content/ckeditor/skinframe","","","user_access","a:1:{i:0;s:19:\"administer ckeditor\";}","ckeditor_skinframe","a:0:{}","","31","5","0","","admin/config/content/ckeditor/skinframe","Change skin of CKEditor","t","","","a:0:{}","0","Configure skin for CKEditor.","","0","sites/all/modules/ckeditor/includes/ckeditor.admin.inc"),
("admin/config/content/formats","","","user_access","a:1:{i:0;s:18:\"administer filters\";}","drupal_get_form","a:1:{i:0;s:21:\"filter_admin_overview\";}","","15","4","0","","admin/config/content/formats","Text formats","t","","","a:0:{}","6","Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.","","0","modules/filter/filter.admin.inc"),
("admin/config/content/formats/%","a:1:{i:4;s:18:\"filter_format_load\";}","","user_access","a:1:{i:0;s:18:\"administer filters\";}","filter_admin_format_page","a:1:{i:0;i:4;}","","30","5","0","","admin/config/content/formats/%","","filter_admin_format_title","a:1:{i:0;i:4;}","","a:0:{}","6","","","0","modules/filter/filter.admin.inc"),
("admin/config/content/formats/%/disable","a:1:{i:4;s:18:\"filter_format_load\";}","","_filter_disable_format_access","a:1:{i:0;i:4;}","drupal_get_form","a:2:{i:0;s:20:\"filter_admin_disable\";i:1;i:4;}","","61","6","0","","admin/config/content/formats/%/disable","Disable text format","t","","","a:0:{}","6","","","0","modules/filter/filter.admin.inc"),
("admin/config/content/formats/add","","","user_access","a:1:{i:0;s:18:\"administer filters\";}","filter_admin_format_page","a:0:{}","","31","5","1","admin/config/content/formats","admin/config/content/formats","Add text format","t","","","a:0:{}","388","","","1","modules/filter/filter.admin.inc"),
("admin/config/content/formats/list","","","user_access","a:1:{i:0;s:18:\"administer filters\";}","drupal_get_form","a:1:{i:0;s:21:\"filter_admin_overview\";}","","31","5","1","admin/config/content/formats","admin/config/content/formats","List","t","","","a:0:{}","140","","","0","modules/filter/filter.admin.inc"),
("admin/config/content/webform","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:22:\"webform_admin_settings\";}","","15","4","0","","admin/config/content/webform","Webform settings","t","","","a:0:{}","6","Global configuration of webform functionality.","","0","sites/all/modules/webform/includes/webform.admin.inc"),
("admin/config/development","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","7","3","0","","admin/config/development","Development","t","","","a:0:{}","6","Development tools.","right","-10","modules/system/system.admin.inc"),
("admin/config/development/logging","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:23:\"system_logging_settings\";}","","15","4","0","","admin/config/development/logging","Logging and errors","t","","","a:0:{}","6","Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.","","-15","modules/system/system.admin.inc"),
("admin/config/development/maintenance","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:28:\"system_site_maintenance_mode\";}","","15","4","0","","admin/config/development/maintenance","Maintenance mode","t","","","a:0:{}","6","Take the site offline for maintenance or bring it back online.","","-10","modules/system/system.admin.inc"),
("admin/config/development/performance","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:27:\"system_performance_settings\";}","","15","4","0","","admin/config/development/performance","Performance","t","","","a:0:{}","6","Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.","","-20","modules/system/system.admin.inc"),
("admin/config/media","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","7","3","0","","admin/config/media","Media","t","","","a:0:{}","6","Media tools.","left","-10","modules/system/system.admin.inc"),
("admin/config/media/file-system","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:27:\"system_file_system_settings\";}","","15","4","0","","admin/config/media/file-system","File system","t","","","a:0:{}","6","Tell Drupal where to store uploaded files and how they are accessed.","","-10","modules/system/system.admin.inc"),
("admin/config/media/image-styles","","","user_access","a:1:{i:0;s:23:\"administer image styles\";}","image_style_list","a:0:{}","","15","4","0","","admin/config/media/image-styles","Image styles","t","","","a:0:{}","6","Configure styles that can be used for resizing or adjusting images on display.","","0","modules/image/image.admin.inc"),
("admin/config/media/image-styles/add","","","user_access","a:1:{i:0;s:23:\"administer image styles\";}","drupal_get_form","a:1:{i:0;s:20:\"image_style_add_form\";}","","31","5","1","admin/config/media/image-styles","admin/config/media/image-styles","Add style","t","","","a:0:{}","388","Add a new image style.","","2","modules/image/image.admin.inc"),
("admin/config/media/image-styles/delete/%","a:1:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;N;i:1;s:1:\"1\";}}}","","user_access","a:1:{i:0;s:23:\"administer image styles\";}","drupal_get_form","a:2:{i:0;s:23:\"image_style_delete_form\";i:1;i:5;}","","62","6","0","","admin/config/media/image-styles/delete/%","Delete style","t","","","a:0:{}","6","Delete an image style.","","0","modules/image/image.admin.inc"),
("admin/config/media/image-styles/edit/%","a:1:{i:5;s:16:\"image_style_load\";}","","user_access","a:1:{i:0;s:23:\"administer image styles\";}","drupal_get_form","a:2:{i:0;s:16:\"image_style_form\";i:1;i:5;}","","62","6","0","","admin/config/media/image-styles/edit/%","Edit style","t","","","a:0:{}","6","Configure an image style.","","0","modules/image/image.admin.inc"),
("admin/config/media/image-styles/edit/%/add/%","a:2:{i:5;a:1:{s:16:\"image_style_load\";a:1:{i:0;i:5;}}i:7;a:1:{s:28:\"image_effect_definition_load\";a:1:{i:0;i:5;}}}","","user_access","a:1:{i:0;s:23:\"administer image styles\";}","drupal_get_form","a:3:{i:0;s:17:\"image_effect_form\";i:1;i:5;i:2;i:7;}","","250","8","0","","admin/config/media/image-styles/edit/%/add/%","Add image effect","t","","","a:0:{}","6","Add a new effect to a style.","","0","modules/image/image.admin.inc"),
("admin/config/media/image-styles/edit/%/effects/%","a:2:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}i:7;a:1:{s:17:\"image_effect_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}}","","user_access","a:1:{i:0;s:23:\"administer image styles\";}","drupal_get_form","a:3:{i:0;s:17:\"image_effect_form\";i:1;i:5;i:2;i:7;}","","250","8","0","","admin/config/media/image-styles/edit/%/effects/%","Edit image effect","t","","","a:0:{}","6","Edit an existing effect within a style.","","0","modules/image/image.admin.inc"),
("admin/config/media/image-styles/edit/%/effects/%/delete","a:2:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}i:7;a:1:{s:17:\"image_effect_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}}","","user_access","a:1:{i:0;s:23:\"administer image styles\";}","drupal_get_form","a:3:{i:0;s:24:\"image_effect_delete_form\";i:1;i:5;i:2;i:7;}","","501","9","0","","admin/config/media/image-styles/edit/%/effects/%/delete","Delete image effect","t","","","a:0:{}","6","Delete an existing effect from a style.","","0","modules/image/image.admin.inc"),
("admin/config/media/image-styles/list","","","user_access","a:1:{i:0;s:23:\"administer image styles\";}","image_style_list","a:0:{}","","31","5","1","admin/config/media/image-styles","admin/config/media/image-styles","List","t","","","a:0:{}","140","List the current image styles on the site.","","1","modules/image/image.admin.inc"),
("admin/config/media/image-styles/revert/%","a:1:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;N;i:1;s:1:\"2\";}}}","","user_access","a:1:{i:0;s:23:\"administer image styles\";}","drupal_get_form","a:2:{i:0;s:23:\"image_style_revert_form\";i:1;i:5;}","","62","6","0","","admin/config/media/image-styles/revert/%","Revert style","t","","","a:0:{}","6","Revert an image style.","","0","modules/image/image.admin.inc"),
("admin/config/media/image-toolkit","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:29:\"system_image_toolkit_settings\";}","","15","4","0","","admin/config/media/image-toolkit","Image toolkit","t","","","a:0:{}","6","Choose which image toolkit to use if you have installed optional toolkits.","","20","modules/system/system.admin.inc"),
("admin/config/people","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","7","3","0","","admin/config/people","People","t","","","a:0:{}","6","Configure user accounts.","left","-20","modules/system/system.admin.inc"),
("admin/config/people/accounts","","","user_access","a:1:{i:0;s:16:\"administer users\";}","drupal_get_form","a:1:{i:0;s:19:\"user_admin_settings\";}","","15","4","0","","admin/config/people/accounts","Account settings","t","","","a:0:{}","6","Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.","","-10","modules/user/user.admin.inc"),
("admin/config/people/accounts/display","","","user_access","a:1:{i:0;s:16:\"administer users\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:7:\"default\";}","","31","5","1","admin/config/people/accounts","admin/config/people/accounts","Manage display","t","","","a:0:{}","132","","","2","modules/field_ui/field_ui.admin.inc"),
("admin/config/people/accounts/display/default","","","_field_ui_view_mode_menu_access","a:5:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:16:\"administer users\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:7:\"default\";}","","63","6","1","admin/config/people/accounts/display","admin/config/people/accounts","Default","t","","","a:0:{}","140","","","-10","modules/field_ui/field_ui.admin.inc"),
("admin/config/people/accounts/display/full","","","_field_ui_view_mode_menu_access","a:5:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:16:\"administer users\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:4:\"full\";}","","63","6","1","admin/config/people/accounts/display","admin/config/people/accounts","User account","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/config/people/accounts/display/token","","","_field_ui_view_mode_menu_access","a:5:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:5:\"token\";i:3;s:11:\"user_access\";i:4;s:16:\"administer users\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:5:\"token\";}","","63","6","1","admin/config/people/accounts/display","admin/config/people/accounts","Tokens","t","","","a:0:{}","132","","","1","modules/field_ui/field_ui.admin.inc"),
("admin/config/people/accounts/fields","","","user_access","a:1:{i:0;s:16:\"administer users\";}","drupal_get_form","a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";}","","31","5","1","admin/config/people/accounts","admin/config/people/accounts","Manage fields","t","","","a:0:{}","132","","","1","modules/field_ui/field_ui.admin.inc"),
("admin/config/people/accounts/fields/%","a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:16:\"administer users\";}","drupal_get_form","a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}","","62","6","0","","admin/config/people/accounts/fields/%","","field_ui_menu_title","a:1:{i:0;i:5;}","","a:0:{}","6","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/config/people/accounts/fields/%/delete","a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:16:\"administer users\";}","drupal_get_form","a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:5;}","","125","7","1","admin/config/people/accounts/fields/%","admin/config/people/accounts/fields/%","Delete","t","","","a:0:{}","132","","","10","modules/field_ui/field_ui.admin.inc"),
("admin/config/people/accounts/fields/%/edit","a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:16:\"administer users\";}","drupal_get_form","a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}","","125","7","1","admin/config/people/accounts/fields/%","admin/config/people/accounts/fields/%","Edit","t","","","a:0:{}","140","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/config/people/accounts/fields/%/field-settings","a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:16:\"administer users\";}","drupal_get_form","a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:5;}","","125","7","1","admin/config/people/accounts/fields/%","admin/config/people/accounts/fields/%","Field settings","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/config/people/accounts/fields/%/widget-type","a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:16:\"administer users\";}","drupal_get_form","a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:5;}","","125","7","1","admin/config/people/accounts/fields/%","admin/config/people/accounts/fields/%","Widget type","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/config/people/accounts/settings","","","user_access","a:1:{i:0;s:16:\"administer users\";}","drupal_get_form","a:1:{i:0;s:19:\"user_admin_settings\";}","","31","5","1","admin/config/people/accounts","admin/config/people/accounts","Settings","t","","","a:0:{}","140","","","-10","modules/user/user.admin.inc"),
("admin/config/people/ip-blocking","","","user_access","a:1:{i:0;s:18:\"block IP addresses\";}","system_ip_blocking","a:0:{}","","15","4","0","","admin/config/people/ip-blocking","IP address blocking","t","","","a:0:{}","6","Manage blocked IP addresses.","","10","modules/system/system.admin.inc"),
("admin/config/people/ip-blocking/delete/%","a:1:{i:5;s:15:\"blocked_ip_load\";}","","user_access","a:1:{i:0;s:18:\"block IP addresses\";}","drupal_get_form","a:2:{i:0;s:25:\"system_ip_blocking_delete\";i:1;i:5;}","","62","6","0","","admin/config/people/ip-blocking/delete/%","Delete IP address","t","","","a:0:{}","6","","","0","modules/system/system.admin.inc"),
("admin/config/regional","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","7","3","0","","admin/config/regional","Regional and language","t","","","a:0:{}","6","Regional settings, localization and translation.","left","-5","modules/system/system.admin.inc"),
("admin/config/regional/date-time","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:25:\"system_date_time_settings\";}","","15","4","0","","admin/config/regional/date-time","Date and time","t","","","a:0:{}","6","Configure display formats for date and time.","","-15","modules/system/system.admin.inc"),
("admin/config/regional/date-time/formats","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","system_date_time_formats","a:0:{}","","31","5","1","admin/config/regional/date-time","admin/config/regional/date-time","Formats","t","","","a:0:{}","132","Configure display format strings for date and time.","","-9","modules/system/system.admin.inc"),
("admin/config/regional/date-time/formats/%/delete","a:1:{i:5;N;}","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:2:{i:0;s:30:\"system_date_delete_format_form\";i:1;i:5;}","","125","7","0","","admin/config/regional/date-time/formats/%/delete","Delete date format","t","","","a:0:{}","6","Allow users to delete a configured date format.","","0","modules/system/system.admin.inc"),
("admin/config/regional/date-time/formats/%/edit","a:1:{i:5;N;}","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:2:{i:0;s:34:\"system_configure_date_formats_form\";i:1;i:5;}","","125","7","0","","admin/config/regional/date-time/formats/%/edit","Edit date format","t","","","a:0:{}","6","Allow users to edit a configured date format.","","0","modules/system/system.admin.inc"),
("admin/config/regional/date-time/formats/add","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:34:\"system_configure_date_formats_form\";}","","63","6","1","admin/config/regional/date-time/formats","admin/config/regional/date-time","Add format","t","","","a:0:{}","388","Allow users to add additional date formats.","","-10","modules/system/system.admin.inc"),
("admin/config/regional/date-time/formats/lookup","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","system_date_time_lookup","a:0:{}","","63","6","0","","admin/config/regional/date-time/formats/lookup","Date and time lookup","t","","","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("admin/config/regional/date-time/types","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:25:\"system_date_time_settings\";}","","31","5","1","admin/config/regional/date-time","admin/config/regional/date-time","Types","t","","","a:0:{}","140","Configure display formats for date and time.","","-10","modules/system/system.admin.inc"),
("admin/config/regional/date-time/types/%/delete","a:1:{i:5;N;}","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:2:{i:0;s:35:\"system_delete_date_format_type_form\";i:1;i:5;}","","125","7","0","","admin/config/regional/date-time/types/%/delete","Delete date type","t","","","a:0:{}","6","Allow users to delete a configured date type.","","0","modules/system/system.admin.inc"),
("admin/config/regional/date-time/types/add","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:32:\"system_add_date_format_type_form\";}","","63","6","1","admin/config/regional/date-time/types","admin/config/regional/date-time","Add date type","t","","","a:0:{}","388","Add new date type.","","-10","modules/system/system.admin.inc"),
("admin/config/regional/settings","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:24:\"system_regional_settings\";}","","15","4","0","","admin/config/regional/settings","Regional settings","t","","","a:0:{}","6","Settings for the site\'s default time zone and country.","","-20","modules/system/system.admin.inc"),
("admin/config/search","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","7","3","0","","admin/config/search","Search and metadata","t","","","a:0:{}","6","Local site search, metadata and SEO.","left","-10","modules/system/system.admin.inc"),
("admin/config/search/clean-urls","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:25:\"system_clean_url_settings\";}","","15","4","0","","admin/config/search/clean-urls","Clean URLs","t","","","a:0:{}","6","Enable or disable clean URLs for your site.","","5","modules/system/system.admin.inc"),
("admin/config/search/clean-urls/check","","","1","a:0:{}","drupal_json_output","a:1:{i:0;a:1:{s:6:\"status\";b:1;}}","","31","5","0","","admin/config/search/clean-urls/check","Clean URL check","t","","","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("admin/config/search/metatags","","","user_access","a:1:{i:0;s:20:\"administer meta tags\";}","metatag_config_overview","a:0:{}","","15","4","0","","admin/config/search/metatags","Metatag","t","","","a:0:{}","6","Configure Metatag defaults.","","0","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/bulk-revert","","","user_access","a:1:{i:0;s:20:\"administer meta tags\";}","drupal_get_form","a:1:{i:0;s:24:\"metatag_bulk_revert_form\";}","","31","5","1","admin/config/search/metatags","admin/config/search/metatags","Bulk revert","t","","","a:0:{}","132","","","40","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/config","","","user_access","a:1:{i:0;s:20:\"administer meta tags\";}","metatag_config_overview","a:0:{}","","31","5","1","admin/config/search/metatags","admin/config/search/metatags","Defaults","t","","","a:0:{}","140","","","-10","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/config/%","a:1:{i:5;s:19:\"metatag_config_load\";}","","user_access","a:1:{i:0;s:20:\"administer meta tags\";}","drupal_get_form","a:2:{i:0;s:24:\"metatag_config_edit_form\";i:1;i:5;}","","62","6","0","","admin/config/search/metatags/config/%","","metatag_config_title","a:1:{i:0;i:5;}","","a:0:{}","6","","","0","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/config/%/delete","a:1:{i:5;s:19:\"metatag_config_load\";}","","metatag_config_access","a:2:{i:0;s:6:\"delete\";i:1;i:5;}","drupal_get_form","a:2:{i:0;s:26:\"metatag_config_delete_form\";i:1;i:5;}","","125","7","0","","admin/config/search/metatags/config/%/delete","Delete","t","","","a:0:{}","6","","","0","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/config/%/disable","a:1:{i:5;s:19:\"metatag_config_load\";}","","metatag_config_access","a:2:{i:0;s:7:\"disable\";i:1;i:5;}","metatag_config_disable","a:1:{i:0;i:5;}","","125","7","0","","admin/config/search/metatags/config/%/disable","Disable","t","","","a:0:{}","6","","","0","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/config/%/edit","a:1:{i:5;s:19:\"metatag_config_load\";}","","user_access","a:1:{i:0;s:20:\"administer meta tags\";}","drupal_get_form","a:2:{i:0;s:24:\"metatag_config_edit_form\";i:1;i:5;}","","125","7","1","admin/config/search/metatags/config/%","admin/config/search/metatags/config/%","Edit","t","","","a:0:{}","140","","","-10","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/config/%/enable","a:1:{i:5;s:19:\"metatag_config_load\";}","","metatag_config_access","a:2:{i:0;s:6:\"enable\";i:1;i:5;}","metatag_config_enable","a:1:{i:0;i:5;}","","125","7","0","","admin/config/search/metatags/config/%/enable","Enable","t","","","a:0:{}","6","","","0","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/config/%/export","a:1:{i:5;s:19:\"metatag_config_load\";}","","user_access","a:1:{i:0;s:20:\"administer meta tags\";}","metatag_config_export_form","a:1:{i:0;i:5;}","","125","7","1","admin/config/search/metatags/config/%","admin/config/search/metatags/config/%","Export","t","","","a:0:{}","132","","","10","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/config/%/revert","a:1:{i:5;s:19:\"metatag_config_load\";}","","metatag_config_access","a:2:{i:0;s:6:\"revert\";i:1;i:5;}","drupal_get_form","a:2:{i:0;s:26:\"metatag_config_delete_form\";i:1;i:5;}","","125","7","1","admin/config/search/metatags/config/%","admin/config/search/metatags/config/%","Revert","t","","","a:0:{}","132","","","0","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/config/add","","","user_access","a:1:{i:0;s:20:\"administer meta tags\";}","drupal_get_form","a:1:{i:0;s:23:\"metatag_config_add_form\";}","","63","6","1","admin/config/search/metatags/config","admin/config/search/metatags","Add default meta tags","t","","","a:0:{}","388","","","0","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/metatags/settings","","","user_access","a:1:{i:0;s:20:\"administer meta tags\";}","drupal_get_form","a:1:{i:0;s:27:\"metatag_admin_settings_form\";}","","31","5","1","admin/config/search/metatags","admin/config/search/metatags","Settings","t","","","a:0:{}","132","","","30","sites/all/modules/metatag/metatag.admin.inc"),
("admin/config/search/page-title","","","user_access","a:1:{i:0;s:22:\"administer page titles\";}","drupal_get_form","a:1:{i:0;s:25:\"page_title_admin_settings\";}","","15","4","0","","admin/config/search/page-title","Page titles","t","","","a:0:{}","6","Configure the page titles for your site (the title in the &lt;head&gt; tag).","","0","sites/all/modules/page_title/page_title.admin.inc"),
("admin/config/search/path","","","user_access","a:1:{i:0;s:22:\"administer url aliases\";}","path_admin_overview","a:0:{}","","15","4","0","","admin/config/search/path","URL aliases","t","","","a:0:{}","6","Change your site\'s URL paths by aliasing them.","","-5","modules/path/path.admin.inc"),
("admin/config/search/path/add","","","user_access","a:1:{i:0;s:22:\"administer url aliases\";}","path_admin_edit","a:0:{}","","31","5","1","admin/config/search/path","admin/config/search/path","Add alias","t","","","a:0:{}","388","","","0","modules/path/path.admin.inc"),
("admin/config/search/path/delete/%","a:1:{i:5;s:9:\"path_load\";}","","user_access","a:1:{i:0;s:22:\"administer url aliases\";}","drupal_get_form","a:2:{i:0;s:25:\"path_admin_delete_confirm\";i:1;i:5;}","","62","6","0","","admin/config/search/path/delete/%","Delete alias","t","","","a:0:{}","6","","","0","modules/path/path.admin.inc"),
("admin/config/search/path/delete_bulk","","","user_access","a:1:{i:0;s:22:\"administer url aliases\";}","drupal_get_form","a:1:{i:0;s:21:\"pathauto_admin_delete\";}","","31","5","1","admin/config/search/path","admin/config/search/path","Delete aliases","t","","","a:0:{}","132","","","40","sites/all/modules/pathauto/pathauto.admin.inc"),
("admin/config/search/path/edit/%","a:1:{i:5;s:9:\"path_load\";}","","user_access","a:1:{i:0;s:22:\"administer url aliases\";}","path_admin_edit","a:1:{i:0;i:5;}","","62","6","0","","admin/config/search/path/edit/%","Edit alias","t","","","a:0:{}","6","","","0","modules/path/path.admin.inc"),
("admin/config/search/path/list","","","user_access","a:1:{i:0;s:22:\"administer url aliases\";}","path_admin_overview","a:0:{}","","31","5","1","admin/config/search/path","admin/config/search/path","List","t","","","a:0:{}","140","","","-10","modules/path/path.admin.inc"),
("admin/config/search/path/patterns","","","user_access","a:1:{i:0;s:19:\"administer pathauto\";}","drupal_get_form","a:1:{i:0;s:22:\"pathauto_patterns_form\";}","","31","5","1","admin/config/search/path","admin/config/search/path","Patterns","t","","","a:0:{}","132","","","10","sites/all/modules/pathauto/pathauto.admin.inc"),
("admin/config/search/path/settings","","","user_access","a:1:{i:0;s:19:\"administer pathauto\";}","drupal_get_form","a:1:{i:0;s:22:\"pathauto_settings_form\";}","","31","5","1","admin/config/search/path","admin/config/search/path","Settings","t","","","a:0:{}","132","","","20","sites/all/modules/pathauto/pathauto.admin.inc"),
("admin/config/search/path/update_bulk","","","user_access","a:1:{i:0;s:22:\"administer url aliases\";}","drupal_get_form","a:1:{i:0;s:25:\"pathauto_bulk_update_form\";}","","31","5","1","admin/config/search/path","admin/config/search/path","Bulk generate","t","","","a:0:{}","132","","","30","sites/all/modules/pathauto/pathauto.admin.inc"),
("admin/config/search/redirect","","","user_access","a:1:{i:0;s:20:\"administer redirects\";}","drupal_get_form","a:1:{i:0;s:18:\"redirect_list_form\";}","","15","4","0","","admin/config/search/redirect","URL redirects","t","","","a:0:{}","6","Redirect users from one URL to another.","","0","sites/all/modules/redirect/redirect.admin.inc"),
("admin/config/search/redirect/404","","","user_access","a:1:{i:0;s:20:\"administer redirects\";}","redirect_404_list","a:0:{}","","31","5","1","admin/config/search/redirect","admin/config/search/redirect","Fix 404 pages","t","","","a:0:{}","132","Add redirects for 404 pages.","","20","sites/all/modules/redirect/redirect.admin.inc");
INSERT INTO menu_router VALUES
("admin/config/search/redirect/add","","","redirect_access","a:2:{i:0;s:6:\"create\";i:1;s:8:\"redirect\";}","drupal_get_form","a:1:{i:0;s:18:\"redirect_edit_form\";}","","31","5","1","admin/config/search/redirect","admin/config/search/redirect","Add redirect","t","","","a:0:{}","388","","","0","sites/all/modules/redirect/redirect.admin.inc"),
("admin/config/search/redirect/delete/%","a:1:{i:5;s:13:\"redirect_load\";}","","redirect_access","a:2:{i:0;s:6:\"delete\";i:1;i:5;}","drupal_get_form","a:2:{i:0;s:20:\"redirect_delete_form\";i:1;i:5;}","","62","6","0","","admin/config/search/redirect/delete/%","Delete redirect","t","","","a:0:{}","6","","","0","sites/all/modules/redirect/redirect.admin.inc"),
("admin/config/search/redirect/edit/%","a:1:{i:5;s:13:\"redirect_load\";}","","redirect_access","a:2:{i:0;s:6:\"update\";i:1;i:5;}","drupal_get_form","a:2:{i:0;s:18:\"redirect_edit_form\";i:1;i:5;}","","62","6","0","","admin/config/search/redirect/edit/%","Edit redirect","t","","","a:0:{}","6","","","0","sites/all/modules/redirect/redirect.admin.inc"),
("admin/config/search/redirect/list","","","user_access","a:1:{i:0;s:20:\"administer redirects\";}","drupal_get_form","a:1:{i:0;s:18:\"redirect_list_form\";}","","31","5","1","admin/config/search/redirect","admin/config/search/redirect","List","t","","","a:0:{}","140","","","-10","sites/all/modules/redirect/redirect.admin.inc"),
("admin/config/search/redirect/settings","","","user_access","a:1:{i:0;s:20:\"administer redirects\";}","drupal_get_form","a:1:{i:0;s:22:\"redirect_settings_form\";}","","31","5","1","admin/config/search/redirect","admin/config/search/redirect","Settings","t","","","a:0:{}","132","Configure behavior for URL redirects.","","50","sites/all/modules/redirect/redirect.admin.inc"),
("admin/config/search/search404","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:18:\"search404_settings\";}","","15","4","0","","admin/config/search/search404","Search 404 settings","t","","","a:0:{}","6","Configure searching for keywords from URLs that result in 404 errors.","","0","sites/all/modules/search404/search404.admin.inc"),
("admin/config/search/settings","","","user_access","a:1:{i:0;s:17:\"administer search\";}","drupal_get_form","a:1:{i:0;s:21:\"search_admin_settings\";}","","15","4","0","","admin/config/search/settings","Search settings","t","","","a:0:{}","6","Configure relevance settings for search and other indexing options.","","-10","modules/search/search.admin.inc"),
("admin/config/search/settings/reindex","","","user_access","a:1:{i:0;s:17:\"administer search\";}","drupal_get_form","a:1:{i:0;s:22:\"search_reindex_confirm\";}","","31","5","0","","admin/config/search/settings/reindex","Clear index","t","","","a:0:{}","4","","","0","modules/search/search.admin.inc"),
("admin/config/search/xmlsitemap","","","user_access","a:1:{i:0;s:21:\"administer xmlsitemap\";}","drupal_get_form","a:1:{i:0;s:28:\"xmlsitemap_sitemap_list_form\";}","","15","4","0","","admin/config/search/xmlsitemap","XML sitemap","t","","","a:0:{}","6","Configure your site\'s XML sitemaps to help search engines find and index pages on your site.","","0","sites/all/modules/xmlsitemap/xmlsitemap.admin.inc"),
("admin/config/search/xmlsitemap/add","","","user_access","a:1:{i:0;s:21:\"administer xmlsitemap\";}","drupal_get_form","a:1:{i:0;s:28:\"xmlsitemap_sitemap_edit_form\";}","","31","5","1","admin/config/search/xmlsitemap","admin/config/search/xmlsitemap","Add new XML sitemap","t","","","a:0:{}","388","","","0","sites/all/modules/xmlsitemap/xmlsitemap.admin.inc"),
("admin/config/search/xmlsitemap/delete/%","a:1:{i:5;s:23:\"xmlsitemap_sitemap_load\";}","","user_access","a:1:{i:0;s:21:\"administer xmlsitemap\";}","drupal_get_form","a:2:{i:0;s:30:\"xmlsitemap_sitemap_delete_form\";i:1;i:5;}","","62","6","0","","admin/config/search/xmlsitemap/delete/%","Delete XML sitemap","t","","","a:0:{}","6","","","0","sites/all/modules/xmlsitemap/xmlsitemap.admin.inc"),
("admin/config/search/xmlsitemap/edit/%","a:1:{i:5;s:23:\"xmlsitemap_sitemap_load\";}","","user_access","a:1:{i:0;s:21:\"administer xmlsitemap\";}","drupal_get_form","a:2:{i:0;s:28:\"xmlsitemap_sitemap_edit_form\";i:1;i:5;}","","62","6","0","","admin/config/search/xmlsitemap/edit/%","Edit XML sitemap","t","","","a:0:{}","6","","","0","sites/all/modules/xmlsitemap/xmlsitemap.admin.inc"),
("admin/config/search/xmlsitemap/list","","","user_access","a:1:{i:0;s:21:\"administer xmlsitemap\";}","drupal_get_form","a:1:{i:0;s:28:\"xmlsitemap_sitemap_list_form\";}","","31","5","1","admin/config/search/xmlsitemap","admin/config/search/xmlsitemap","List","t","","","a:0:{}","140","","","-10","sites/all/modules/xmlsitemap/xmlsitemap.admin.inc"),
("admin/config/search/xmlsitemap/rebuild","","","_xmlsitemap_rebuild_form_access","a:0:{}","drupal_get_form","a:1:{i:0;s:23:\"xmlsitemap_rebuild_form\";}","","31","5","1","admin/config/search/xmlsitemap","admin/config/search/xmlsitemap","Rebuild links","t","","","a:0:{}","132","Rebuild the site map.","","20","sites/all/modules/xmlsitemap/xmlsitemap.admin.inc"),
("admin/config/search/xmlsitemap/settings","","","user_access","a:1:{i:0;s:21:\"administer xmlsitemap\";}","drupal_get_form","a:1:{i:0;s:24:\"xmlsitemap_settings_form\";}","","31","5","1","admin/config/search/xmlsitemap","admin/config/search/xmlsitemap","Settings","t","","","a:0:{}","132","","","10","sites/all/modules/xmlsitemap/xmlsitemap.admin.inc"),
("admin/config/search/xmlsitemap/settings/%/%","a:2:{i:5;a:1:{s:27:\"xmlsitemap_link_bundle_load\";a:1:{i:0;i:6;}}i:6;N;}","","xmlsitemap_link_bundle_access","a:1:{i:0;i:5;}","drupal_get_form","a:2:{i:0;s:36:\"xmlsitemap_link_bundle_settings_form\";i:1;i:5;}","","124","7","0","","admin/config/search/xmlsitemap/settings/%/%","","t","","","a:0:{}","6","","","0","sites/all/modules/xmlsitemap/xmlsitemap.admin.inc"),
("admin/config/services","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","7","3","0","","admin/config/services","Web services","t","","","a:0:{}","6","Tools related to web services.","right","0","modules/system/system.admin.inc"),
("admin/config/services/rss-publishing","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:25:\"system_rss_feeds_settings\";}","","15","4","0","","admin/config/services/rss-publishing","RSS publishing","t","","","a:0:{}","6","Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.","","0","modules/system/system.admin.inc"),
("admin/config/services/sendgrid","","","user_access","a:1:{i:0;s:28:\"administer sendgrid settings\";}","drupal_get_form","a:1:{i:0;s:26:\"sendgrid_integration_admin\";}","","15","4","0","","admin/config/services/sendgrid","SendGrid Settings","t","","","a:0:{}","6","SendGrid Integration Settings","","1",""),
("admin/config/services/sendgrid/default","","","user_access","a:1:{i:0;s:28:\"administer sendgrid settings\";}","drupal_get_form","a:1:{i:0;s:26:\"sendgrid_integration_admin\";}","","31","5","1","admin/config/services/sendgrid","admin/config/services/sendgrid","Administer SendGrid Integration","t","","","a:0:{}","140","","","0",""),
("admin/config/services/sendgrid/test","","","user_access","a:1:{i:0;s:28:\"administer sendgrid settings\";}","drupal_get_form","a:1:{i:0;s:25:\"sendgrid_integration_test\";}","","31","5","1","admin/config/services/sendgrid","admin/config/services/sendgrid","SendGrid Test Email Send","t","","","a:0:{}","132","Send a test email through sendgrid.","","50","sites/all/modules/sendgrid_integration/sendgrid_integration.admin.inc"),
("admin/config/system","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","7","3","0","","admin/config/system","System","t","","","a:0:{}","6","General system related configuration.","right","-20","modules/system/system.admin.inc"),
("admin/config/system/actions","","","user_access","a:1:{i:0;s:18:\"administer actions\";}","system_actions_manage","a:0:{}","","15","4","0","","admin/config/system/actions","Actions","t","","","a:0:{}","6","Manage the actions defined for your site.","","0","modules/system/system.admin.inc"),
("admin/config/system/actions/configure","","","user_access","a:1:{i:0;s:18:\"administer actions\";}","drupal_get_form","a:1:{i:0;s:24:\"system_actions_configure\";}","","31","5","0","","admin/config/system/actions/configure","Configure an advanced action","t","","","a:0:{}","4","","","0","modules/system/system.admin.inc"),
("admin/config/system/actions/delete/%","a:1:{i:5;s:12:\"actions_load\";}","","user_access","a:1:{i:0;s:18:\"administer actions\";}","drupal_get_form","a:2:{i:0;s:26:\"system_actions_delete_form\";i:1;i:5;}","","62","6","0","","admin/config/system/actions/delete/%","Delete action","t","","","a:0:{}","6","Delete an action.","","0","modules/system/system.admin.inc"),
("admin/config/system/actions/manage","","","user_access","a:1:{i:0;s:18:\"administer actions\";}","system_actions_manage","a:0:{}","","31","5","1","admin/config/system/actions","admin/config/system/actions","Manage actions","t","","","a:0:{}","140","Manage the actions defined for your site.","","-2","modules/system/system.admin.inc"),
("admin/config/system/actions/orphan","","","user_access","a:1:{i:0;s:18:\"administer actions\";}","system_actions_remove_orphans","a:0:{}","","31","5","0","","admin/config/system/actions/orphan","Remove orphans","t","","","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("admin/config/system/composer-manager","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","composer_manager_packages_page","a:0:{}","","15","4","0","","admin/config/system/composer-manager","Composer Manager","t","","","a:0:{}","6","View the status of packages managed by Composer and configure the location of the composer.json file and verdor directory.","","0","sites/all/modules/composer_manager/composer_manager.admin.inc"),
("admin/config/system/composer-manager/packages","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","composer_manager_packages_page","a:0:{}","","31","5","1","admin/config/system/composer-manager","admin/config/system/composer-manager","Packages","t","","","a:0:{}","140","","","-10","sites/all/modules/composer_manager/composer_manager.admin.inc"),
("admin/config/system/composer-manager/settings","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:30:\"composer_manager_settings_form\";}","","31","5","1","admin/config/system/composer-manager","admin/config/system/composer-manager","Settings","t","","","a:0:{}","132","","","0","sites/all/modules/composer_manager/composer_manager.admin.inc"),
("admin/config/system/cron","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:20:\"system_cron_settings\";}","","15","4","0","","admin/config/system/cron","Cron","t","","","a:0:{}","6","Manage automatic site maintenance tasks.","","20","modules/system/system.admin.inc"),
("admin/config/system/globalredirect","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:23:\"globalredirect_settings\";}","","15","4","0","","admin/config/system/globalredirect","Global Redirect","t","","","a:0:{}","6","Chose which features you would like enabled for Global Redirect","","0","sites/all/modules/globalredirect/globalredirect.admin.inc"),
("admin/config/system/mailsystem","","","user_access","a:1:{i:0;s:21:\"administer mailsystem\";}","drupal_get_form","a:1:{i:0;s:25:\"mailsystem_admin_settings\";}","","15","4","0","","admin/config/system/mailsystem","Mail System","t","","","a:0:{}","6","Configure per-module Mail System settings.","","0","sites/all/modules/mailsystem/mailsystem.admin.inc"),
("admin/config/system/securepages","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:20:\"securepages_settings\";}","","15","4","0","","admin/config/system/securepages","Secure Pages","t","","","a:0:{}","6","Configure which pages are and are not to be viewed in SSL","","0","sites/all/modules/securepages/securepages.admin.inc"),
("admin/config/system/site-information","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:32:\"system_site_information_settings\";}","","15","4","0","","admin/config/system/site-information","Site information","t","","","a:0:{}","6","Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.","","-20","modules/system/system.admin.inc"),
("admin/config/user-interface","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","7","3","0","","admin/config/user-interface","User interface","t","","","a:0:{}","6","Tools that enhance the user interface.","right","-15","modules/system/system.admin.inc"),
("admin/config/user-interface/shortcut","","","user_access","a:1:{i:0;s:20:\"administer shortcuts\";}","shortcut_set_admin","a:0:{}","","15","4","0","","admin/config/user-interface/shortcut","Shortcuts","t","","","a:0:{}","6","Add and modify shortcut sets.","","0","modules/shortcut/shortcut.admin.inc"),
("admin/config/user-interface/shortcut/%","a:1:{i:4;s:17:\"shortcut_set_load\";}","","shortcut_set_edit_access","a:1:{i:0;i:4;}","drupal_get_form","a:2:{i:0;s:22:\"shortcut_set_customize\";i:1;i:4;}","","30","5","0","","admin/config/user-interface/shortcut/%","Edit shortcuts","shortcut_set_title_callback","a:1:{i:0;i:4;}","","a:0:{}","6","","","0","modules/shortcut/shortcut.admin.inc"),
("admin/config/user-interface/shortcut/%/add-link","a:1:{i:4;s:17:\"shortcut_set_load\";}","","shortcut_set_edit_access","a:1:{i:0;i:4;}","drupal_get_form","a:2:{i:0;s:17:\"shortcut_link_add\";i:1;i:4;}","","61","6","1","admin/config/user-interface/shortcut/%","admin/config/user-interface/shortcut/%","Add shortcut","t","","","a:0:{}","388","","","0","modules/shortcut/shortcut.admin.inc"),
("admin/config/user-interface/shortcut/%/add-link-inline","a:1:{i:4;s:17:\"shortcut_set_load\";}","","shortcut_set_edit_access","a:1:{i:0;i:4;}","shortcut_link_add_inline","a:1:{i:0;i:4;}","","61","6","0","","admin/config/user-interface/shortcut/%/add-link-inline","Add shortcut","t","","","a:0:{}","0","","","0","modules/shortcut/shortcut.admin.inc"),
("admin/config/user-interface/shortcut/%/delete","a:1:{i:4;s:17:\"shortcut_set_load\";}","","shortcut_set_delete_access","a:1:{i:0;i:4;}","drupal_get_form","a:2:{i:0;s:24:\"shortcut_set_delete_form\";i:1;i:4;}","","61","6","0","","admin/config/user-interface/shortcut/%/delete","Delete shortcut set","t","","","a:0:{}","6","","","0","modules/shortcut/shortcut.admin.inc"),
("admin/config/user-interface/shortcut/%/edit","a:1:{i:4;s:17:\"shortcut_set_load\";}","","shortcut_set_edit_access","a:1:{i:0;i:4;}","drupal_get_form","a:2:{i:0;s:22:\"shortcut_set_edit_form\";i:1;i:4;}","","61","6","1","admin/config/user-interface/shortcut/%","admin/config/user-interface/shortcut/%","Edit set name","t","","","a:0:{}","132","","","10","modules/shortcut/shortcut.admin.inc"),
("admin/config/user-interface/shortcut/%/links","a:1:{i:4;s:17:\"shortcut_set_load\";}","","shortcut_set_edit_access","a:1:{i:0;i:4;}","drupal_get_form","a:2:{i:0;s:22:\"shortcut_set_customize\";i:1;i:4;}","","61","6","1","admin/config/user-interface/shortcut/%","admin/config/user-interface/shortcut/%","List links","t","","","a:0:{}","140","","","0","modules/shortcut/shortcut.admin.inc"),
("admin/config/user-interface/shortcut/add-set","","","user_access","a:1:{i:0;s:20:\"administer shortcuts\";}","drupal_get_form","a:1:{i:0;s:21:\"shortcut_set_add_form\";}","","31","5","1","admin/config/user-interface/shortcut","admin/config/user-interface/shortcut","Add shortcut set","t","","","a:0:{}","388","","","0","modules/shortcut/shortcut.admin.inc"),
("admin/config/user-interface/shortcut/link/%","a:1:{i:5;s:14:\"menu_link_load\";}","","shortcut_link_access","a:1:{i:0;i:5;}","drupal_get_form","a:2:{i:0;s:18:\"shortcut_link_edit\";i:1;i:5;}","","62","6","0","","admin/config/user-interface/shortcut/link/%","Edit shortcut","t","","","a:0:{}","6","","","0","modules/shortcut/shortcut.admin.inc"),
("admin/config/user-interface/shortcut/link/%/delete","a:1:{i:5;s:14:\"menu_link_load\";}","","shortcut_link_access","a:1:{i:0;i:5;}","drupal_get_form","a:2:{i:0;s:20:\"shortcut_link_delete\";i:1;i:5;}","","125","7","0","","admin/config/user-interface/shortcut/link/%/delete","Delete shortcut","t","","","a:0:{}","6","","","0","modules/shortcut/shortcut.admin.inc"),
("admin/config/workflow","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","7","3","0","","admin/config/workflow","Workflow","t","","","a:0:{}","6","Content workflow, editorial workflow tools.","right","5","modules/system/system.admin.inc"),
("admin/content","","","user_access","a:1:{i:0;s:23:\"access content overview\";}","drupal_get_form","a:1:{i:0;s:18:\"node_admin_content\";}","","3","2","0","","admin/content","Content","t","","","a:0:{}","6","Administer content and comments.","","-10","modules/node/node.admin.inc"),
("admin/content/comment","","","user_access","a:1:{i:0;s:19:\"administer comments\";}","comment_admin","a:0:{}","","7","3","1","admin/content","admin/content","Comments","t","","","a:0:{}","134","List and edit site comments and the comment approval queue.","","0","modules/comment/comment.admin.inc"),
("admin/content/comment/approval","","","user_access","a:1:{i:0;s:19:\"administer comments\";}","comment_admin","a:1:{i:0;s:8:\"approval\";}","","15","4","1","admin/content/comment","admin/content","Unapproved comments","comment_count_unpublished","","","a:0:{}","132","","","0","modules/comment/comment.admin.inc"),
("admin/content/comment/new","","","user_access","a:1:{i:0;s:19:\"administer comments\";}","comment_admin","a:0:{}","","15","4","1","admin/content/comment","admin/content","Published comments","t","","","a:0:{}","140","","","-10","modules/comment/comment.admin.inc"),
("admin/content/node","","","user_access","a:1:{i:0;s:23:\"access content overview\";}","drupal_get_form","a:1:{i:0;s:18:\"node_admin_content\";}","","7","3","1","admin/content","admin/content","Content","t","","","a:0:{}","140","","","-10","modules/node/node.admin.inc"),
("admin/content/webform","","","user_access","a:1:{i:0;s:26:\"access all webform results\";}","webform_admin_content","a:0:{}","","7","3","1","admin/content","admin/content","Webforms","t","","","a:0:{}","132","View and edit all the available webforms on your site.","","0","sites/all/modules/webform/includes/webform.admin.inc"),
("admin/dashboard","","","user_access","a:1:{i:0;s:16:\"access dashboard\";}","dashboard_admin","a:0:{}","","3","2","0","","admin/dashboard","Dashboard","t","","","a:0:{}","6","View and customize your dashboard.","","-15",""),
("admin/dashboard/block-content/%/%","a:2:{i:3;N;i:4;N;}","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","dashboard_show_block_content","a:2:{i:0;i:3;i:1;i:4;}","","28","5","0","","admin/dashboard/block-content/%/%","","t","","","a:0:{}","0","","","0",""),
("admin/dashboard/configure","","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","dashboard_admin_blocks","a:0:{}","","7","3","0","","admin/dashboard/configure","Configure available dashboard blocks","t","","","a:0:{}","4","Configure which blocks can be shown on the dashboard.","","0",""),
("admin/dashboard/customize","","","user_access","a:1:{i:0;s:16:\"access dashboard\";}","dashboard_admin","a:1:{i:0;b:1;}","","7","3","0","","admin/dashboard/customize","Customize dashboard","t","","","a:0:{}","4","Customize your dashboard.","","0",""),
("admin/dashboard/drawer","","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","dashboard_show_disabled","a:0:{}","","7","3","0","","admin/dashboard/drawer","","t","","","a:0:{}","0","","","0",""),
("admin/dashboard/update","","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","dashboard_update","a:0:{}","","7","3","0","","admin/dashboard/update","","t","","","a:0:{}","0","","","0",""),
("admin/help","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_main","a:0:{}","","3","2","0","","admin/help","Help","t","","","a:0:{}","6","Reference for usage, configuration, and modules.","","9","modules/help/help.admin.inc"),
("admin/help/block","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/block","block","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/ckeditor","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/ckeditor","ckeditor","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/color","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/color","color","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/comment","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/comment","comment","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/contextual","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/contextual","contextual","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/dashboard","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/dashboard","dashboard","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/dblog","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/dblog","dblog","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/field","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/field","field","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/field_sql_storage","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/field_sql_storage","field_sql_storage","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/field_ui","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/field_ui","field_ui","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/file","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/file","file","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/filter","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/filter","filter","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/globalredirect","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/globalredirect","globalredirect","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/help","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/help","help","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/image","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/image","image","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/list","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/list","list","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/menu","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/menu","menu","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/metatag","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/metatag","metatag","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/node","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/node","node","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/number","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/number","number","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/options","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/options","options","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/overlay","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/overlay","overlay","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/page_title","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/page_title","page_title","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/path","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/path","path","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/pathauto","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/pathauto","pathauto","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/rdf","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/rdf","rdf","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/redirect","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/redirect","redirect","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/search","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/search","search","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/sendgrid_integration","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/sendgrid_integration","sendgrid_integration","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/shortcut","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/shortcut","shortcut","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/system","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/system","system","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/taxonomy","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/taxonomy","taxonomy","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/text","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/text","text","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/token","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/token","token","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/toolbar","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/toolbar","toolbar","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/update","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/update","update","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/user","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/user","user","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/webform","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/webform","webform","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/help/xmlsitemap","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","help_page","a:1:{i:0;i:2;}","","7","3","0","","admin/help/xmlsitemap","xmlsitemap","t","","","a:0:{}","4","","","0","modules/help/help.admin.inc"),
("admin/index","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_index","a:0:{}","","3","2","1","admin","admin","Index","t","","","a:0:{}","132","","","-18","modules/system/system.admin.inc");
INSERT INTO menu_router VALUES
("admin/modules","","","user_access","a:1:{i:0;s:18:\"administer modules\";}","drupal_get_form","a:1:{i:0;s:14:\"system_modules\";}","","3","2","0","","admin/modules","Modules","t","","","a:0:{}","6","Extend site functionality.","","-2","modules/system/system.admin.inc"),
("admin/modules/install","","","update_manager_access","a:0:{}","drupal_get_form","a:2:{i:0;s:27:\"update_manager_install_form\";i:1;s:6:\"module\";}","","7","3","1","admin/modules","admin/modules","Install new module","t","","","a:0:{}","388","","","25","modules/update/update.manager.inc"),
("admin/modules/list","","","user_access","a:1:{i:0;s:18:\"administer modules\";}","drupal_get_form","a:1:{i:0;s:14:\"system_modules\";}","","7","3","1","admin/modules","admin/modules","List","t","","","a:0:{}","140","","","0","modules/system/system.admin.inc"),
("admin/modules/list/confirm","","","user_access","a:1:{i:0;s:18:\"administer modules\";}","drupal_get_form","a:1:{i:0;s:14:\"system_modules\";}","","15","4","0","","admin/modules/list/confirm","List","t","","","a:0:{}","4","","","0","modules/system/system.admin.inc"),
("admin/modules/uninstall","","","user_access","a:1:{i:0;s:18:\"administer modules\";}","drupal_get_form","a:1:{i:0;s:24:\"system_modules_uninstall\";}","","7","3","1","admin/modules","admin/modules","Uninstall","t","","","a:0:{}","132","","","20","modules/system/system.admin.inc"),
("admin/modules/uninstall/confirm","","","user_access","a:1:{i:0;s:18:\"administer modules\";}","drupal_get_form","a:1:{i:0;s:24:\"system_modules_uninstall\";}","","15","4","0","","admin/modules/uninstall/confirm","Uninstall","t","","","a:0:{}","4","","","0","modules/system/system.admin.inc"),
("admin/modules/update","","","update_manager_access","a:0:{}","drupal_get_form","a:2:{i:0;s:26:\"update_manager_update_form\";i:1;s:6:\"module\";}","","7","3","1","admin/modules","admin/modules","Update","t","","","a:0:{}","132","","","10","modules/update/update.manager.inc"),
("admin/people","","","user_access","a:1:{i:0;s:16:\"administer users\";}","user_admin","a:1:{i:0;s:4:\"list\";}","","3","2","0","","admin/people","People","t","","","a:0:{}","6","Manage user accounts, roles, and permissions.","left","-4","modules/user/user.admin.inc"),
("admin/people/create","","","user_access","a:1:{i:0;s:16:\"administer users\";}","user_admin","a:1:{i:0;s:6:\"create\";}","","7","3","1","admin/people","admin/people","Add user","t","","","a:0:{}","388","","","0","modules/user/user.admin.inc"),
("admin/people/people","","","user_access","a:1:{i:0;s:16:\"administer users\";}","user_admin","a:1:{i:0;s:4:\"list\";}","","7","3","1","admin/people","admin/people","List","t","","","a:0:{}","140","Find and manage people interacting with your site.","","-10","modules/user/user.admin.inc"),
("admin/people/permissions","","","user_access","a:1:{i:0;s:22:\"administer permissions\";}","drupal_get_form","a:1:{i:0;s:22:\"user_admin_permissions\";}","","7","3","1","admin/people","admin/people","Permissions","t","","","a:0:{}","132","Determine access to features by selecting permissions for roles.","","0","modules/user/user.admin.inc"),
("admin/people/permissions/list","","","user_access","a:1:{i:0;s:22:\"administer permissions\";}","drupal_get_form","a:1:{i:0;s:22:\"user_admin_permissions\";}","","15","4","1","admin/people/permissions","admin/people","Permissions","t","","","a:0:{}","140","Determine access to features by selecting permissions for roles.","","-8","modules/user/user.admin.inc"),
("admin/people/permissions/roles","","","user_access","a:1:{i:0;s:22:\"administer permissions\";}","drupal_get_form","a:1:{i:0;s:16:\"user_admin_roles\";}","","15","4","1","admin/people/permissions","admin/people","Roles","t","","","a:0:{}","132","List, edit, or add user roles.","","-5","modules/user/user.admin.inc"),
("admin/people/permissions/roles/delete/%","a:1:{i:5;s:14:\"user_role_load\";}","","user_role_edit_access","a:1:{i:0;i:5;}","drupal_get_form","a:2:{i:0;s:30:\"user_admin_role_delete_confirm\";i:1;i:5;}","","62","6","0","","admin/people/permissions/roles/delete/%","Delete role","t","","","a:0:{}","6","","","0","modules/user/user.admin.inc"),
("admin/people/permissions/roles/edit/%","a:1:{i:5;s:14:\"user_role_load\";}","","user_role_edit_access","a:1:{i:0;i:5;}","drupal_get_form","a:2:{i:0;s:15:\"user_admin_role\";i:1;i:5;}","","62","6","0","","admin/people/permissions/roles/edit/%","Edit role","t","","","a:0:{}","6","","","0","modules/user/user.admin.inc"),
("admin/reports","","","user_access","a:1:{i:0;s:19:\"access site reports\";}","system_admin_menu_block_page","a:0:{}","","3","2","0","","admin/reports","Reports","t","","","a:0:{}","6","View reports, updates, and errors.","left","5","modules/system/system.admin.inc"),
("admin/reports/access-denied","","","user_access","a:1:{i:0;s:19:\"access site reports\";}","dblog_top","a:1:{i:0;s:13:\"access denied\";}","","7","3","0","","admin/reports/access-denied","Top \'access denied\' errors","t","","","a:0:{}","6","View \'access denied\' errors (403s).","","0","modules/dblog/dblog.admin.inc"),
("admin/reports/dblog","","","user_access","a:1:{i:0;s:19:\"access site reports\";}","dblog_overview","a:0:{}","","7","3","0","","admin/reports/dblog","Recent log messages","t","","","a:0:{}","6","View events that have recently been logged.","","-1","modules/dblog/dblog.admin.inc"),
("admin/reports/event/%","a:1:{i:3;N;}","","user_access","a:1:{i:0;s:19:\"access site reports\";}","dblog_event","a:1:{i:0;i:3;}","","14","4","0","","admin/reports/event/%","Details","t","","","a:0:{}","6","","","0","modules/dblog/dblog.admin.inc"),
("admin/reports/fields","","","user_access","a:1:{i:0;s:24:\"administer content types\";}","field_ui_fields_list","a:0:{}","","7","3","0","","admin/reports/fields","Field list","t","","","a:0:{}","6","Overview of fields on all entity types.","","0","modules/field_ui/field_ui.admin.inc"),
("admin/reports/page-not-found","","","user_access","a:1:{i:0;s:19:\"access site reports\";}","dblog_top","a:1:{i:0;s:14:\"page not found\";}","","7","3","0","","admin/reports/page-not-found","Top \'page not found\' errors","t","","","a:0:{}","6","View \'page not found\' errors (404s).","","0","modules/dblog/dblog.admin.inc"),
("admin/reports/page-not-found/redirect","","","user_access","a:1:{i:0;s:20:\"administer redirects\";}","drupal_goto","a:1:{i:0;s:32:\"admin/config/search/redirect/404\";}","","15","4","1","admin/reports/page-not-found","admin/reports/page-not-found","Fix 404 pages with URL redirects","t","","","a:0:{}","388","","","0",""),
("admin/reports/page-title","","","views_access","a:1:{i:0;a:2:{i:0;s:16:\"views_check_perm\";i:1;a:1:{i:0;s:22:\"administer page titles\";}}}","views_page","a:2:{i:0;s:21:\"list_node_page_titles\";i:1;s:6:\"page_1\";}","","7","3","0","","admin/reports/page-title","Page Title List","t","","","a:0:{}","6","List all nodes with their Page Titles","","0",""),
("admin/reports/search","","","user_access","a:1:{i:0;s:19:\"access site reports\";}","dblog_top","a:1:{i:0;s:6:\"search\";}","","7","3","0","","admin/reports/search","Top search phrases","t","","","a:0:{}","6","View most popular search phrases.","","0","modules/dblog/dblog.admin.inc"),
("admin/reports/status","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","system_status","a:0:{}","","7","3","0","","admin/reports/status","Status report","t","","","a:0:{}","6","Get a status report about your site\'s operation and any detected problems.","","-60","modules/system/system.admin.inc"),
("admin/reports/status/php","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","system_php","a:0:{}","","15","4","0","","admin/reports/status/php","PHP","t","","","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("admin/reports/status/rebuild","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","drupal_get_form","a:1:{i:0;s:30:\"node_configure_rebuild_confirm\";}","","15","4","0","","admin/reports/status/rebuild","Rebuild permissions","t","","","a:0:{}","0","","","0","modules/node/node.admin.inc"),
("admin/reports/status/run-cron","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","system_run_cron","a:0:{}","","15","4","0","","admin/reports/status/run-cron","Run cron","t","","","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("admin/reports/updates","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","update_status","a:0:{}","","7","3","0","","admin/reports/updates","Available updates","t","","","a:0:{}","6","Get a status report about available updates for your installed modules and themes.","","-50","modules/update/update.report.inc"),
("admin/reports/updates/check","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","update_manual_status","a:0:{}","","15","4","0","","admin/reports/updates/check","Manual update check","t","","","a:0:{}","0","","","0","modules/update/update.fetch.inc"),
("admin/reports/updates/install","","","update_manager_access","a:0:{}","drupal_get_form","a:2:{i:0;s:27:\"update_manager_install_form\";i:1;s:6:\"report\";}","","15","4","1","admin/reports/updates","admin/reports/updates","Install new module or theme","t","","","a:0:{}","388","","","25","modules/update/update.manager.inc"),
("admin/reports/updates/list","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","update_status","a:0:{}","","15","4","1","admin/reports/updates","admin/reports/updates","List","t","","","a:0:{}","140","","","0","modules/update/update.report.inc"),
("admin/reports/updates/settings","","","user_access","a:1:{i:0;s:29:\"administer site configuration\";}","drupal_get_form","a:1:{i:0;s:15:\"update_settings\";}","","15","4","1","admin/reports/updates","admin/reports/updates","Settings","t","","","a:0:{}","132","","","50","modules/update/update.settings.inc"),
("admin/reports/updates/update","","","update_manager_access","a:0:{}","drupal_get_form","a:2:{i:0;s:26:\"update_manager_update_form\";i:1;s:6:\"report\";}","","15","4","1","admin/reports/updates","admin/reports/updates","Update","t","","","a:0:{}","132","","","10","modules/update/update.manager.inc"),
("admin/structure","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","3","2","0","","admin/structure","Structure","t","","","a:0:{}","6","Administer blocks, content types, menus, etc.","right","-8","modules/system/system.admin.inc"),
("admin/structure/block","","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","block_admin_display","a:1:{i:0;s:6:\"bartik\";}","","7","3","0","","admin/structure/block","Blocks","t","","","a:0:{}","6","Configure what block content appears in your site\'s sidebars and other regions.","","0","modules/block/block.admin.inc"),
("admin/structure/block/add","","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","drupal_get_form","a:1:{i:0;s:20:\"block_add_block_form\";}","","15","4","1","admin/structure/block","admin/structure/block","Add block","t","","","a:0:{}","388","","","0","modules/block/block.admin.inc"),
("admin/structure/block/demo/bartik","","","_block_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","block_admin_demo","a:1:{i:0;s:6:\"bartik\";}","","31","5","0","","admin/structure/block/demo/bartik","Bartik","t","","_block_custom_theme","a:1:{i:0;s:6:\"bartik\";}","0","","","0","modules/block/block.admin.inc"),
("admin/structure/block/demo/garland","","","_block_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","block_admin_demo","a:1:{i:0;s:7:\"garland\";}","","31","5","0","","admin/structure/block/demo/garland","Garland","t","","_block_custom_theme","a:1:{i:0;s:7:\"garland\";}","0","","","0","modules/block/block.admin.inc"),
("admin/structure/block/demo/seven","","","_block_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","block_admin_demo","a:1:{i:0;s:5:\"seven\";}","","31","5","0","","admin/structure/block/demo/seven","Seven","t","","_block_custom_theme","a:1:{i:0;s:5:\"seven\";}","0","","","0","modules/block/block.admin.inc"),
("admin/structure/block/demo/stark","","","_block_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","block_admin_demo","a:1:{i:0;s:5:\"stark\";}","","31","5","0","","admin/structure/block/demo/stark","Stark","t","","_block_custom_theme","a:1:{i:0;s:5:\"stark\";}","0","","","0","modules/block/block.admin.inc"),
("admin/structure/block/list/bartik","","","_block_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","block_admin_display","a:1:{i:0;s:6:\"bartik\";}","","31","5","1","admin/structure/block","admin/structure/block","Bartik","t","","","a:0:{}","140","","","-10","modules/block/block.admin.inc"),
("admin/structure/block/list/garland","","","_block_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","block_admin_display","a:1:{i:0;s:7:\"garland\";}","","31","5","1","admin/structure/block","admin/structure/block","Garland","t","","","a:0:{}","132","","","0","modules/block/block.admin.inc"),
("admin/structure/block/list/garland/add","","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","drupal_get_form","a:1:{i:0;s:20:\"block_add_block_form\";}","","63","6","1","admin/structure/block/list/garland","admin/structure/block","Add block","t","","","a:0:{}","388","","","0","modules/block/block.admin.inc"),
("admin/structure/block/list/seven","","","_block_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:19:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","block_admin_display","a:1:{i:0;s:5:\"seven\";}","","31","5","1","admin/structure/block","admin/structure/block","Seven","t","","","a:0:{}","132","","","0","modules/block/block.admin.inc"),
("admin/structure/block/list/seven/add","","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","drupal_get_form","a:1:{i:0;s:20:\"block_add_block_form\";}","","63","6","1","admin/structure/block/list/seven","admin/structure/block","Add block","t","","","a:0:{}","388","","","0","modules/block/block.admin.inc"),
("admin/structure/block/list/stark","","","_block_themes_access","a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}","block_admin_display","a:1:{i:0;s:5:\"stark\";}","","31","5","1","admin/structure/block","admin/structure/block","Stark","t","","","a:0:{}","132","","","0","modules/block/block.admin.inc"),
("admin/structure/block/list/stark/add","","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","drupal_get_form","a:1:{i:0;s:20:\"block_add_block_form\";}","","63","6","1","admin/structure/block/list/stark","admin/structure/block","Add block","t","","","a:0:{}","388","","","0","modules/block/block.admin.inc"),
("admin/structure/block/manage/%/%","a:2:{i:4;N;i:5;N;}","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","drupal_get_form","a:3:{i:0;s:21:\"block_admin_configure\";i:1;i:4;i:2;i:5;}","","60","6","0","","admin/structure/block/manage/%/%","Configure block","t","","","a:0:{}","6","","","0","modules/block/block.admin.inc"),
("admin/structure/block/manage/%/%/configure","a:2:{i:4;N;i:5;N;}","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","drupal_get_form","a:3:{i:0;s:21:\"block_admin_configure\";i:1;i:4;i:2;i:5;}","","121","7","2","admin/structure/block/manage/%/%","admin/structure/block/manage/%/%","Configure block","t","","","a:0:{}","140","","","0","modules/block/block.admin.inc"),
("admin/structure/block/manage/%/%/delete","a:2:{i:4;N;i:5;N;}","","user_access","a:1:{i:0;s:17:\"administer blocks\";}","drupal_get_form","a:3:{i:0;s:25:\"block_custom_block_delete\";i:1;i:4;i:2;i:5;}","","121","7","0","admin/structure/block/manage/%/%","admin/structure/block/manage/%/%","Delete block","t","","","a:0:{}","132","","","0","modules/block/block.admin.inc"),
("admin/structure/menu","","","user_access","a:1:{i:0;s:15:\"administer menu\";}","menu_overview_page","a:0:{}","","7","3","0","","admin/structure/menu","Menus","t","","","a:0:{}","6","Add new menus to your site, edit existing menus, and rename and reorganize menu links.","","0","modules/menu/menu.admin.inc"),
("admin/structure/menu/add","","","user_access","a:1:{i:0;s:15:\"administer menu\";}","drupal_get_form","a:2:{i:0;s:14:\"menu_edit_menu\";i:1;s:3:\"add\";}","","15","4","1","admin/structure/menu","admin/structure/menu","Add menu","t","","","a:0:{}","388","","","0","modules/menu/menu.admin.inc"),
("admin/structure/menu/item/%/delete","a:1:{i:4;s:14:\"menu_link_load\";}","","user_access","a:1:{i:0;s:15:\"administer menu\";}","menu_item_delete_page","a:1:{i:0;i:4;}","","61","6","0","","admin/structure/menu/item/%/delete","Delete menu link","t","","","a:0:{}","6","","","0","modules/menu/menu.admin.inc"),
("admin/structure/menu/item/%/edit","a:1:{i:4;s:14:\"menu_link_load\";}","","user_access","a:1:{i:0;s:15:\"administer menu\";}","drupal_get_form","a:4:{i:0;s:14:\"menu_edit_item\";i:1;s:4:\"edit\";i:2;i:4;i:3;N;}","","61","6","0","","admin/structure/menu/item/%/edit","Edit menu link","t","","","a:0:{}","6","","","0","modules/menu/menu.admin.inc"),
("admin/structure/menu/item/%/reset","a:1:{i:4;s:14:\"menu_link_load\";}","","user_access","a:1:{i:0;s:15:\"administer menu\";}","drupal_get_form","a:2:{i:0;s:23:\"menu_reset_item_confirm\";i:1;i:4;}","","61","6","0","","admin/structure/menu/item/%/reset","Reset menu link","t","","","a:0:{}","6","","","0","modules/menu/menu.admin.inc"),
("admin/structure/menu/list","","","user_access","a:1:{i:0;s:15:\"administer menu\";}","menu_overview_page","a:0:{}","","15","4","1","admin/structure/menu","admin/structure/menu","List menus","t","","","a:0:{}","140","","","-10","modules/menu/menu.admin.inc"),
("admin/structure/menu/manage/%","a:1:{i:4;s:9:\"menu_load\";}","","user_access","a:1:{i:0;s:15:\"administer menu\";}","drupal_get_form","a:2:{i:0;s:18:\"menu_overview_form\";i:1;i:4;}","","30","5","0","","admin/structure/menu/manage/%","Customize menu","menu_overview_title","a:1:{i:0;i:4;}","","a:0:{}","6","","","0","modules/menu/menu.admin.inc"),
("admin/structure/menu/manage/%/add","a:1:{i:4;s:9:\"menu_load\";}","","user_access","a:1:{i:0;s:15:\"administer menu\";}","drupal_get_form","a:4:{i:0;s:14:\"menu_edit_item\";i:1;s:3:\"add\";i:2;N;i:3;i:4;}","","61","6","1","admin/structure/menu/manage/%","admin/structure/menu/manage/%","Add link","t","","","a:0:{}","388","","","0","modules/menu/menu.admin.inc"),
("admin/structure/menu/manage/%/delete","a:1:{i:4;s:9:\"menu_load\";}","","user_access","a:1:{i:0;s:15:\"administer menu\";}","menu_delete_menu_page","a:1:{i:0;i:4;}","","61","6","0","","admin/structure/menu/manage/%/delete","Delete menu","t","","","a:0:{}","6","","","0","modules/menu/menu.admin.inc"),
("admin/structure/menu/manage/%/edit","a:1:{i:4;s:9:\"menu_load\";}","","user_access","a:1:{i:0;s:15:\"administer menu\";}","drupal_get_form","a:3:{i:0;s:14:\"menu_edit_menu\";i:1;s:4:\"edit\";i:2;i:4;}","","61","6","3","admin/structure/menu/manage/%","admin/structure/menu/manage/%","Edit menu","t","","","a:0:{}","132","","","0","modules/menu/menu.admin.inc"),
("admin/structure/menu/manage/%/list","a:1:{i:4;s:9:\"menu_load\";}","","user_access","a:1:{i:0;s:15:\"administer menu\";}","drupal_get_form","a:2:{i:0;s:18:\"menu_overview_form\";i:1;i:4;}","","61","6","3","admin/structure/menu/manage/%","admin/structure/menu/manage/%","List links","t","","","a:0:{}","140","","","-10","modules/menu/menu.admin.inc"),
("admin/structure/menu/parents","","","user_access","a:1:{i:0;s:15:\"administer menu\";}","menu_parent_options_js","a:0:{}","","15","4","0","","admin/structure/menu/parents","Parent menu items","t","","","a:0:{}","0","","","0",""),
("admin/structure/menu/settings","","","user_access","a:1:{i:0;s:15:\"administer menu\";}","drupal_get_form","a:1:{i:0;s:14:\"menu_configure\";}","","15","4","1","admin/structure/menu","admin/structure/menu","Settings","t","","","a:0:{}","132","","","5","modules/menu/menu.admin.inc"),
("admin/structure/taxonomy","","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:1:{i:0;s:30:\"taxonomy_overview_vocabularies\";}","","7","3","0","","admin/structure/taxonomy","Taxonomy","t","","","a:0:{}","6","Manage tagging, categorization, and classification of your content.","","0","modules/taxonomy/taxonomy.admin.inc"),
("admin/structure/taxonomy/%","a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:2:{i:0;s:23:\"taxonomy_overview_terms\";i:1;i:3;}","","14","4","0","","admin/structure/taxonomy/%","","entity_label","a:2:{i:0;s:19:\"taxonomy_vocabulary\";i:1;i:3;}","","a:0:{}","6","","","0","modules/taxonomy/taxonomy.admin.inc"),
("admin/structure/taxonomy/%/add","a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:3:{i:0;s:18:\"taxonomy_form_term\";i:1;a:0:{}i:2;i:3;}","","29","5","1","admin/structure/taxonomy/%","admin/structure/taxonomy/%","Add term","t","","","a:0:{}","388","","","0","modules/taxonomy/taxonomy.admin.inc"),
("admin/structure/taxonomy/%/display","a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;i:3;s:7:\"default\";}","","29","5","1","admin/structure/taxonomy/%","admin/structure/taxonomy/%","Manage display","t","","","a:0:{}","132","","","2","modules/field_ui/field_ui.admin.inc"),
("admin/structure/taxonomy/%/display/default","a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:19:\"administer taxonomy\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;i:3;s:7:\"default\";}","","59","6","1","admin/structure/taxonomy/%/display","admin/structure/taxonomy/%","Default","t","","","a:0:{}","140","","","-10","modules/field_ui/field_ui.admin.inc"),
("admin/structure/taxonomy/%/display/full","a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:19:\"administer taxonomy\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;i:3;s:4:\"full\";}","","59","6","1","admin/structure/taxonomy/%/display","admin/structure/taxonomy/%","Taxonomy term page","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/taxonomy/%/display/token","a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:5:\"token\";i:3;s:11:\"user_access\";i:4;s:19:\"administer taxonomy\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;i:3;s:5:\"token\";}","","59","6","1","admin/structure/taxonomy/%/display","admin/structure/taxonomy/%","Tokens","t","","","a:0:{}","132","","","1","modules/field_ui/field_ui.admin.inc"),
("admin/structure/taxonomy/%/edit","a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:2:{i:0;s:24:\"taxonomy_form_vocabulary\";i:1;i:3;}","","29","5","1","admin/structure/taxonomy/%","admin/structure/taxonomy/%","Edit","t","","","a:0:{}","132","","","-10","modules/taxonomy/taxonomy.admin.inc"),
("admin/structure/taxonomy/%/fields","a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;}","","29","5","1","admin/structure/taxonomy/%","admin/structure/taxonomy/%","Manage fields","t","","","a:0:{}","132","","","1","modules/field_ui/field_ui.admin.inc"),
("admin/structure/taxonomy/%/fields/%","a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}","","58","6","0","","admin/structure/taxonomy/%/fields/%","","field_ui_menu_title","a:1:{i:0;i:5;}","","a:0:{}","6","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/taxonomy/%/fields/%/delete","a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:5;}","","117","7","1","admin/structure/taxonomy/%/fields/%","admin/structure/taxonomy/%/fields/%","Delete","t","","","a:0:{}","132","","","10","modules/field_ui/field_ui.admin.inc"),
("admin/structure/taxonomy/%/fields/%/edit","a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}","","117","7","1","admin/structure/taxonomy/%/fields/%","admin/structure/taxonomy/%/fields/%","Edit","t","","","a:0:{}","140","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/taxonomy/%/fields/%/field-settings","a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:5;}","","117","7","1","admin/structure/taxonomy/%/fields/%","admin/structure/taxonomy/%/fields/%","Field settings","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/taxonomy/%/fields/%/widget-type","a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:5;}","","117","7","1","admin/structure/taxonomy/%/fields/%","admin/structure/taxonomy/%/fields/%","Widget type","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/taxonomy/%/list","a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:2:{i:0;s:23:\"taxonomy_overview_terms\";i:1;i:3;}","","29","5","1","admin/structure/taxonomy/%","admin/structure/taxonomy/%","List","t","","","a:0:{}","140","","","-20","modules/taxonomy/taxonomy.admin.inc"),
("admin/structure/taxonomy/add","","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:1:{i:0;s:24:\"taxonomy_form_vocabulary\";}","","15","4","1","admin/structure/taxonomy","admin/structure/taxonomy","Add vocabulary","t","","","a:0:{}","388","","","0","modules/taxonomy/taxonomy.admin.inc"),
("admin/structure/taxonomy/list","","","user_access","a:1:{i:0;s:19:\"administer taxonomy\";}","drupal_get_form","a:1:{i:0;s:30:\"taxonomy_overview_vocabularies\";}","","15","4","1","admin/structure/taxonomy","admin/structure/taxonomy","List","t","","","a:0:{}","140","","","-10","modules/taxonomy/taxonomy.admin.inc"),
("admin/structure/types","","","user_access","a:1:{i:0;s:24:\"administer content types\";}","node_overview_types","a:0:{}","","7","3","0","","admin/structure/types","Content types","t","","","a:0:{}","6","Manage content types, including default status, front page promotion, comment settings, etc.","","0","modules/node/content_types.inc"),
("admin/structure/types/add","","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:1:{i:0;s:14:\"node_type_form\";}","","15","4","1","admin/structure/types","admin/structure/types","Add content type","t","","","a:0:{}","388","","","0","modules/node/content_types.inc"),
("admin/structure/types/list","","","user_access","a:1:{i:0;s:24:\"administer content types\";}","node_overview_types","a:0:{}","","15","4","1","admin/structure/types","admin/structure/types","List","t","","","a:0:{}","140","","","-10","modules/node/content_types.inc"),
("admin/structure/types/manage/%","a:1:{i:4;s:14:\"node_type_load\";}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:14:\"node_type_form\";i:1;i:4;}","","30","5","0","","admin/structure/types/manage/%","Edit content type","node_type_page_title","a:1:{i:0;i:4;}","","a:0:{}","6","","","0","modules/node/content_types.inc"),
("admin/structure/types/manage/%/comment/display","a:1:{i:4;s:22:\"comment_node_type_load\";}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:7:\"comment\";i:2;i:4;i:3;s:7:\"default\";}","","123","7","1","admin/structure/types/manage/%","admin/structure/types/manage/%","Comment display","t","","","a:0:{}","132","","","4","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/comment/display/default","a:1:{i:4;s:22:\"comment_node_type_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:7:\"comment\";i:2;i:4;i:3;s:7:\"default\";}","","247","8","1","admin/structure/types/manage/%/comment/display","admin/structure/types/manage/%","Default","t","","","a:0:{}","140","","","-10","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/comment/display/full","a:1:{i:4;s:22:\"comment_node_type_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:7:\"comment\";i:2;i:4;i:3;s:4:\"full\";}","","247","8","1","admin/structure/types/manage/%/comment/display","admin/structure/types/manage/%","Full comment","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/comment/display/token","a:1:{i:4;s:22:\"comment_node_type_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:5:\"token\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:7:\"comment\";i:2;i:4;i:3;s:5:\"token\";}","","247","8","1","admin/structure/types/manage/%/comment/display","admin/structure/types/manage/%","Tokens","t","","","a:0:{}","132","","","1","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/comment/fields","a:1:{i:4;s:22:\"comment_node_type_load\";}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:7:\"comment\";i:2;i:4;}","","123","7","1","admin/structure/types/manage/%","admin/structure/types/manage/%","Comment fields","t","","","a:0:{}","132","","","3","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/comment/fields/%","a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:7;}","","246","8","0","","admin/structure/types/manage/%/comment/fields/%","","field_ui_menu_title","a:1:{i:0;i:7;}","","a:0:{}","6","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/comment/fields/%/delete","a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:7;}","","493","9","1","admin/structure/types/manage/%/comment/fields/%","admin/structure/types/manage/%/comment/fields/%","Delete","t","","","a:0:{}","132","","","10","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/comment/fields/%/edit","a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:7;}","","493","9","1","admin/structure/types/manage/%/comment/fields/%","admin/structure/types/manage/%/comment/fields/%","Edit","t","","","a:0:{}","140","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/comment/fields/%/field-settings","a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:7;}","","493","9","1","admin/structure/types/manage/%/comment/fields/%","admin/structure/types/manage/%/comment/fields/%","Field settings","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/comment/fields/%/widget-type","a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:7;}","","493","9","1","admin/structure/types/manage/%/comment/fields/%","admin/structure/types/manage/%/comment/fields/%","Widget type","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/delete","a:1:{i:4;s:14:\"node_type_load\";}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:24:\"node_type_delete_confirm\";i:1;i:4;}","","61","6","0","","admin/structure/types/manage/%/delete","Delete","t","","","a:0:{}","6","","","0","modules/node/content_types.inc"),
("admin/structure/types/manage/%/display","a:1:{i:4;s:14:\"node_type_load\";}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:7:\"default\";}","","61","6","1","admin/structure/types/manage/%","admin/structure/types/manage/%","Manage display","t","","","a:0:{}","132","","","2","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/display/default","a:1:{i:4;s:14:\"node_type_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:7:\"default\";}","","123","7","1","admin/structure/types/manage/%/display","admin/structure/types/manage/%","Default","t","","","a:0:{}","140","","","-10","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/display/full","a:1:{i:4;s:14:\"node_type_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:4:\"full\";}","","123","7","1","admin/structure/types/manage/%/display","admin/structure/types/manage/%","Full content","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/display/rss","a:1:{i:4;s:14:\"node_type_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:3:\"rss\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:3:\"rss\";}","","123","7","1","admin/structure/types/manage/%/display","admin/structure/types/manage/%","RSS","t","","","a:0:{}","132","","","2","modules/field_ui/field_ui.admin.inc");
INSERT INTO menu_router VALUES
("admin/structure/types/manage/%/display/search_index","a:1:{i:4;s:14:\"node_type_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:12:\"search_index\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:12:\"search_index\";}","","123","7","1","admin/structure/types/manage/%/display","admin/structure/types/manage/%","Search index","t","","","a:0:{}","132","","","3","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/display/search_result","a:1:{i:4;s:14:\"node_type_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:13:\"search_result\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:13:\"search_result\";}","","123","7","1","admin/structure/types/manage/%/display","admin/structure/types/manage/%","Search result highlighting input","t","","","a:0:{}","132","","","4","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/display/teaser","a:1:{i:4;s:14:\"node_type_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:6:\"teaser\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:6:\"teaser\";}","","123","7","1","admin/structure/types/manage/%/display","admin/structure/types/manage/%","Teaser","t","","","a:0:{}","132","","","1","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/display/token","a:1:{i:4;s:14:\"node_type_load\";}","","_field_ui_view_mode_menu_access","a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:5:\"token\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}","drupal_get_form","a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:5:\"token\";}","","123","7","1","admin/structure/types/manage/%/display","admin/structure/types/manage/%","Tokens","t","","","a:0:{}","132","","","5","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/edit","a:1:{i:4;s:14:\"node_type_load\";}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:14:\"node_type_form\";i:1;i:4;}","","61","6","1","admin/structure/types/manage/%","admin/structure/types/manage/%","Edit","t","","","a:0:{}","140","","","0","modules/node/content_types.inc"),
("admin/structure/types/manage/%/fields","a:1:{i:4;s:14:\"node_type_load\";}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:4:\"node\";i:2;i:4;}","","61","6","1","admin/structure/types/manage/%","admin/structure/types/manage/%","Manage fields","t","","","a:0:{}","132","","","1","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/fields/%","a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:6;}","","122","7","0","","admin/structure/types/manage/%/fields/%","","field_ui_menu_title","a:1:{i:0;i:6;}","","a:0:{}","6","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/fields/%/delete","a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:6;}","","245","8","1","admin/structure/types/manage/%/fields/%","admin/structure/types/manage/%/fields/%","Delete","t","","","a:0:{}","132","","","10","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/fields/%/edit","a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:6;}","","245","8","1","admin/structure/types/manage/%/fields/%","admin/structure/types/manage/%/fields/%","Edit","t","","","a:0:{}","140","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/fields/%/field-settings","a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:6;}","","245","8","1","admin/structure/types/manage/%/fields/%","admin/structure/types/manage/%/fields/%","Field settings","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/structure/types/manage/%/fields/%/widget-type","a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}","","user_access","a:1:{i:0;s:24:\"administer content types\";}","drupal_get_form","a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:6;}","","245","8","1","admin/structure/types/manage/%/fields/%","admin/structure/types/manage/%/fields/%","Widget type","t","","","a:0:{}","132","","","0","modules/field_ui/field_ui.admin.inc"),
("admin/tasks","","","user_access","a:1:{i:0;s:27:\"access administration pages\";}","system_admin_menu_block_page","a:0:{}","","3","2","1","admin","admin","Tasks","t","","","a:0:{}","140","","","-20","modules/system/system.admin.inc"),
("admin/update/ready","","","update_manager_access","a:0:{}","drupal_get_form","a:1:{i:0;s:32:\"update_manager_update_ready_form\";}","","7","3","0","","admin/update/ready","Ready to update","t","","","a:0:{}","0","","","0","modules/update/update.manager.inc"),
("admin/views/ajax/autocomplete/taxonomy","","","user_access","a:1:{i:0;s:14:\"access content\";}","views_ajax_autocomplete_taxonomy","a:0:{}","","31","5","0","","admin/views/ajax/autocomplete/taxonomy","","t","","ajax_base_page_theme","a:0:{}","0","","","0","sites/all/modules/views/includes/ajax.inc"),
("admin/views/ajax/autocomplete/user","","","user_access","a:1:{i:0;s:20:\"access user profiles\";}","views_ajax_autocomplete_user","a:0:{}","","31","5","0","","admin/views/ajax/autocomplete/user","","t","","ajax_base_page_theme","a:0:{}","0","","","0","sites/all/modules/views/includes/ajax.inc"),
("batch","","","1","a:0:{}","system_batch_page","a:0:{}","","1","1","0","","batch","","t","","_system_batch_theme","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("ckeditor/disable/wysiwyg/%","a:1:{i:3;N;}","","1","a:1:{i:0;s:19:\"administer ckeditor\";}","ckeditor_disable_wysiwyg","a:1:{i:0;i:3;}","","14","4","0","","ckeditor/disable/wysiwyg/%","Disable the WYSIWYG module","t","","","a:0:{}","0","Disable WYSIWYG module.","","0","sites/all/modules/ckeditor/includes/ckeditor.admin.inc"),
("ckeditor/xss","","","1","a:0:{}","ckeditor_filter_xss","a:0:{}","","3","2","0","","ckeditor/xss","XSS Filter","t","","","a:0:{}","0","XSS Filter.","","0","sites/all/modules/ckeditor/includes/ckeditor.page.inc"),
("comment/%","a:1:{i:1;N;}","","user_access","a:1:{i:0;s:15:\"access comments\";}","comment_permalink","a:1:{i:0;i:1;}","","2","2","0","","comment/%","Comment permalink","t","","","a:0:{}","6","","","0",""),
("comment/%/approve","a:1:{i:1;N;}","","user_access","a:1:{i:0;s:19:\"administer comments\";}","comment_approve","a:1:{i:0;i:1;}","","5","3","0","","comment/%/approve","Approve","t","","","a:0:{}","6","","","1","modules/comment/comment.pages.inc"),
("comment/%/delete","a:1:{i:1;N;}","","user_access","a:1:{i:0;s:19:\"administer comments\";}","comment_confirm_delete_page","a:1:{i:0;i:1;}","","5","3","1","comment/%","comment/%","Delete","t","","","a:0:{}","132","","","2","modules/comment/comment.admin.inc"),
("comment/%/edit","a:1:{i:1;s:12:\"comment_load\";}","","comment_access","a:2:{i:0;s:4:\"edit\";i:1;i:1;}","comment_edit_page","a:1:{i:0;i:1;}","","5","3","1","comment/%","comment/%","Edit","t","","","a:0:{}","132","","","0",""),
("comment/%/view","a:1:{i:1;N;}","","user_access","a:1:{i:0;s:15:\"access comments\";}","comment_permalink","a:1:{i:0;i:1;}","","5","3","1","comment/%","comment/%","View comment","t","","","a:0:{}","140","","","-10",""),
("comment/reply/%","a:1:{i:2;s:9:\"node_load\";}","","node_access","a:2:{i:0;s:4:\"view\";i:1;i:2;}","comment_reply","a:1:{i:0;i:2;}","","6","3","0","","comment/reply/%","Add new comment","t","","","a:0:{}","6","","","0","modules/comment/comment.pages.inc"),
("ctools/autocomplete/%","a:1:{i:2;N;}","","user_access","a:1:{i:0;s:14:\"access content\";}","ctools_content_autocomplete_entity","a:1:{i:0;i:2;}","","6","3","0","","ctools/autocomplete/%","","t","","","a:0:{}","0","","","0","sites/all/modules/ctools/includes/content.menu.inc"),
("ctools/context/ajax/access/add","","","user_access","a:1:{i:0;s:14:\"access content\";}","ctools_access_ajax_add","a:0:{}","","31","5","0","","ctools/context/ajax/access/add","","t","","ajax_base_page_theme","a:0:{}","0","","","0","sites/all/modules/ctools/includes/context-access-admin.inc"),
("ctools/context/ajax/access/configure","","","user_access","a:1:{i:0;s:14:\"access content\";}","ctools_access_ajax_edit","a:0:{}","","31","5","0","","ctools/context/ajax/access/configure","","t","","ajax_base_page_theme","a:0:{}","0","","","0","sites/all/modules/ctools/includes/context-access-admin.inc"),
("ctools/context/ajax/access/delete","","","user_access","a:1:{i:0;s:14:\"access content\";}","ctools_access_ajax_delete","a:0:{}","","31","5","0","","ctools/context/ajax/access/delete","","t","","ajax_base_page_theme","a:0:{}","0","","","0","sites/all/modules/ctools/includes/context-access-admin.inc"),
("ctools/context/ajax/add","","","user_access","a:1:{i:0;s:14:\"access content\";}","ctools_context_ajax_item_add","a:0:{}","","15","4","0","","ctools/context/ajax/add","","t","","ajax_base_page_theme","a:0:{}","0","","","0","sites/all/modules/ctools/includes/context-admin.inc"),
("ctools/context/ajax/configure","","","user_access","a:1:{i:0;s:14:\"access content\";}","ctools_context_ajax_item_edit","a:0:{}","","15","4","0","","ctools/context/ajax/configure","","t","","ajax_base_page_theme","a:0:{}","0","","","0","sites/all/modules/ctools/includes/context-admin.inc"),
("ctools/context/ajax/delete","","","user_access","a:1:{i:0;s:14:\"access content\";}","ctools_context_ajax_item_delete","a:0:{}","","15","4","0","","ctools/context/ajax/delete","","t","","ajax_base_page_theme","a:0:{}","0","","","0","sites/all/modules/ctools/includes/context-admin.inc"),
("file/ajax","","","user_access","a:1:{i:0;s:14:\"access content\";}","file_ajax_upload","a:0:{}","ajax_deliver","3","2","0","","file/ajax","","t","","ajax_base_page_theme","a:0:{}","0","","","0",""),
("file/progress","","","user_access","a:1:{i:0;s:14:\"access content\";}","file_ajax_progress","a:0:{}","","3","2","0","","file/progress","","t","","ajax_base_page_theme","a:0:{}","0","","","0",""),
("filter/tips","","","1","a:0:{}","filter_tips_long","a:0:{}","","3","2","0","","filter/tips","Compose tips","t","","","a:0:{}","20","","","0","modules/filter/filter.pages.inc"),
("filter/tips/%","a:1:{i:2;s:18:\"filter_format_load\";}","","filter_access","a:1:{i:0;i:2;}","filter_tips_long","a:1:{i:0;i:2;}","","6","3","0","","filter/tips/%","Compose tips","t","","","a:0:{}","6","","","0","modules/filter/filter.pages.inc"),
("node","","","user_access","a:1:{i:0;s:14:\"access content\";}","node_page_default","a:0:{}","","1","1","0","","node","","t","","","a:0:{}","0","","","0",""),
("node/%","a:1:{i:1;s:9:\"node_load\";}","","node_access","a:2:{i:0;s:4:\"view\";i:1;i:1;}","node_page_view","a:1:{i:0;i:1;}","","2","2","0","","node/%","","node_page_title","a:1:{i:0;i:1;}","","a:0:{}","6","","","0",""),
("node/%/delete","a:1:{i:1;s:9:\"node_load\";}","","node_access","a:2:{i:0;s:6:\"delete\";i:1;i:1;}","drupal_get_form","a:2:{i:0;s:19:\"node_delete_confirm\";i:1;i:1;}","","5","3","2","node/%","node/%","Delete","t","","","a:0:{}","132","","","1","modules/node/node.pages.inc"),
("node/%/done","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_confirmation_page_access","a:1:{i:0;i:1;}","_webform_confirmation","a:1:{i:0;i:1;}","","5","3","0","","node/%/done","Webform confirmation","t","","","a:0:{}","0","","","0",""),
("node/%/edit","a:1:{i:1;s:9:\"node_load\";}","","node_access","a:2:{i:0;s:6:\"update\";i:1;i:1;}","node_page_edit","a:1:{i:0;i:1;}","","5","3","3","node/%","node/%","Edit","t","","","a:0:{}","132","","","0","modules/node/node.pages.inc"),
("node/%/revisions","a:1:{i:1;s:9:\"node_load\";}","","_node_revision_access","a:1:{i:0;i:1;}","node_revision_overview","a:1:{i:0;i:1;}","","5","3","1","node/%","node/%","Revisions","t","","","a:0:{}","132","","","2","modules/node/node.pages.inc"),
("node/%/revisions/%/delete","a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}","","_node_revision_access","a:2:{i:0;i:1;i:1;s:6:\"delete\";}","drupal_get_form","a:2:{i:0;s:28:\"node_revision_delete_confirm\";i:1;i:1;}","","21","5","0","","node/%/revisions/%/delete","Delete earlier revision","t","","","a:0:{}","6","","","0","modules/node/node.pages.inc"),
("node/%/revisions/%/revert","a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}","","_node_revision_access","a:2:{i:0;i:1;i:1;s:6:\"update\";}","drupal_get_form","a:2:{i:0;s:28:\"node_revision_revert_confirm\";i:1;i:1;}","","21","5","0","","node/%/revisions/%/revert","Revert to earlier revision","t","","","a:0:{}","6","","","0","modules/node/node.pages.inc"),
("node/%/revisions/%/view","a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}","","_node_revision_access","a:1:{i:0;i:1;}","node_show","a:2:{i:0;i:1;i:1;b:1;}","","21","5","0","","node/%/revisions/%/view","Revisions","t","","","a:0:{}","6","","","0",""),
("node/%/submission/%","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:1:{i:0;i:1;}}i:3;a:1:{s:28:\"webform_menu_submission_load\";a:1:{i:0;i:1;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_submission_access","a:3:{i:0;i:1;i:1;i:3;i:2;s:4:\"view\";}","webform_submission_page","a:3:{i:0;i:1;i:1;i:3;i:2;s:4:\"html\";}","","10","4","0","","node/%/submission/%","Webform submission","webform_submission_title","a:2:{i:0;i:1;i:1;i:3;}","","a:0:{}","0","","","0","sites/all/modules/webform/includes/webform.submissions.inc"),
("node/%/submission/%/delete","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:1:{i:0;i:1;}}i:3;a:1:{s:28:\"webform_menu_submission_load\";a:1:{i:0;i:1;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_submission_access","a:3:{i:0;i:1;i:1;i:3;i:2;s:6:\"delete\";}","drupal_get_form","a:3:{i:0;s:30:\"webform_submission_delete_form\";i:1;i:1;i:2;i:3;}","","21","5","1","node/%/submission/%","node/%/submission/%","Delete","t","","","a:0:{}","132","","","2","sites/all/modules/webform/includes/webform.submissions.inc"),
("node/%/submission/%/edit","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:1:{i:0;i:1;}}i:3;a:1:{s:28:\"webform_menu_submission_load\";a:1:{i:0;i:1;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_submission_access","a:3:{i:0;i:1;i:1;i:3;i:2;s:4:\"edit\";}","webform_submission_page","a:3:{i:0;i:1;i:1;i:3;i:2;s:4:\"form\";}","","21","5","1","node/%/submission/%","node/%/submission/%","Edit","t","","","a:0:{}","132","","","1","sites/all/modules/webform/includes/webform.submissions.inc"),
("node/%/submission/%/resend","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:1:{i:0;i:1;}}i:3;a:1:{s:28:\"webform_menu_submission_load\";a:1:{i:0;i:1;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_results_access","a:1:{i:0;i:1;}","drupal_get_form","a:3:{i:0;s:25:\"webform_submission_resend\";i:1;i:1;i:2;i:3;}","","21","5","0","","node/%/submission/%/resend","Resend e-mails","t","","","a:0:{}","0","","","0","sites/all/modules/webform/includes/webform.submissions.inc"),
("node/%/submission/%/view","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:1:{i:0;i:1;}}i:3;a:1:{s:28:\"webform_menu_submission_load\";a:1:{i:0;i:1;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_submission_access","a:3:{i:0;i:1;i:1;i:3;i:2;s:4:\"view\";}","webform_submission_page","a:3:{i:0;i:1;i:1;i:3;i:2;s:4:\"html\";}","","21","5","1","node/%/submission/%","node/%/submission/%","View","t","","","a:0:{}","140","","","0","sites/all/modules/webform/includes/webform.submissions.inc"),
("node/%/submissions","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_submission_access","a:3:{i:0;i:1;i:1;N;i:2;s:4:\"list\";}","webform_results_submissions","a:3:{i:0;i:1;i:1;b:1;i:2;s:2:\"50\";}","","5","3","0","","node/%/submissions","Submissions","t","","","a:0:{}","0","","","0","sites/all/modules/webform/includes/webform.report.inc"),
("node/%/view","a:1:{i:1;s:9:\"node_load\";}","","node_access","a:2:{i:0;s:4:\"view\";i:1;i:1;}","node_page_view","a:1:{i:0;i:1;}","","5","3","1","node/%","node/%","View","t","","","a:0:{}","140","","","-10",""),
("node/%/webform","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","webform_components_page","a:1:{i:0;i:1;}","","5","3","3","node/%","node/%","Webform","t","","","a:0:{}","132","","","1","sites/all/modules/webform/includes/webform.components.inc"),
("node/%/webform-results","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_results_access","a:1:{i:0;i:1;}","webform_results_submissions","a:3:{i:0;i:1;i:1;b:0;i:2;s:2:\"50\";}","","5","3","3","node/%","node/%","Results","t","","","a:0:{}","132","","","2","sites/all/modules/webform/includes/webform.report.inc"),
("node/%/webform-results/analysis","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_results_access","a:1:{i:0;i:1;}","webform_results_analysis","a:1:{i:0;i:1;}","","11","4","1","node/%/webform-results","node/%","Analysis","t","","","a:0:{}","132","","","5","sites/all/modules/webform/includes/webform.report.inc"),
("node/%/webform-results/analysis/%","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:2:{i:0;i:1;i:1;i:4;}}i:4;a:1:{s:27:\"webform_menu_component_load\";a:2:{i:0;i:1;i:1;i:4;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_results_access","a:1:{i:0;i:1;}","webform_results_analysis","a:3:{i:0;i:1;i:1;a:0:{}i:2;i:4;}","","22","5","1","node/%/webform-results/analysis","node/%","Analysis","t","","","a:0:{}","132","","","0","sites/all/modules/webform/includes/webform.report.inc"),
("node/%/webform-results/analysis/%/more","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:2:{i:0;i:1;i:1;i:4;}}i:4;a:1:{s:27:\"webform_menu_component_load\";a:2:{i:0;i:1;i:1;i:4;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_results_access","a:1:{i:0;i:1;}","webform_results_analysis","a:3:{i:0;i:1;i:1;a:0:{}i:2;i:4;}","","45","6","1","node/%/webform-results/analysis/%","node/%","In-depth analysis","t","","","a:0:{}","140","","","0","sites/all/modules/webform/includes/webform.report.inc"),
("node/%/webform-results/clear","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_results_clear_access","a:1:{i:0;i:1;}","drupal_get_form","a:2:{i:0;s:26:\"webform_results_clear_form\";i:1;i:1;}","","11","4","1","node/%/webform-results","node/%","Clear","t","","","a:0:{}","132","","","8","sites/all/modules/webform/includes/webform.report.inc"),
("node/%/webform-results/download","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_results_access","a:1:{i:0;i:1;}","drupal_get_form","a:2:{i:0;s:29:\"webform_results_download_form\";i:1;i:1;}","","11","4","1","node/%/webform-results","node/%","Download","t","","","a:0:{}","132","","","7","sites/all/modules/webform/includes/webform.report.inc"),
("node/%/webform-results/download-file","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_results_access","a:1:{i:0;i:1;}","webform_results_download_callback","a:1:{i:0;i:1;}","","11","4","0","","node/%/webform-results/download-file","Download","t","","","a:0:{}","0","","","0","sites/all/modules/webform/includes/webform.report.inc"),
("node/%/webform-results/submissions","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_results_access","a:1:{i:0;i:1;}","webform_results_submissions","a:3:{i:0;i:1;i:1;b:0;i:2;s:2:\"50\";}","","11","4","1","node/%/webform-results","node/%","Submissions","t","","","a:0:{}","140","","","4","sites/all/modules/webform/includes/webform.report.inc"),
("node/%/webform-results/table","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_results_access","a:1:{i:0;i:1;}","webform_results_table","a:2:{i:0;i:1;i:1;s:2:\"50\";}","","11","4","1","node/%/webform-results","node/%","Table","t","","","a:0:{}","132","","","6","sites/all/modules/webform/includes/webform.report.inc"),
("node/%/webform/components","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","webform_components_page","a:1:{i:0;i:1;}","","11","4","1","node/%/webform","node/%","Form components","t","","","a:0:{}","140","","","0","sites/all/modules/webform/includes/webform.components.inc"),
("node/%/webform/components/%","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:2:{i:0;i:1;i:1;i:5;}}i:4;a:1:{s:27:\"webform_menu_component_load\";a:2:{i:0;i:1;i:1;i:5;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","drupal_get_form","a:4:{i:0;s:27:\"webform_component_edit_form\";i:1;i:1;i:2;i:4;i:3;b:0;}","","22","5","1","node/%/webform/components","node/%","","t","","","a:0:{}","132","","","0","sites/all/modules/webform/includes/webform.components.inc"),
("node/%/webform/components/%/clone","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:2:{i:0;i:1;i:1;i:5;}}i:4;a:1:{s:27:\"webform_menu_component_load\";a:2:{i:0;i:1;i:1;i:5;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","drupal_get_form","a:4:{i:0;s:27:\"webform_component_edit_form\";i:1;i:1;i:2;i:4;i:3;b:1;}","","45","6","1","node/%/webform/components/%","node/%","","t","","","a:0:{}","132","","","0","sites/all/modules/webform/includes/webform.components.inc"),
("node/%/webform/components/%/delete","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:2:{i:0;i:1;i:1;i:5;}}i:4;a:1:{s:27:\"webform_menu_component_load\";a:2:{i:0;i:1;i:1;i:5;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","drupal_get_form","a:3:{i:0;s:29:\"webform_component_delete_form\";i:1;i:1;i:2;i:4;}","","45","6","1","node/%/webform/components/%","node/%","","t","","","a:0:{}","132","","","0","sites/all/modules/webform/includes/webform.components.inc"),
("node/%/webform/conditionals","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","drupal_get_form","a:2:{i:0;s:25:\"webform_conditionals_form\";i:1;i:1;}","","11","4","1","node/%/webform","node/%","Conditionals","t","","","a:0:{}","132","","","1","sites/all/modules/webform/includes/webform.conditionals.inc"),
("node/%/webform/configure","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","drupal_get_form","a:2:{i:0;s:22:\"webform_configure_form\";i:1;i:1;}","","11","4","1","node/%/webform","node/%","Form settings","t","","","a:0:{}","132","","","5","sites/all/modules/webform/includes/webform.pages.inc"),
("node/%/webform/emails","a:1:{i:1;s:17:\"webform_menu_load\";}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","drupal_get_form","a:2:{i:0;s:19:\"webform_emails_form\";i:1;i:1;}","","11","4","1","node/%/webform","node/%","E-mails","t","","","a:0:{}","132","","","4","sites/all/modules/webform/includes/webform.emails.inc"),
("node/%/webform/emails/%","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:1:{i:0;i:1;}}i:4;a:1:{s:23:\"webform_menu_email_load\";a:1:{i:0;i:1;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","drupal_get_form","a:3:{i:0;s:23:\"webform_email_edit_form\";i:1;i:1;i:2;i:4;}","","22","5","1","node/%/webform/emails","node/%","","t","","","a:0:{}","132","","","0","sites/all/modules/webform/includes/webform.emails.inc"),
("node/%/webform/emails/%/clone","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:1:{i:0;i:1;}}i:4;a:1:{s:23:\"webform_menu_email_load\";a:1:{i:0;i:1;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","drupal_get_form","a:4:{i:0;s:23:\"webform_email_edit_form\";i:1;i:1;i:2;i:4;i:3;b:1;}","","45","6","1","node/%/webform/emails/%","node/%","","t","","","a:0:{}","132","","","0","sites/all/modules/webform/includes/webform.emails.inc"),
("node/%/webform/emails/%/delete","a:2:{i:1;a:1:{s:17:\"webform_menu_load\";a:1:{i:0;i:1;}}i:4;a:1:{s:23:\"webform_menu_email_load\";a:1:{i:0;i:1;}}}","a:1:{i:1;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:1;}","drupal_get_form","a:3:{i:0;s:25:\"webform_email_delete_form\";i:1;i:1;i:2;i:4;}","","45","6","1","node/%/webform/emails/%","node/%","","t","","","a:0:{}","132","","","0","sites/all/modules/webform/includes/webform.emails.inc"),
("node/add","","","_node_add_access","a:0:{}","node_add_page","a:0:{}","","3","2","0","","node/add","Add content","t","","","a:0:{}","6","","","0","modules/node/node.pages.inc"),
("node/add/article","","","node_access","a:2:{i:0;s:6:\"create\";i:1;s:7:\"article\";}","node_add","a:1:{i:0;s:7:\"article\";}","","7","3","0","","node/add/article","Article","check_plain","","","a:0:{}","6","Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.","","0","modules/node/node.pages.inc"),
("node/add/page","","","node_access","a:2:{i:0;s:6:\"create\";i:1;s:4:\"page\";}","node_add","a:1:{i:0;s:4:\"page\";}","","7","3","0","","node/add/page","Basic page","check_plain","","","a:0:{}","6","Use <em>basic pages</em> for your static content, such as an \'About us\' page.","","0","modules/node/node.pages.inc"),
("node/add/webform","","","node_access","a:2:{i:0;s:6:\"create\";i:1;s:7:\"webform\";}","node_add","a:1:{i:0;s:7:\"webform\";}","","7","3","0","","node/add/webform","Webform","check_plain","","","a:0:{}","6","Create a new form or questionnaire accessible to users. Submission results and statistics are recorded and accessible to privileged users.","","0","modules/node/node.pages.inc"),
("overlay-ajax/%","a:1:{i:1;N;}","","user_access","a:1:{i:0;s:14:\"access overlay\";}","overlay_ajax_render_region","a:1:{i:0;i:1;}","","2","2","0","","overlay-ajax/%","","t","","","a:0:{}","0","","","0",""),
("overlay/dismiss-message","","","user_access","a:1:{i:0;s:14:\"access overlay\";}","overlay_user_dismiss_message","a:0:{}","","3","2","0","","overlay/dismiss-message","","t","","","a:0:{}","0","","","0",""),
("rss.xml","","","user_access","a:1:{i:0;s:14:\"access content\";}","node_feed","a:2:{i:0;b:0;i:1;a:0:{}}","","1","1","0","","rss.xml","RSS feed","t","","","a:0:{}","0","","","0",""),
("search","","","search_is_active","a:0:{}","search_view","a:0:{}","","1","1","0","","search","Search","t","","","a:0:{}","20","","","0","modules/search/search.pages.inc"),
("search/node","","","_search_menu_access","a:1:{i:0;s:4:\"node\";}","search_view","a:2:{i:0;s:4:\"node\";i:1;s:0:\"\";}","","3","2","1","search","search","Content","t","","","a:0:{}","132","","","-10","modules/search/search.pages.inc"),
("search/node/%","a:1:{i:2;a:1:{s:14:\"menu_tail_load\";a:2:{i:0;s:4:\"%map\";i:1;s:6:\"%index\";}}}","a:1:{i:2;s:16:\"menu_tail_to_arg\";}","_search_menu_access","a:1:{i:0;s:4:\"node\";}","search_view","a:2:{i:0;s:4:\"node\";i:1;i:2;}","","6","3","1","search/node","search/node/%","Content","t","","","a:0:{}","132","","","0","modules/search/search.pages.inc"),
("search/user","","","_search_menu_access","a:1:{i:0;s:4:\"user\";}","search_view","a:2:{i:0;s:4:\"user\";i:1;s:0:\"\";}","","3","2","1","search","search","Users","t","","","a:0:{}","132","","","0","modules/search/search.pages.inc"),
("search/user/%","a:1:{i:2;a:1:{s:14:\"menu_tail_load\";a:2:{i:0;s:4:\"%map\";i:1;s:6:\"%index\";}}}","a:1:{i:2;s:16:\"menu_tail_to_arg\";}","_search_menu_access","a:1:{i:0;s:4:\"user\";}","search_view","a:2:{i:0;s:4:\"user\";i:1;i:2;}","","6","3","1","search/node","search/node/%","Users","t","","","a:0:{}","132","","","0","modules/search/search.pages.inc"),
("search404","","","1","a:0:{}","search404_page","a:0:{}","","1","1","0","","search404","Page not found","t","","","a:0:{}","0","","","0","sites/all/modules/search404/search404.page.inc"),
("sitemap.xml","","","1","a:0:{}","xmlsitemap_output_chunk","a:0:{}","","1","1","0","","sitemap.xml","","t","","","a:0:{}","0","","","0","sites/all/modules/xmlsitemap/xmlsitemap.pages.inc"),
("sitemap.xsl","","","1","a:0:{}","xmlsitemap_output_xsl","a:0:{}","","1","1","0","","sitemap.xsl","","t","","","a:0:{}","0","","","0","sites/all/modules/xmlsitemap/xmlsitemap.pages.inc"),
("sites/default/files/styles/%","a:1:{i:4;s:16:\"image_style_load\";}","","1","a:0:{}","image_style_deliver","a:1:{i:0;i:4;}","","30","5","0","","sites/default/files/styles/%","Generate image style","t","","","a:0:{}","0","","","0",""),
("system/ajax","","","1","a:0:{}","ajax_form_callback","a:0:{}","ajax_deliver","3","2","0","","system/ajax","AHAH callback","t","","ajax_base_page_theme","a:0:{}","0","","","0","includes/form.inc"),
("system/files","","","1","a:0:{}","file_download","a:1:{i:0;s:7:\"private\";}","","3","2","0","","system/files","File download","t","","","a:0:{}","0","","","0",""),
("system/files/styles/%","a:1:{i:3;s:16:\"image_style_load\";}","","1","a:0:{}","image_style_deliver","a:1:{i:0;i:3;}","","14","4","0","","system/files/styles/%","Generate image style","t","","","a:0:{}","0","","","0",""),
("system/temporary","","","1","a:0:{}","file_download","a:1:{i:0;s:9:\"temporary\";}","","3","2","0","","system/temporary","Temporary files","t","","","a:0:{}","0","","","0",""),
("system/timezone","","","1","a:0:{}","system_timezone","a:0:{}","","3","2","0","","system/timezone","Time zone","t","","","a:0:{}","0","","","0","modules/system/system.admin.inc"),
("taxonomy/autocomplete","","","user_access","a:1:{i:0;s:14:\"access content\";}","taxonomy_autocomplete","a:0:{}","","3","2","0","","taxonomy/autocomplete","Autocomplete taxonomy","t","","","a:0:{}","0","","","0","modules/taxonomy/taxonomy.pages.inc"),
("taxonomy/term/%","a:1:{i:2;s:18:\"taxonomy_term_load\";}","","user_access","a:1:{i:0;s:14:\"access content\";}","taxonomy_term_page","a:1:{i:0;i:2;}","","6","3","0","","taxonomy/term/%","Taxonomy term","taxonomy_term_title","a:1:{i:0;i:2;}","","a:0:{}","6","","","0","modules/taxonomy/taxonomy.pages.inc"),
("taxonomy/term/%/edit","a:1:{i:2;s:18:\"taxonomy_term_load\";}","","taxonomy_term_edit_access","a:1:{i:0;i:2;}","drupal_get_form","a:3:{i:0;s:18:\"taxonomy_form_term\";i:1;i:2;i:2;N;}","","13","4","1","taxonomy/term/%","taxonomy/term/%","Edit","t","","","a:0:{}","132","","","10","modules/taxonomy/taxonomy.admin.inc"),
("taxonomy/term/%/feed","a:1:{i:2;s:18:\"taxonomy_term_load\";}","","user_access","a:1:{i:0;s:14:\"access content\";}","taxonomy_term_feed","a:1:{i:0;i:2;}","","13","4","0","","taxonomy/term/%/feed","Taxonomy term","taxonomy_term_title","a:1:{i:0;i:2;}","","a:0:{}","0","","","0","modules/taxonomy/taxonomy.pages.inc"),
("taxonomy/term/%/view","a:1:{i:2;s:18:\"taxonomy_term_load\";}","","user_access","a:1:{i:0;s:14:\"access content\";}","taxonomy_term_page","a:1:{i:0;i:2;}","","13","4","1","taxonomy/term/%","taxonomy/term/%","View","t","","","a:0:{}","140","","","0","modules/taxonomy/taxonomy.pages.inc"),
("token/autocomplete/%","a:1:{i:2;s:15:\"token_type_load\";}","","1","a:0:{}","token_autocomplete_token","a:1:{i:0;i:2;}","","6","3","0","","token/autocomplete/%","","t","","","a:0:{}","0","","","0","sites/all/modules/token/token.pages.inc"),
("token/flush-cache","","","user_access","a:1:{i:0;s:12:\"flush caches\";}","token_flush_cache_callback","a:0:{}","","3","2","0","","token/flush-cache","","t","","","a:0:{}","0","","","0","sites/all/modules/token/token.pages.inc"),
("token/tree","","","1","a:0:{}","token_page_output_tree","a:0:{}","","3","2","0","","token/tree","","t","","ajax_base_page_theme","a:0:{}","0","","","0","sites/all/modules/token/token.pages.inc");
INSERT INTO menu_router VALUES
("toolbar/toggle","","","user_access","a:1:{i:0;s:14:\"access toolbar\";}","toolbar_toggle_page","a:0:{}","","3","2","0","","toolbar/toggle","Toggle drawer visibility","t","","","a:0:{}","0","","","0",""),
("user","","","1","a:0:{}","user_page","a:0:{}","","1","1","0","","user","User account","user_menu_title","","","a:0:{}","6","","","-10","modules/user/user.pages.inc"),
("user/%","a:1:{i:1;s:9:\"user_load\";}","","user_view_access","a:1:{i:0;i:1;}","user_view_page","a:1:{i:0;i:1;}","","2","2","0","","user/%","My account","user_page_title","a:1:{i:0;i:1;}","","a:0:{}","6","","","0",""),
("user/%/cancel","a:1:{i:1;s:9:\"user_load\";}","","user_cancel_access","a:1:{i:0;i:1;}","drupal_get_form","a:2:{i:0;s:24:\"user_cancel_confirm_form\";i:1;i:1;}","","5","3","0","","user/%/cancel","Cancel account","t","","","a:0:{}","6","","","0","modules/user/user.pages.inc"),
("user/%/cancel/confirm/%/%","a:3:{i:1;s:9:\"user_load\";i:4;N;i:5;N;}","","user_cancel_access","a:1:{i:0;i:1;}","user_cancel_confirm","a:3:{i:0;i:1;i:1;i:4;i:2;i:5;}","","44","6","0","","user/%/cancel/confirm/%/%","Confirm account cancellation","t","","","a:0:{}","6","","","0","modules/user/user.pages.inc"),
("user/%/edit","a:1:{i:1;s:9:\"user_load\";}","","user_edit_access","a:1:{i:0;i:1;}","drupal_get_form","a:2:{i:0;s:17:\"user_profile_form\";i:1;i:1;}","","5","3","1","user/%","user/%","Edit","t","","","a:0:{}","132","","","0","modules/user/user.pages.inc"),
("user/%/edit/account","a:1:{i:1;a:1:{s:18:\"user_category_load\";a:2:{i:0;s:4:\"%map\";i:1;s:6:\"%index\";}}}","","user_edit_access","a:1:{i:0;i:1;}","drupal_get_form","a:2:{i:0;s:17:\"user_profile_form\";i:1;i:1;}","","11","4","1","user/%/edit","user/%","Account","t","","","a:0:{}","140","","","0","modules/user/user.pages.inc"),
("user/%/shortcuts","a:1:{i:1;s:9:\"user_load\";}","","shortcut_set_switch_access","a:1:{i:0;i:1;}","drupal_get_form","a:2:{i:0;s:19:\"shortcut_set_switch\";i:1;i:1;}","","5","3","1","user/%","user/%","Shortcuts","t","","","a:0:{}","132","","","0","modules/shortcut/shortcut.admin.inc"),
("user/%/view","a:1:{i:1;s:9:\"user_load\";}","","user_view_access","a:1:{i:0;i:1;}","user_view_page","a:1:{i:0;i:1;}","","5","3","1","user/%","user/%","View","t","","","a:0:{}","140","","","-10",""),
("user/autocomplete","","","user_access","a:1:{i:0;s:20:\"access user profiles\";}","user_autocomplete","a:0:{}","","3","2","0","","user/autocomplete","User autocomplete","t","","","a:0:{}","0","","","0","modules/user/user.pages.inc"),
("user/login","","","user_is_anonymous","a:0:{}","user_page","a:0:{}","","3","2","1","user","user","Log in","t","","","a:0:{}","140","","","0","modules/user/user.pages.inc"),
("user/logout","","","user_is_logged_in","a:0:{}","user_logout","a:0:{}","","3","2","0","","user/logout","Log out","t","","","a:0:{}","6","","","10","modules/user/user.pages.inc"),
("user/password","","","1","a:0:{}","drupal_get_form","a:1:{i:0;s:9:\"user_pass\";}","","3","2","1","user","user","Request new password","t","","","a:0:{}","132","","","0","modules/user/user.pages.inc"),
("user/register","","","user_register_access","a:0:{}","drupal_get_form","a:1:{i:0;s:18:\"user_register_form\";}","","3","2","1","user","user","Create new account","t","","","a:0:{}","132","","","0",""),
("user/reset/%/%/%","a:3:{i:2;N;i:3;N;i:4;N;}","","1","a:0:{}","drupal_get_form","a:4:{i:0;s:15:\"user_pass_reset\";i:1;i:2;i:2;i:3;i:3;i:4;}","","24","5","0","","user/reset/%/%/%","Reset password","t","","","a:0:{}","0","","","0","modules/user/user.pages.inc"),
("views/ajax","","","1","a:0:{}","views_ajax","a:0:{}","ajax_deliver","3","2","0","","views/ajax","Views","t","","ajax_base_page_theme","a:0:{}","0","Ajax callback for view loading.","","0","sites/all/modules/views/includes/ajax.inc"),
("webform/ajax/options/%","a:1:{i:3;a:1:{s:17:\"webform_menu_load\";a:1:{i:0;i:3;}}}","a:1:{i:3;s:19:\"webform_menu_to_arg\";}","webform_node_update_access","a:1:{i:0;i:3;}","webform_select_options_ajax","a:0:{}","","14","4","0","","webform/ajax/options/%","","t","","","a:0:{}","0","","","0","sites/all/modules/webform/components/select.inc"),
("webform/autocomplete","","","user_access","a:1:{i:0;s:16:\"administer views\";}","webform_views_autocomplete","a:0:{}","","3","2","0","","webform/autocomplete","Webforms","t","","","a:0:{}","0","","","0","sites/all/modules/webform/views/webform.views.inc");




CREATE TABLE `metatag` (
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to.',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The entity id this data is attached to.',
  `revision_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The revision_id for the entity object this data is attached to.',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language of the tag.',
  `data` longblob NOT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`language`),
  KEY `type_revision` (`entity_type`,`revision_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;






CREATE TABLE `metatag_config` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a metatag configuration set.',
  `instance` varchar(255) NOT NULL DEFAULT '' COMMENT 'The machine-name of the configuration, typically entity-type:bundle.',
  `config` longblob NOT NULL COMMENT 'Serialized data containing the meta tag configuration.',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Storage of meta tag configuration and defaults.';






CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned DEFAULT NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';






CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';


INSERT INTO node_access VALUES
("0","0","all","1","0","0");




CREATE TABLE `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.',
  PRIMARY KEY (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`),
  KEY `comment_count` (`comment_count`),
  KEY `last_comment_uid` (`last_comment_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';






CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';






CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';


INSERT INTO node_type VALUES
("article","Article","node_content","node","Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.","","1","Title","1","1","0","0","article"),
("page","Basic page","node_content","node","Use <em>basic pages</em> for your static content, such as an \'About us\' page.","","1","Title","1","1","0","0","page"),
("webform","Webform","node_content","node","Create a new form or questionnaire accessible to users. Submission results and statistics are recorded and accessible to privileged users.","","1","Title","1","1","0","0","webform");




CREATE TABLE `page_title` (
  `type` varchar(15) NOT NULL DEFAULT 'node',
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `page_title` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;






CREATE TABLE `pathauto_state` (
  `entity_type` varchar(32) NOT NULL COMMENT 'An entity type.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'An entity ID.',
  `pathauto` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The automatic alias status of the entity.',
  PRIMARY KEY (`entity_type`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The status of each entity alias (whether it was...';






CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';






CREATE TABLE `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';


INSERT INTO rdf_mapping VALUES
("node","article","a:11:{s:11:\"field_image\";a:2:{s:10:\"predicates\";a:2:{i:0;s:8:\"og:image\";i:1;s:12:\"rdfs:seeAlso\";}s:4:\"type\";s:3:\"rel\";}s:10:\"field_tags\";a:2:{s:10:\"predicates\";a:1:{i:0;s:10:\"dc:subject\";}s:4:\"type\";s:3:\"rel\";}s:7:\"rdftype\";a:2:{i:0;s:9:\"sioc:Item\";i:1;s:13:\"foaf:Document\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}"),
("node","page","a:9:{s:7:\"rdftype\";a:1:{i:0;s:13:\"foaf:Document\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}");




CREATE TABLE `redirect` (
  `rid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique redirect ID.',
  `hash` varchar(64) NOT NULL COMMENT 'A unique hash based on source, source_options, and language.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The redirect type; if value is ’redirect’ it is a normal redirect handled by the module.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who created the redirect.',
  `source` varchar(255) NOT NULL COMMENT 'The source path to redirect from.',
  `source_options` text NOT NULL COMMENT 'A serialized array of source options.',
  `redirect` varchar(255) NOT NULL COMMENT 'The destination path to redirect to.',
  `redirect_options` text NOT NULL COMMENT 'A serialized array of redirect options.',
  `language` varchar(12) NOT NULL DEFAULT 'und' COMMENT 'The language this redirect is for; if blank, the alias will be used for unknown languages.',
  `status_code` smallint(6) NOT NULL COMMENT 'The HTTP status code to use for the redirect.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times the redirect has been used.',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The timestamp of when the redirect was last accessed.',
  `status` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the redirect is enabled (visible to non-administrators).',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `hash` (`hash`),
  KEY `expires` (`type`,`access`),
  KEY `status_source_language` (`status`,`source`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information on redirects.';






CREATE TABLE `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';


INSERT INTO registry VALUES
("AccessDeniedTestCase","class","modules/system/system.test","system","0"),
("AdminMetaTagTestCase","class","modules/system/system.test","system","0"),
("ArchiverInterface","interface","includes/archiver.inc","","0"),
("ArchiverTar","class","modules/system/system.archiver.inc","system","0"),
("ArchiverZip","class","modules/system/system.archiver.inc","system","0"),
("Archive_Tar","class","modules/system/system.tar.inc","system","0"),
("BatchMemoryQueue","class","includes/batch.queue.inc","","0"),
("BatchQueue","class","includes/batch.queue.inc","","0"),
("BlockAdminThemeTestCase","class","modules/block/block.test","block","0"),
("BlockCacheTestCase","class","modules/block/block.test","block","0"),
("BlockHashTestCase","class","modules/block/block.test","block","0"),
("BlockHiddenRegionTestCase","class","modules/block/block.test","block","0"),
("BlockHTMLIdTestCase","class","modules/block/block.test","block","0"),
("BlockInvalidRegionTestCase","class","modules/block/block.test","block","0"),
("BlockTemplateSuggestionsUnitTest","class","modules/block/block.test","block","0"),
("BlockTestCase","class","modules/block/block.test","block","0"),
("BlockViewModuleDeltaAlterWebTest","class","modules/block/block.test","block","0"),
("ColorTestCase","class","modules/color/color.test","color","0"),
("CommentActionsTestCase","class","modules/comment/comment.test","comment","0"),
("CommentAnonymous","class","modules/comment/comment.test","comment","0"),
("CommentApprovalTest","class","modules/comment/comment.test","comment","0"),
("CommentBlockFunctionalTest","class","modules/comment/comment.test","comment","0"),
("CommentContentRebuild","class","modules/comment/comment.test","comment","0"),
("CommentController","class","modules/comment/comment.module","comment","0"),
("CommentFieldsTest","class","modules/comment/comment.test","comment","0"),
("CommentHelperCase","class","modules/comment/comment.test","comment","0"),
("CommentInterfaceTest","class","modules/comment/comment.test","comment","0"),
("CommentNodeAccessTest","class","modules/comment/comment.test","comment","0"),
("CommentNodeChangesTestCase","class","modules/comment/comment.test","comment","0"),
("CommentPagerTest","class","modules/comment/comment.test","comment","0"),
("CommentPreviewTest","class","modules/comment/comment.test","comment","0"),
("CommentRSSUnitTest","class","modules/comment/comment.test","comment","0"),
("CommentThreadingTestCase","class","modules/comment/comment.test","comment","0"),
("CommentTokenReplaceTestCase","class","modules/comment/comment.test","comment","0"),
("ConfirmFormTest","class","modules/system/system.test","system","0"),
("ContextualDynamicContextTestCase","class","modules/contextual/contextual.test","contextual","0"),
("CronQueueTestCase","class","modules/system/system.test","system","0"),
("CronRunTestCase","class","modules/system/system.test","system","0"),
("CToolsCssCache","class","sites/all/modules/ctools/includes/css-cache.inc","ctools","0"),
("CtoolsObjectCache","class","sites/all/modules/ctools/tests/css_cache.test","ctools","0"),
("ctools_context","class","sites/all/modules/ctools/includes/context.inc","ctools","0"),
("ctools_context_optional","class","sites/all/modules/ctools/includes/context.inc","ctools","0"),
("ctools_context_required","class","sites/all/modules/ctools/includes/context.inc","ctools","0"),
("ctools_export_ui","class","sites/all/modules/ctools/plugins/export_ui/ctools_export_ui.class.php","ctools","0"),
("ctools_math_expr","class","sites/all/modules/ctools/includes/math-expr.inc","ctools","0"),
("ctools_math_expr_stack","class","sites/all/modules/ctools/includes/math-expr.inc","ctools","0"),
("ctools_stylizer_image_processor","class","sites/all/modules/ctools/includes/stylizer.inc","ctools","0"),
("DashboardBlocksTestCase","class","modules/dashboard/dashboard.test","dashboard","0"),
("Database","class","includes/database/database.inc","","0"),
("DatabaseCondition","class","includes/database/query.inc","","0"),
("DatabaseConnection","class","includes/database/database.inc","","0"),
("DatabaseConnectionNotDefinedException","class","includes/database/database.inc","","0"),
("DatabaseConnection_mysql","class","includes/database/mysql/database.inc","","0"),
("DatabaseConnection_pgsql","class","includes/database/pgsql/database.inc","","0"),
("DatabaseConnection_sqlite","class","includes/database/sqlite/database.inc","","0"),
("DatabaseDriverNotSpecifiedException","class","includes/database/database.inc","","0"),
("DatabaseLog","class","includes/database/log.inc","","0"),
("DatabaseSchema","class","includes/database/schema.inc","","0"),
("DatabaseSchemaObjectDoesNotExistException","class","includes/database/schema.inc","","0"),
("DatabaseSchemaObjectExistsException","class","includes/database/schema.inc","","0"),
("DatabaseSchema_mysql","class","includes/database/mysql/schema.inc","","0"),
("DatabaseSchema_pgsql","class","includes/database/pgsql/schema.inc","","0"),
("DatabaseSchema_sqlite","class","includes/database/sqlite/schema.inc","","0"),
("DatabaseStatementBase","class","includes/database/database.inc","","0"),
("DatabaseStatementEmpty","class","includes/database/database.inc","","0"),
("DatabaseStatementInterface","interface","includes/database/database.inc","","0"),
("DatabaseStatementPrefetch","class","includes/database/prefetch.inc","","0"),
("DatabaseStatement_sqlite","class","includes/database/sqlite/database.inc","","0"),
("DatabaseTaskException","class","includes/install.inc","","0"),
("DatabaseTasks","class","includes/install.inc","","0"),
("DatabaseTasks_mysql","class","includes/database/mysql/install.inc","","0"),
("DatabaseTasks_pgsql","class","includes/database/pgsql/install.inc","","0"),
("DatabaseTasks_sqlite","class","includes/database/sqlite/install.inc","","0"),
("DatabaseTransaction","class","includes/database/database.inc","","0"),
("DatabaseTransactionCommitFailedException","class","includes/database/database.inc","","0"),
("DatabaseTransactionExplicitCommitNotAllowedException","class","includes/database/database.inc","","0"),
("DatabaseTransactionNameNonUniqueException","class","includes/database/database.inc","","0"),
("DatabaseTransactionNoActiveException","class","includes/database/database.inc","","0"),
("DatabaseTransactionOutOfOrderException","class","includes/database/database.inc","","0"),
("DateTimeFunctionalTest","class","modules/system/system.test","system","0"),
("DBLogTestCase","class","modules/dblog/dblog.test","dblog","0"),
("DefaultMailSystem","class","modules/system/system.mail.inc","system","0"),
("DeleteQuery","class","includes/database/query.inc","","0"),
("DeleteQuery_sqlite","class","includes/database/sqlite/query.inc","","0"),
("DrupalCacheArray","class","includes/bootstrap.inc","","0"),
("DrupalCacheInterface","interface","includes/cache.inc","","0"),
("DrupalDatabaseCache","class","includes/cache.inc","","0"),
("DrupalDateIntervalMetaTag","class","sites/all/modules/metatag/metatag.inc","metatag","0"),
("DrupalDefaultEntityController","class","includes/entity.inc","","0"),
("DrupalDefaultMetaTag","class","sites/all/modules/metatag/metatag.inc","metatag","0"),
("DrupalEntityControllerInterface","interface","includes/entity.inc","","0"),
("DrupalFakeCache","class","includes/cache-install.inc","","0"),
("DrupalLinkMetaTag","class","sites/all/modules/metatag/metatag.inc","metatag","0"),
("DrupalListMetaTag","class","sites/all/modules/metatag/metatag.inc","metatag","0"),
("DrupalLocalStreamWrapper","class","includes/stream_wrappers.inc","","0"),
("DrupalMetaTagInterface","interface","sites/all/modules/metatag/metatag.inc","metatag","0"),
("DrupalPrivateStreamWrapper","class","includes/stream_wrappers.inc","","0"),
("DrupalPublicStreamWrapper","class","includes/stream_wrappers.inc","","0"),
("DrupalQueue","class","modules/system/system.queue.inc","system","0"),
("DrupalQueueInterface","interface","modules/system/system.queue.inc","system","0");
INSERT INTO registry VALUES
("DrupalReliableQueueInterface","interface","modules/system/system.queue.inc","system","0"),
("DrupalSetMessageTest","class","modules/system/system.test","system","0"),
("DrupalStreamWrapperInterface","interface","includes/stream_wrappers.inc","","0"),
("DrupalTemporaryStreamWrapper","class","includes/stream_wrappers.inc","","0"),
("DrupalTextMetaTag","class","sites/all/modules/metatag/metatag.inc","metatag","0"),
("DrupalTitleMetaTag","class","sites/all/modules/metatag/metatag.inc","metatag","0"),
("DrupalUpdateException","class","includes/update.inc","","0"),
("DrupalUpdaterInterface","interface","includes/updater.inc","","0"),
("EnableDisableTestCase","class","modules/system/system.test","system","0"),
("EntityFieldQuery","class","includes/entity.inc","","0"),
("EntityFieldQueryException","class","includes/entity.inc","","0"),
("EntityMalformedException","class","includes/entity.inc","","0"),
("EntityPropertiesTestCase","class","modules/field/tests/field.test","field","0"),
("FieldAttachOtherTestCase","class","modules/field/tests/field.test","field","0"),
("FieldAttachStorageTestCase","class","modules/field/tests/field.test","field","0"),
("FieldAttachTestCase","class","modules/field/tests/field.test","field","0"),
("FieldBulkDeleteTestCase","class","modules/field/tests/field.test","field","0"),
("FieldCrudTestCase","class","modules/field/tests/field.test","field","0"),
("FieldDisplayAPITestCase","class","modules/field/tests/field.test","field","0"),
("FieldException","class","modules/field/field.module","field","0"),
("FieldFormTestCase","class","modules/field/tests/field.test","field","0"),
("FieldInfo","class","modules/field/field.info.class.inc","field","0"),
("FieldInfoTestCase","class","modules/field/tests/field.test","field","0"),
("FieldInstanceCrudTestCase","class","modules/field/tests/field.test","field","0"),
("FieldsOverlapException","class","includes/database/database.inc","","0"),
("FieldSqlStorageTestCase","class","modules/field/modules/field_sql_storage/field_sql_storage.test","field_sql_storage","0"),
("FieldTestCase","class","modules/field/tests/field.test","field","0"),
("FieldTranslationsTestCase","class","modules/field/tests/field.test","field","0"),
("FieldUIAlterTestCase","class","modules/field_ui/field_ui.test","field_ui","0"),
("FieldUIManageDisplayTestCase","class","modules/field_ui/field_ui.test","field_ui","0"),
("FieldUIManageFieldsTestCase","class","modules/field_ui/field_ui.test","field_ui","0"),
("FieldUITestCase","class","modules/field_ui/field_ui.test","field_ui","0"),
("FieldUpdateForbiddenException","class","modules/field/field.module","field","0"),
("FieldValidationException","class","modules/field/field.attach.inc","field","0"),
("FileFieldDisplayTestCase","class","modules/file/tests/file.test","file","0"),
("FileFieldPathTestCase","class","modules/file/tests/file.test","file","0"),
("FileFieldRevisionTestCase","class","modules/file/tests/file.test","file","0"),
("FileFieldTestCase","class","modules/file/tests/file.test","file","0"),
("FileFieldValidateTestCase","class","modules/file/tests/file.test","file","0"),
("FileFieldWidgetTestCase","class","modules/file/tests/file.test","file","0"),
("FileManagedFileElementTestCase","class","modules/file/tests/file.test","file","0"),
("FilePrivateTestCase","class","modules/file/tests/file.test","file","0"),
("FileTaxonomyTermTestCase","class","modules/file/tests/file.test","file","0"),
("FileTokenReplaceTestCase","class","modules/file/tests/file.test","file","0"),
("FileTransfer","class","includes/filetransfer/filetransfer.inc","","0"),
("FileTransferChmodInterface","interface","includes/filetransfer/filetransfer.inc","","0"),
("FileTransferException","class","includes/filetransfer/filetransfer.inc","","0"),
("FileTransferFTP","class","includes/filetransfer/ftp.inc","","0"),
("FileTransferFTPExtension","class","includes/filetransfer/ftp.inc","","0"),
("FileTransferLocal","class","includes/filetransfer/local.inc","","0"),
("FileTransferSSH","class","includes/filetransfer/ssh.inc","","0"),
("FilterAdminTestCase","class","modules/filter/filter.test","filter","0"),
("FilterCRUDTestCase","class","modules/filter/filter.test","filter","0"),
("FilterDefaultFormatTestCase","class","modules/filter/filter.test","filter","0"),
("FilterDOMSerializeTestCase","class","modules/filter/filter.test","filter","0"),
("FilterFormatAccessTestCase","class","modules/filter/filter.test","filter","0"),
("FilterHooksTestCase","class","modules/filter/filter.test","filter","0"),
("FilterNoFormatTestCase","class","modules/filter/filter.test","filter","0"),
("FilterSecurityTestCase","class","modules/filter/filter.test","filter","0"),
("FilterSettingsTestCase","class","modules/filter/filter.test","filter","0"),
("FilterUnitTestCase","class","modules/filter/filter.test","filter","0"),
("FloodFunctionalTest","class","modules/system/system.test","system","0"),
("FrontPageTestCase","class","modules/system/system.test","system","0"),
("GlobalRedirectTestCase","class","sites/all/modules/globalredirect/globalredirect.test","globalredirect","0"),
("GlobalRedirectTestCaseConfigAlpha","class","sites/all/modules/globalredirect/globalredirect.test","globalredirect","0"),
("GlobalRedirectTestCaseConfigBeta","class","sites/all/modules/globalredirect/globalredirect.test","globalredirect","0"),
("GlobalRedirectTestCaseConfigLanguages","class","sites/all/modules/globalredirect/globalredirect.test","globalredirect","0"),
("GlobalRedirectTestCaseDefault","class","sites/all/modules/globalredirect/globalredirect.test","globalredirect","0"),
("HelpTestCase","class","modules/help/help.test","help","0"),
("HookRequirementsTestCase","class","modules/system/system.test","system","0"),
("ImageAdminStylesUnitTest","class","modules/image/image.test","image","0"),
("ImageAdminUiTestCase","class","modules/image/image.test","image","0"),
("ImageDimensionsScaleTestCase","class","modules/image/image.test","image","0"),
("ImageDimensionsTestCase","class","modules/image/image.test","image","0"),
("ImageEffectsUnitTest","class","modules/image/image.test","image","0"),
("ImageFieldDefaultImagesTestCase","class","modules/image/image.test","image","0"),
("ImageFieldDisplayTestCase","class","modules/image/image.test","image","0"),
("ImageFieldTestCase","class","modules/image/image.test","image","0"),
("ImageFieldValidateTestCase","class","modules/image/image.test","image","0"),
("ImageStyleFlushTest","class","modules/image/image.test","image","0"),
("ImageStylesPathAndUrlTestCase","class","modules/image/image.test","image","0"),
("ImageThemeFunctionWebTestCase","class","modules/image/image.test","image","0"),
("InfoFileParserTestCase","class","modules/system/system.test","system","0"),
("InsertQuery","class","includes/database/query.inc","","0"),
("InsertQuery_mysql","class","includes/database/mysql/query.inc","","0"),
("InsertQuery_pgsql","class","includes/database/pgsql/query.inc","","0"),
("InsertQuery_sqlite","class","includes/database/sqlite/query.inc","","0"),
("InvalidMergeQueryException","class","includes/database/database.inc","","0"),
("IPAddressBlockingTestCase","class","modules/system/system.test","system","0"),
("ListDynamicValuesTestCase","class","modules/field/modules/list/tests/list.test","list","0"),
("ListDynamicValuesValidationTestCase","class","modules/field/modules/list/tests/list.test","list","0"),
("ListFieldTestCase","class","modules/field/modules/list/tests/list.test","list","0"),
("ListFieldUITestCase","class","modules/field/modules/list/tests/list.test","list","0"),
("MailSystemInterface","interface","includes/mail.inc","","0"),
("MemCacheClearCase","class","sites/all/modules/memcache/tests/memcache.test","memcache","0"),
("MemCacheDrupal","class","sites/all/modules/memcache/memcache.inc","memcache","0"),
("MemCacheGetMultipleUnitTest","class","sites/all/modules/memcache/tests/memcache.test","memcache","0"),
("MemcacheLockFunctionalTest","class","sites/all/modules/memcache/tests/memcache-lock.test","memcache","0"),
("MemCacheRealWorldCase","class","sites/all/modules/memcache/tests/memcache.test","memcache","0"),
("MemCacheSavingCase","class","sites/all/modules/memcache/tests/memcache.test","memcache","0");
INSERT INTO registry VALUES
("MemcacheSessionTestCase","class","sites/all/modules/memcache/tests/memcache-session.test","memcache","0"),
("MemCacheStampedeProtection","class","sites/all/modules/memcache/tests/memcache.test","memcache","0"),
("MemCacheStatisticsTestCase","class","sites/all/modules/memcache/tests/memcache.test","memcache","0"),
("MemcacheTestCase","class","sites/all/modules/memcache/tests/memcache.test","memcache","0"),
("MemoryQueue","class","modules/system/system.queue.inc","system","0"),
("MenuNodeTestCase","class","modules/menu/menu.test","menu","0"),
("MenuTestCase","class","modules/menu/menu.test","menu","0"),
("MergeQuery","class","includes/database/query.inc","","0"),
("MetatagCoreImageTest","class","sites/all/modules/metatag/tests/metatag.image.test","metatag","0"),
("MetatagCoreLocaleTest","class","sites/all/modules/metatag/tests/metatag.locale.test","metatag","0"),
("MetatagCoreNodeTest","class","sites/all/modules/metatag/tests/metatag.node.test","metatag","0"),
("MetatagCoreStringHandlingTest","class","sites/all/modules/metatag/tests/metatag.string_handling.test","metatag","0"),
("MetatagCoreStringHandlingWithI18nTest","class","sites/all/modules/metatag/tests/metatag.string_handling_with_i18n.test","metatag","0"),
("MetatagCoreTagRemovalTest","class","sites/all/modules/metatag/tests/metatag.core_tag_removal.test","metatag","0"),
("MetatagCoreTermTest","class","sites/all/modules/metatag/tests/metatag.term.test","metatag","0"),
("MetatagCoreUnitTest","class","sites/all/modules/metatag/tests/metatag.unit.test","metatag","0"),
("MetatagCoreUserTest","class","sites/all/modules/metatag/tests/metatag.user.test","metatag","0"),
("MetatagCoreWithI18nConfigTest","class","sites/all/modules/metatag/tests/metatag.with_i18n_config.test","metatag","0"),
("MetatagCoreWithI18nDisabledTest","class","sites/all/modules/metatag/tests/metatag.with_i18n_disabled.test","metatag","0"),
("MetatagCoreWithI18nNodeTest","class","sites/all/modules/metatag/tests/metatag.with_i18n_node.test","metatag","0"),
("MetatagCoreWithI18nOutputTest","class","sites/all/modules/metatag/tests/metatag.with_i18n_output.test","metatag","0"),
("MetatagCoreWithMediaTest","class","sites/all/modules/metatag/tests/metatag.with_media.test","metatag","0"),
("MetatagCoreWithPanelsTest","class","sites/all/modules/metatag/tests/metatag.with_panels.test","metatag","0"),
("MetatagCoreWithProfile2Test","class","sites/all/modules/metatag/tests/metatag.with_profile2.test","metatag","0"),
("MetatagCoreWithSearchAPITest","class","sites/all/modules/metatag/tests/metatag.with_search_api.test","metatag","0"),
("MetatagCoreWithViewsTest","class","sites/all/modules/metatag/tests/metatag.with_views.test","metatag","0"),
("MetatagSearchAlterCallback","class","sites/all/modules/metatag/metatag.search_api.inc","metatag","0"),
("MetatagTestHelper","class","sites/all/modules/metatag/tests/metatag.helper.test","metatag","0"),
("MigrateMetatagHandler","class","sites/all/modules/metatag/metatag.migrate.inc","metatag","0"),
("MockMemCacheDrupal","class","sites/all/modules/memcache/tests/memcache.test","memcache","0"),
("ModuleDependencyTestCase","class","modules/system/system.test","system","0"),
("ModuleRequiredTestCase","class","modules/system/system.test","system","0"),
("ModuleTestCase","class","modules/system/system.test","system","0"),
("ModuleUpdater","class","modules/system/system.updater.inc","system","0"),
("ModuleVersionTestCase","class","modules/system/system.test","system","0"),
("MultiStepNodeFormBasicOptionsTest","class","modules/node/node.test","node","0"),
("NewDefaultThemeBlocks","class","modules/block/block.test","block","0"),
("NodeAccessBaseTableTestCase","class","modules/node/node.test","node","0"),
("NodeAccessFieldTestCase","class","modules/node/node.test","node","0"),
("NodeAccessPagerTestCase","class","modules/node/node.test","node","0"),
("NodeAccessRebuildTestCase","class","modules/node/node.test","node","0"),
("NodeAccessRecordsTestCase","class","modules/node/node.test","node","0"),
("NodeAccessTestCase","class","modules/node/node.test","node","0"),
("NodeAdminTestCase","class","modules/node/node.test","node","0"),
("NodeBlockFunctionalTest","class","modules/node/node.test","node","0"),
("NodeBlockTestCase","class","modules/node/node.test","node","0"),
("NodeBuildContent","class","modules/node/node.test","node","0"),
("NodeController","class","modules/node/node.module","node","0"),
("NodeCreationTestCase","class","modules/node/node.test","node","0"),
("NodeEntityFieldQueryAlter","class","modules/node/node.test","node","0"),
("NodeEntityViewModeAlterTest","class","modules/node/node.test","node","0"),
("NodeFeedTestCase","class","modules/node/node.test","node","0"),
("NodeLoadHooksTestCase","class","modules/node/node.test","node","0"),
("NodeLoadMultipleTestCase","class","modules/node/node.test","node","0"),
("NodePageCacheTest","class","modules/node/node.test","node","0"),
("NodePostSettingsTestCase","class","modules/node/node.test","node","0"),
("NodeQueryAlter","class","modules/node/node.test","node","0"),
("NodeRevisionPermissionsTestCase","class","modules/node/node.test","node","0"),
("NodeRevisionsTestCase","class","modules/node/node.test","node","0"),
("NodeRSSContentTestCase","class","modules/node/node.test","node","0"),
("NodeSaveTestCase","class","modules/node/node.test","node","0"),
("NodeTitleTestCase","class","modules/node/node.test","node","0"),
("NodeTitleXSSTestCase","class","modules/node/node.test","node","0"),
("NodeTokenReplaceTestCase","class","modules/node/node.test","node","0"),
("NodeTypePersistenceTestCase","class","modules/node/node.test","node","0"),
("NodeTypeTestCase","class","modules/node/node.test","node","0"),
("NodeWebTestCase","class","modules/node/node.test","node","0"),
("NoFieldsException","class","includes/database/database.inc","","0"),
("NoHelpTestCase","class","modules/help/help.test","help","0"),
("NonDefaultBlockAdmin","class","modules/block/block.test","block","0"),
("NumberFieldTestCase","class","modules/field/modules/number/number.test","number","0"),
("OptionsSelectDynamicValuesTestCase","class","modules/field/modules/options/options.test","options","0"),
("OptionsWidgetsTestCase","class","modules/field/modules/options/options.test","options","0"),
("PageEditTestCase","class","modules/node/node.test","node","0"),
("PageNotFoundTestCase","class","modules/system/system.test","system","0"),
("PagePreviewTestCase","class","modules/node/node.test","node","0"),
("PagerDefault","class","includes/pager.inc","","0"),
("PageTitleFiltering","class","modules/system/system.test","system","0"),
("PageTitleTestCase","class","sites/all/modules/page_title/page_title.test","page_title","0"),
("PageViewTestCase","class","modules/node/node.test","node","0"),
("page_title_plugin_display_page_with_page_title","class","sites/all/modules/page_title/views/plugins/page_title_plugin_display_page_with_page_title.inc","page_title","0"),
("PathautoBulkUpdateTestCase","class","sites/all/modules/pathauto/pathauto.test","pathauto","0"),
("PathautoFunctionalTestCase","class","sites/all/modules/pathauto/pathauto.test","pathauto","0"),
("PathautoFunctionalTestHelper","class","sites/all/modules/pathauto/pathauto.test","pathauto","0"),
("PathautoLocaleTestCase","class","sites/all/modules/pathauto/pathauto.test","pathauto","0"),
("PathautoMigrationHandler","class","sites/all/modules/pathauto/pathauto.migrate.inc","pathauto","0"),
("PathautoTestHelper","class","sites/all/modules/pathauto/pathauto.test","pathauto","0"),
("PathautoTokenTestCase","class","sites/all/modules/pathauto/pathauto.test","pathauto","0"),
("PathautoUnitTestCase","class","sites/all/modules/pathauto/pathauto.test","pathauto","0"),
("PathLanguageTestCase","class","modules/path/path.test","path","0"),
("PathLanguageUITestCase","class","modules/path/path.test","path","0"),
("PathMonolingualTestCase","class","modules/path/path.test","path","0"),
("PathTaxonomyTermTestCase","class","modules/path/path.test","path","0"),
("PathTestCase","class","modules/path/path.test","path","0"),
("Query","class","includes/database/query.inc","","0"),
("QueryAlterableInterface","interface","includes/database/query.inc","","0"),
("QueryConditionInterface","interface","includes/database/query.inc","","0"),
("QueryExtendableInterface","interface","includes/database/select.inc","","0"),
("QueryPlaceholderInterface","interface","includes/database/query.inc","","0"),
("QueueTestCase","class","modules/system/system.test","system","0");
INSERT INTO registry VALUES
("RdfCommentAttributesTestCase","class","modules/rdf/rdf.test","rdf","0"),
("RdfCrudTestCase","class","modules/rdf/rdf.test","rdf","0"),
("RdfGetRdfNamespacesTestCase","class","modules/rdf/rdf.test","rdf","0"),
("RdfMappingDefinitionTestCase","class","modules/rdf/rdf.test","rdf","0"),
("RdfMappingHookTestCase","class","modules/rdf/rdf.test","rdf","0"),
("RdfRdfaMarkupTestCase","class","modules/rdf/rdf.test","rdf","0"),
("RdfTrackerAttributesTestCase","class","modules/rdf/rdf.test","rdf","0"),
("RedirectController","class","sites/all/modules/redirect/redirect.controller.inc","redirect","0"),
("RedirectFunctionalTest","class","sites/all/modules/redirect/redirect.test","redirect","0"),
("RedirectTestHelper","class","sites/all/modules/redirect/redirect.test","redirect","0"),
("RedirectUnitTest","class","sites/all/modules/redirect/redirect.test","redirect","0"),
("redirect_handler_field_redirect_link_delete","class","sites/all/modules/redirect/views/redirect_handler_field_redirect_link_delete.inc","redirect","0"),
("redirect_handler_field_redirect_link_edit","class","sites/all/modules/redirect/views/redirect_handler_field_redirect_link_edit.inc","redirect","0"),
("redirect_handler_field_redirect_operations","class","sites/all/modules/redirect/views/redirect_handler_field_redirect_operations.inc","redirect","0"),
("redirect_handler_field_redirect_redirect","class","sites/all/modules/redirect/views/redirect_handler_field_redirect_redirect.inc","redirect","0"),
("redirect_handler_field_redirect_source","class","sites/all/modules/redirect/views/redirect_handler_field_redirect_source.inc","redirect","0"),
("redirect_handler_filter_redirect_type","class","sites/all/modules/redirect/views/redirect_handler_filter_redirect_type.inc","redirect","0"),
("RetrieveFileTestCase","class","modules/system/system.test","system","0"),
("SchemaCache","class","includes/bootstrap.inc","","0"),
("SearchAdvancedSearchForm","class","modules/search/search.test","search","0"),
("SearchBlockTestCase","class","modules/search/search.test","search","0"),
("SearchCommentCountToggleTestCase","class","modules/search/search.test","search","0"),
("SearchCommentTestCase","class","modules/search/search.test","search","0"),
("SearchConfigSettingsForm","class","modules/search/search.test","search","0"),
("SearchEmbedForm","class","modules/search/search.test","search","0"),
("SearchExactTestCase","class","modules/search/search.test","search","0"),
("SearchExcerptTestCase","class","modules/search/search.test","search","0"),
("SearchExpressionInsertExtractTestCase","class","modules/search/search.test","search","0"),
("SearchKeywordsConditions","class","modules/search/search.test","search","0"),
("SearchLanguageTestCase","class","modules/search/search.test","search","0"),
("SearchMatchTestCase","class","modules/search/search.test","search","0"),
("SearchNodeAccessTest","class","modules/search/search.test","search","0"),
("SearchNodeTagTest","class","modules/search/search.test","search","0"),
("SearchNumberMatchingTestCase","class","modules/search/search.test","search","0"),
("SearchNumbersTestCase","class","modules/search/search.test","search","0"),
("SearchPageOverride","class","modules/search/search.test","search","0"),
("SearchPageText","class","modules/search/search.test","search","0"),
("SearchQuery","class","modules/search/search.extender.inc","search","0"),
("SearchRankingTestCase","class","modules/search/search.test","search","0"),
("SearchSetLocaleTest","class","modules/search/search.test","search","0"),
("SearchSimplifyTestCase","class","modules/search/search.test","search","0"),
("SearchTokenizerTestCase","class","modules/search/search.test","search","0"),
("SecurePagesTestCase","class","sites/all/modules/securepages/securepages.test","securepages","0"),
("SelectQuery","class","includes/database/select.inc","","0"),
("SelectQueryExtender","class","includes/database/select.inc","","0"),
("SelectQueryInterface","interface","includes/database/select.inc","","0"),
("SelectQuery_pgsql","class","includes/database/pgsql/select.inc","","0"),
("SelectQuery_sqlite","class","includes/database/sqlite/select.inc","","0"),
("SendgridIntegrationTestCase","class","sites/all/modules/sendgrid_integration/tests/sendgrid_integration.test","sendgrid_integration","0"),
("SendgridIntegrationTestCaseMail","class","sites/all/modules/sendgrid_integration/tests/sendgrid_integration.mail_test.test","sendgrid_integration","0"),
("SendGridMailSystem","class","sites/all/modules/sendgrid_integration/inc/sendgrid.mail.inc","sendgrid_integration","0"),
("ShortcutLinksTestCase","class","modules/shortcut/shortcut.test","shortcut","0"),
("ShortcutSetsTestCase","class","modules/shortcut/shortcut.test","shortcut","0"),
("ShortcutTestCase","class","modules/shortcut/shortcut.test","shortcut","0"),
("ShutdownFunctionsTest","class","modules/system/system.test","system","0"),
("SiteMaintenanceTestCase","class","modules/system/system.test","system","0"),
("SkipDotsRecursiveDirectoryIterator","class","includes/filetransfer/filetransfer.inc","","0"),
("StreamWrapperInterface","interface","includes/stream_wrappers.inc","","0"),
("SummaryLengthTestCase","class","modules/node/node.test","node","0"),
("SystemAdminTestCase","class","modules/system/system.test","system","0"),
("SystemAuthorizeCase","class","modules/system/system.test","system","0"),
("SystemBlockTestCase","class","modules/system/system.test","system","0"),
("SystemIndexPhpTest","class","modules/system/system.test","system","0"),
("SystemInfoAlterTestCase","class","modules/system/system.test","system","0"),
("SystemMainContentFallback","class","modules/system/system.test","system","0"),
("SystemQueue","class","modules/system/system.queue.inc","system","0"),
("SystemThemeFunctionalTest","class","modules/system/system.test","system","0"),
("SystemValidTokenTest","class","modules/system/system.test","system","0"),
("TableSort","class","includes/tablesort.inc","","0"),
("TaxonomyEFQTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyHooksTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyLegacyTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyLoadMultipleTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyRSSTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyTermController","class","modules/taxonomy/taxonomy.module","taxonomy","0"),
("TaxonomyTermFieldMultipleVocabularyTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyTermFieldTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyTermFunctionTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyTermIndexTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyTermTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyThemeTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyTokenReplaceTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyVocabularyController","class","modules/taxonomy/taxonomy.module","taxonomy","0"),
("TaxonomyVocabularyFunctionalTest","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyVocabularyTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TaxonomyWebTestCase","class","modules/taxonomy/taxonomy.test","taxonomy","0"),
("TestingMailSystem","class","modules/system/system.mail.inc","system","0"),
("TextFieldTestCase","class","modules/field/modules/text/text.test","text","0"),
("TextSummaryTestCase","class","modules/field/modules/text/text.test","text","0"),
("TextTranslationTestCase","class","modules/field/modules/text/text.test","text","0"),
("ThemeRegistry","class","includes/theme.inc","","0"),
("ThemeUpdater","class","modules/system/system.updater.inc","system","0"),
("TokenArrayTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenBlockTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenCommentTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenCurrentPageTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenDateTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenEntityTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenFileTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenMenuTestCase","class","sites/all/modules/token/token.test","token","0");
INSERT INTO registry VALUES
("TokenNodeTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenProfileTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenRandomTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenReplaceTestCase","class","modules/system/system.test","system","0"),
("TokenScanTest","class","modules/system/system.test","system","0"),
("TokenTaxonomyTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenTestHelper","class","sites/all/modules/token/token.test","token","0"),
("TokenUnitTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenURLTestCase","class","sites/all/modules/token/token.test","token","0"),
("TokenUserTestCase","class","sites/all/modules/token/token.test","token","0"),
("TruncateQuery","class","includes/database/query.inc","","0"),
("TruncateQuery_mysql","class","includes/database/mysql/query.inc","","0"),
("TruncateQuery_sqlite","class","includes/database/sqlite/query.inc","","0"),
("UpdateCoreTestCase","class","modules/update/update.test","update","0"),
("UpdateCoreUnitTestCase","class","modules/update/update.test","update","0"),
("UpdateQuery","class","includes/database/query.inc","","0"),
("UpdateQuery_pgsql","class","includes/database/pgsql/query.inc","","0"),
("UpdateQuery_sqlite","class","includes/database/sqlite/query.inc","","0"),
("Updater","class","includes/updater.inc","","0"),
("UpdaterException","class","includes/updater.inc","","0"),
("UpdaterFileTransferException","class","includes/updater.inc","","0"),
("UpdateScriptFunctionalTest","class","modules/system/system.test","system","0"),
("UpdateTestContribCase","class","modules/update/update.test","update","0"),
("UpdateTestHelper","class","modules/update/update.test","update","0"),
("UpdateTestUploadCase","class","modules/update/update.test","update","0"),
("UserAccountLinksUnitTests","class","modules/user/user.test","user","0"),
("UserAdminTestCase","class","modules/user/user.test","user","0"),
("UserAuthmapAssignmentTestCase","class","modules/user/user.test","user","0"),
("UserAutocompleteTestCase","class","modules/user/user.test","user","0"),
("UserBlocksUnitTests","class","modules/user/user.test","user","0"),
("UserCancelTestCase","class","modules/user/user.test","user","0"),
("UserController","class","modules/user/user.module","user","0"),
("UserCreateTestCase","class","modules/user/user.test","user","0"),
("UserEditedOwnAccountTestCase","class","modules/user/user.test","user","0"),
("UserEditTestCase","class","modules/user/user.test","user","0"),
("UserLoginTestCase","class","modules/user/user.test","user","0"),
("UserPasswordResetTestCase","class","modules/user/user.test","user","0"),
("UserPermissionsTestCase","class","modules/user/user.test","user","0"),
("UserPictureTestCase","class","modules/user/user.test","user","0"),
("UserRegistrationTestCase","class","modules/user/user.test","user","0"),
("UserRoleAdminTestCase","class","modules/user/user.test","user","0"),
("UserRolesAssignmentTestCase","class","modules/user/user.test","user","0"),
("UserSaveTestCase","class","modules/user/user.test","user","0"),
("UserSignatureTestCase","class","modules/user/user.test","user","0"),
("UserTimeZoneFunctionalTest","class","modules/user/user.test","user","0"),
("UserTokenReplaceTestCase","class","modules/user/user.test","user","0"),
("UserUserSearchTestCase","class","modules/user/user.test","user","0"),
("UserValidateCurrentPassCustomForm","class","modules/user/user.test","user","0"),
("UserValidationTestCase","class","modules/user/user.test","user","0"),
("view","class","sites/all/modules/views/includes/view.inc","views","0"),
("ViewsAccessTest","class","sites/all/modules/views/tests/views_access.test","views","0"),
("ViewsAnalyzeTest","class","sites/all/modules/views/tests/views_analyze.test","views","0"),
("ViewsArgumentDefaultTest","class","sites/all/modules/views/tests/views_argument_default.test","views","0"),
("ViewsArgumentValidatorTest","class","sites/all/modules/views/tests/views_argument_validator.test","views","0"),
("ViewsBasicTest","class","sites/all/modules/views/tests/views_basic.test","views","0"),
("ViewsCacheTest","class","sites/all/modules/views/tests/views_cache.test","views","0"),
("ViewsExposedFormTest","class","sites/all/modules/views/tests/views_exposed_form.test","views","0"),
("viewsFieldApiDataTest","class","sites/all/modules/views/tests/field/views_fieldapi.test","views","0"),
("ViewsFieldApiTestHelper","class","sites/all/modules/views/tests/field/views_fieldapi.test","views","0"),
("ViewsGlossaryTestCase","class","sites/all/modules/views/tests/views_glossary.test","views","0"),
("ViewsHandlerAreaTextTest","class","sites/all/modules/views/tests/handlers/views_handler_area_text.test","views","0"),
("viewsHandlerArgumentCommentUserUidTest","class","sites/all/modules/views/tests/comment/views_handler_argument_comment_user_uid.test","views","0"),
("ViewsHandlerArgumentNullTest","class","sites/all/modules/views/tests/handlers/views_handler_argument_null.test","views","0"),
("ViewsHandlerArgumentStringTest","class","sites/all/modules/views/tests/handlers/views_handler_argument_string.test","views","0"),
("ViewsHandlerFieldBooleanTest","class","sites/all/modules/views/tests/handlers/views_handler_field_boolean.test","views","0"),
("ViewsHandlerFieldCustomTest","class","sites/all/modules/views/tests/handlers/views_handler_field_custom.test","views","0"),
("ViewsHandlerFieldDateTest","class","sites/all/modules/views/tests/handlers/views_handler_field_date.test","views","0"),
("viewsHandlerFieldFieldTest","class","sites/all/modules/views/tests/field/views_fieldapi.test","views","0"),
("ViewsHandlerFieldMath","class","sites/all/modules/views/tests/handlers/views_handler_field_math.test","views","0"),
("ViewsHandlerFieldTest","class","sites/all/modules/views/tests/handlers/views_handler_field.test","views","0"),
("ViewsHandlerFieldUrlTest","class","sites/all/modules/views/tests/handlers/views_handler_field_url.test","views","0"),
("viewsHandlerFieldUserNameTest","class","sites/all/modules/views/tests/user/views_handler_field_user_name.test","views","0"),
("ViewsHandlerFileExtensionTest","class","sites/all/modules/views/tests/handlers/views_handler_field_file_extension.test","views","0"),
("ViewsHandlerFilterCombineTest","class","sites/all/modules/views/tests/handlers/views_handler_filter_combine.test","views","0"),
("viewsHandlerFilterCommentUserUidTest","class","sites/all/modules/views/tests/comment/views_handler_filter_comment_user_uid.test","views","0"),
("ViewsHandlerFilterCounterTest","class","sites/all/modules/views/tests/handlers/views_handler_field_counter.test","views","0"),
("ViewsHandlerFilterDateTest","class","sites/all/modules/views/tests/handlers/views_handler_filter_date.test","views","0"),
("ViewsHandlerFilterEqualityTest","class","sites/all/modules/views/tests/handlers/views_handler_filter_equality.test","views","0"),
("ViewsHandlerFilterInOperator","class","sites/all/modules/views/tests/handlers/views_handler_filter_in_operator.test","views","0"),
("ViewsHandlerFilterNumericTest","class","sites/all/modules/views/tests/handlers/views_handler_filter_numeric.test","views","0"),
("ViewsHandlerFilterStringTest","class","sites/all/modules/views/tests/handlers/views_handler_filter_string.test","views","0"),
("ViewsHandlerRelationshipNodeTermDataTest","class","sites/all/modules/views/tests/taxonomy/views_handler_relationship_node_term_data.test","views","0"),
("ViewsHandlerSortDateTest","class","sites/all/modules/views/tests/handlers/views_handler_sort_date.test","views","0"),
("ViewsHandlerSortRandomTest","class","sites/all/modules/views/tests/handlers/views_handler_sort_random.test","views","0"),
("ViewsHandlerSortTest","class","sites/all/modules/views/tests/handlers/views_handler_sort.test","views","0"),
("ViewsHandlersTest","class","sites/all/modules/views/tests/views_handlers.test","views","0"),
("ViewsHandlerTest","class","sites/all/modules/views/tests/handlers/views_handlers.test","views","0"),
("ViewsHandlerTestFileSize","class","sites/all/modules/views/tests/handlers/views_handler_field_file_size.test","views","0"),
("ViewsHandlerTestXss","class","sites/all/modules/views/tests/handlers/views_handler_field_xss.test","views","0"),
("ViewsModuleTest","class","sites/all/modules/views/tests/views_module.test","views","0"),
("ViewsNodeRevisionRelationsTestCase","class","sites/all/modules/views/tests/node/views_node_revision_relations.test","views","0"),
("ViewsPagerTest","class","sites/all/modules/views/tests/views_pager.test","views","0"),
("ViewsPluginDisplayTestCase","class","sites/all/modules/views/tests/plugins/views_plugin_display.test","views","0"),
("viewsPluginStyleJumpMenuTest","class","sites/all/modules/views/tests/styles/views_plugin_style_jump_menu.test","views","0"),
("ViewsPluginStyleMappingTest","class","sites/all/modules/views/tests/styles/views_plugin_style_mapping.test","views","0"),
("ViewsPluginStyleTestBase","class","sites/all/modules/views/tests/styles/views_plugin_style_base.test","views","0"),
("ViewsPluginStyleTestCase","class","sites/all/modules/views/tests/styles/views_plugin_style.test","views","0"),
("ViewsPluginStyleUnformattedTestCase","class","sites/all/modules/views/tests/styles/views_plugin_style_unformatted.test","views","0"),
("ViewsQueryGroupByTest","class","sites/all/modules/views/tests/views_groupby.test","views","0"),
("viewsSearchQuery","class","sites/all/modules/views/modules/search/views_handler_filter_search.inc","views","0");
INSERT INTO registry VALUES
("ViewsSqlTest","class","sites/all/modules/views/tests/views_query.test","views","0"),
("ViewsTestCase","class","sites/all/modules/views/tests/views_query.test","views","0"),
("ViewsTranslatableTest","class","sites/all/modules/views/tests/views_translatable.test","views","0"),
("viewsUiGroupbyTestCase","class","sites/all/modules/views/tests/views_groupby.test","views","0"),
("ViewsUIWizardBasicTestCase","class","sites/all/modules/views/tests/views_ui.test","views","0"),
("ViewsUIWizardDefaultViewsTestCase","class","sites/all/modules/views/tests/views_ui.test","views","0"),
("ViewsUIWizardHelper","class","sites/all/modules/views/tests/views_ui.test","views","0"),
("ViewsUIWizardItemsPerPageTestCase","class","sites/all/modules/views/tests/views_ui.test","views","0"),
("ViewsUIWizardJumpMenuTestCase","class","sites/all/modules/views/tests/views_ui.test","views","0"),
("ViewsUIWizardMenuTestCase","class","sites/all/modules/views/tests/views_ui.test","views","0"),
("ViewsUIWizardOverrideDisplaysTestCase","class","sites/all/modules/views/tests/views_ui.test","views","0"),
("ViewsUIWizardSortingTestCase","class","sites/all/modules/views/tests/views_ui.test","views","0"),
("ViewsUIWizardTaggedWithTestCase","class","sites/all/modules/views/tests/views_ui.test","views","0"),
("ViewsUpgradeTestCase","class","sites/all/modules/views/tests/views_upgrade.test","views","0"),
("ViewsUserArgumentDefault","class","sites/all/modules/views/tests/user/views_user_argument_default.test","views","0"),
("ViewsUserArgumentValidate","class","sites/all/modules/views/tests/user/views_user_argument_validate.test","views","0"),
("ViewsUserTestCase","class","sites/all/modules/views/tests/user/views_user.test","views","0"),
("ViewsViewTest","class","sites/all/modules/views/tests/views_view.test","views","0"),
("views_db_object","class","sites/all/modules/views/includes/view.inc","views","0"),
("views_display","class","sites/all/modules/views/includes/view.inc","views","0"),
("views_handler","class","sites/all/modules/views/includes/handlers.inc","views","0"),
("views_handler_area","class","sites/all/modules/views/handlers/views_handler_area.inc","views","0"),
("views_handler_area_broken","class","sites/all/modules/views/handlers/views_handler_area.inc","views","0"),
("views_handler_area_messages","class","sites/all/modules/views/handlers/views_handler_area_messages.inc","views","0"),
("views_handler_area_result","class","sites/all/modules/views/handlers/views_handler_area_result.inc","views","0"),
("views_handler_area_text","class","sites/all/modules/views/handlers/views_handler_area_text.inc","views","0"),
("views_handler_area_text_custom","class","sites/all/modules/views/handlers/views_handler_area_text_custom.inc","views","0"),
("views_handler_area_view","class","sites/all/modules/views/handlers/views_handler_area_view.inc","views","0"),
("views_handler_argument","class","sites/all/modules/views/handlers/views_handler_argument.inc","views","0"),
("views_handler_argument_aggregator_category_cid","class","sites/all/modules/views/modules/aggregator/views_handler_argument_aggregator_category_cid.inc","views","0"),
("views_handler_argument_aggregator_fid","class","sites/all/modules/views/modules/aggregator/views_handler_argument_aggregator_fid.inc","views","0"),
("views_handler_argument_aggregator_iid","class","sites/all/modules/views/modules/aggregator/views_handler_argument_aggregator_iid.inc","views","0"),
("views_handler_argument_broken","class","sites/all/modules/views/handlers/views_handler_argument.inc","views","0"),
("views_handler_argument_comment_user_uid","class","sites/all/modules/views/modules/comment/views_handler_argument_comment_user_uid.inc","views","0"),
("views_handler_argument_date","class","sites/all/modules/views/handlers/views_handler_argument_date.inc","views","0"),
("views_handler_argument_field_list","class","sites/all/modules/views/modules/field/views_handler_argument_field_list.inc","views","0"),
("views_handler_argument_field_list_string","class","sites/all/modules/views/modules/field/views_handler_argument_field_list_string.inc","views","0"),
("views_handler_argument_file_fid","class","sites/all/modules/views/modules/system/views_handler_argument_file_fid.inc","views","0"),
("views_handler_argument_formula","class","sites/all/modules/views/handlers/views_handler_argument_formula.inc","views","0"),
("views_handler_argument_group_by_numeric","class","sites/all/modules/views/handlers/views_handler_argument_group_by_numeric.inc","views","0"),
("views_handler_argument_locale_group","class","sites/all/modules/views/modules/locale/views_handler_argument_locale_group.inc","views","0"),
("views_handler_argument_locale_language","class","sites/all/modules/views/modules/locale/views_handler_argument_locale_language.inc","views","0"),
("views_handler_argument_many_to_one","class","sites/all/modules/views/handlers/views_handler_argument_many_to_one.inc","views","0"),
("views_handler_argument_node_created_day","class","sites/all/modules/views/modules/node/views_handler_argument_dates_various.inc","views","0"),
("views_handler_argument_node_created_fulldate","class","sites/all/modules/views/modules/node/views_handler_argument_dates_various.inc","views","0"),
("views_handler_argument_node_created_month","class","sites/all/modules/views/modules/node/views_handler_argument_dates_various.inc","views","0"),
("views_handler_argument_node_created_week","class","sites/all/modules/views/modules/node/views_handler_argument_dates_various.inc","views","0"),
("views_handler_argument_node_created_year","class","sites/all/modules/views/modules/node/views_handler_argument_dates_various.inc","views","0"),
("views_handler_argument_node_created_year_month","class","sites/all/modules/views/modules/node/views_handler_argument_dates_various.inc","views","0"),
("views_handler_argument_node_language","class","sites/all/modules/views/modules/node/views_handler_argument_node_language.inc","views","0"),
("views_handler_argument_node_nid","class","sites/all/modules/views/modules/node/views_handler_argument_node_nid.inc","views","0"),
("views_handler_argument_node_tnid","class","sites/all/modules/views/modules/translation/views_handler_argument_node_tnid.inc","views","0"),
("views_handler_argument_node_type","class","sites/all/modules/views/modules/node/views_handler_argument_node_type.inc","views","0"),
("views_handler_argument_node_uid_revision","class","sites/all/modules/views/modules/node/views_handler_argument_node_uid_revision.inc","views","0"),
("views_handler_argument_node_vid","class","sites/all/modules/views/modules/node/views_handler_argument_node_vid.inc","views","0"),
("views_handler_argument_null","class","sites/all/modules/views/handlers/views_handler_argument_null.inc","views","0"),
("views_handler_argument_numeric","class","sites/all/modules/views/handlers/views_handler_argument_numeric.inc","views","0"),
("views_handler_argument_search","class","sites/all/modules/views/modules/search/views_handler_argument_search.inc","views","0"),
("views_handler_argument_string","class","sites/all/modules/views/handlers/views_handler_argument_string.inc","views","0"),
("views_handler_argument_taxonomy","class","sites/all/modules/views/modules/taxonomy/views_handler_argument_taxonomy.inc","views","0"),
("views_handler_argument_term_node_tid","class","sites/all/modules/views/modules/taxonomy/views_handler_argument_term_node_tid.inc","views","0"),
("views_handler_argument_term_node_tid_depth","class","sites/all/modules/views/modules/taxonomy/views_handler_argument_term_node_tid_depth.inc","views","0"),
("views_handler_argument_term_node_tid_depth_join","class","sites/all/modules/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_join.inc","views","0"),
("views_handler_argument_term_node_tid_depth_modifier","class","sites/all/modules/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_modifier.inc","views","0"),
("views_handler_argument_tracker_comment_user_uid","class","sites/all/modules/views/modules/tracker/views_handler_argument_tracker_comment_user_uid.inc","views","0"),
("views_handler_argument_users_roles_rid","class","sites/all/modules/views/modules/user/views_handler_argument_users_roles_rid.inc","views","0"),
("views_handler_argument_user_uid","class","sites/all/modules/views/modules/user/views_handler_argument_user_uid.inc","views","0"),
("views_handler_argument_vocabulary_machine_name","class","sites/all/modules/views/modules/taxonomy/views_handler_argument_vocabulary_machine_name.inc","views","0"),
("views_handler_argument_vocabulary_vid","class","sites/all/modules/views/modules/taxonomy/views_handler_argument_vocabulary_vid.inc","views","0"),
("views_handler_field","class","sites/all/modules/views/handlers/views_handler_field.inc","views","0"),
("views_handler_field_accesslog_path","class","sites/all/modules/views/modules/statistics/views_handler_field_accesslog_path.inc","views","0"),
("views_handler_field_aggregator_category","class","sites/all/modules/views/modules/aggregator/views_handler_field_aggregator_category.inc","views","0"),
("views_handler_field_aggregator_title_link","class","sites/all/modules/views/modules/aggregator/views_handler_field_aggregator_title_link.inc","views","0"),
("views_handler_field_aggregator_xss","class","sites/all/modules/views/modules/aggregator/views_handler_field_aggregator_xss.inc","views","0"),
("views_handler_field_boolean","class","sites/all/modules/views/handlers/views_handler_field_boolean.inc","views","0"),
("views_handler_field_broken","class","sites/all/modules/views/handlers/views_handler_field.inc","views","0"),
("views_handler_field_comment","class","sites/all/modules/views/modules/comment/views_handler_field_comment.inc","views","0"),
("views_handler_field_comment_depth","class","sites/all/modules/views/modules/comment/views_handler_field_comment_depth.inc","views","0"),
("views_handler_field_comment_link","class","sites/all/modules/views/modules/comment/views_handler_field_comment_link.inc","views","0"),
("views_handler_field_comment_link_approve","class","sites/all/modules/views/modules/comment/views_handler_field_comment_link_approve.inc","views","0"),
("views_handler_field_comment_link_delete","class","sites/all/modules/views/modules/comment/views_handler_field_comment_link_delete.inc","views","0"),
("views_handler_field_comment_link_edit","class","sites/all/modules/views/modules/comment/views_handler_field_comment_link_edit.inc","views","0"),
("views_handler_field_comment_link_reply","class","sites/all/modules/views/modules/comment/views_handler_field_comment_link_reply.inc","views","0"),
("views_handler_field_comment_node_link","class","sites/all/modules/views/modules/comment/views_handler_field_comment_node_link.inc","views","0"),
("views_handler_field_comment_username","class","sites/all/modules/views/modules/comment/views_handler_field_comment_username.inc","views","0"),
("views_handler_field_contact_link","class","sites/all/modules/views/modules/contact/views_handler_field_contact_link.inc","views","0"),
("views_handler_field_contextual_links","class","sites/all/modules/views/handlers/views_handler_field_contextual_links.inc","views","0"),
("views_handler_field_counter","class","sites/all/modules/views/handlers/views_handler_field_counter.inc","views","0"),
("views_handler_field_ctools_dropdown","class","sites/all/modules/views/handlers/views_handler_field_ctools_dropdown.inc","views","0"),
("views_handler_field_custom","class","sites/all/modules/views/handlers/views_handler_field_custom.inc","views","0"),
("views_handler_field_date","class","sites/all/modules/views/handlers/views_handler_field_date.inc","views","0"),
("views_handler_field_entity","class","sites/all/modules/views/handlers/views_handler_field_entity.inc","views","0"),
("views_handler_field_field","class","sites/all/modules/views/modules/field/views_handler_field_field.inc","views","0"),
("views_handler_field_file","class","sites/all/modules/views/modules/system/views_handler_field_file.inc","views","0"),
("views_handler_field_file_extension","class","sites/all/modules/views/modules/system/views_handler_field_file_extension.inc","views","0"),
("views_handler_field_file_filemime","class","sites/all/modules/views/modules/system/views_handler_field_file_filemime.inc","views","0"),
("views_handler_field_file_size","class","sites/all/modules/views/handlers/views_handler_field.inc","views","0"),
("views_handler_field_file_status","class","sites/all/modules/views/modules/system/views_handler_field_file_status.inc","views","0"),
("views_handler_field_file_uri","class","sites/all/modules/views/modules/system/views_handler_field_file_uri.inc","views","0"),
("views_handler_field_filter_format_name","class","sites/all/modules/views/modules/filter/views_handler_field_filter_format_name.inc","views","0");
INSERT INTO registry VALUES
("views_handler_field_history_user_timestamp","class","sites/all/modules/views/modules/node/views_handler_field_history_user_timestamp.inc","views","0"),
("views_handler_field_last_comment_timestamp","class","sites/all/modules/views/modules/comment/views_handler_field_last_comment_timestamp.inc","views","0"),
("views_handler_field_links","class","sites/all/modules/views/handlers/views_handler_field_links.inc","views","0"),
("views_handler_field_locale_group","class","sites/all/modules/views/modules/locale/views_handler_field_locale_group.inc","views","0"),
("views_handler_field_locale_language","class","sites/all/modules/views/modules/locale/views_handler_field_locale_language.inc","views","0"),
("views_handler_field_locale_link_edit","class","sites/all/modules/views/modules/locale/views_handler_field_locale_link_edit.inc","views","0"),
("views_handler_field_machine_name","class","sites/all/modules/views/handlers/views_handler_field_machine_name.inc","views","0"),
("views_handler_field_markup","class","sites/all/modules/views/handlers/views_handler_field_markup.inc","views","0"),
("views_handler_field_math","class","sites/all/modules/views/handlers/views_handler_field_math.inc","views","0"),
("views_handler_field_ncs_last_comment_name","class","sites/all/modules/views/modules/comment/views_handler_field_ncs_last_comment_name.inc","views","0"),
("views_handler_field_ncs_last_updated","class","sites/all/modules/views/modules/comment/views_handler_field_ncs_last_updated.inc","views","0"),
("views_handler_field_node","class","sites/all/modules/views/modules/node/views_handler_field_node.inc","views","0"),
("views_handler_field_node_comment","class","sites/all/modules/views/modules/comment/views_handler_field_node_comment.inc","views","0"),
("views_handler_field_node_counter_timestamp","class","sites/all/modules/views/modules/statistics/views_handler_field_node_counter_timestamp.inc","views","0"),
("views_handler_field_node_language","class","sites/all/modules/views/modules/locale/views_handler_field_node_language.inc","views","0"),
("views_handler_field_node_link","class","sites/all/modules/views/modules/node/views_handler_field_node_link.inc","views","0"),
("views_handler_field_node_link_delete","class","sites/all/modules/views/modules/node/views_handler_field_node_link_delete.inc","views","0"),
("views_handler_field_node_link_edit","class","sites/all/modules/views/modules/node/views_handler_field_node_link_edit.inc","views","0"),
("views_handler_field_node_link_translate","class","sites/all/modules/views/modules/translation/views_handler_field_node_link_translate.inc","views","0"),
("views_handler_field_node_new_comments","class","sites/all/modules/views/modules/comment/views_handler_field_node_new_comments.inc","views","0"),
("views_handler_field_node_page_title","class","sites/all/modules/page_title/views_handler_field_node_page_title.inc","page_title","0"),
("views_handler_field_node_path","class","sites/all/modules/views/modules/node/views_handler_field_node_path.inc","views","0"),
("views_handler_field_node_revision","class","sites/all/modules/views/modules/node/views_handler_field_node_revision.inc","views","0"),
("views_handler_field_node_revision_link","class","sites/all/modules/views/modules/node/views_handler_field_node_revision_link.inc","views","0"),
("views_handler_field_node_revision_link_delete","class","sites/all/modules/views/modules/node/views_handler_field_node_revision_link_delete.inc","views","0"),
("views_handler_field_node_revision_link_revert","class","sites/all/modules/views/modules/node/views_handler_field_node_revision_link_revert.inc","views","0"),
("views_handler_field_node_translation_link","class","sites/all/modules/views/modules/translation/views_handler_field_node_translation_link.inc","views","0"),
("views_handler_field_node_type","class","sites/all/modules/views/modules/node/views_handler_field_node_type.inc","views","0"),
("views_handler_field_node_version_count","class","sites/all/modules/views/modules/node/views_handler_field_node_version_count.inc","views","0"),
("views_handler_field_numeric","class","sites/all/modules/views/handlers/views_handler_field_numeric.inc","views","0"),
("views_handler_field_prerender_list","class","sites/all/modules/views/handlers/views_handler_field_prerender_list.inc","views","0"),
("views_handler_field_profile_date","class","sites/all/modules/views/modules/profile/views_handler_field_profile_date.inc","views","0"),
("views_handler_field_profile_list","class","sites/all/modules/views/modules/profile/views_handler_field_profile_list.inc","views","0"),
("views_handler_field_search_score","class","sites/all/modules/views/modules/search/views_handler_field_search_score.inc","views","0"),
("views_handler_field_serialized","class","sites/all/modules/views/handlers/views_handler_field_serialized.inc","views","0"),
("views_handler_field_statistics_numeric","class","sites/all/modules/views/modules/statistics/views_handler_field_statistics_numeric.inc","views","0"),
("views_handler_field_taxonomy","class","sites/all/modules/views/modules/taxonomy/views_handler_field_taxonomy.inc","views","0"),
("views_handler_field_term_link_edit","class","sites/all/modules/views/modules/taxonomy/views_handler_field_term_link_edit.inc","views","0"),
("views_handler_field_term_node_tid","class","sites/all/modules/views/modules/taxonomy/views_handler_field_term_node_tid.inc","views","0"),
("views_handler_field_time_interval","class","sites/all/modules/views/handlers/views_handler_field_time_interval.inc","views","0"),
("views_handler_field_url","class","sites/all/modules/views/handlers/views_handler_field_url.inc","views","0"),
("views_handler_field_user","class","sites/all/modules/views/modules/user/views_handler_field_user.inc","views","0"),
("views_handler_field_user_language","class","sites/all/modules/views/modules/user/views_handler_field_user_language.inc","views","0"),
("views_handler_field_user_link","class","sites/all/modules/views/modules/user/views_handler_field_user_link.inc","views","0"),
("views_handler_field_user_link_cancel","class","sites/all/modules/views/modules/user/views_handler_field_user_link_cancel.inc","views","0"),
("views_handler_field_user_link_edit","class","sites/all/modules/views/modules/user/views_handler_field_user_link_edit.inc","views","0"),
("views_handler_field_user_mail","class","sites/all/modules/views/modules/user/views_handler_field_user_mail.inc","views","0"),
("views_handler_field_user_name","class","sites/all/modules/views/modules/user/views_handler_field_user_name.inc","views","0"),
("views_handler_field_user_permissions","class","sites/all/modules/views/modules/user/views_handler_field_user_permissions.inc","views","0"),
("views_handler_field_user_picture","class","sites/all/modules/views/modules/user/views_handler_field_user_picture.inc","views","0"),
("views_handler_field_user_roles","class","sites/all/modules/views/modules/user/views_handler_field_user_roles.inc","views","0"),
("views_handler_field_xss","class","sites/all/modules/views/handlers/views_handler_field.inc","views","0"),
("views_handler_filter","class","sites/all/modules/views/handlers/views_handler_filter.inc","views","0"),
("views_handler_filter_aggregator_category_cid","class","sites/all/modules/views/modules/aggregator/views_handler_filter_aggregator_category_cid.inc","views","0"),
("views_handler_filter_boolean_operator","class","sites/all/modules/views/handlers/views_handler_filter_boolean_operator.inc","views","0"),
("views_handler_filter_boolean_operator_string","class","sites/all/modules/views/handlers/views_handler_filter_boolean_operator_string.inc","views","0"),
("views_handler_filter_broken","class","sites/all/modules/views/handlers/views_handler_filter.inc","views","0"),
("views_handler_filter_combine","class","sites/all/modules/views/handlers/views_handler_filter_combine.inc","views","0"),
("views_handler_filter_comment_user_uid","class","sites/all/modules/views/modules/comment/views_handler_filter_comment_user_uid.inc","views","0"),
("views_handler_filter_date","class","sites/all/modules/views/handlers/views_handler_filter_date.inc","views","0"),
("views_handler_filter_entity_bundle","class","sites/all/modules/views/handlers/views_handler_filter_entity_bundle.inc","views","0"),
("views_handler_filter_equality","class","sites/all/modules/views/handlers/views_handler_filter_equality.inc","views","0"),
("views_handler_filter_fields_compare","class","sites/all/modules/views/handlers/views_handler_filter_fields_compare.inc","views","0"),
("views_handler_filter_field_list","class","sites/all/modules/views/modules/field/views_handler_filter_field_list.inc","views","0"),
("views_handler_filter_field_list_boolean","class","sites/all/modules/views/modules/field/views_handler_filter_field_list_boolean.inc","views","0"),
("views_handler_filter_file_status","class","sites/all/modules/views/modules/system/views_handler_filter_file_status.inc","views","0"),
("views_handler_filter_group_by_numeric","class","sites/all/modules/views/handlers/views_handler_filter_group_by_numeric.inc","views","0"),
("views_handler_filter_history_user_timestamp","class","sites/all/modules/views/modules/node/views_handler_filter_history_user_timestamp.inc","views","0"),
("views_handler_filter_in_operator","class","sites/all/modules/views/handlers/views_handler_filter_in_operator.inc","views","0"),
("views_handler_filter_locale_group","class","sites/all/modules/views/modules/locale/views_handler_filter_locale_group.inc","views","0"),
("views_handler_filter_locale_language","class","sites/all/modules/views/modules/locale/views_handler_filter_locale_language.inc","views","0"),
("views_handler_filter_locale_version","class","sites/all/modules/views/modules/locale/views_handler_filter_locale_version.inc","views","0"),
("views_handler_filter_many_to_one","class","sites/all/modules/views/handlers/views_handler_filter_many_to_one.inc","views","0"),
("views_handler_filter_ncs_last_updated","class","sites/all/modules/views/modules/comment/views_handler_filter_ncs_last_updated.inc","views","0"),
("views_handler_filter_node_access","class","sites/all/modules/views/modules/node/views_handler_filter_node_access.inc","views","0"),
("views_handler_filter_node_comment","class","sites/all/modules/views/modules/comment/views_handler_filter_node_comment.inc","views","0"),
("views_handler_filter_node_language","class","sites/all/modules/views/modules/locale/views_handler_filter_node_language.inc","views","0"),
("views_handler_filter_node_status","class","sites/all/modules/views/modules/node/views_handler_filter_node_status.inc","views","0"),
("views_handler_filter_node_tnid","class","sites/all/modules/views/modules/translation/views_handler_filter_node_tnid.inc","views","0"),
("views_handler_filter_node_tnid_child","class","sites/all/modules/views/modules/translation/views_handler_filter_node_tnid_child.inc","views","0"),
("views_handler_filter_node_type","class","sites/all/modules/views/modules/node/views_handler_filter_node_type.inc","views","0"),
("views_handler_filter_node_uid_revision","class","sites/all/modules/views/modules/node/views_handler_filter_node_uid_revision.inc","views","0"),
("views_handler_filter_node_version_count","class","sites/all/modules/views/modules/node/views_handler_filter_node_version_count.inc","views","0"),
("views_handler_filter_numeric","class","sites/all/modules/views/handlers/views_handler_filter_numeric.inc","views","0"),
("views_handler_filter_profile_selection","class","sites/all/modules/views/modules/profile/views_handler_filter_profile_selection.inc","views","0"),
("views_handler_filter_search","class","sites/all/modules/views/modules/search/views_handler_filter_search.inc","views","0"),
("views_handler_filter_string","class","sites/all/modules/views/handlers/views_handler_filter_string.inc","views","0"),
("views_handler_filter_system_type","class","sites/all/modules/views/modules/system/views_handler_filter_system_type.inc","views","0"),
("views_handler_filter_term_node_tid","class","sites/all/modules/views/modules/taxonomy/views_handler_filter_term_node_tid.inc","views","0"),
("views_handler_filter_term_node_tid_depth","class","sites/all/modules/views/modules/taxonomy/views_handler_filter_term_node_tid_depth.inc","views","0"),
("views_handler_filter_term_node_tid_depth_join","class","sites/all/modules/views/modules/taxonomy/views_handler_filter_term_node_tid_depth_join.inc","views","0"),
("views_handler_filter_tracker_boolean_operator","class","sites/all/modules/views/modules/tracker/views_handler_filter_tracker_boolean_operator.inc","views","0"),
("views_handler_filter_tracker_comment_user_uid","class","sites/all/modules/views/modules/tracker/views_handler_filter_tracker_comment_user_uid.inc","views","0"),
("views_handler_filter_user_current","class","sites/all/modules/views/modules/user/views_handler_filter_user_current.inc","views","0"),
("views_handler_filter_user_name","class","sites/all/modules/views/modules/user/views_handler_filter_user_name.inc","views","0"),
("views_handler_filter_user_permissions","class","sites/all/modules/views/modules/user/views_handler_filter_user_permissions.inc","views","0"),
("views_handler_filter_user_roles","class","sites/all/modules/views/modules/user/views_handler_filter_user_roles.inc","views","0"),
("views_handler_filter_vocabulary_machine_name","class","sites/all/modules/views/modules/taxonomy/views_handler_filter_vocabulary_machine_name.inc","views","0"),
("views_handler_filter_vocabulary_vid","class","sites/all/modules/views/modules/taxonomy/views_handler_filter_vocabulary_vid.inc","views","0"),
("views_handler_relationship","class","sites/all/modules/views/handlers/views_handler_relationship.inc","views","0");
INSERT INTO registry VALUES
("views_handler_relationship_broken","class","sites/all/modules/views/handlers/views_handler_relationship.inc","views","0"),
("views_handler_relationship_entity_reverse","class","sites/all/modules/views/modules/field/views_handler_relationship_entity_reverse.inc","views","0"),
("views_handler_relationship_groupwise_max","class","sites/all/modules/views/handlers/views_handler_relationship_groupwise_max.inc","views","0"),
("views_handler_relationship_node_term_data","class","sites/all/modules/views/modules/taxonomy/views_handler_relationship_node_term_data.inc","views","0"),
("views_handler_relationship_translation","class","sites/all/modules/views/modules/translation/views_handler_relationship_translation.inc","views","0"),
("views_handler_sort","class","sites/all/modules/views/handlers/views_handler_sort.inc","views","0"),
("views_handler_sort_broken","class","sites/all/modules/views/handlers/views_handler_sort.inc","views","0"),
("views_handler_sort_comment_thread","class","sites/all/modules/views/modules/comment/views_handler_sort_comment_thread.inc","views","0"),
("views_handler_sort_date","class","sites/all/modules/views/handlers/views_handler_sort_date.inc","views","0"),
("views_handler_sort_group_by_numeric","class","sites/all/modules/views/handlers/views_handler_sort_group_by_numeric.inc","views","0"),
("views_handler_sort_menu_hierarchy","class","sites/all/modules/views/handlers/views_handler_sort_menu_hierarchy.inc","views","0"),
("views_handler_sort_ncs_last_comment_name","class","sites/all/modules/views/modules/comment/views_handler_sort_ncs_last_comment_name.inc","views","0"),
("views_handler_sort_ncs_last_updated","class","sites/all/modules/views/modules/comment/views_handler_sort_ncs_last_updated.inc","views","0"),
("views_handler_sort_node_language","class","sites/all/modules/views/modules/locale/views_handler_sort_node_language.inc","views","0"),
("views_handler_sort_node_version_count","class","sites/all/modules/views/modules/node/views_handler_sort_node_version_count.inc","views","0"),
("views_handler_sort_random","class","sites/all/modules/views/handlers/views_handler_sort_random.inc","views","0"),
("views_handler_sort_search_score","class","sites/all/modules/views/modules/search/views_handler_sort_search_score.inc","views","0"),
("views_join","class","sites/all/modules/views/includes/handlers.inc","views","0"),
("views_join_subquery","class","sites/all/modules/views/includes/handlers.inc","views","0"),
("views_many_to_one_helper","class","sites/all/modules/views/includes/handlers.inc","views","0"),
("views_object","class","sites/all/modules/views/includes/base.inc","views","0"),
("views_plugin","class","sites/all/modules/views/includes/plugins.inc","views","0"),
("views_plugin_access","class","sites/all/modules/views/plugins/views_plugin_access.inc","views","0"),
("views_plugin_access_none","class","sites/all/modules/views/plugins/views_plugin_access_none.inc","views","0"),
("views_plugin_access_perm","class","sites/all/modules/views/plugins/views_plugin_access_perm.inc","views","0"),
("views_plugin_access_role","class","sites/all/modules/views/plugins/views_plugin_access_role.inc","views","0"),
("views_plugin_argument_default","class","sites/all/modules/views/plugins/views_plugin_argument_default.inc","views","0"),
("views_plugin_argument_default_book_root","class","sites/all/modules/views/modules/book/views_plugin_argument_default_book_root.inc","views","0"),
("views_plugin_argument_default_current_user","class","sites/all/modules/views/modules/user/views_plugin_argument_default_current_user.inc","views","0"),
("views_plugin_argument_default_fixed","class","sites/all/modules/views/plugins/views_plugin_argument_default_fixed.inc","views","0"),
("views_plugin_argument_default_node","class","sites/all/modules/views/modules/node/views_plugin_argument_default_node.inc","views","0"),
("views_plugin_argument_default_php","class","sites/all/modules/views/plugins/views_plugin_argument_default_php.inc","views","0"),
("views_plugin_argument_default_raw","class","sites/all/modules/views/plugins/views_plugin_argument_default_raw.inc","views","0"),
("views_plugin_argument_default_taxonomy_tid","class","sites/all/modules/views/modules/taxonomy/views_plugin_argument_default_taxonomy_tid.inc","views","0"),
("views_plugin_argument_default_user","class","sites/all/modules/views/modules/user/views_plugin_argument_default_user.inc","views","0"),
("views_plugin_argument_validate","class","sites/all/modules/views/plugins/views_plugin_argument_validate.inc","views","0"),
("views_plugin_argument_validate_node","class","sites/all/modules/views/modules/node/views_plugin_argument_validate_node.inc","views","0"),
("views_plugin_argument_validate_numeric","class","sites/all/modules/views/plugins/views_plugin_argument_validate_numeric.inc","views","0"),
("views_plugin_argument_validate_php","class","sites/all/modules/views/plugins/views_plugin_argument_validate_php.inc","views","0"),
("views_plugin_argument_validate_taxonomy_term","class","sites/all/modules/views/modules/taxonomy/views_plugin_argument_validate_taxonomy_term.inc","views","0"),
("views_plugin_argument_validate_user","class","sites/all/modules/views/modules/user/views_plugin_argument_validate_user.inc","views","0"),
("views_plugin_cache","class","sites/all/modules/views/plugins/views_plugin_cache.inc","views","0"),
("views_plugin_cache_none","class","sites/all/modules/views/plugins/views_plugin_cache_none.inc","views","0"),
("views_plugin_cache_time","class","sites/all/modules/views/plugins/views_plugin_cache_time.inc","views","0"),
("views_plugin_display","class","sites/all/modules/views/plugins/views_plugin_display.inc","views","0"),
("views_plugin_display_attachment","class","sites/all/modules/views/plugins/views_plugin_display_attachment.inc","views","0"),
("views_plugin_display_block","class","sites/all/modules/views/plugins/views_plugin_display_block.inc","views","0"),
("views_plugin_display_default","class","sites/all/modules/views/plugins/views_plugin_display_default.inc","views","0"),
("views_plugin_display_embed","class","sites/all/modules/views/plugins/views_plugin_display_embed.inc","views","0"),
("views_plugin_display_extender","class","sites/all/modules/views/plugins/views_plugin_display_extender.inc","views","0"),
("views_plugin_display_feed","class","sites/all/modules/views/plugins/views_plugin_display_feed.inc","views","0"),
("views_plugin_display_page","class","sites/all/modules/views/plugins/views_plugin_display_page.inc","views","0"),
("views_plugin_exposed_form","class","sites/all/modules/views/plugins/views_plugin_exposed_form.inc","views","0"),
("views_plugin_exposed_form_basic","class","sites/all/modules/views/plugins/views_plugin_exposed_form_basic.inc","views","0"),
("views_plugin_exposed_form_input_required","class","sites/all/modules/views/plugins/views_plugin_exposed_form_input_required.inc","views","0"),
("views_plugin_localization","class","sites/all/modules/views/plugins/views_plugin_localization.inc","views","0"),
("views_plugin_localization_core","class","sites/all/modules/views/plugins/views_plugin_localization_core.inc","views","0"),
("views_plugin_localization_none","class","sites/all/modules/views/plugins/views_plugin_localization_none.inc","views","0"),
("views_plugin_localization_test","class","sites/all/modules/views/tests/views_plugin_localization_test.inc","views","0"),
("views_plugin_pager","class","sites/all/modules/views/plugins/views_plugin_pager.inc","views","0"),
("views_plugin_pager_full","class","sites/all/modules/views/plugins/views_plugin_pager_full.inc","views","0"),
("views_plugin_pager_mini","class","sites/all/modules/views/plugins/views_plugin_pager_mini.inc","views","0"),
("views_plugin_pager_none","class","sites/all/modules/views/plugins/views_plugin_pager_none.inc","views","0"),
("views_plugin_pager_some","class","sites/all/modules/views/plugins/views_plugin_pager_some.inc","views","0"),
("views_plugin_query","class","sites/all/modules/views/plugins/views_plugin_query.inc","views","0"),
("views_plugin_query_default","class","sites/all/modules/views/plugins/views_plugin_query_default.inc","views","0"),
("views_plugin_row","class","sites/all/modules/views/plugins/views_plugin_row.inc","views","0"),
("views_plugin_row_aggregator_rss","class","sites/all/modules/views/modules/aggregator/views_plugin_row_aggregator_rss.inc","views","0"),
("views_plugin_row_comment_rss","class","sites/all/modules/views/modules/comment/views_plugin_row_comment_rss.inc","views","0"),
("views_plugin_row_comment_view","class","sites/all/modules/views/modules/comment/views_plugin_row_comment_view.inc","views","0"),
("views_plugin_row_fields","class","sites/all/modules/views/plugins/views_plugin_row_fields.inc","views","0"),
("views_plugin_row_node_rss","class","sites/all/modules/views/modules/node/views_plugin_row_node_rss.inc","views","0"),
("views_plugin_row_node_view","class","sites/all/modules/views/modules/node/views_plugin_row_node_view.inc","views","0"),
("views_plugin_row_rss_fields","class","sites/all/modules/views/plugins/views_plugin_row_rss_fields.inc","views","0"),
("views_plugin_row_search_view","class","sites/all/modules/views/modules/search/views_plugin_row_search_view.inc","views","0"),
("views_plugin_row_user_view","class","sites/all/modules/views/modules/user/views_plugin_row_user_view.inc","views","0"),
("views_plugin_style","class","sites/all/modules/views/plugins/views_plugin_style.inc","views","0"),
("views_plugin_style_default","class","sites/all/modules/views/plugins/views_plugin_style_default.inc","views","0"),
("views_plugin_style_grid","class","sites/all/modules/views/plugins/views_plugin_style_grid.inc","views","0"),
("views_plugin_style_jump_menu","class","sites/all/modules/views/plugins/views_plugin_style_jump_menu.inc","views","0"),
("views_plugin_style_list","class","sites/all/modules/views/plugins/views_plugin_style_list.inc","views","0"),
("views_plugin_style_mapping","class","sites/all/modules/views/plugins/views_plugin_style_mapping.inc","views","0"),
("views_plugin_style_rss","class","sites/all/modules/views/plugins/views_plugin_style_rss.inc","views","0"),
("views_plugin_style_summary","class","sites/all/modules/views/plugins/views_plugin_style_summary.inc","views","0"),
("views_plugin_style_summary_jump_menu","class","sites/all/modules/views/plugins/views_plugin_style_summary_jump_menu.inc","views","0"),
("views_plugin_style_summary_unformatted","class","sites/all/modules/views/plugins/views_plugin_style_summary_unformatted.inc","views","0"),
("views_plugin_style_table","class","sites/all/modules/views/plugins/views_plugin_style_table.inc","views","0"),
("views_test_area_access","class","sites/all/modules/views/tests/test_handlers/views_test_area_access.inc","views","0"),
("views_test_plugin_access_test_dynamic","class","sites/all/modules/views/tests/test_plugins/views_test_plugin_access_test_dynamic.inc","views","0"),
("views_test_plugin_access_test_static","class","sites/all/modules/views/tests/test_plugins/views_test_plugin_access_test_static.inc","views","0"),
("views_test_plugin_style_test_mapping","class","sites/all/modules/views/tests/test_plugins/views_test_plugin_style_test_mapping.inc","views","0"),
("WebformComponentsTestCase","class","sites/all/modules/webform/tests/components.test","webform","0"),
("WebformConditionals","class","sites/all/modules/webform/includes/webform.webformconditionals.inc","webform","0"),
("WebformConditionalsTestCase","class","sites/all/modules/webform/tests/conditionals.test","webform","0"),
("WebformGeneralTestCase","class","sites/all/modules/webform/tests/webform.test","webform","0"),
("WebformPermissionsTestCase","class","sites/all/modules/webform/tests/permissions.test","webform","0"),
("WebformSubmissionTestCase","class","sites/all/modules/webform/tests/submission.test","webform","0"),
("WebformTestCase","class","sites/all/modules/webform/tests/webform.test","webform","0"),
("webform_exporter","class","sites/all/modules/webform/includes/exporters/webform_exporter.inc","webform","0"),
("webform_exporter_delimited","class","sites/all/modules/webform/includes/exporters/webform_exporter_delimited.inc","webform","0");
INSERT INTO registry VALUES
("webform_exporter_excel_delimited","class","sites/all/modules/webform/includes/exporters/webform_exporter_excel_delimited.inc","webform","0"),
("webform_exporter_excel_xlsx","class","sites/all/modules/webform/includes/exporters/webform_exporter_excel_xlsx.inc","webform","0"),
("webform_handler_area_result_pager","class","sites/all/modules/webform/views/webform_handler_area_result_pager.inc","webform","0"),
("webform_handler_field_form_body","class","sites/all/modules/webform/views/webform_handler_field_form_body.inc","webform","0"),
("webform_handler_field_is_draft","class","sites/all/modules/webform/views/webform_handler_field_is_draft.inc","webform","0"),
("webform_handler_field_node_link_edit","class","sites/all/modules/webform/views/webform_handler_field_node_link_edit.inc","webform","0"),
("webform_handler_field_node_link_results","class","sites/all/modules/webform/views/webform_handler_field_node_link_results.inc","webform","0"),
("webform_handler_field_numeric_data","class","sites/all/modules/webform/views/webform_handler_numeric_data.inc","webform","0"),
("webform_handler_field_submission_count","class","sites/all/modules/webform/views/webform_handler_field_submission_count.inc","webform","0"),
("webform_handler_field_submission_data","class","sites/all/modules/webform/views/webform_handler_field_submission_data.inc","webform","0"),
("webform_handler_field_submission_link","class","sites/all/modules/webform/views/webform_handler_field_submission_link.inc","webform","0"),
("webform_handler_field_webform_status","class","sites/all/modules/webform/views/webform_handler_field_webform_status.inc","webform","0"),
("webform_handler_filter_is_draft","class","sites/all/modules/webform/views/webform_handler_filter_is_draft.inc","webform","0"),
("webform_handler_filter_numeric_data","class","sites/all/modules/webform/views/webform_handler_numeric_data.inc","webform","0"),
("webform_handler_filter_submission_data","class","sites/all/modules/webform/views/webform_handler_filter_submission_data.inc","webform","0"),
("webform_handler_filter_webform_status","class","sites/all/modules/webform/views/webform_handler_filter_webform_status.inc","webform","0"),
("webform_handler_relationship_submission_data","class","sites/all/modules/webform/views/webform_handler_relationship_submission_data.inc","webform","0"),
("webform_handler_sort_numeric_data","class","sites/all/modules/webform/views/webform_handler_numeric_data.inc","webform","0"),
("webform_views_plugin_row_submission_view","class","sites/all/modules/webform/views/webform_plugin_row_submission_view.inc","webform","0"),
("XMLSitemapException","class","sites/all/modules/xmlsitemap/xmlsitemap.xmlsitemap.inc","xmlsitemap","0"),
("XMLSitemapFunctionalTest","class","sites/all/modules/xmlsitemap/xmlsitemap.test","xmlsitemap","0"),
("XMLSitemapGenerationException","class","sites/all/modules/xmlsitemap/xmlsitemap.xmlsitemap.inc","xmlsitemap","0"),
("XMLSitemapIndexWriter","class","sites/all/modules/xmlsitemap/xmlsitemap.xmlsitemap.inc","xmlsitemap","0"),
("XMLSitemapRobotsTxtIntegrationTest","class","sites/all/modules/xmlsitemap/xmlsitemap.test","xmlsitemap","0"),
("XMLSitemapTestHelper","class","sites/all/modules/xmlsitemap/xmlsitemap.test","xmlsitemap","0"),
("XMLSitemapUnitTest","class","sites/all/modules/xmlsitemap/xmlsitemap.test","xmlsitemap","0"),
("XMLSitemapWriter","class","sites/all/modules/xmlsitemap/xmlsitemap.xmlsitemap.inc","xmlsitemap","0");




CREATE TABLE `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';


INSERT INTO registry_file VALUES
("includes/actions.inc","f36b066681463c7dfe189e0430cb1a89bf66f7e228cbb53cdfcd93987193f759"),
("includes/ajax.inc","a22c8f7345c1f714ea40bbaa1385fa0e3763b389c82656cf6ff3e4d051532ee4"),
("includes/archiver.inc","bdbb21b712a62f6b913590b609fd17cd9f3c3b77c0d21f68e71a78427ed2e3e9"),
("includes/authorize.inc","6d64d8c21aa01eb12fc29918732e4df6b871ed06e5d41373cb95c197ed661d13"),
("includes/batch.inc","1fe00f9a25481cd43e19fbd6bd37b7ff9dca79f8405ec3e55ffb011be12ec2c3"),
("includes/batch.queue.inc","554b2e92e1dad0f7fd5a19cb8dff7e109f10fbe2441a5692d076338ec908de0f"),
("includes/bootstrap.inc","46d3e700b5faaa94161f5667e85323c5aed13bb7ed84cb122acce27cb49c0009"),
("includes/cache-install.inc","e7ed123c5805703c84ad2cce9c1ca46b3ce8caeeea0d8ef39a3024a4ab95fa0e"),
("includes/cache.inc","ee0bf13c7e067695dffcb9ade3b79fea82a3a8db9e9a422ebfcc91c383aa4b4c"),
("includes/common.inc","7e07d4740b6b59dc2b0bf5ed44183c8bba676537359376d747df80edbd8a4c6e"),
("includes/database/database.inc","27f874fb21e1a85c86e0317669e2e26c1c6611a5e913c5bbce4c7aa62734edfe"),
("includes/database/log.inc","9feb5a17ae2fabcf26a96d2a634ba73da501f7bcfc3599a693d916a6971d00d1"),
("includes/database/mysql/database.inc","b92eedf14735579e11a9d14810650d95b6eb1809c4b6648f47d36dd7f957ac75"),
("includes/database/mysql/install.inc","6ae316941f771732fbbabed7e1d6b4cbb41b1f429dd097d04b3345aa15e461a0"),
("includes/database/mysql/query.inc","0212a871646c223bf77aa26b945c77a8974855373967b5fb9fdc09f8a1de88a6"),
("includes/database/mysql/schema.inc","6f43ac87508f868fe38ee09994fc18d69915bada0237f8ac3b717cafe8f22c6b"),
("includes/database/pgsql/database.inc","d737f95947d78eb801e8ec8ca8b01e72d2e305924efce8abca0a98c1b5264cff"),
("includes/database/pgsql/install.inc","585b80c5bbd6f134bff60d06397f15154657a577d4da8d1b181858905f09dea5"),
("includes/database/pgsql/query.inc","0df57377686c921e722a10b49d5e433b131176c8059a4ace4680964206fc14b4"),
("includes/database/pgsql/schema.inc","1588daadfa53506aa1f5d94572162a45a46dc3ceabdd0e2f224532ded6508403"),
("includes/database/pgsql/select.inc","fd4bba7887c1dc6abc8f080fc3a76c01d92ea085434e355dc1ecb50d8743c22d"),
("includes/database/prefetch.inc","b5b207a66a69ecb52ee4f4459af16a7b5eabedc87254245f37cc33bebb61c0fb"),
("includes/database/query.inc","4016a397f10f071cac338fd0a9b004296106e42ab2b9db8c7ff0db341658e88f"),
("includes/database/schema.inc","9fecfd13fc1d4056a62d385840dccd052ea0e184dc47101f4bd8f57f10b68174"),
("includes/database/select.inc","5e9cdc383564ba86cb9dcad0046990ce15415a3000e4f617d6e0f30a205b852c"),
("includes/database/sqlite/database.inc","4281c6e80932560ecbeb07d1757efd133e8699a6fccf58c27a55df0f71794622"),
("includes/database/sqlite/install.inc","6620f354aa175a116ba3a0562c980d86cc3b8b481042fc3cc5ed6a4d1a7a6d74"),
("includes/database/sqlite/query.inc","f33ab1b6350736a231a4f3f93012d3aac4431ac4e5510fb3a015a5aa6cab8303"),
("includes/database/sqlite/schema.inc","cd829700205a8574f8b9d88cd1eaf909519c64754c6f84d6c62b5d21f5886f8d"),
("includes/database/sqlite/select.inc","8d1c426dbd337733c206cce9f59a172546c6ed856d8ef3f1c7bef05a16f7bf68"),
("includes/date.inc","18c047be64f201e16d189f1cc47ed9dcf0a145151b1ee187e90511b24e5d2b36"),
("includes/entity.inc","e4fc9ff21b165a804d7ac4f036b3b5bd1d3c73da7029bf3f761d4bdee9ae3c96"),
("includes/errors.inc","72cc29840b24830df98a5628286b4d82738f2abbb78e69b4980310ff12062668"),
("includes/file.inc","9de0398940bf2db560902736f1832d8b72b3e8b49dbbaba5f94c9331425ee04a"),
("includes/file.mimetypes.inc","33266e837f4ce076378e7e8cef6c5af46446226ca4259f83e13f605856a7f147"),
("includes/filetransfer/filetransfer.inc","fdea8ae48345ec91885ac48a9bc53daf87616271472bb7c29b7e3ce219b22034"),
("includes/filetransfer/ftp.inc","51eb119b8e1221d598ffa6cc46c8a322aa77b49a3d8879f7fb38b7221cf7e06d"),
("includes/filetransfer/local.inc","7cbfdb46abbdf539640db27e66fb30e5265128f31002bd0dfc3af16ae01a9492"),
("includes/filetransfer/ssh.inc","92f1232158cb32ab04cbc93ae38ad3af04796e18f66910a9bc5ca8e437f06891"),
("includes/form.inc","e8740cc136c284b132cc2f970a2bfc618e011f85b96140aaf7f7c49c891eca31"),
("includes/graph.inc","8e0e313a8bb33488f371df11fc1b58d7cf80099b886cd1003871e2c896d1b536"),
("includes/image.inc","bcdc7e1599c02227502b9d0fe36eeb2b529b130a392bc709eb737647bd361826"),
("includes/install.core.inc","733ec6fac8e51747d1c83f266a42e4a0cb6bf31ac50f17f06e37c9e0865f4a38"),
("includes/install.inc","fbb23627b06abb070b4531da786c1e06bf1dbd6f923bb2b404f4808c2340b0f9"),
("includes/iso.inc","0ce4c225edcfa9f037703bc7dd09d4e268a69bcc90e55da0a3f04c502bd2f349"),
("includes/json-encode.inc","02a822a652d00151f79db9aa9e171c310b69b93a12f549bc2ce00533a8efa14e"),
("includes/language.inc","4e08f30843a7ccaeea5c041083e9f77d33d57ff002f1ab4f66168e2c683ce128"),
("includes/locale.inc","f8a3ba7868698e9b43c2ceaebe2cbdcb92d6c68427e817a6e10a76b937b5a127"),
("includes/lock.inc","a181c8bd4f88d292a0a73b9f1fbd727e3314f66ec3631f288e6b9a54ba2b70fa"),
("includes/mail.inc","41d0e657119a05f8d7e85ebf32e74b12a1c3107d717a348158414b113e208b9c"),
("includes/menu.inc","2ecc6f990dc2d987425c680e27a4ddeec2e8376a2be408b00a144131f41a59ea"),
("includes/module.inc","50cf3d3a93d72d1f261c6eceeaa23688ab7272315c5b806f702e518b8d000bfd"),
("includes/pager.inc","6f9494b85c07a2cc3be4e54aff2d2757485238c476a7da084d25bde1d88be6d8"),
("includes/password.inc","fd9a1c94fe5a0fa7c7049a2435c7280b1d666b2074595010e3c492dd15712775"),
("includes/path.inc","2dca08d14a46e5ac6a665b7a5dde78045d8de2b35aaa78c6fb811e1125ce4953"),
("includes/registry.inc","f47b20859f0fc80bf4bb2849a1282d6c54006957b69da0e5f4691de585ca4cdf"),
("includes/session.inc","7548621ae4c273179a76eba41aa58b740100613bc015ad388a5c30132b61e34b"),
("includes/stream_wrappers.inc","4f1feb774a8dbc04ca382fa052f59e58039c7261625f3df29987d6b31f08d92d"),
("includes/tablesort.inc","2d88768a544829595dd6cda2a5eb008bedb730f36bba6dfe005d9ddd999d5c0f"),
("includes/theme.inc","193e6453b5e1534ba48c40bfa13528c6ba21b819e8ebe618309b302a2ba90f4c"),
("includes/theme.maintenance.inc","39f068b3eee4d10a90d6aa3c86db587b6d25844c2919d418d34d133cfe330f5a"),
("includes/token.inc","5e7898cd78689e2c291ed3cd8f41c032075656896f1db57e49217aac19ae0428"),
("includes/unicode.entities.inc","2b858138596d961fbaa4c6e3986e409921df7f76b6ee1b109c4af5970f1e0f54"),
("includes/unicode.inc","e18772dafe0f80eb139fcfc582fef1704ba9f730647057d4f4841d6a6e4066ca"),
("includes/update.inc","77403195059de797422d9d9202f18548a38558995120c7f9ffb9bd044730a3bc"),
("includes/updater.inc","d2da0e74ed86e93c209f16069f3d32e1a134ceb6c06a0044f78e841a1b54e380"),
("includes/utility.inc","3458fd2b55ab004dd0cc529b8e58af12916e8bd36653b072bdd820b26b907ed5"),
("includes/xmlrpc.inc","ea24176ec445c440ba0c825fc7b04a31b440288df8ef02081560dc418e34e659"),
("includes/xmlrpcs.inc","925c4d5bf429ad9650f059a8862a100bd394dce887933f5b3e7e32309a51fd8e"),
("modules/block/block.test","40d9de00589211770a85c47d38c8ad61c598ec65d9332128a882eb8750e65a16"),
("modules/color/color.test","013806279bd47ceb2f82ca854b57f880ba21058f7a2592c422afae881a7f5d15"),
("modules/comment/comment.module","db858137ff6ce06d87cb3b8f5275bed90c33a6d9aa7d46e7a74524cc2f052309"),
("modules/comment/comment.test","0443a4dbc5aef3d64405a7cabf462c8c5e0b24517d89410d261027b85292cd4b"),
("modules/contextual/contextual.test","023dafa199bd325ecc55a17b2a3db46ac0a31e23059f701f789f3bc42427ba0b"),
("modules/dashboard/dashboard.test","125df00fc6deb985dc554aa7807a48e60a68dbbddbad9ec2c4718da724f0e683"),
("modules/dblog/dblog.test","e6c6ba087256e007159a2dbfcd3554f824503cc3b2ef1335497e3f05d4cd67c0"),
("modules/field/field.attach.inc","2df4687b5ec078c4893dc1fea514f67524fd5293de717b9e05caf977e5ae2327"),
("modules/field/field.info.class.inc","cf18178e119d43897d3abd882ba3acc0cf59d1ad747663437c57b1ec4d0a4322"),
("modules/field/field.module","e9359f8cac64b2d81ac067d7da22972116dc10b9b346752a8ef8292943a958c9"),
("modules/field/modules/field_sql_storage/field_sql_storage.test","315eedaf2022afc884c35efd3b7c400eddab6ea30bec91924bc82ab5cd3e79f2"),
("modules/field/modules/list/tests/list.test","97e55bd49f6f4b0562d04aa3773b5ab9b35063aee05c8c7231780cdcf9c97714"),
("modules/field/modules/number/number.test","9ccf835bbf80ff31b121286f6fbcf59cc42b622a51ab56b22362b2f55c656e18"),
("modules/field/modules/options/options.test","5a9d86ddda33bef96468072c53bd0f7b28966e5d23d58a965724a672c9dae62a"),
("modules/field/modules/text/text.test","a1e5cb0fa8c0651c68d560d9bb7781463a84200f701b00b6e797a9ca792a7e42"),
("modules/field/tests/field.test","5eaad7a933ef8ea05b958056492ce17858cd542111f0fe81dd1a5949ad8f966e"),
("modules/field_ui/field_ui.test","ded58a83a37cf111834f68fde9c34cddc7f4d36b91f31281e41ed5220c65dac4"),
("modules/file/tests/file.test","e255648f4178ad702f1f0017d19679a30b2a1ac95c0ef0f9174579cdfdc04b38"),
("modules/filter/filter.test","268488be9d8e6a4bfa906bbb5bbf1f0df5881c04a421cbefcd7aa4f05fb63ba0"),
("modules/help/help.test","bc934de8c71bd9874a05ccb5e8f927f4c227b3b2397d739e8504c8fd6ae5a83c"),
("modules/image/image.test","3f07aff7b581be787d8ee4bea178c1b416d24906be99a3afb894154f1da801d8"),
("modules/menu/menu.test","51817d6c591c28cf268145c2d39b41f66e453edf42c86472e61b7081da1d86bb"),
("modules/node/node.module","70f969229d03819dba439546ae7aef30283b93e410af1b45f5a25b90d3cb8edd"),
("modules/node/node.test","b08b445f7580848468bf2b2822ae378074e05246b006e0bf56f4fb0e7c9feb70"),
("modules/path/path.test","2004183b2c7c86028bf78c519c6a7afc4397a8267874462b0c2b49b0f8c20322"),
("modules/rdf/rdf.test","9849d2b717119aa6b5f1496929e7ac7c9c0a6e98486b66f3876bda0a8c165525"),
("modules/search/search.extender.inc","013a6a841cc48a6dc991153fb692b8d1546e56b78d9c95e97e0d7e92296d3481"),
("modules/search/search.test","84e3939f935d661ecc856549719dae35c6eb8825f4540454cf78774a87d5d85b"),
("modules/shortcut/shortcut.test","0d78280d4d0a05aa772218e45911552e39611ca9c258b9dd436307914ac3f254"),
("modules/system/system.archiver.inc","faa849f3e646a910ab82fd6c8bbf0a4e6b8c60725d7ba81ec0556bd716616cd1"),
("modules/system/system.mail.inc","d31e1769f5defbe5f27dc68f641ab80fb8d3de92f6e895f4c654ec05fc7e5f0f");
INSERT INTO registry_file VALUES
("modules/system/system.queue.inc","a60cff401fc410cd81dc1d105ed66f79396ed7b15fdc3a5c5b80593ad5d4352a"),
("modules/system/system.tar.inc","d0d2f191d79b3227852e7436908386bdd7a25f78c73f3c8bf9ef5903892ae993"),
("modules/system/system.test","a8b6d3a8f11944af3e947ac53b8ad4cd37f1af11256e12768c7c24b9b4052711"),
("modules/system/system.updater.inc","338cf14cb691ba16ee551b3b9e0fa4f579a2f25c964130658236726d17563b6a"),
("modules/taxonomy/taxonomy.module","9ab4bfec327be23de5833fcedf12b935fd8739851a53acf931422c293994998b"),
("modules/taxonomy/taxonomy.test","8525035816906e327ad48bd48bb071597f4c58368a692bcec401299a86699e6e"),
("modules/update/update.test","1ea3e22bd4d47afb8b2799057cdbdfbb57ce09013d9d5f2de7e61ef9c2ebc72d"),
("modules/user/user.module","13943197697f7a8ebee75246e4fcd6f8a5bf92e1f2ad9fb2066f3ff27d769c82"),
("modules/user/user.test","5bb03ec7ffec6eac7df049115b6c3c64558e9d6fbb4a084ba86999db02177f46"),
("sites/all/modules/ctools/includes/context.inc","4cec11a71872eb916c4315c9f727a184d46758aa64bb950d86877a60b9007157"),
("sites/all/modules/ctools/includes/css-cache.inc","db90ff67669d9fa445e91074ac67fb97cdb191a19e68d42744f0fd4158649cfa"),
("sites/all/modules/ctools/includes/math-expr.inc","601db581743dd22d67f7aaf228bd8d26298d72033fc675d02385a1fd6d31888f"),
("sites/all/modules/ctools/includes/stylizer.inc","3f91f5ed42fb6ee1b65ddef7ac22577b07a5d75ca1eb2df60041243ced5c7079"),
("sites/all/modules/ctools/plugins/export_ui/ctools_export_ui.class.php","2fd87a7d80689e4d44673b31c07b762144eb8ac57324fd0b9cd9ede5f4ea34b5"),
("sites/all/modules/ctools/tests/css_cache.test","0dbc038efedb1fa06d2617b7c72b3a45d6ee5b5b791dcb1134876f174a2a7733"),
("sites/all/modules/globalredirect/globalredirect.test","8ed85e68dd69614fe283b719f1833437a85d80121ffc44f4243f8269e3489a29"),
("sites/all/modules/memcache/memcache.inc","ab14cf6170e9d1122cfaf2205c2ce064b3cae9eb7e4f23509ffcf323cce2ede0"),
("sites/all/modules/memcache/tests/memcache-lock.test","db8644e50838306bc8f969c71a02735bafde361435ae0dfe491c1bc3035f4839"),
("sites/all/modules/memcache/tests/memcache-session.test","13f9f958b927b13ad1b08a4ac2d68e115f2af74a5eb2dd69d72860d0cad095ac"),
("sites/all/modules/memcache/tests/memcache.test","3f533eb03321ddde3fb7aba795b4b18a67dcea9ff6d5e1c49a2cac4dd8223a13"),
("sites/all/modules/metatag/metatag.inc","6d0d094edcf5204bdb177793e0164eaa2fbc18b118fd93fc6ef09af461891731"),
("sites/all/modules/metatag/metatag.migrate.inc","6908826a4e8b4779af7611c7c2c7b65b19f00b9f37d0a671b7b1e935a944400d"),
("sites/all/modules/metatag/metatag.search_api.inc","1944b0b73c14c1ec1c7e188cf1785b9aca9983907a331f3c68468cb35f018f16"),
("sites/all/modules/metatag/tests/metatag.core_tag_removal.test","3448dab54155324e7c05be224d8561eb1e50126e2746febbe4350b0e3fb59457"),
("sites/all/modules/metatag/tests/metatag.helper.test","e79874878d2d635b1a41e7140abd0519b914672087a0de30b601e1b7ade3f0a2"),
("sites/all/modules/metatag/tests/metatag.image.test","46471fde33f535e835779c198f8a4fef4414e70aa747e66a3c0baf37f53ad669"),
("sites/all/modules/metatag/tests/metatag.locale.test","6a230fb6551f34eeb03dcbbe4accab3999fd529d5fb0e302c371b3045fc8f3e2"),
("sites/all/modules/metatag/tests/metatag.node.test","e5e25fbd998c5c810a6af17f1ff91785943eb8ae65e1004c9c4f83e9fcf9d3d3"),
("sites/all/modules/metatag/tests/metatag.string_handling.test","e62815ae38c029cce0185b3eb07b96bbc2a32dc9d325795666d66b6e6d450995"),
("sites/all/modules/metatag/tests/metatag.string_handling_with_i18n.test","c9179090cdf7386c835ce3d4ca2d77e0db3a090cba448abf4a13dca983e27b99"),
("sites/all/modules/metatag/tests/metatag.term.test","66a616176ed8dc5bcf9f7b68ee43f2d8cb5ece1281bacef0014a3819c2121449"),
("sites/all/modules/metatag/tests/metatag.unit.test","e47127ae7ccfc2da9cad211769e0712d8afa2bfa3d2efe03a847fc05f034166c"),
("sites/all/modules/metatag/tests/metatag.user.test","434d432914d627b69ddbf3bffa1a4922d4d67d794d0333c8bd0af91abe9c0793"),
("sites/all/modules/metatag/tests/metatag.with_i18n_config.test","5325794154abf448a94ad5801f1a3cccd45d4c521c26de46d787bcf8bb0bebe4"),
("sites/all/modules/metatag/tests/metatag.with_i18n_disabled.test","15d999e13f890f67a4f8eeb4cb9066b68c87e8286802bc7ff3f8832b73e01f47"),
("sites/all/modules/metatag/tests/metatag.with_i18n_node.test","3d973bd083957fcd1510cbdd345146328c884dd1c858d8cc636623d3ca6e5be2"),
("sites/all/modules/metatag/tests/metatag.with_i18n_output.test","10fa81fc9243bc496fc57c8c47d8de133eb80f1423cfc15d8ec43dc613adad5f"),
("sites/all/modules/metatag/tests/metatag.with_media.test","2801bfa1763f96ec3bcd113803039c98748851bb77602da30bc6778c3ee1e56a"),
("sites/all/modules/metatag/tests/metatag.with_panels.test","a0bb04ea42b27a18facd38180171612e700d9ad9fd0ca701da0701124058f87b"),
("sites/all/modules/metatag/tests/metatag.with_profile2.test","d86eb0dcd467969a60be453837bfd64e2652023484ce6141806fd0e5d459014e"),
("sites/all/modules/metatag/tests/metatag.with_search_api.test","48f1638b34fe98f462931f4a900d9fb9acd9246c7a589e5c143dc04027daf771"),
("sites/all/modules/metatag/tests/metatag.with_views.test","c596027f38b0655f9ca043a70d514bc7a60bc967742fe7910f47dc668ac38233"),
("sites/all/modules/page_title/page_title.admin.inc","e0405d6c699886e8ef74f3f1f70a6fa07dfbb91c791073064e04b1634ddaf0c9"),
("sites/all/modules/page_title/page_title.module","6b505a0178f0dbbb9ad989fde671ed75f4bd885752d130573ed3e1288a552d1c"),
("sites/all/modules/page_title/page_title.test","3ebd9f71ba6ce3db7619876dc81f0a44f27131ece009fe1c2cdac2e488cfd9cc"),
("sites/all/modules/page_title/page_title.tokens.inc","af90f0e9fdb445d95a52c0785e62f21592763de65af52ebeeb9f99f81b28a9c7"),
("sites/all/modules/page_title/views/plugins/page_title_plugin_display_page_with_page_title.inc","32ed1e558e859d4601c8803302757708f902fbd9897f01e084b14b7a3c5a9262"),
("sites/all/modules/page_title/views_handler_field_node_page_title.inc","c5d7604cc3d5ceb9e74c92b53d4f4f3872f79e8d324d64640a250418c565497f"),
("sites/all/modules/pathauto/pathauto.migrate.inc","31084f25620be5620aecf9d60356dba662b6eda426c0c94ba996821110e4b1cc"),
("sites/all/modules/pathauto/pathauto.test","1297560df48bad9b325d775d3bc64a411c03a0fd630c5e53ff8e46c4550a6977"),
("sites/all/modules/redirect/redirect.controller.inc","ad0557fee4dc80a22f6c019fa8e0c1eb151601e4b4df9ca7153fc84b4c89316c"),
("sites/all/modules/redirect/redirect.test","030818b1156655e42398bd8afdbb3bdd35d9fe2ead0ecc509a190a07581c7b74"),
("sites/all/modules/redirect/views/redirect.views.inc","7ac6fcf5c81e69d27658182279b0484f0cf6e1283001848214fb9a7bc032d00e"),
("sites/all/modules/redirect/views/redirect_handler_field_redirect_link_delete.inc","604f94a85db5739da0b24b1eb4a912499adf86417596ab0b122f4dc2ce61541a"),
("sites/all/modules/redirect/views/redirect_handler_field_redirect_link_edit.inc","4bb451856045c2c93228860f7caed0273ec24457c851ffd00b87ab0f18ec5ce3"),
("sites/all/modules/redirect/views/redirect_handler_field_redirect_operations.inc","b4ba11ebbb6ae9dc8501dd5e0975d09eaa073d1d87d788805d1173e731c7202c"),
("sites/all/modules/redirect/views/redirect_handler_field_redirect_redirect.inc","b871087b4d70edae7c2c84556da61e7d8497b5f176d4b3b457ebfac4ec87ae57"),
("sites/all/modules/redirect/views/redirect_handler_field_redirect_source.inc","53bfa76d77e12613028960fc1dc273aa6e8bbc88503c8d246232456916a5e848"),
("sites/all/modules/redirect/views/redirect_handler_filter_redirect_type.inc","7d18f17511ed08f8c5ea401e2cc3ac430021dd1520c11f06cdae2ad56bcf18b4"),
("sites/all/modules/search404/search404.install","3b2df3ac62c32a0f88a0392c14476b5ecffd52545ada89ee58359ab22fa229a3"),
("sites/all/modules/search404/search404.module","245fa211c4fbf62c76ad041ac52c7c444ff5b4ed8b90ddadbf439e2555974437"),
("sites/all/modules/securepages/securepages.test","ac83e6ca58ad2e6c53a130eb02f37ad44eaa5e2e9f0d83511371f4f829aade5d"),
("sites/all/modules/sendgrid_integration/inc/sendgrid.mail.inc","86c8753bc805d45682aee6ad7a460b37e458de832e8c3871a0ff2fc7c9b2f3f9"),
("sites/all/modules/sendgrid_integration/tests/sendgrid_integration.mail_test.test","1ba332808719a0e3e8f83d2238c3e9c377b4b641882034d0784da68d84fc2926"),
("sites/all/modules/sendgrid_integration/tests/sendgrid_integration.test","cdb4c8c0feac418bfe1d3483c3c4dfba6a9ec79f41903ebddb6f275923ff69dc"),
("sites/all/modules/token/token.test","79c44cc6bb46caa41eaf371df9c77d7ef98bbee7d96c04ca1039375dc6674961"),
("sites/all/modules/views/handlers/views_handler_area.inc","95d4374c805c057c9855304ded14ce316cdee8aca0744120a74400e2a8173fae"),
("sites/all/modules/views/handlers/views_handler_area_messages.inc","de94f83a65b47d55bbb4949fcf93dd4ad628a4a105cea2b47cdc22593f3e5925"),
("sites/all/modules/views/handlers/views_handler_area_result.inc","836747c024cc153ec4516737da0c42a864eb708e0b77d2f8ba606411c57356a2"),
("sites/all/modules/views/handlers/views_handler_area_text.inc","531d0ac3b64206970593762df0abac60524f607253c3af876dd66ba747786dce"),
("sites/all/modules/views/handlers/views_handler_area_text_custom.inc","35b702060c192b0adf6601ed437d0a02effd3accb71c07d6156013c8be9d5a15"),
("sites/all/modules/views/handlers/views_handler_area_view.inc","e604b5716d9ea202ab0b8e51d2bd0a4a8eeab461db0a74bf37745d6cbba25c41"),
("sites/all/modules/views/handlers/views_handler_argument.inc","1f0498d1878e331f59b9f0cc87b67df330437c736e565a05fe1a14ab65ec3f26"),
("sites/all/modules/views/handlers/views_handler_argument_date.inc","1b423d5a437bbd8ed97d0bfb69c635d36f15114699a7bc0056568cc87937477d"),
("sites/all/modules/views/handlers/views_handler_argument_formula.inc","5a29748494a7e1c37606224de0c3cac45566efe057e4748b6676a898ac224a61"),
("sites/all/modules/views/handlers/views_handler_argument_group_by_numeric.inc","b8d29f27592448b63f15138510128203d726590daef56cf153a09407c90ec481"),
("sites/all/modules/views/handlers/views_handler_argument_many_to_one.inc","b2de259c2d00fe7ed04eb5d45eb5107ce60535dd0275823883cc29b04d1a3974"),
("sites/all/modules/views/handlers/views_handler_argument_null.inc","26699660fd0915ec078d7eb35a93ef39fd53e3a2a4841c0ac5dbf0bb02207bee"),
("sites/all/modules/views/handlers/views_handler_argument_numeric.inc","ae23d847fa0f1e92baec32665a8894e26660999e338bebffb49ee42daac5a063"),
("sites/all/modules/views/handlers/views_handler_argument_string.inc","f8fe4daf0a636cc93d520a0d5ff212840d8bdaa704ddc3c59a24667f341ed3a1"),
("sites/all/modules/views/handlers/views_handler_field.inc","3d059d737e738436a15651f9ac8374f460a71eb569619ba0a8a14a55a3efc87e"),
("sites/all/modules/views/handlers/views_handler_field_boolean.inc","dc00b916a223935e05f51d94a2dffbaf430b162517072f7c2122332af41e8fc2"),
("sites/all/modules/views/handlers/views_handler_field_contextual_links.inc","2f54701c9f71a4a525e724a6787b5e0089a3c38e426d1925bf8344d017d571bf"),
("sites/all/modules/views/handlers/views_handler_field_counter.inc","865a5ad7df830dae9e167709446e66cebf3e32e91ec05b5c2b887c96d0d6b0d8"),
("sites/all/modules/views/handlers/views_handler_field_ctools_dropdown.inc","a78c424ef884ae9878c0b140d532bdf3b116fdc0e8a7cd519848c675d5b1a5a6"),
("sites/all/modules/views/handlers/views_handler_field_custom.inc","a3d25fc20401ae0a1af4b7d6e83376a5b7dc18ab0aed17a3c6d81e2314cf19f8"),
("sites/all/modules/views/handlers/views_handler_field_date.inc","79cb6583981104d70d20393fe62281c749680f375cb67355635ef00688258934"),
("sites/all/modules/views/handlers/views_handler_field_entity.inc","909ab36aff896ad8fa4306d95a052172ec27e471ab385a035fcadef8d019e0f9"),
("sites/all/modules/views/handlers/views_handler_field_links.inc","331a7c8e68a9a94a41a0d7e3e2b6a5c8436792cf244b409ffd732f9cbbab3642"),
("sites/all/modules/views/handlers/views_handler_field_machine_name.inc","df2fe47cf9c6d2e7de8627c08da809fb60883c38697340966f303c223e22aee4"),
("sites/all/modules/views/handlers/views_handler_field_markup.inc","a0c652fdf47f7efe35bbf2371f00e230409fe90ea0038eb101bf0c93ae0718e9"),
("sites/all/modules/views/handlers/views_handler_field_math.inc","08c9fb88b20ca346ee3dc29773b2341ea294ba85b659dbd8c1cc92a9ddf900e8"),
("sites/all/modules/views/handlers/views_handler_field_numeric.inc","1e36f9d55b4cfeb268068e5c9bd6f326999c04191485d3db4610e94e6f57fad9"),
("sites/all/modules/views/handlers/views_handler_field_prerender_list.inc","0fe605bf457886fbca5f041a422fc51c6a1927654dcd06cbfc619496fe57de0e"),
("sites/all/modules/views/handlers/views_handler_field_serialized.inc","ad3d82a9f37ae4c71a875526c353839da2ff529351efc7861f8b7c9d4b5a47db"),
("sites/all/modules/views/handlers/views_handler_field_time_interval.inc","280d569784312d19dabfb7aeb94639442ae37e16cba02659a8251de08a4f1de2"),
("sites/all/modules/views/handlers/views_handler_field_url.inc","7ca57a8dcc42a3d1e7e7ec5defa64a689cb678073e15153ff6a7cafe54c90249"),
("sites/all/modules/views/handlers/views_handler_filter.inc","b21fbc12bf620db26d391ac0f9e12f5076bbd188c8086c593187365d70bb2861"),
("sites/all/modules/views/handlers/views_handler_filter_boolean_operator.inc","f4ca59e4e1f91f219a1b33690a4ad412269946804fe7cacf24f2574b2c6d8599"),
("sites/all/modules/views/handlers/views_handler_filter_boolean_operator_string.inc","0ddd32cda535112c187de1c062797849ff90d9b312a8659056e76d2d209f694a");
INSERT INTO registry_file VALUES
("sites/all/modules/views/handlers/views_handler_filter_combine.inc","802f033bba6a9965896b02e3c3e0ea4493e4be282f2c5444ebbeec7e8a478072"),
("sites/all/modules/views/handlers/views_handler_filter_date.inc","fb63877ecfa64f2be8557a21dcf34e28b59c4a9c5f561f55738162d2301c4aa1"),
("sites/all/modules/views/handlers/views_handler_filter_entity_bundle.inc","02db977a67a09f70bdc8e2bbc46a05fff8a6d8bd6423308c95418476e84714a3"),
("sites/all/modules/views/handlers/views_handler_filter_equality.inc","2100cdd7f5232348adae494c5122ba41ff051eee0a8cc14aeaf6a66202cb7ed1"),
("sites/all/modules/views/handlers/views_handler_filter_fields_compare.inc","e116c3796f1bd409b150f5ab896b9bab956d6e71a82e5770ed6fde44605751b2"),
("sites/all/modules/views/handlers/views_handler_filter_group_by_numeric.inc","9401c4c0fe0d678898e5288ef8152784a12e0743df21dec15457353eb2cdb01d"),
("sites/all/modules/views/handlers/views_handler_filter_in_operator.inc","8fd7f075468bddde5c4208b1c3a6105f8fea0ac0c214452a37c00fc2f3453a7d"),
("sites/all/modules/views/handlers/views_handler_filter_many_to_one.inc","b4a415c2824195d3d7d0e37ada9d69ebec0b9cd833ebcac2439efc20aac15595"),
("sites/all/modules/views/handlers/views_handler_filter_numeric.inc","8a999227d17674a70381ab8b45fbdc91269a83a45e5f7514607ed8b4a5bf6a9f"),
("sites/all/modules/views/handlers/views_handler_filter_string.inc","140006335ac5b19b6253b431afde624db70385b9d22390b8c275296ae469cc7b"),
("sites/all/modules/views/handlers/views_handler_relationship.inc","4fefdb6c9c48b72dcfe86484123b97eb5f5b90b6a440d8026d71f74dccbd1cd6"),
("sites/all/modules/views/handlers/views_handler_relationship_groupwise_max.inc","47dcfe351159b10153697c17b3a92607edb34a258ba3b44087c947b9cc88e86f"),
("sites/all/modules/views/handlers/views_handler_sort.inc","06aab8d75f3dce81eb032128b8f755bfff752dcefc2e5d494b137bca161fdefa"),
("sites/all/modules/views/handlers/views_handler_sort_date.inc","d7e771abf74585bd09cc8e666747a093f40848b451de8ba67c8158317946f1b2"),
("sites/all/modules/views/handlers/views_handler_sort_group_by_numeric.inc","4ba1c38c9af32789a951b8f9377e13631ae26bf1dac3371b31a37ead25b32eb8"),
("sites/all/modules/views/handlers/views_handler_sort_menu_hierarchy.inc","ccd65ea3b3270366b7175e2cd7cc9167a09c27e1486949e4a05495ff5c7be5c1"),
("sites/all/modules/views/handlers/views_handler_sort_random.inc","05a00c3bf76c3278ae0ce39a206a6224089faf5ac4a00dd5b8a558f06fab8e46"),
("sites/all/modules/views/includes/base.inc","5ad8155dbc31cc4460b65747d99b70a64a83f6fefa00231c8d965293a7a183ee"),
("sites/all/modules/views/includes/handlers.inc","2f1a8ab8dad27856cf7fc14ef59314ded0722dfe06152bd8a8bd7caaea363518"),
("sites/all/modules/views/includes/plugins.inc","11c03b1c69be7e9969ec0665b07ddfe170c9505f8d4e862cb27f1232a2a4240e"),
("sites/all/modules/views/includes/view.inc","c11ed134250ed074b7ac2ed21d6ae28ba84ec663407dc4ceebcf15b078ce69ce"),
("sites/all/modules/views/modules/aggregator/views_handler_argument_aggregator_category_cid.inc","97acf41d6694fd4451909c18b118f482db9f39aa4b8c5cfa75d044d410c46012"),
("sites/all/modules/views/modules/aggregator/views_handler_argument_aggregator_fid.inc","c37def91d635b01db36809141d147d263cc910895e11c05e73d703e86b39fd43"),
("sites/all/modules/views/modules/aggregator/views_handler_argument_aggregator_iid.inc","344f2806344d9c6356f2e19d297522f53bab7a4cebdf23c76d04c85c9e0a0d8e"),
("sites/all/modules/views/modules/aggregator/views_handler_field_aggregator_category.inc","252b30b832d8c0097d6878f5d56beecfc8cc1fc7cc8b5a4670d8d95a80b4f17d"),
("sites/all/modules/views/modules/aggregator/views_handler_field_aggregator_title_link.inc","1bb18967b11f2f4de62075d27e483f175b5e3431622c2e5e8292afcd000beadf"),
("sites/all/modules/views/modules/aggregator/views_handler_field_aggregator_xss.inc","2db2e1f0500e0a252c7367e6a92906870b3247f9d424f999c381368ee2c76597"),
("sites/all/modules/views/modules/aggregator/views_handler_filter_aggregator_category_cid.inc","7c7c0690c836ac1b75bca3433aca587b79aec3e7d072ce97dc9b33a35780ad4f"),
("sites/all/modules/views/modules/aggregator/views_plugin_row_aggregator_rss.inc","591e5bb7272e389fe5fc2b563f8887dbc3674811ffbb41333d36a7a9a1859e56"),
("sites/all/modules/views/modules/book/views_plugin_argument_default_book_root.inc","bd3bd9496bf519b1688cf39396f3afa495a29c8190a3e173c0740f4d20606a53"),
("sites/all/modules/views/modules/comment/views_handler_argument_comment_user_uid.inc","5e29f7523010a074bda7c619b24c5d31e0c060cdbe47136b8b16b2f198ed4b4a"),
("sites/all/modules/views/modules/comment/views_handler_field_comment.inc","a126d690cc5bf8491cb4bee4cc8237b90e86768bebbbecb8a9409a3c1e00fa9e"),
("sites/all/modules/views/modules/comment/views_handler_field_comment_depth.inc","1dc353a31d3c71c67d0b3e6854d9e767e421010fbbf6a8b04a14035e5f7c097f"),
("sites/all/modules/views/modules/comment/views_handler_field_comment_link.inc","1f7382f7cb05c65a7cba44e4cd58022bbc6ce5597b96228d1891d7720510bf0e"),
("sites/all/modules/views/modules/comment/views_handler_field_comment_link_approve.inc","f6db8a0b4dd9fffba9d8ecb7b7363ba99d3b2dc7176436a0a6dd7a93195a5789"),
("sites/all/modules/views/modules/comment/views_handler_field_comment_link_delete.inc","905a4cb1f91a4b40ee1ca1d1ded9958ae18e82286589fec100adb676769b1fe9"),
("sites/all/modules/views/modules/comment/views_handler_field_comment_link_edit.inc","8139c932cde20f366a3019111c054b1ed00dbc0c40634b91239b400243b7723a"),
("sites/all/modules/views/modules/comment/views_handler_field_comment_link_reply.inc","8807884efb840407696c909b9d5d07f60bde9d7f385a59eca214178ce5369558"),
("sites/all/modules/views/modules/comment/views_handler_field_comment_node_link.inc","64746ff2b80a5f8e83b996a325c3d5c8393934c331510b93d5815ea11c1db162"),
("sites/all/modules/views/modules/comment/views_handler_field_comment_username.inc","1ce3fa61b3933a3e15466760e4c5d4a85407ba4c8753422b766fc04395fa4d02"),
("sites/all/modules/views/modules/comment/views_handler_field_last_comment_timestamp.inc","30c55ec6d55bf4928b757f2a236aab56d34a8e6955944a1471e9d7b7aed057c0"),
("sites/all/modules/views/modules/comment/views_handler_field_ncs_last_comment_name.inc","82025f3ad22b63abc57172d358b3f975006109802f4a5ecac93ce3785c505cae"),
("sites/all/modules/views/modules/comment/views_handler_field_ncs_last_updated.inc","facfbc5defd843f4dfb60e645f09a784234d87876628c8de98d2dfa6bb98a895"),
("sites/all/modules/views/modules/comment/views_handler_field_node_comment.inc","0cf9e8fb416dca35c3b9df3125eb3a8585f798c6a8f8d0e1034b1fccb5cec38b"),
("sites/all/modules/views/modules/comment/views_handler_field_node_new_comments.inc","e0830d1f70dea473e46ab2b86e380ef741b2907f033777889f812f46989f2ff7"),
("sites/all/modules/views/modules/comment/views_handler_filter_comment_user_uid.inc","f526c2c4153b28d7b144054828261ba7b26566169350477cd4fb3f5b5f280719"),
("sites/all/modules/views/modules/comment/views_handler_filter_ncs_last_updated.inc","9369675dfee24891fe19bddf85a847c275b8127949c55112ae5cb4d422977d24"),
("sites/all/modules/views/modules/comment/views_handler_filter_node_comment.inc","70706c47bad9180c2426005da6c178ed8d27b75b28cb797ca2a1925a96dcef09"),
("sites/all/modules/views/modules/comment/views_handler_sort_comment_thread.inc","a64bc780cba372bd408f08a5ea9289cdf3d40562bdf2f7320657be9a9f6c7882"),
("sites/all/modules/views/modules/comment/views_handler_sort_ncs_last_comment_name.inc","9f039e8b8a046c058fda620804e3503be7b3e7e3e4119f0b015ccbae0922635b"),
("sites/all/modules/views/modules/comment/views_handler_sort_ncs_last_updated.inc","fa8b9c3614ad5838aa40194940d9dc6935175a16e141ac919f40e74a7428c4e3"),
("sites/all/modules/views/modules/comment/views_plugin_row_comment_rss.inc","96f651234e30a3aff805ae9a524c99813a286bf75b5a9fd8da2d7d4fbec50810"),
("sites/all/modules/views/modules/comment/views_plugin_row_comment_view.inc","82d7296fa3109ca170f66f6f3b5e1209af98a9519bb5e4a2c42d9fc0e95d7078"),
("sites/all/modules/views/modules/contact/views_handler_field_contact_link.inc","ec783b215a06c89c0933107a580c144051118305dd0129ac28a7fea5f95a8fd5"),
("sites/all/modules/views/modules/field/views_handler_argument_field_list.inc","eff5152a2c120425a2a75fe7dbcb49ed86e5d48392b0f45b49c2e7abee9fa72b"),
("sites/all/modules/views/modules/field/views_handler_argument_field_list_string.inc","534af91d92da7a622580ab8b262f9ef76241671a5185f30ba81898806c7b7f15"),
("sites/all/modules/views/modules/field/views_handler_field_field.inc","94ff7382dba773fc637c777e20b810ae7d4aa4936fb0bc067e6a3824ba929d2d"),
("sites/all/modules/views/modules/field/views_handler_filter_field_list.inc","3b55cd0a14453c95ebd534507ab842a8505496d0b7e4c7fcd61c186034c7322d"),
("sites/all/modules/views/modules/field/views_handler_filter_field_list_boolean.inc","d33035e141ca686b3f18da1e97adaa1ff8e5d1db266340d3030e873a744685e2"),
("sites/all/modules/views/modules/field/views_handler_relationship_entity_reverse.inc","060035c5430c81671e4541bcf7de833c8a1eb3fa3f3a9db94dd3cebfa4299ef1"),
("sites/all/modules/views/modules/filter/views_handler_field_filter_format_name.inc","fc3f074ffb39822182783a8d5cf2b89ffcc097ccbb2ed15818a72a99e3a18468"),
("sites/all/modules/views/modules/locale/views_handler_argument_locale_group.inc","c8545411096da40f48eef8ec59391f4729c884079482e3e5b3cdd5578a1f9ad7"),
("sites/all/modules/views/modules/locale/views_handler_argument_locale_language.inc","a1b6505bb26e4b3abce543b9097cd0a7b8cddf00bf1e49fbba86febebb0f4486"),
("sites/all/modules/views/modules/locale/views_handler_field_locale_group.inc","5b62afe18f92ee4a5fb49eb0995e65b4744bbe3b9c24ffe8f6c21f3191c04afc"),
("sites/all/modules/views/modules/locale/views_handler_field_locale_language.inc","0cc08bd2d42e07f26e7acc92642b36f0ac62bf23ee9ba3fd21e6cab9a80e9f72"),
("sites/all/modules/views/modules/locale/views_handler_field_locale_link_edit.inc","3883d3f37030d6d8e397e79ccb99ec3cb715ba7a789510f4b79b7515e314e7ae"),
("sites/all/modules/views/modules/locale/views_handler_field_node_language.inc","a6ccdb6c1c4df3b4fd31b714f5aa4ac99771ffce63439d6c5de6c0ae2f09a2c1"),
("sites/all/modules/views/modules/locale/views_handler_filter_locale_group.inc","40fbc041bab64f336f59d1e0593f184b879b2a0c9e2a6050709bdc54cceb2716"),
("sites/all/modules/views/modules/locale/views_handler_filter_locale_language.inc","3433893d988aad36b918dd6214f5258b701506bc9c0c6a72fd854a036b635e20"),
("sites/all/modules/views/modules/locale/views_handler_filter_locale_version.inc","9337ea5216784ffc67a0aa45c946e65ad11fc40849189cc70911a81366b78620"),
("sites/all/modules/views/modules/locale/views_handler_filter_node_language.inc","d7edea3f35891cc76aa3bb185b9c1404378623ea7fd214c2a1f0d824df12779a"),
("sites/all/modules/views/modules/locale/views_handler_sort_node_language.inc","b7b70efcf7de1f4dee4722ac8aa16031f17d62e60b1b5772f9985cadf91e4415"),
("sites/all/modules/views/modules/node/views_handler_argument_dates_various.inc","d2c17e6ec3d221bdd0d1c060da4b0c85274c8ac5a0b624b1469b162694a8d0f5"),
("sites/all/modules/views/modules/node/views_handler_argument_node_language.inc","7ee3ba02bddaa6aeef9961cdf6af7bb386fc2b12529f095b28520bb98af51775"),
("sites/all/modules/views/modules/node/views_handler_argument_node_nid.inc","11c5b62413ffd1b2c66d4b60a2fe21cf6eb839ae40d4ef81c7a938c5be3e30de"),
("sites/all/modules/views/modules/node/views_handler_argument_node_type.inc","9e21b4cc4ae861f58c804ea7e2c17fbc5dd2a7938b9abfeb54437b531fc95e6e"),
("sites/all/modules/views/modules/node/views_handler_argument_node_uid_revision.inc","675c99f8da9748ac507e202f546914bee3ed4065f6ce83a23a2aaafdaefd084e"),
("sites/all/modules/views/modules/node/views_handler_argument_node_vid.inc","7e5da5594a336c1d0f4cf080ab3fcd690e0de1ee6b5e1830b5fb76a46bced19c"),
("sites/all/modules/views/modules/node/views_handler_field_history_user_timestamp.inc","7d6d9c8273d317ab908d4873a32086dbd5f78a2b2d07b7ed79975841a2cadea6"),
("sites/all/modules/views/modules/node/views_handler_field_node.inc","99a0ef52b68e8913eb3563d5c47097c09e46c6493fcb006f383c6f6798edb7fc"),
("sites/all/modules/views/modules/node/views_handler_field_node_link.inc","26d8309a3a9140682d7d90e4d16ff664a3d7ce662af6ccbf75dc4c493515d7d9"),
("sites/all/modules/views/modules/node/views_handler_field_node_link_delete.inc","3eeed8c9ffc088ee28b8ffaa5e2b084db24284acc4d1b2e69f90c96cc889016d"),
("sites/all/modules/views/modules/node/views_handler_field_node_link_edit.inc","28f8c3b7d3d60c31fec3cdf81c84cfbb20f492220457694a0e150c3ddee030c0"),
("sites/all/modules/views/modules/node/views_handler_field_node_path.inc","f392fde21e434fd40fc672546ef684780179d91827350ba9c348bb1cc5924727"),
("sites/all/modules/views/modules/node/views_handler_field_node_revision.inc","3f510d58acaa8f844292b86c388cb1e78eac8c732bb5e7c9e92439c425710240"),
("sites/all/modules/views/modules/node/views_handler_field_node_revision_link.inc","ace72f296cf4a4da4b7dd7b303532aebf93b6b1c18a5d30b51b65738475e3889"),
("sites/all/modules/views/modules/node/views_handler_field_node_revision_link_delete.inc","0a36602f080c4ef2bb5cb7dbddc5533deab7743c2fbf3bd88b9e478432cac7fb"),
("sites/all/modules/views/modules/node/views_handler_field_node_revision_link_revert.inc","80ddc7f0c001fde9af491bb22d6044b85324fe90bea611fc3822408fd60008fa"),
("sites/all/modules/views/modules/node/views_handler_field_node_type.inc","f8f39c6f238f837270d1b2e42e67bf9ab400a37fe24246c8b86dfcfacc1c4fd9"),
("sites/all/modules/views/modules/node/views_handler_field_node_version_count.inc","1298f7f7ee4b6e6e2957b266fbb7c63e102b9d7e9ccca8d5a86592736bce9493"),
("sites/all/modules/views/modules/node/views_handler_filter_history_user_timestamp.inc","2970f270e071cad079880e9598d9f7b71d4dd2a2a42a31cd4489029a3cafe158"),
("sites/all/modules/views/modules/node/views_handler_filter_node_access.inc","ca625167c8928f1c5b354c27c120ed9b19c1df665dc3b02ed6d96b58194d6243"),
("sites/all/modules/views/modules/node/views_handler_filter_node_status.inc","f7099a59d3f237f2870ecb6b0b5e49dd9d785b1085e94baf55687251e7f3231b"),
("sites/all/modules/views/modules/node/views_handler_filter_node_type.inc","6842082e7b6e131d6e002e627e6b4490b93ca6ffe7fc0b158d31843217c8c929"),
("sites/all/modules/views/modules/node/views_handler_filter_node_uid_revision.inc","2cfe9ba95e5ea8c240a57cfa1bed58385cbfed0c7f35e3d8c4da6d873b5a61fa"),
("sites/all/modules/views/modules/node/views_handler_filter_node_version_count.inc","de61f3547604e5905486cdae5f5e94d1a45bdac4d3c43157193dd6fe0dd6473c"),
("sites/all/modules/views/modules/node/views_handler_sort_node_version_count.inc","ce2a392319ebed3dbb2b660f3d6f4c6690b1cd46cf6b1c01802f12158114c4c4"),
("sites/all/modules/views/modules/node/views_plugin_argument_default_node.inc","7fb79c8f4adb9bcef7c7da4bf4046fe3490e16c244f6ab96fdca97a8567315ff"),
("sites/all/modules/views/modules/node/views_plugin_argument_validate_node.inc","f10d3f4081eed5ca32c41b67e9a0e6f35b2f8ba2cd7897230cb5a680b410a6de"),
("sites/all/modules/views/modules/node/views_plugin_row_node_rss.inc","1e55454684102fad08c947695c370a890a22ea22c3c9aca3207f2299aa3daf7e");
INSERT INTO registry_file VALUES
("sites/all/modules/views/modules/node/views_plugin_row_node_view.inc","713e1c83702ac2d0d7fe76374110cdfd657598a8f3b086ec2352f2de38101504"),
("sites/all/modules/views/modules/profile/views_handler_field_profile_date.inc","e206509ef8b592e602e005f6e3fa5ba8ef7222bdb5bacd0aaeea898c4001e9b0"),
("sites/all/modules/views/modules/profile/views_handler_field_profile_list.inc","da5fa527ab4bb6a1ff44cc2f9cec91cf3b094670f9e6e3884e1fedce714afe6f"),
("sites/all/modules/views/modules/profile/views_handler_filter_profile_selection.inc","758dea53760a1b655986c33d21345ac396ad41d10ddf39dd16bc7d8c68e72da7"),
("sites/all/modules/views/modules/search/views_handler_argument_search.inc","0a96f3a3201091b95a0ed3763a98ed290cdda8f10ff89b58d432d0523bbe6f83"),
("sites/all/modules/views/modules/search/views_handler_field_search_score.inc","711af637c864b775672d9f6203fc2da0902ed17404181d1117b400012aac366f"),
("sites/all/modules/views/modules/search/views_handler_filter_search.inc","5082e294639d5048e4167adcb9b2a43d0f1420e3c5c4284764fa9bc79e1f2bcc"),
("sites/all/modules/views/modules/search/views_handler_sort_search_score.inc","9d23dd6c464d486266749106caec1d10cec2da1cc3ae5f907f39056c46badbdf"),
("sites/all/modules/views/modules/search/views_plugin_row_search_view.inc","bc25864154d4df0a58bc1ac1148581c76df36267a1d18f8caee2e3e1233c8286"),
("sites/all/modules/views/modules/statistics/views_handler_field_accesslog_path.inc","7843e5f4b35f4322d673b5646e840c274f7d747f2c60c4d4e9c47e282e6db37d"),
("sites/all/modules/views/modules/statistics/views_handler_field_node_counter_timestamp.inc","a1de51345d268dc0f080104ff9ae4c9ca1f7a2dd45560a59630b2bb03bdc54c9"),
("sites/all/modules/views/modules/statistics/views_handler_field_statistics_numeric.inc","b46b6b14e14631941ac2dc9baf0b1290c148f42801f05cb419f84a2091d03e40"),
("sites/all/modules/views/modules/system/views_handler_argument_file_fid.inc","e9bf1fdf12f210f0a77774381b670c77ee88e7789971ce732b254f6be5a0e451"),
("sites/all/modules/views/modules/system/views_handler_field_file.inc","0fff4adb471c0c164a78f507b035a68d41f404ab10535f06f6c11206f39a7681"),
("sites/all/modules/views/modules/system/views_handler_field_file_extension.inc","768aa56198c7e82327391084f5dd27d7efdb8179ff6b8c941f892fe30469a0da"),
("sites/all/modules/views/modules/system/views_handler_field_file_filemime.inc","bdd7f1255f3000f7f2900341d4c4ca378244b96390ef52a30db2962d017b61a4"),
("sites/all/modules/views/modules/system/views_handler_field_file_status.inc","bfb0b9d796a4dbf95c4bb7a3deef7724bcda9e0d9067939b74ec787da934f2b0"),
("sites/all/modules/views/modules/system/views_handler_field_file_uri.inc","350d7dde27ee97cb4279360374eb8633ce7fee115a109346bea85c2c4e3a68c2"),
("sites/all/modules/views/modules/system/views_handler_filter_file_status.inc","9210a34795f9db36974525e718c91c03c28554da1199932791925d7c4a2f3b11"),
("sites/all/modules/views/modules/system/views_handler_filter_system_type.inc","d27513703a75c4d8af79b489266cf4102a36e350c3d90404dab24403ab637205"),
("sites/all/modules/views/modules/taxonomy/views_handler_argument_taxonomy.inc","8962fa76f1e03316932468b0fd805817af94726beb82bf9f4786e0c709264662"),
("sites/all/modules/views/modules/taxonomy/views_handler_argument_term_node_tid.inc","79a80284231b3bc5aab36833e8200853686784f880dc6b104552d61fc602f27c"),
("sites/all/modules/views/modules/taxonomy/views_handler_argument_term_node_tid_depth.inc","5b2806fbad4a6cc104e733a3a0faf6eb1c19975930c67c4149fb3267976e0b7d"),
("sites/all/modules/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_join.inc","ca667646f99645c00e6dfb7eb52e2f54faf848be41c99af5caf2201dcd56926b"),
("sites/all/modules/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_modifier.inc","d85ebe68290239b25fc240451655b825325854e9707cf742fbd75de81e0f1aa7"),
("sites/all/modules/views/modules/taxonomy/views_handler_argument_vocabulary_machine_name.inc","888647527bec3444b2d0a571a77900396d7c5e884bca04a2a3667a61f6377b5e"),
("sites/all/modules/views/modules/taxonomy/views_handler_argument_vocabulary_vid.inc","bf4be783ef6899f004f4dbd06c1bf2cd6dbc322678c825eec36bee81d667e81f"),
("sites/all/modules/views/modules/taxonomy/views_handler_field_taxonomy.inc","b0dd5cfa87c44b95aefd819444e4985c1773350bcf9fe073a2ef5c82b680b833"),
("sites/all/modules/views/modules/taxonomy/views_handler_field_term_link_edit.inc","3da63f6feb1fa3312853b54585d761d037dac8841b4c06e01e35463c9098064a"),
("sites/all/modules/views/modules/taxonomy/views_handler_field_term_node_tid.inc","29c5132ac98a2959405e44f9a83096b0dcfa30ed7fb4688453ca7e1fc779684b"),
("sites/all/modules/views/modules/taxonomy/views_handler_filter_term_node_tid.inc","3216febeeb3ab73ae29b77cb97b1d787394dd8cccacc32e13ab223db4fc044e9"),
("sites/all/modules/views/modules/taxonomy/views_handler_filter_term_node_tid_depth.inc","0b05ec052dcc03081e20338808dda17beb0bdf869b0cfc1375ca96cfb758c22a"),
("sites/all/modules/views/modules/taxonomy/views_handler_filter_term_node_tid_depth_join.inc","76d59ca83bdcb40493055829a9132646ed89478d7eb6e468db2d879e66e3794c"),
("sites/all/modules/views/modules/taxonomy/views_handler_filter_vocabulary_machine_name.inc","f1787b436b914cfe5ca6f2575d4c0595f4f496795711d6e8a116a39986728b0a"),
("sites/all/modules/views/modules/taxonomy/views_handler_filter_vocabulary_vid.inc","2a4d7dfbb6b795d217e2617595238f552bbea04b80217c933f1ee9978ceb7a0e"),
("sites/all/modules/views/modules/taxonomy/views_handler_relationship_node_term_data.inc","2ef7502b02b7ea435ac166274c0e7b8576ef76353fc196a26ab79e9057b6da56"),
("sites/all/modules/views/modules/taxonomy/views_plugin_argument_default_taxonomy_tid.inc","fc4c3ace525162fc922de581af0710c7d92dc355e9630040a29a5c3a6ab7f9af"),
("sites/all/modules/views/modules/taxonomy/views_plugin_argument_validate_taxonomy_term.inc","d1a7aa7ebd9c698afcdcf75b2f0affa981124064ff787ebc716bfac3ee0f60af"),
("sites/all/modules/views/modules/tracker/views_handler_argument_tracker_comment_user_uid.inc","91f5b7e9537942eee7a1798906f772cb9806eebfdc201c54fcdecf027cd71d0f"),
("sites/all/modules/views/modules/tracker/views_handler_filter_tracker_boolean_operator.inc","5efea908902052d68141017b6f29f17381e7bb8ebb6d88245471926f0a552207"),
("sites/all/modules/views/modules/tracker/views_handler_filter_tracker_comment_user_uid.inc","05e07f74d1e3978afd4c80a9b4bd72444872b84a44949a512f1d3040ce28421c"),
("sites/all/modules/views/modules/translation/views_handler_argument_node_tnid.inc","b0e3c87d3790cfa2e265f3d9700f2b3c2857932aa4b6e003e5d0114fc1b4d499"),
("sites/all/modules/views/modules/translation/views_handler_field_node_link_translate.inc","27a1ac81b50d4807d9a1eff4c5dc8929e4472f9d363f70f5391a794db73424a2"),
("sites/all/modules/views/modules/translation/views_handler_field_node_translation_link.inc","641ff25cd317bb803de2ace4bd23e8c5f5af5ba4ac38aab7be2fdc58fbb9e86a"),
("sites/all/modules/views/modules/translation/views_handler_filter_node_tnid.inc","0942fd793740e3aec032a1abb7132f53788a9cdeaeb3d931cac908ac30b73950"),
("sites/all/modules/views/modules/translation/views_handler_filter_node_tnid_child.inc","2a7a96d6caa4a99996549be0457bf40fa619731543a636d4573e55c190c64c7a"),
("sites/all/modules/views/modules/translation/views_handler_relationship_translation.inc","9137c85f5ca309d4ee0d3243c470563a5853f5926b8cbd3e843438d4308c9516"),
("sites/all/modules/views/modules/user/views_handler_argument_users_roles_rid.inc","72da80e7f3c6980da024d86f37ba3721021cc1ead2cfcc1ab9b27897b7b5077a"),
("sites/all/modules/views/modules/user/views_handler_argument_user_uid.inc","a4af1bdc1ec5e40587c22c14e839980050baaa346c9d5934ef3f01794932cdc5"),
("sites/all/modules/views/modules/user/views_handler_field_user.inc","1a2141524e43d86b52c7828fe6df61dd603ad433743c1139cfc5cc28ccb5ce74"),
("sites/all/modules/views/modules/user/views_handler_field_user_language.inc","5a3da9e08ebeebbcb5abc6a9b16e0d380c5bb5c57b608afb540a3ca6dc1b2959"),
("sites/all/modules/views/modules/user/views_handler_field_user_link.inc","5a0f35d5305a29816658385ecbd804bf43c92d4b3629fbe4bd9b8d0e9574b6ff"),
("sites/all/modules/views/modules/user/views_handler_field_user_link_cancel.inc","b865881b15ce86b5a00f2892d3fc62f40131417527211275ff9a3d09d485750b"),
("sites/all/modules/views/modules/user/views_handler_field_user_link_edit.inc","5d7c1155d9eccbd6b07c7446fe2b6a8848d6a500f508ac3779f16df56816f92b"),
("sites/all/modules/views/modules/user/views_handler_field_user_mail.inc","b7355b704f19322afb4876cea27744367e20098d4ed973e480bf2baf1ddd111c"),
("sites/all/modules/views/modules/user/views_handler_field_user_name.inc","5fd9a4d7843fee83cf529384a52d7ae69e40a9c8846e7f285e94f4bbbf8c7e29"),
("sites/all/modules/views/modules/user/views_handler_field_user_permissions.inc","ec37373524bf23ae107adda6b825570c550e6654c0f0956409fc58df2c860903"),
("sites/all/modules/views/modules/user/views_handler_field_user_picture.inc","0103d136a91fb219fd981801301b7df00adf90617900ded08efbf6d7df04959b"),
("sites/all/modules/views/modules/user/views_handler_field_user_roles.inc","ab5068c4f01a05c6511f7d4b973a77650d5b5c481d4a73f63b7a9b1ef9c0d138"),
("sites/all/modules/views/modules/user/views_handler_filter_user_current.inc","7f70b7e3b3c10e75d95f54afc9c2fe2f1af9b7a9eab2308d2961b2588dc05845"),
("sites/all/modules/views/modules/user/views_handler_filter_user_name.inc","5225e5d89051313e0e49ea833709bb4dc44369afeee970b0cfaf1818ababa22c"),
("sites/all/modules/views/modules/user/views_handler_filter_user_permissions.inc","a72e8d02c1075cebfee33e5b046460eef9193b2a7c1d47ff130457e4485b6fe5"),
("sites/all/modules/views/modules/user/views_handler_filter_user_roles.inc","3bb69fbc4e352ce8e4840ec78bdd0f1f29e8709097ce6b29cc2fedd2c74c023e"),
("sites/all/modules/views/modules/user/views_plugin_argument_default_current_user.inc","11e729115350deffe46ebfe3a55281fa169a90e38a76c3a9d98f26c87900a22b"),
("sites/all/modules/views/modules/user/views_plugin_argument_default_user.inc","fe567f009a8e20f402f104b157fd44c04d6bd886a39b2f3355104f644f905419"),
("sites/all/modules/views/modules/user/views_plugin_argument_validate_user.inc","40d623b0a678fa7c292da92582f06449d0396341ab161069f0fe8d1086ab95da"),
("sites/all/modules/views/modules/user/views_plugin_row_user_view.inc","52548cca3f18d25b06cfce15ee00acea530b85bd22a10944d984b5a798c5969f"),
("sites/all/modules/views/plugins/views_plugin_access.inc","cc16bf7dc4c10eab382e948cfd91902ac1055514b627e3c50932376d3e3f1b91"),
("sites/all/modules/views/plugins/views_plugin_access_none.inc","8e0a6b706c60abf63ab84d8624567ca12a5b80ad293e4334790065fbe6fa14d4"),
("sites/all/modules/views/plugins/views_plugin_access_perm.inc","1807a9c91485a5abd3fb2f6590ed4bc185fdabe308db37b169be8abdfc30cab2"),
("sites/all/modules/views/plugins/views_plugin_access_role.inc","8784836ea87ec6b0974125ed95ed6bbf6fdf91624f496f22c28e9229c695068d"),
("sites/all/modules/views/plugins/views_plugin_argument_default.inc","43e593760f0e8f031f2e7b861385caa5e39f37de400fe4595925288c78f52f23"),
("sites/all/modules/views/plugins/views_plugin_argument_default_fixed.inc","daaa3b59b54cbb11e411e010303f67a51348bb97a4e06997b475f4c41e91c4e0"),
("sites/all/modules/views/plugins/views_plugin_argument_default_php.inc","7a133b603294bfe498bfdeb50fade0b6e3cf8862270376067d86f69e7dc50eb8"),
("sites/all/modules/views/plugins/views_plugin_argument_default_raw.inc","4318e0dfa56f167183453cf8cd913f3b7ee539b77a096507905e36db12ded97e"),
("sites/all/modules/views/plugins/views_plugin_argument_validate.inc","2ada4fdc59b366f33209c0cfc515b06e765b487091760cfa22e94ca1c028c9cb"),
("sites/all/modules/views/plugins/views_plugin_argument_validate_numeric.inc","c050d3b5723dbfdca9ad312c7fa198e509c626057b95eed326820ce733dd9730"),
("sites/all/modules/views/plugins/views_plugin_argument_validate_php.inc","56a09922081a5e368d5796907727e35cbf43b0d634e53f947990c8a42d5b5f3e"),
("sites/all/modules/views/plugins/views_plugin_cache.inc","b684e3ce1aeed33dd5e30f53527399a7a733d4cf1aae8acac9c6a2ca8b51b24b"),
("sites/all/modules/views/plugins/views_plugin_cache_none.inc","a0d0ba252e1e2b65350c7ce648b97364726fa8ded5a366bfcce30c62daee4450"),
("sites/all/modules/views/plugins/views_plugin_cache_time.inc","3a0a0f86f4f3d9a9d8b17accde4aa61150a627e3d782b96c6ab4d997c24fa94f"),
("sites/all/modules/views/plugins/views_plugin_display.inc","89eebaf4d1ced12cd8bbfcd36cf2655a88a34b62b9c67750be73874fae2bc33f"),
("sites/all/modules/views/plugins/views_plugin_display_attachment.inc","6124e2ec51eadd7500fb878c25d9c5044b4ae9b6323dbbaa40b4806b69dd4cc0"),
("sites/all/modules/views/plugins/views_plugin_display_block.inc","0246e9010ff70d04c8bdf859eb4f8e7e8143c411d7b72f676cf00031dc8727a1"),
("sites/all/modules/views/plugins/views_plugin_display_default.inc","91c6554d8f41f848bf30093d44d076051c54e998f6b50bdc2a922bfeeef9c54d"),
("sites/all/modules/views/plugins/views_plugin_display_embed.inc","5424f2ea9e031faade7a562b8013aea193db5b0bc1be92b97bd7967de0d7bfff"),
("sites/all/modules/views/plugins/views_plugin_display_extender.inc","75fb9f80e7f153715b911690c7140f251df588e6a541fab5881fbfafc0bbf778"),
("sites/all/modules/views/plugins/views_plugin_display_feed.inc","f2fb6152e12da300b9bb8e1b45621dfe921c3ce0e769970ee1532e32a3657c53"),
("sites/all/modules/views/plugins/views_plugin_display_page.inc","f7138a876ee88c50266d9fcb65f632d8d46d43d8152f760630cb11ae5e69afde"),
("sites/all/modules/views/plugins/views_plugin_exposed_form.inc","0632ce61b4e39f8c0f39866987e4908657020298520fcf7c2712c0135e77d95b"),
("sites/all/modules/views/plugins/views_plugin_exposed_form_basic.inc","c736e1862b393e15ecc80deb58663405a1d68c2db07eb620d8e640406876cd17"),
("sites/all/modules/views/plugins/views_plugin_exposed_form_input_required.inc","98b81e3b78f7242dd30a3754830bdde2fb1dfe8f002ae0daa06976f1bb64fa75"),
("sites/all/modules/views/plugins/views_plugin_localization.inc","d7239cc693994dcd069c1f1e7847a7902c5bd29b8d64a93cdf37c602576661fb"),
("sites/all/modules/views/plugins/views_plugin_localization_core.inc","f0900c0640e7c779e9b876223ea395f613c8fe8449f6c8eb5d060e2d54a6afcc"),
("sites/all/modules/views/plugins/views_plugin_localization_none.inc","4930c3a13ddc0df3065f4920a836ffdc933b037e1337764e6687d7311f49dd8a"),
("sites/all/modules/views/plugins/views_plugin_pager.inc","d7c32e38f149e9009e175395dff2b00ec429867653c7535301b705a7cc69d9ed"),
("sites/all/modules/views/plugins/views_plugin_pager_full.inc","60e4dec532de00bf7e785e5fa29a0be43c7b550efa85df0346a1712a3c39f7cd"),
("sites/all/modules/views/plugins/views_plugin_pager_mini.inc","0a9d101d5a4217fb888c643bfddd7bf7f2f9c0937faa2753a31452a5ee68190b"),
("sites/all/modules/views/plugins/views_plugin_pager_none.inc","822cab1ada25f4902a0505f13db86886061d2ced655438b33b197d031ccceddd"),
("sites/all/modules/views/plugins/views_plugin_pager_some.inc","bc6aa7cbf1bc09374eced33334195c8897e4078336b8306d02d71c7aaaa22c99");
INSERT INTO registry_file VALUES
("sites/all/modules/views/plugins/views_plugin_query.inc","0594d1fd0c34b86c6b81741e134da2d385d6be47b667af6660dd1d268fb7fa95"),
("sites/all/modules/views/plugins/views_plugin_query_default.inc","cfb70855fde94bf257a9fef9f8cf34a37a3cc0e98196ee2c65edcd63aacedb7f"),
("sites/all/modules/views/plugins/views_plugin_row.inc","3ca81529526b930cfb0dda202757f203649236b90441e3c035bb79cd419ee2a6"),
("sites/all/modules/views/plugins/views_plugin_row_fields.inc","875fb2868cdbcc5f7af03098cbe55b9bb91ef512e5e52ccde89f7a02a0c5fbe2"),
("sites/all/modules/views/plugins/views_plugin_row_rss_fields.inc","62f4a0ceef14aec9958ee8b98d352303f10818ddc66031814cc8b9d21752ade9"),
("sites/all/modules/views/plugins/views_plugin_style.inc","015f7682a6535d0254e5b39edf22d95121eb41438d94a28c8659a2bc3a1ca237"),
("sites/all/modules/views/plugins/views_plugin_style_default.inc","bf411e635d2fd9e09eb245b43581a0a7b670359180ccb042d42a5e579bbe9c30"),
("sites/all/modules/views/plugins/views_plugin_style_grid.inc","35094b7f644b7e0692c9026b6b6b4c4c864c37fcdedef04b359dd2bdba496a47"),
("sites/all/modules/views/plugins/views_plugin_style_jump_menu.inc","102fb3041a2f9a4ce9607a5bc2acc296ed625bee2fcbfa70354c1edd613066cd"),
("sites/all/modules/views/plugins/views_plugin_style_list.inc","407b928d2c74a91903b681088bccce926d2268d0a9a6a34c185a4849dc0d7e31"),
("sites/all/modules/views/plugins/views_plugin_style_mapping.inc","af4b75dd08f1597280a8deb6086259be4f10af50acace43ce2013170655f752c"),
("sites/all/modules/views/plugins/views_plugin_style_rss.inc","ac72d530faffee78a1695a0b3893528ceb8451f18be0521c580485904a5ba57b"),
("sites/all/modules/views/plugins/views_plugin_style_summary.inc","872df59f8f389eaf9b019e82d859dd198d31166e26a9102132e3932c7f1f2916"),
("sites/all/modules/views/plugins/views_plugin_style_summary_jump_menu.inc","2ec0d225824ee65b6bb61317979e1dabe2be524a66ab19da924c6949dd31af3b"),
("sites/all/modules/views/plugins/views_plugin_style_summary_unformatted.inc","c1e6f9dd1d75e29fee271171440d2182e633a1dbbc996cb186f637ff7ad93ed9"),
("sites/all/modules/views/plugins/views_plugin_style_table.inc","0cbcc5d256a13953fbd3e5966a33d2426d5c3bd8c228ef370daebf2f428e693c"),
("sites/all/modules/views/tests/comment/views_handler_argument_comment_user_uid.test","b8b417ef0e05806a88bd7d5e2f7dcb41339fbf5b66f39311defc9fb65476d561"),
("sites/all/modules/views/tests/comment/views_handler_filter_comment_user_uid.test","347c6ffd4383706dbde844235aaf31cff44a22e95d2e6d8ef4da34a41b70edd1"),
("sites/all/modules/views/tests/field/views_fieldapi.test","53e6d57c2d1d6cd0cd92e15ca4077ba532214daf41e9c7c0f940c7c8dbd86a66"),
("sites/all/modules/views/tests/handlers/views_handlers.test","f94dd3c4ba0bb1ffbf42704f600b94a808c1202a9ca26e7bdef8e7921c2724e9"),
("sites/all/modules/views/tests/handlers/views_handler_area_text.test","af74a74a3357567b844606add76d7ca1271317778dd7bd245a216cf963c738b4"),
("sites/all/modules/views/tests/handlers/views_handler_argument_null.test","1d174e1f467b905d67217bd755100d78ffeca4aa4ada5c4be40270cd6d30b721"),
("sites/all/modules/views/tests/handlers/views_handler_argument_string.test","3d0213af0041146abb61dcdc750869ed773d0ac80cfa74ffbadfdd03b1f11c52"),
("sites/all/modules/views/tests/handlers/views_handler_field.test","af552bf825ab77486b3d0d156779b7c4806ce5a983c6116ad68b633daf9bb927"),
("sites/all/modules/views/tests/handlers/views_handler_field_boolean.test","d334b12a850f36b41fe89ab30a9d758fd3ce434286bd136404344b7b288460ae"),
("sites/all/modules/views/tests/handlers/views_handler_field_counter.test","75b31942adf06b107f5ffd3c97545fde8cd1040b1d00f682e3c7c1320026e26c"),
("sites/all/modules/views/tests/handlers/views_handler_field_custom.test","1446bc3d5a6b1180a79edfa46a5268dbf7f089836aa3bc45df00ddaff9dd0ce1"),
("sites/all/modules/views/tests/handlers/views_handler_field_date.test","02df76a93a42d6131957748b1e69254835f9e44a47dafca1e833914e6b7f88a0"),
("sites/all/modules/views/tests/handlers/views_handler_field_file_extension.test","606ca091ad7e5709f7653324aaa021484d1f0e07e8639b3f0f7c26d3cfdee53c"),
("sites/all/modules/views/tests/handlers/views_handler_field_file_size.test","49184db68af398a54e81c8a76261acd861da8fd7846b9d51dcf476d61396bfb9"),
("sites/all/modules/views/tests/handlers/views_handler_field_math.test","6e39e4f782e6b36151ceafb41a5509f7c661be79b393b24f6f5496d724535887"),
("sites/all/modules/views/tests/handlers/views_handler_field_url.test","b41f762a71594b438a2e60a79c8260ba54e6305635725b0747e29f0d3ffe08c9"),
("sites/all/modules/views/tests/handlers/views_handler_field_xss.test","f129ee16c03f84673e33990cbb2da5aa88c362f46e9ba1620b2a842ffd1c9cd2"),
("sites/all/modules/views/tests/handlers/views_handler_filter_combine.test","05842d83a11822afe7d566835f5db9f0f94fdb27ddfc388d38138767bdf36f8b"),
("sites/all/modules/views/tests/handlers/views_handler_filter_date.test","ad2ca901c6a4ac3a82fc349a33826f043c6c80f773f40374be2e95acb39491e3"),
("sites/all/modules/views/tests/handlers/views_handler_filter_equality.test","c88f21c9cbf1aae83393b26616908f8020c18fe378d76256c7ba192df2ec17af"),
("sites/all/modules/views/tests/handlers/views_handler_filter_in_operator.test","89420a4071677232e0eb82b184b37b818a82bdb2ff90a8b21293f9ecb21808bf"),
("sites/all/modules/views/tests/handlers/views_handler_filter_numeric.test","35ac7a34e696b979e86ef7209b6697098d9abe218e30a02cc4fe39fb11f2a852"),
("sites/all/modules/views/tests/handlers/views_handler_filter_string.test","b7d090780748faad478e619fd55673d746d4a0cf343d9e40ea96881324c34cbd"),
("sites/all/modules/views/tests/handlers/views_handler_sort.test","f4ff79e6bc54e83c4eb2777811f33702b7e9fe7416ef70ae00d100fa54d44fec"),
("sites/all/modules/views/tests/handlers/views_handler_sort_date.test","f548584d7c6a71cabd3ce07e04053a38df3f3e1685210ce8114238fd05344c10"),
("sites/all/modules/views/tests/handlers/views_handler_sort_random.test","4fdba9bf05a26720ffa97e7a37da65ddc9044bd2832f8c89007b82feb062f182"),
("sites/all/modules/views/tests/node/views_node_revision_relations.test","9467497a6d693615b48c8f57611a850002317bcb091b926d2efbbe56a4e61480"),
("sites/all/modules/views/tests/plugins/views_plugin_display.test","4a6b136543a60999604c54125fa9d4f5aa61a5dcc71e2133d89325d81bc0fc2d"),
("sites/all/modules/views/tests/styles/views_plugin_style.test","d38f553c625a1eee5527dcef0bd1087374555dc0643bc2329dec594dc8a75bf1"),
("sites/all/modules/views/tests/styles/views_plugin_style_base.test","54fb7816d18416d8b0db67e9f55aa2aa50ac204eb9311be14b6700b7d7a95ae7"),
("sites/all/modules/views/tests/styles/views_plugin_style_jump_menu.test","b88baa8aebe183943a6e4cf2df314fef13ac41b5844cd5fa4aa91557dd624895"),
("sites/all/modules/views/tests/styles/views_plugin_style_mapping.test","a4e68bc8cfbeff4a1d9b8085fd115bfe7a8c4b84c049573fa0409b0dc8c2f053"),
("sites/all/modules/views/tests/styles/views_plugin_style_unformatted.test","033ca29d41af47cd7bd12d50fea6c956dde247202ebda9df7f637111481bb51d"),
("sites/all/modules/views/tests/taxonomy/views_handler_relationship_node_term_data.test","6074f5c7ae63225ea0cd26626ace6c017740e226f4d3c234e39869c31308223d"),
("sites/all/modules/views/tests/test_handlers/views_test_area_access.inc","619e39bc4535976865b96751535d0d5aac4a7a87c1d47cb6d4c4bb9c9fa74716"),
("sites/all/modules/views/tests/test_plugins/views_test_plugin_access_test_dynamic.inc","6a3ce8c256b84734b6b67a893ab24465a5f62d7bdf9ab5d22082a31849346b7d"),
("sites/all/modules/views/tests/test_plugins/views_test_plugin_access_test_static.inc","e345e42d443cfa73db0ed2be61291117ebd57b86196cdb77c6f440e93443def3"),
("sites/all/modules/views/tests/test_plugins/views_test_plugin_style_test_mapping.inc","0b2c68626105bd5f6b9074022a37c3d09d3a6bd70b811bb26d5eacad6d74546f"),
("sites/all/modules/views/tests/user/views_handler_field_user_name.test","69641b6da26d8daee9a2ceb2d0df56668bf09b86db1d4071c275b6e8d0885f9e"),
("sites/all/modules/views/tests/user/views_user.test","fbb63b42a0b7051bd4d33cf36841f39d7cc13a63b0554eca431b2a08c19facae"),
("sites/all/modules/views/tests/user/views_user_argument_default.test","6423f2db7673763991b1fd0c452a7d84413c7dd888ca6c95545fadc531cfaaf4"),
("sites/all/modules/views/tests/user/views_user_argument_validate.test","c88c9e5d162958f8924849758486a0d83822ada06088f5cf71bfbe76932d8d84"),
("sites/all/modules/views/tests/views_access.test","f8b9d04b43c09a67ec722290a30408c1df8c163cf6e5863b41468bb4e381ee6f"),
("sites/all/modules/views/tests/views_analyze.test","5548e36c99bb626209d63e5cddbc31f49ad83865c983d2662c6826b328d24ffb"),
("sites/all/modules/views/tests/views_argument_default.test","5950937aae4608bba5b86f366ef3a56cc6518bbccfeaeacda79fa13246d220e4"),
("sites/all/modules/views/tests/views_argument_validator.test","31f8f49946c8aa3b03d6d9a2281bdfb11c54071b28e83fb3e827ca6ff5e38c88"),
("sites/all/modules/views/tests/views_basic.test","655bd33983f84bbea68a3f24bfab545d2c02f36a478566edf35a98a58ff0c6cf"),
("sites/all/modules/views/tests/views_cache.test","4e9b8ae1d9e72a9eaee95f5083004316d2199617f7d6c8f4bea40e99d17efcd8"),
("sites/all/modules/views/tests/views_exposed_form.test","2b2b16373af8ecade91d7c77bd8c2da8286a33bde554874f5d81399d201c3228"),
("sites/all/modules/views/tests/views_glossary.test","118d50177a68a6f88e3727e10f8bcc6f95176282cc42fbd604458eeb932a36e8"),
("sites/all/modules/views/tests/views_groupby.test","f26ad6857dc4821a4a0780642bda05fcb69ed506968e521f759bb28be4080143"),
("sites/all/modules/views/tests/views_handlers.test","a696e3d6b1748da03a04ac532f403700d07c920b9c405c628a6c94ea6764f501"),
("sites/all/modules/views/tests/views_module.test","5137e27449639d3e02f1b27206ef3ff96957546333b517318dfe8f58239dc860"),
("sites/all/modules/views/tests/views_pager.test","6f448c8c13c5177afb35103119d6281958a2d6dbdfb96ae5f4ee77cb3b44adc5"),
("sites/all/modules/views/tests/views_plugin_localization_test.inc","baedcf6c7381f9c5d3a5062f7d256f96808d06e04b6e73eff8e791e5f5293f45"),
("sites/all/modules/views/tests/views_query.test","f8cb1649e43c8a2b036fec742e86b8eb9c2c4c095a4c4e7a7c3ca13c6ce8e6e6"),
("sites/all/modules/views/tests/views_test.views_default.inc","9664b95577fe2664410921bb751e1d99109e79b734f2c8c142d4083449282bd0"),
("sites/all/modules/views/tests/views_translatable.test","6899c7b09ab72c262480cf78d200ecddfb683e8f2495438a55b35ae0e103a1b3"),
("sites/all/modules/views/tests/views_ui.test","f9687a363d7cc2828739583e3eedeb68c99acd505ff4e3036c806a42b93a2688"),
("sites/all/modules/views/tests/views_upgrade.test","c48bd74b85809dd78d963e525e38f3b6dd7e12aa249f73bd6a20247a40d6713a"),
("sites/all/modules/views/tests/views_view.test","a52e010d27cc2eb29804a3acd30f574adf11fad1f5860e431178b61cddbdbb69"),
("sites/all/modules/webform/includes/exporters/webform_exporter.inc","5b681b19fc29764749622e59ed5c8093f6e16156cca7f537973be888e87a8e19"),
("sites/all/modules/webform/includes/exporters/webform_exporter_delimited.inc","aaa051b7c984e26ae39a08bdfb9e1bc27a1f60d30bb83315bb2dc74fc5b03b87"),
("sites/all/modules/webform/includes/exporters/webform_exporter_excel_delimited.inc","fe301ec8cba10b2e5ecdfed30c386fef1dbb1a33db21a19fa686533775b72223"),
("sites/all/modules/webform/includes/exporters/webform_exporter_excel_xlsx.inc","b3407ce58fb72c05d723ab699440f687db6344d4a8756eca7333deaa9c6f2df3"),
("sites/all/modules/webform/includes/webform.webformconditionals.inc","570b6547d286fdd91aa431cd524711a5fdec600ae379e508b0bc453a218b5720"),
("sites/all/modules/webform/tests/components.test","3c3933763024a02ecf00197e48792a4cb3d7d38ee433a687d862403d1b33597b"),
("sites/all/modules/webform/tests/conditionals.test","cd6c0093d349a9b5e9e2c88b67f61ca037fab12f9d6baaf556d2592d460484b4"),
("sites/all/modules/webform/tests/permissions.test","a3a44e69e38d99f100bc8e38ecac9c732e7f6559d08760f17d090f83b3661b6b"),
("sites/all/modules/webform/tests/submission.test","29b2d613653a21a3644e6401e4156827eaeb344e79b5c2140ed8e1751f6a00fa"),
("sites/all/modules/webform/tests/webform.test","a1f5ca21126eaefbd33bea6bbebd231798428fccf430f20f263d9f0aedcf0fd0"),
("sites/all/modules/webform/views/webform.views.inc","10d205b4c10a77b1da972554898c2e452226973f57affee3f26dcf1620102161"),
("sites/all/modules/webform/views/webform_handler_area_result_pager.inc","23b6f7013773cfed06c540748f7e2f0dc40602289bc97d73fe603ca9c87f0deb"),
("sites/all/modules/webform/views/webform_handler_field_form_body.inc","60d708d683c67b553ecee37c7d74b00ee4b06253799e31befef9cb3ff703abb2"),
("sites/all/modules/webform/views/webform_handler_field_is_draft.inc","1f1411981bc3e96ae4dccfb4c52a059b2e6488818ad4649fe8074f7de2d324f6"),
("sites/all/modules/webform/views/webform_handler_field_node_link_edit.inc","15c6c4755b2ec87f71699399851a831176d515071ef356de4a64b75b76989e89"),
("sites/all/modules/webform/views/webform_handler_field_node_link_results.inc","5320f9c4ffa4842d2efc31c6d563c083e0432c682f1eff706ade34fb8e54d630"),
("sites/all/modules/webform/views/webform_handler_field_submission_count.inc","1ed985c65786a215a39ecb119ad26c7e78108ecb8f969ed902cc4618c5378232"),
("sites/all/modules/webform/views/webform_handler_field_submission_data.inc","70d287d53cf06c2d4f49f9cdbc9c8855ad8c9a08c44523e45a465b5daa29d977"),
("sites/all/modules/webform/views/webform_handler_field_submission_link.inc","faaf698125ac99f18bdb8c4a7b9961e5ad06bdd157c7bbeaf8a8ad7d5be6aa60"),
("sites/all/modules/webform/views/webform_handler_field_webform_status.inc","1545900e2423f6869995b1a82072d25e0d0f66c51df5dbe691698d8e15020d73"),
("sites/all/modules/webform/views/webform_handler_filter_is_draft.inc","dfb94fba66085fd0c07b8012f6846228fabc46809b00028bb896d6a304cdfec8"),
("sites/all/modules/webform/views/webform_handler_filter_submission_data.inc","74d41b7fc50055de6279fd1d4757752841018374116ca844466b72a6085f9792"),
("sites/all/modules/webform/views/webform_handler_filter_webform_status.inc","4a6e3f21703f750b31e868e64fd1fc4b760c01b9a3ca98b250f34c29614fbc69");
INSERT INTO registry_file VALUES
("sites/all/modules/webform/views/webform_handler_numeric_data.inc","ce2d03c6fd25c5022ca1441f3f6b69e7d6643d67c06e853c2968500e7a8bf215"),
("sites/all/modules/webform/views/webform_handler_relationship_submission_data.inc","10ba625ac9813ee2b7cb3b66b557ea8d60d32ae5bf4300b8bd6ee41be0303fbd"),
("sites/all/modules/webform/views/webform_plugin_row_submission_view.inc","728907aaf814b5dc10a6d2c2c60880b160031536e81cff7071ffe04c570a7f60"),
("sites/all/modules/xmlsitemap/xmlsitemap.admin.inc","b73ad4a71b0812a9139c9f94c8bd9f4de20ac18e92aa6a20dd454f49017aefff"),
("sites/all/modules/xmlsitemap/xmlsitemap.drush.inc","f0e53dc57e1e519b12f371229a073fccf26962c9e5f82c3a248bb6a138cee530"),
("sites/all/modules/xmlsitemap/xmlsitemap.generate.inc","fcd22f453050d84f800a9b07d2e01a8f000c246c599800c01f9e0d54a26e58f5"),
("sites/all/modules/xmlsitemap/xmlsitemap.inc","4756ba8cb52490694be238c1bc113507dda9b35bba6e6a35c56c5fe7bc5b2596"),
("sites/all/modules/xmlsitemap/xmlsitemap.install","d256dff37a055081cd5184d33ad926a06522e20efa5ca69c5b12bcf5d7343835"),
("sites/all/modules/xmlsitemap/xmlsitemap.module","c007b442115bfdb493a59e8c10997e8939cf9ba699b68ffaf9804be724aaf591"),
("sites/all/modules/xmlsitemap/xmlsitemap.pages.inc","6e57ba3ec16d819b81a40adfe26eb1ed985129c4a5f44473a9a41ad4c5bc37da"),
("sites/all/modules/xmlsitemap/xmlsitemap.test","196f237157aaff4b0ed60577a1deec2b432bc1375a9b3a52096756d5e42349c5"),
("sites/all/modules/xmlsitemap/xmlsitemap.xmlsitemap.inc","ac8bc2c3ea562e862f2c84871cb59923b65c03c63ef4a924ba3438cb3d736a9b");




CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';


INSERT INTO role VALUES
("3","administrator","2"),
("1","anonymous user","0"),
("2","authenticated user","1");




CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';


INSERT INTO role_permission VALUES
("1","access comments","comment"),
("1","access content","node"),
("1","use text format filtered_html","filter"),
("2","access comments","comment"),
("2","access content","node"),
("2","post comments","comment"),
("2","skip comment approval","comment"),
("2","use text format filtered_html","filter"),
("3","access administration pages","system"),
("3","access all views","views"),
("3","access all webform results","webform"),
("3","access comments","comment"),
("3","access content","node"),
("3","access content overview","node"),
("3","access contextual links","contextual"),
("3","access dashboard","dashboard"),
("3","access overlay","overlay"),
("3","access own webform results","webform"),
("3","access own webform submissions","webform"),
("3","access site in maintenance mode","system"),
("3","access site reports","system"),
("3","access toolbar","toolbar"),
("3","access user profiles","user"),
("3","administer actions","system"),
("3","administer blocks","block"),
("3","administer ckeditor","ckeditor"),
("3","administer comments","comment"),
("3","administer content types","node"),
("3","administer filters","filter"),
("3","administer image styles","image"),
("3","administer mailsystem","mailsystem"),
("3","administer menu","menu"),
("3","administer meta tags","metatag"),
("3","administer modules","system"),
("3","administer nodes","node"),
("3","administer page titles","page_title"),
("3","administer pathauto","pathauto"),
("3","administer permissions","user"),
("3","administer redirects","redirect"),
("3","administer search","search"),
("3","administer sendgrid settings","sendgrid_integration"),
("3","administer shortcuts","shortcut"),
("3","administer site configuration","system"),
("3","administer software updates","system"),
("3","administer taxonomy","taxonomy"),
("3","administer themes","system"),
("3","administer url aliases","path"),
("3","administer users","user"),
("3","administer views","views"),
("3","administer xmlsitemap","xmlsitemap"),
("3","block IP addresses","system"),
("3","bypass node access","node"),
("3","cancel account","user"),
("3","change own username","user"),
("3","create article content","node"),
("3","create page content","node"),
("3","create url aliases","path"),
("3","customize ckeditor","ckeditor"),
("3","customize shortcut links","shortcut"),
("3","delete all webform submissions","webform"),
("3","delete any article content","node"),
("3","delete any page content","node"),
("3","delete own article content","node"),
("3","delete own page content","node"),
("3","delete own webform submissions","webform"),
("3","delete revisions","node"),
("3","delete terms in 1","taxonomy"),
("3","edit all webform submissions","webform"),
("3","edit any article content","node"),
("3","edit any page content","node"),
("3","edit meta tags","metatag"),
("3","edit own article content","node"),
("3","edit own comments","comment"),
("3","edit own page content","node"),
("3","edit own webform submissions","webform"),
("3","edit terms in 1","taxonomy"),
("3","edit webform components","webform"),
("3","notify of path changes","pathauto"),
("3","post comments","comment"),
("3","revert revisions","node"),
("3","search content","search"),
("3","select account cancellation method","user"),
("3","set page title","page_title"),
("3","skip comment approval","comment"),
("3","switch shortcut sets","shortcut"),
("3","use advanced search","search"),
("3","use ctools import","ctools"),
("3","use text format filtered_html","filter"),
("3","use text format full_html","filter"),
("3","view own unpublished content","node"),
("3","view revisions","node"),
("3","view the administration theme","system");




CREATE TABLE `search_dataset` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.',
  PRIMARY KEY (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';






CREATE TABLE `search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.',
  PRIMARY KEY (`word`,`sid`,`type`),
  KEY `sid_type` (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';






CREATE TABLE `search_node_links` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.',
  PRIMARY KEY (`sid`,`type`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';






CREATE TABLE `search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';






CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';






CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';


INSERT INTO sequences VALUES
("1");




CREATE TABLE `sessions` (
  `uid` int(10) unsigned NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.',
  PRIMARY KEY (`sid`,`ssid`),
  KEY `timestamp` (`timestamp`),
  KEY `uid` (`uid`),
  KEY `ssid` (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';


INSERT INTO sessions VALUES
("1","59xSnD_1V8PD2Nsh2jGo7ACCBQeAW_DV3-nz8AqLAv0","","106.66.75.209","1457520145","0","batches|a:1:{i:1;b:1;}");




CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';


INSERT INTO shortcut_set VALUES
("shortcut-set-1","Default");




CREATE TABLE `shortcut_set_users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.',
  PRIMARY KEY (`uid`),
  KEY `set_name` (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';






CREATE TABLE `system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.',
  PRIMARY KEY (`filename`),
  KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  KEY `type_name` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';


INSERT INTO system VALUES
("modules/aggregator/aggregator.module","aggregator","module","","0","0","-1","0","a:14:{s:4:\"name\";s:10:\"Aggregator\";s:11:\"description\";s:57:\"Aggregates syndicated content (RSS, RDF, and Atom feeds).\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"aggregator.test\";}s:9:\"configure\";s:41:\"admin/config/services/aggregator/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:14:\"aggregator.css\";s:33:\"modules/aggregator/aggregator.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/aggregator/tests/aggregator_test.module","aggregator_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:23:\"Aggregator module tests\";s:11:\"description\";s:46:\"Support module for aggregator related testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/block/block.module","block","module","","1","0","7009","-5","a:13:{s:4:\"name\";s:5:\"Block\";s:11:\"description\";s:140:\"Controls the visual building blocks a page is constructed with. Blocks are boxes of content rendered into an area, or region, of a web page.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"block.test\";}s:9:\"configure\";s:21:\"admin/structure/block\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/block/tests/block_test.module","block_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:10:\"Block test\";s:11:\"description\";s:21:\"Provides test blocks.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/blog/blog.module","blog","module","","0","0","-1","0","a:12:{s:4:\"name\";s:4:\"Blog\";s:11:\"description\";s:25:\"Enables multi-user blogs.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"blog.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/book/book.module","book","module","","0","0","-1","0","a:14:{s:4:\"name\";s:4:\"Book\";s:11:\"description\";s:66:\"Allows users to create and organize related content in an outline.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"book.test\";}s:9:\"configure\";s:27:\"admin/content/book/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"book.css\";s:21:\"modules/book/book.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/color/color.module","color","module","","1","0","7001","0","a:12:{s:4:\"name\";s:5:\"Color\";s:11:\"description\";s:70:\"Allows administrators to change the color scheme of compatible themes.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"color.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/comment/comment.module","comment","module","","1","0","7009","0","a:14:{s:4:\"name\";s:7:\"Comment\";s:11:\"description\";s:57:\"Allows users to comment on and discuss published content.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"text\";}s:5:\"files\";a:2:{i:0;s:14:\"comment.module\";i:1;s:12:\"comment.test\";}s:9:\"configure\";s:21:\"admin/content/comment\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:11:\"comment.css\";s:27:\"modules/comment/comment.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/contact/contact.module","contact","module","","0","0","-1","0","a:13:{s:4:\"name\";s:7:\"Contact\";s:11:\"description\";s:61:\"Enables the use of both personal and site-wide contact forms.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"contact.test\";}s:9:\"configure\";s:23:\"admin/structure/contact\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/contextual/contextual.module","contextual","module","","1","0","0","0","a:12:{s:4:\"name\";s:16:\"Contextual links\";s:11:\"description\";s:75:\"Provides contextual links to perform actions related to elements on a page.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"contextual.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/dashboard/dashboard.module","dashboard","module","","1","0","0","0","a:13:{s:4:\"name\";s:9:\"Dashboard\";s:11:\"description\";s:136:\"Provides a dashboard page in the administrative interface for organizing administrative tasks and tracking information within your site.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:5:\"files\";a:1:{i:0;s:14:\"dashboard.test\";}s:12:\"dependencies\";a:1:{i:0;s:5:\"block\";}s:9:\"configure\";s:25:\"admin/dashboard/customize\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/dblog/dblog.module","dblog","module","","1","1","7002","0","a:12:{s:4:\"name\";s:16:\"Database logging\";s:11:\"description\";s:47:\"Logs and records system events to the database.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"dblog.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/field/field.module","field","module","","1","0","7003","0","a:14:{s:4:\"name\";s:5:\"Field\";s:11:\"description\";s:57:\"Field API to add fields to entities like nodes and users.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:4:{i:0;s:12:\"field.module\";i:1;s:16:\"field.attach.inc\";i:2;s:20:\"field.info.class.inc\";i:3;s:16:\"tests/field.test\";}s:12:\"dependencies\";a:1:{i:0;s:17:\"field_sql_storage\";}s:8:\"required\";b:1;s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"theme/field.css\";s:29:\"modules/field/theme/field.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/field/modules/field_sql_storage/field_sql_storage.module","field_sql_storage","module","","1","0","7002","0","a:13:{s:4:\"name\";s:17:\"Field SQL storage\";s:11:\"description\";s:37:\"Stores field data in an SQL database.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:22:\"field_sql_storage.test\";}s:8:\"required\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/field/modules/list/list.module","list","module","","1","0","7002","0","a:12:{s:4:\"name\";s:4:\"List\";s:11:\"description\";s:69:\"Defines list field types. Use with Options to create selection lists.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:5:\"field\";i:1;s:7:\"options\";}s:5:\"files\";a:1:{i:0;s:15:\"tests/list.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/field/modules/list/tests/list_test.module","list_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:9:\"List test\";s:11:\"description\";s:41:\"Support module for the List module tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/field/modules/number/number.module","number","module","","1","0","0","0","a:12:{s:4:\"name\";s:6:\"Number\";s:11:\"description\";s:28:\"Defines numeric field types.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:11:\"number.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/field/modules/options/options.module","options","module","","1","0","0","0","a:12:{s:4:\"name\";s:7:\"Options\";s:11:\"description\";s:82:\"Defines selection, check box and radio button widgets for text and numeric fields.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:12:\"options.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/field/modules/text/text.module","text","module","","1","0","7000","0","a:14:{s:4:\"name\";s:4:\"Text\";s:11:\"description\";s:32:\"Defines simple text field types.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:9:\"text.test\";}s:8:\"required\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:11:\"explanation\";s:73:\"Field type(s) in use - see <a href=\"/admin/reports/fields\">Field list</a>\";}"),
("modules/field/tests/field_test.module","field_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:14:\"Field API Test\";s:11:\"description\";s:39:\"Support module for the Field API tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:5:\"files\";a:1:{i:0;s:21:\"field_test.entity.inc\";}s:7:\"version\";s:4:\"7.43\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/field_ui/field_ui.module","field_ui","module","","1","0","0","0","a:12:{s:4:\"name\";s:8:\"Field UI\";s:11:\"description\";s:33:\"User interface for the Field API.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:13:\"field_ui.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/file/file.module","file","module","","1","0","0","0","a:12:{s:4:\"name\";s:4:\"File\";s:11:\"description\";s:26:\"Defines a file field type.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:15:\"tests/file.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/file/tests/file_module_test.module","file_module_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:9:\"File test\";s:11:\"description\";s:53:\"Provides hooks for testing File module functionality.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/filter/filter.module","filter","module","","1","0","7010","0","a:14:{s:4:\"name\";s:6:\"Filter\";s:11:\"description\";s:43:\"Filters content in preparation for display.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"filter.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:28:\"admin/config/content/formats\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/forum/forum.module","forum","module","","0","0","-1","0","a:14:{s:4:\"name\";s:5:\"Forum\";s:11:\"description\";s:27:\"Provides discussion forums.\";s:12:\"dependencies\";a:2:{i:0;s:8:\"taxonomy\";i:1;s:7:\"comment\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"forum.test\";}s:9:\"configure\";s:21:\"admin/structure/forum\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:9:\"forum.css\";s:23:\"modules/forum/forum.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/help/help.module","help","module","","1","0","0","0","a:12:{s:4:\"name\";s:4:\"Help\";s:11:\"description\";s:35:\"Manages the display of online help.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"help.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/image/image.module","image","module","","1","0","7005","0","a:15:{s:4:\"name\";s:5:\"Image\";s:11:\"description\";s:34:\"Provides image manipulation tools.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"file\";}s:5:\"files\";a:1:{i:0;s:10:\"image.test\";}s:9:\"configure\";s:31:\"admin/config/media/image-styles\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:8:\"required\";b:1;s:11:\"explanation\";s:73:\"Field type(s) in use - see <a href=\"/admin/reports/fields\">Field list</a>\";}"),
("modules/image/tests/image_module_test.module","image_module_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:10:\"Image test\";s:11:\"description\";s:69:\"Provides hook implementations for testing Image module functionality.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:24:\"image_module_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/locale/locale.module","locale","module","","0","0","-1","0","a:13:{s:4:\"name\";s:6:\"Locale\";s:11:\"description\";s:119:\"Adds language handling functionality and enables the translation of the user interface to languages other than English.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"locale.test\";}s:9:\"configure\";s:30:\"admin/config/regional/language\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/locale/tests/locale_test.module","locale_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:11:\"Locale Test\";s:11:\"description\";s:42:\"Support module for the locale layer tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/menu/menu.module","menu","module","","1","0","7003","0","a:13:{s:4:\"name\";s:4:\"Menu\";s:11:\"description\";s:60:\"Allows administrators to customize the site navigation menu.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"menu.test\";}s:9:\"configure\";s:20:\"admin/structure/menu\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/node/node.module","node","module","","1","0","7015","0","a:15:{s:4:\"name\";s:4:\"Node\";s:11:\"description\";s:66:\"Allows content to be submitted to the site and displayed on pages.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:11:\"node.module\";i:1;s:9:\"node.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:21:\"admin/structure/types\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"node.css\";s:21:\"modules/node/node.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/node/tests/node_access_test.module","node_access_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:24:\"Node module access tests\";s:11:\"description\";s:43:\"Support module for node permission testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/node/tests/node_test.module","node_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:17:\"Node module tests\";s:11:\"description\";s:40:\"Support module for node related testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/node/tests/node_test_exception.module","node_test_exception","module","","0","0","-1","0","a:13:{s:4:\"name\";s:27:\"Node module exception tests\";s:11:\"description\";s:50:\"Support module for node related exception testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/openid/openid.module","openid","module","","0","0","-1","0","a:12:{s:4:\"name\";s:6:\"OpenID\";s:11:\"description\";s:48:\"Allows users to log into your site using OpenID.\";s:7:\"version\";s:4:\"7.43\";s:7:\"package\";s:4:\"Core\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"openid.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/openid/tests/openid_test.module","openid_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:21:\"OpenID dummy provider\";s:11:\"description\";s:33:\"OpenID provider used for testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"openid\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/overlay/overlay.module","overlay","module","","1","1","0","0","a:12:{s:4:\"name\";s:7:\"Overlay\";s:11:\"description\";s:59:\"Displays the Drupal administration interface in an overlay.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/path/path.module","path","module","","1","0","0","0","a:13:{s:4:\"name\";s:4:\"Path\";s:11:\"description\";s:28:\"Allows users to rename URLs.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"path.test\";}s:9:\"configure\";s:24:\"admin/config/search/path\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/php/php.module","php","module","","0","0","-1","0","a:12:{s:4:\"name\";s:10:\"PHP filter\";s:11:\"description\";s:50:\"Allows embedded PHP code/snippets to be evaluated.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:8:\"php.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/poll/poll.module","poll","module","","0","0","-1","0","a:13:{s:4:\"name\";s:4:\"Poll\";s:11:\"description\";s:95:\"Allows your site to capture votes on different topics in the form of multiple choice questions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"poll.test\";}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"poll.css\";s:21:\"modules/poll/poll.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/profile/profile.module","profile","module","","0","0","-1","0","a:14:{s:4:\"name\";s:7:\"Profile\";s:11:\"description\";s:36:\"Supports configurable user profiles.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"profile.test\";}s:9:\"configure\";s:27:\"admin/config/people/profile\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/rdf/rdf.module","rdf","module","","1","0","0","0","a:12:{s:4:\"name\";s:3:\"RDF\";s:11:\"description\";s:148:\"Enriches your content with metadata to let other applications (e.g. search engines, aggregators) better understand its relationships and attributes.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:8:\"rdf.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/rdf/tests/rdf_test.module","rdf_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:16:\"RDF module tests\";s:11:\"description\";s:38:\"Support module for RDF module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/search/search.module","search","module","","1","0","7000","0","a:14:{s:4:\"name\";s:6:\"Search\";s:11:\"description\";s:36:\"Enables site-wide keyword searching.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:19:\"search.extender.inc\";i:1;s:11:\"search.test\";}s:9:\"configure\";s:28:\"admin/config/search/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"search.css\";s:25:\"modules/search/search.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/search/tests/search_embedded_form.module","search_embedded_form","module","","0","0","-1","0","a:13:{s:4:\"name\";s:20:\"Search embedded form\";s:11:\"description\";s:59:\"Support module for search module testing of embedded forms.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/search/tests/search_extra_type.module","search_extra_type","module","","0","0","-1","0","a:13:{s:4:\"name\";s:16:\"Test search type\";s:11:\"description\";s:41:\"Support module for search module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/search/tests/search_node_tags.module","search_node_tags","module","","0","0","-1","0","a:13:{s:4:\"name\";s:21:\"Test search node tags\";s:11:\"description\";s:44:\"Support module for Node search tags testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/shortcut/shortcut.module","shortcut","module","","1","0","0","0","a:13:{s:4:\"name\";s:8:\"Shortcut\";s:11:\"description\";s:60:\"Allows users to manage customizable lists of shortcut links.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:13:\"shortcut.test\";}s:9:\"configure\";s:36:\"admin/config/user-interface/shortcut\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/simpletest.module","simpletest","module","","0","0","-1","0","a:13:{s:4:\"name\";s:7:\"Testing\";s:11:\"description\";s:53:\"Provides a framework for unit and functional testing.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:50:{i:0;s:15:\"simpletest.test\";i:1;s:24:\"drupal_web_test_case.php\";i:2;s:18:\"tests/actions.test\";i:3;s:15:\"tests/ajax.test\";i:4;s:16:\"tests/batch.test\";i:5;s:15:\"tests/boot.test\";i:6;s:20:\"tests/bootstrap.test\";i:7;s:16:\"tests/cache.test\";i:8;s:17:\"tests/common.test\";i:9;s:24:\"tests/database_test.test\";i:10;s:22:\"tests/entity_crud.test\";i:11;s:32:\"tests/entity_crud_hook_test.test\";i:12;s:23:\"tests/entity_query.test\";i:13;s:16:\"tests/error.test\";i:14;s:15:\"tests/file.test\";i:15;s:23:\"tests/filetransfer.test\";i:16;s:15:\"tests/form.test\";i:17;s:16:\"tests/graph.test\";i:18;s:16:\"tests/image.test\";i:19;s:15:\"tests/lock.test\";i:20;s:15:\"tests/mail.test\";i:21;s:15:\"tests/menu.test\";i:22;s:17:\"tests/module.test\";i:23;s:16:\"tests/pager.test\";i:24;s:19:\"tests/password.test\";i:25;s:15:\"tests/path.test\";i:26;s:19:\"tests/registry.test\";i:27;s:17:\"tests/schema.test\";i:28;s:18:\"tests/session.test\";i:29;s:20:\"tests/tablesort.test\";i:30;s:16:\"tests/theme.test\";i:31;s:18:\"tests/unicode.test\";i:32;s:17:\"tests/update.test\";i:33;s:17:\"tests/xmlrpc.test\";i:34;s:26:\"tests/upgrade/upgrade.test\";i:35;s:34:\"tests/upgrade/upgrade.comment.test\";i:36;s:33:\"tests/upgrade/upgrade.filter.test\";i:37;s:32:\"tests/upgrade/upgrade.forum.test\";i:38;s:33:\"tests/upgrade/upgrade.locale.test\";i:39;s:31:\"tests/upgrade/upgrade.menu.test\";i:40;s:31:\"tests/upgrade/upgrade.node.test\";i:41;s:35:\"tests/upgrade/upgrade.taxonomy.test\";i:42;s:34:\"tests/upgrade/upgrade.trigger.test\";i:43;s:39:\"tests/upgrade/upgrade.translatable.test\";i:44;s:33:\"tests/upgrade/upgrade.upload.test\";i:45;s:31:\"tests/upgrade/upgrade.user.test\";i:46;s:36:\"tests/upgrade/update.aggregator.test\";i:47;s:33:\"tests/upgrade/update.trigger.test\";i:48;s:31:\"tests/upgrade/update.field.test\";i:49;s:30:\"tests/upgrade/update.user.test\";}s:9:\"configure\";s:41:\"admin/config/development/testing/settings\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/actions_loop_test.module","actions_loop_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:17:\"Actions loop test\";s:11:\"description\";s:39:\"Support module for action loop testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/ajax_forms_test.module","ajax_forms_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:26:\"AJAX form test mock module\";s:11:\"description\";s:25:\"Test for AJAX form calls.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/ajax_test.module","ajax_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:9:\"AJAX Test\";s:11:\"description\";s:40:\"Support module for AJAX framework tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/batch_test.module","batch_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:14:\"Batch API test\";s:11:\"description\";s:35:\"Support module for Batch API tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/boot_test_1.module","boot_test_1","module","","0","0","-1","0","a:13:{s:4:\"name\";s:21:\"Early bootstrap tests\";s:11:\"description\";s:39:\"A support module for hook_boot testing.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/boot_test_2.module","boot_test_2","module","","0","0","-1","0","a:13:{s:4:\"name\";s:21:\"Early bootstrap tests\";s:11:\"description\";s:44:\"A support module for hook_boot hook testing.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/common_test.module","common_test","module","","0","0","-1","0","a:14:{s:4:\"name\";s:11:\"Common Test\";s:11:\"description\";s:32:\"Support module for Common tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:15:\"common_test.css\";s:40:\"modules/simpletest/tests/common_test.css\";}s:5:\"print\";a:1:{s:21:\"common_test.print.css\";s:46:\"modules/simpletest/tests/common_test.print.css\";}}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/common_test_cron_helper.module","common_test_cron_helper","module","","0","0","-1","0","a:13:{s:4:\"name\";s:23:\"Common Test Cron Helper\";s:11:\"description\";s:56:\"Helper module for CronRunTestCase::testCronExceptions().\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/database_test.module","database_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:13:\"Database Test\";s:11:\"description\";s:40:\"Support module for Database layer tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/drupal_autoload_test/drupal_autoload_test.module","drupal_autoload_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:25:\"Drupal code registry test\";s:11:\"description\";s:45:\"Support module for testing the code registry.\";s:5:\"files\";a:2:{i:0;s:34:\"drupal_autoload_test_interface.inc\";i:1;s:30:\"drupal_autoload_test_class.inc\";}s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/drupal_system_listing_compatible_test/drupal_system_listing_compatible_test.module","drupal_system_listing_compatible_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:37:\"Drupal system listing compatible test\";s:11:\"description\";s:62:\"Support module for testing the drupal_system_listing function.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/drupal_system_listing_incompatible_test/drupal_system_listing_incompatible_test.module","drupal_system_listing_incompatible_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:39:\"Drupal system listing incompatible test\";s:11:\"description\";s:62:\"Support module for testing the drupal_system_listing function.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/entity_cache_test.module","entity_cache_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:17:\"Entity cache test\";s:11:\"description\";s:40:\"Support module for testing entity cache.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:28:\"entity_cache_test_dependency\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/entity_cache_test_dependency.module","entity_cache_test_dependency","module","","0","0","-1","0","a:13:{s:4:\"name\";s:28:\"Entity cache test dependency\";s:11:\"description\";s:51:\"Support dependency module for testing entity cache.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/entity_crud_hook_test.module","entity_crud_hook_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:22:\"Entity CRUD Hooks Test\";s:11:\"description\";s:35:\"Support module for CRUD hook tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/entity_query_access_test.module","entity_query_access_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:24:\"Entity query access test\";s:11:\"description\";s:49:\"Support module for checking entity query results.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/error_test.module","error_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:10:\"Error test\";s:11:\"description\";s:47:\"Support module for error and exception testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/file_test.module","file_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:9:\"File test\";s:11:\"description\";s:39:\"Support module for file handling tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:16:\"file_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/filter_test.module","filter_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:18:\"Filter test module\";s:11:\"description\";s:33:\"Tests filter hooks and functions.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/form_test.module","form_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:12:\"FormAPI Test\";s:11:\"description\";s:34:\"Support module for Form API tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/image_test.module","image_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:10:\"Image test\";s:11:\"description\";s:39:\"Support module for image toolkit tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/menu_test.module","menu_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:15:\"Hook menu tests\";s:11:\"description\";s:37:\"Support module for menu hook testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/module_test.module","module_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:11:\"Module test\";s:11:\"description\";s:41:\"Support module for module system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/path_test.module","path_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:15:\"Hook path tests\";s:11:\"description\";s:37:\"Support module for path hook testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/psr_0_test/psr_0_test.module","psr_0_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:16:\"PSR-0 Test cases\";s:11:\"description\";s:44:\"Test classes to be discovered by simpletest.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/psr_4_test/psr_4_test.module","psr_4_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:16:\"PSR-4 Test cases\";s:11:\"description\";s:44:\"Test classes to be discovered by simpletest.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/requirements1_test.module","requirements1_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:19:\"Requirements 1 Test\";s:11:\"description\";s:80:\"Tests that a module is not installed when it fails hook_requirements(\'install\').\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/requirements2_test.module","requirements2_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:19:\"Requirements 2 Test\";s:11:\"description\";s:98:\"Tests that a module is not installed when the one it depends on fails hook_requirements(\'install).\";s:12:\"dependencies\";a:2:{i:0;s:18:\"requirements1_test\";i:1;s:7:\"comment\";}s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/session_test.module","session_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:12:\"Session test\";s:11:\"description\";s:40:\"Support module for session data testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/system_dependencies_test.module","system_dependencies_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:22:\"System dependency test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:19:\"_missing_dependency\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/system_incompatible_core_version_dependencies_test.module","system_incompatible_core_version_dependencies_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:50:\"System incompatible core version dependencies test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:37:\"system_incompatible_core_version_test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/system_incompatible_core_version_test.module","system_incompatible_core_version_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:37:\"System incompatible core version test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"5.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/system_incompatible_module_version_dependencies_test.module","system_incompatible_module_version_dependencies_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:52:\"System incompatible module version dependencies test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:46:\"system_incompatible_module_version_test (>2.0)\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/system_incompatible_module_version_test.module","system_incompatible_module_version_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:39:\"System incompatible module version test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/system_project_namespace_test.module","system_project_namespace_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:29:\"System project namespace test\";s:11:\"description\";s:58:\"Support module for testing project namespace dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:13:\"drupal:filter\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/system_test.module","system_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:11:\"System test\";s:11:\"description\";s:34:\"Support module for system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:18:\"system_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/taxonomy_test.module","taxonomy_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:20:\"Taxonomy test module\";s:11:\"description\";s:45:\"\"Tests functions and hooks not used in core\".\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:8:\"taxonomy\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/theme_test.module","theme_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:10:\"Theme test\";s:11:\"description\";s:40:\"Support module for theme system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/update_script_test.module","update_script_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:18:\"Update script test\";s:11:\"description\";s:41:\"Support module for update script testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/update_test_1.module","update_test_1","module","","0","0","-1","0","a:13:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/update_test_2.module","update_test_2","module","","0","0","-1","0","a:13:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/update_test_3.module","update_test_3","module","","0","0","-1","0","a:13:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/url_alter_test.module","url_alter_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:15:\"Url_alter tests\";s:11:\"description\";s:45:\"A support modules for url_alter hook testing.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/simpletest/tests/xmlrpc_test.module","xmlrpc_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:12:\"XML-RPC Test\";s:11:\"description\";s:75:\"Support module for XML-RPC tests according to the validator1 specification.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/statistics/statistics.module","statistics","module","","0","0","-1","0","a:13:{s:4:\"name\";s:10:\"Statistics\";s:11:\"description\";s:37:\"Logs access statistics for your site.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"statistics.test\";}s:9:\"configure\";s:30:\"admin/config/system/statistics\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/syslog/syslog.module","syslog","module","","0","0","-1","0","a:13:{s:4:\"name\";s:6:\"Syslog\";s:11:\"description\";s:41:\"Logs and records system events to syslog.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"syslog.test\";}s:9:\"configure\";s:32:\"admin/config/development/logging\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/system/system.module","system","module","","1","1","7080","0","a:14:{s:4:\"name\";s:6:\"System\";s:11:\"description\";s:54:\"Handles general site configuration for administrators.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:6:{i:0;s:19:\"system.archiver.inc\";i:1;s:15:\"system.mail.inc\";i:2;s:16:\"system.queue.inc\";i:3;s:14:\"system.tar.inc\";i:4;s:18:\"system.updater.inc\";i:5;s:11:\"system.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:19:\"admin/config/system\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/system/tests/cron_queue_test.module","cron_queue_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:15:\"Cron Queue test\";s:11:\"description\";s:41:\"Support module for the cron queue runner.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/system/tests/system_cron_test.module","system_cron_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:16:\"System Cron Test\";s:11:\"description\";s:45:\"Support module for testing the system_cron().\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/taxonomy/taxonomy.module","taxonomy","module","","1","0","7011","0","a:15:{s:4:\"name\";s:8:\"Taxonomy\";s:11:\"description\";s:38:\"Enables the categorization of content.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"options\";}s:5:\"files\";a:2:{i:0;s:15:\"taxonomy.module\";i:1;s:13:\"taxonomy.test\";}s:9:\"configure\";s:24:\"admin/structure/taxonomy\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:8:\"required\";b:1;s:11:\"explanation\";s:73:\"Field type(s) in use - see <a href=\"/admin/reports/fields\">Field list</a>\";}");
INSERT INTO system VALUES
("modules/toolbar/toolbar.module","toolbar","module","","1","0","0","0","a:12:{s:4:\"name\";s:7:\"Toolbar\";s:11:\"description\";s:99:\"Provides a toolbar that shows the top-level administration menu items and links from other modules.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/tracker/tracker.module","tracker","module","","0","0","-1","0","a:12:{s:4:\"name\";s:7:\"Tracker\";s:11:\"description\";s:45:\"Enables tracking of recent content for users.\";s:12:\"dependencies\";a:1:{i:0;s:7:\"comment\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"tracker.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/translation/tests/translation_test.module","translation_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:24:\"Content Translation Test\";s:11:\"description\";s:49:\"Support module for the content translation tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/translation/translation.module","translation","module","","0","0","-1","0","a:12:{s:4:\"name\";s:19:\"Content translation\";s:11:\"description\";s:57:\"Allows content to be translated into different languages.\";s:12:\"dependencies\";a:1:{i:0;s:6:\"locale\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:16:\"translation.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/trigger/tests/trigger_test.module","trigger_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:12:\"Trigger Test\";s:11:\"description\";s:33:\"Support module for Trigger tests.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.43\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/trigger/trigger.module","trigger","module","","0","0","-1","0","a:13:{s:4:\"name\";s:7:\"Trigger\";s:11:\"description\";s:90:\"Enables actions to be fired on certain system events, such as when new content is created.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"trigger.test\";}s:9:\"configure\";s:23:\"admin/structure/trigger\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/update/tests/aaa_update_test.module","aaa_update_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:15:\"AAA Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.43\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/update/tests/bbb_update_test.module","bbb_update_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:15:\"BBB Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.43\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/update/tests/ccc_update_test.module","ccc_update_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:15:\"CCC Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.43\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/update/tests/update_test.module","update_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/update/update.module","update","module","","1","0","7001","0","a:13:{s:4:\"name\";s:14:\"Update manager\";s:11:\"description\";s:104:\"Checks for available updates, and can securely install or update modules and themes via a web interface.\";s:7:\"version\";s:4:\"7.43\";s:7:\"package\";s:4:\"Core\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"update.test\";}s:9:\"configure\";s:30:\"admin/reports/updates/settings\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("modules/user/tests/user_form_test.module","user_form_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:22:\"User module form tests\";s:11:\"description\";s:37:\"Support module for user form testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("modules/user/user.module","user","module","","1","0","7018","0","a:15:{s:4:\"name\";s:4:\"User\";s:11:\"description\";s:47:\"Manages the user registration and login system.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:11:\"user.module\";i:1;s:9:\"user.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:19:\"admin/config/people\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"user.css\";s:21:\"modules/user/user.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("profiles/standard/standard.profile","standard","module","","1","0","0","1000","a:15:{s:4:\"name\";s:8:\"Standard\";s:11:\"description\";s:51:\"Install with commonly used features pre-configured.\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:21:{i:0;s:5:\"block\";i:1;s:5:\"color\";i:2;s:7:\"comment\";i:3;s:10:\"contextual\";i:4;s:9:\"dashboard\";i:5;s:4:\"help\";i:6;s:5:\"image\";i:7;s:4:\"list\";i:8;s:4:\"menu\";i:9;s:6:\"number\";i:10;s:7:\"options\";i:11;s:4:\"path\";i:12;s:8:\"taxonomy\";i:13;s:5:\"dblog\";i:14;s:6:\"search\";i:15;s:8:\"shortcut\";i:16;s:7:\"toolbar\";i:17;s:7:\"overlay\";i:18;s:8:\"field_ui\";i:19;s:4:\"file\";i:20;s:3:\"rdf\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:5:\"mtime\";i:1474356108;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;s:6:\"hidden\";b:1;s:8:\"required\";b:1;s:17:\"distribution_name\";s:6:\"Drupal\";}"),
("sites/all/modules/ckeditor/ckeditor.module","ckeditor","module","","1","0","7005","0","a:13:{s:4:\"name\";s:8:\"CKEditor\";s:11:\"description\";s:76:\"Enables CKEditor (WYSIWYG HTML editor) for use instead of plain text fields.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:14:\"User interface\";s:9:\"configure\";s:29:\"admin/config/content/ckeditor\";s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:8:\"ckeditor\";s:9:\"datestamp\";s:10:\"1450969741\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/composer_manager/composer_manager.module","composer_manager","module","","1","1","7100","0","a:13:{s:4:\"name\";s:16:\"Composer Manager\";s:11:\"description\";s:119:\"Provides consolidated management of third-party, Composer-compatible packages that are required by contributed modules.\";s:7:\"package\";s:5:\"Other\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:3:\"5.3\";s:9:\"configure\";s:36:\"admin/config/system/composer-manager\";s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:16:\"composer_manager\";s:9:\"datestamp\";s:10:\"1446212041\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/composer_manager/composer_manager_sa/composer_manager_sa.module","composer_manager_sa","module","","0","0","-1","0","a:12:{s:4:\"name\";s:36:\"Composer Manager Security Advisories\";s:11:\"description\";s:92:\"Check for known security issues in Composer libraries from FriendsOfPHP/security-advisories.\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:16:\"composer_manager\";}s:7:\"version\";s:7:\"7.x-1.8\";s:7:\"project\";s:16:\"composer_manager\";s:9:\"datestamp\";s:10:\"1446212041\";s:5:\"mtime\";i:1474356108;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/bulk_export/bulk_export.module","bulk_export","module","","0","0","-1","0","a:12:{s:4:\"name\";s:11:\"Bulk Export\";s:11:\"description\";s:67:\"Performs bulk exporting of data objects known about by Chaos tools.\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/ctools.module","ctools","module","","1","0","7001","0","a:12:{s:4:\"name\";s:11:\"Chaos tools\";s:11:\"description\";s:46:\"A library of helpful tools by Merlin of Chaos.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:5:\"files\";a:5:{i:0;s:20:\"includes/context.inc\";i:1;s:22:\"includes/css-cache.inc\";i:2;s:22:\"includes/math-expr.inc\";i:3;s:21:\"includes/stylizer.inc\";i:4;s:20:\"tests/css_cache.test\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/ctools_access_ruleset/ctools_access_ruleset.module","ctools_access_ruleset","module","","0","0","-1","0","a:12:{s:4:\"name\";s:15:\"Custom rulesets\";s:11:\"description\";s:81:\"Create custom, exportable, reusable access rulesets for applications like Panels.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/ctools_ajax_sample/ctools_ajax_sample.module","ctools_ajax_sample","module","","0","0","-1","0","a:12:{s:4:\"name\";s:33:\"Chaos Tools (CTools) AJAX Example\";s:11:\"description\";s:41:\"Shows how to use the power of Chaos AJAX.\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/ctools_custom_content/ctools_custom_content.module","ctools_custom_content","module","","0","0","-1","0","a:12:{s:4:\"name\";s:20:\"Custom content panes\";s:11:\"description\";s:79:\"Create custom, exportable, reusable content panes for applications like Panels.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/ctools_plugin_example/ctools_plugin_example.module","ctools_plugin_example","module","","0","0","-1","0","a:12:{s:4:\"name\";s:35:\"Chaos Tools (CTools) Plugin Example\";s:11:\"description\";s:75:\"Shows how an external module can provide ctools plugins (for Panels, etc.).\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:12:\"dependencies\";a:4:{i:0;s:6:\"ctools\";i:1;s:6:\"panels\";i:2;s:12:\"page_manager\";i:3;s:13:\"advanced_help\";}s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/page_manager/page_manager.module","page_manager","module","","0","0","-1","0","a:12:{s:4:\"name\";s:12:\"Page manager\";s:11:\"description\";s:54:\"Provides a UI and API to manage pages within the site.\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/stylizer/stylizer.module","stylizer","module","","0","0","-1","0","a:12:{s:4:\"name\";s:8:\"Stylizer\";s:11:\"description\";s:53:\"Create custom styles for applications such as Panels.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:12:\"dependencies\";a:2:{i:0;s:6:\"ctools\";i:1;s:5:\"color\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/term_depth/term_depth.module","term_depth","module","","0","0","-1","0","a:12:{s:4:\"name\";s:17:\"Term Depth access\";s:11:\"description\";s:48:\"Controls access to context based upon term depth\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/tests/ctools_export_test/ctools_export_test.module","ctools_export_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:18:\"CTools export test\";s:11:\"description\";s:25:\"CTools export test module\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:6:\"hidden\";b:1;s:5:\"files\";a:1:{i:0;s:18:\"ctools_export.test\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/tests/ctools_plugin_test.module","ctools_plugin_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:24:\"Chaos tools plugins test\";s:11:\"description\";s:42:\"Provides hooks for testing ctools plugins.\";s:7:\"package\";s:16:\"Chaos tool suite\";s:7:\"version\";s:7:\"7.x-1.9\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:5:\"files\";a:6:{i:0;s:19:\"ctools.plugins.test\";i:1;s:17:\"object_cache.test\";i:2;s:8:\"css.test\";i:3;s:12:\"context.test\";i:4;s:20:\"math_expression.test\";i:5;s:26:\"math_expression_stack.test\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/ctools/views_content/views_content.module","views_content","module","","0","0","-1","0","a:12:{s:4:\"name\";s:19:\"Views content panes\";s:11:\"description\";s:104:\"Allows Views content to be used in Panels, Dashboard and other modules which use the CTools Content API.\";s:7:\"package\";s:16:\"Chaos tool suite\";s:12:\"dependencies\";a:2:{i:0;s:6:\"ctools\";i:1;s:5:\"views\";}s:4:\"core\";s:3:\"7.x\";s:7:\"version\";s:7:\"7.x-1.9\";s:5:\"files\";a:3:{i:0;s:61:\"plugins/views/views_content_plugin_display_ctools_context.inc\";i:1;s:57:\"plugins/views/views_content_plugin_display_panel_pane.inc\";i:2;s:59:\"plugins/views/views_content_plugin_style_ctools_context.inc\";}s:7:\"project\";s:6:\"ctools\";s:9:\"datestamp\";s:10:\"1440020680\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/globalredirect/globalredirect.module","globalredirect","module","","1","0","6101","0","a:13:{s:4:\"name\";s:15:\"Global Redirect\";s:11:\"description\";s:129:\"Searches for an alias of the current URL and 301 redirects if found. Stops duplicate content arising when path module is enabled.\";s:7:\"package\";s:15:\"Path management\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:19:\"globalredirect.test\";}s:9:\"configure\";s:34:\"admin/config/system/globalredirect\";s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:14:\"globalredirect\";s:9:\"datestamp\";s:10:\"1339748779\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/mailsystem/mailsystem.module","mailsystem","module","","1","0","0","0","a:13:{s:7:\"package\";s:4:\"Mail\";s:4:\"name\";s:11:\"Mail System\";s:11:\"description\";s:77:\"Provides a user interface for per-module and site-wide mail_system selection.\";s:3:\"php\";s:3:\"5.0\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:30:\"admin/config/system/mailsystem\";s:12:\"dependencies\";a:1:{i:0;s:6:\"filter\";}s:7:\"version\";s:8:\"7.x-2.34\";s:7:\"project\";s:10:\"mailsystem\";s:9:\"datestamp\";s:10:\"1334082653\";s:5:\"mtime\";i:1474356108;s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/memcache/memcache.module","memcache","module","","1","0","7000","0","a:12:{s:4:\"name\";s:8:\"Memcache\";s:11:\"description\";s:43:\"High performance integration with memcache.\";s:7:\"package\";s:27:\"Performance and scalability\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:4:{i:0;s:12:\"memcache.inc\";i:1;s:19:\"tests/memcache.test\";i:2;s:27:\"tests/memcache-session.test\";i:3;s:24:\"tests/memcache-lock.test\";}s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:8:\"memcache\";s:9:\"datestamp\";s:10:\"1422088394\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/memcache/memcache_admin/memcache_admin.module","memcache_admin","module","","0","0","-1","0","a:13:{s:4:\"name\";s:14:\"Memcache Admin\";s:11:\"description\";s:60:\"Adds a User Interface to monitor the Memcache for this site.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:27:\"Performance and scalability\";s:9:\"configure\";s:28:\"admin/config/system/memcache\";s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:8:\"memcache\";s:9:\"datestamp\";s:10:\"1422088394\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/memcache/tests/memcache_test.module","memcache_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:13:\"Memcache test\";s:11:\"description\";s:36:\"Support module for memcache testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:7:\"7.x-1.5\";s:7:\"project\";s:8:\"memcache\";s:9:\"datestamp\";s:10:\"1422088394\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag.module","metatag","module","","1","0","7110","0","a:14:{s:4:\"name\";s:7:\"Metatag\";s:11:\"description\";s:47:\"Adds support and an API to implement meta tags.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:3:{i:0;s:16:\"system (>= 7.28)\";i:1;s:6:\"ctools\";i:2;s:5:\"token\";}s:9:\"configure\";s:28:\"admin/config/search/metatags\";s:5:\"files\";a:22:{i:0;s:11:\"metatag.inc\";i:1;s:19:\"metatag.migrate.inc\";i:2;s:22:\"metatag.search_api.inc\";i:3;s:25:\"tests/metatag.helper.test\";i:4;s:23:\"tests/metatag.unit.test\";i:5;s:23:\"tests/metatag.node.test\";i:6;s:23:\"tests/metatag.term.test\";i:7;s:23:\"tests/metatag.user.test\";i:8;s:35:\"tests/metatag.core_tag_removal.test\";i:9;s:34:\"tests/metatag.string_handling.test\";i:10;s:44:\"tests/metatag.string_handling_with_i18n.test\";i:11;s:24:\"tests/metatag.image.test\";i:12;s:25:\"tests/metatag.locale.test\";i:13;s:35:\"tests/metatag.with_i18n_output.test\";i:14;s:37:\"tests/metatag.with_i18n_disabled.test\";i:15;s:35:\"tests/metatag.with_i18n_config.test\";i:16;s:33:\"tests/metatag.with_i18n_node.test\";i:17;s:29:\"tests/metatag.with_media.test\";i:18;s:30:\"tests/metatag.with_panels.test\";i:19;s:32:\"tests/metatag.with_profile2.test\";i:20;s:34:\"tests/metatag.with_search_api.test\";i:21;s:29:\"tests/metatag.with_views.test\";}s:17:\"test_dependencies\";a:12:{i:0;s:5:\"devel\";i:1;s:16:\"imagecache_token\";i:2;s:18:\"entity_translation\";i:3;s:4:\"i18n\";i:4;s:7:\"context\";i:5;s:6:\"panels\";i:6;s:5:\"views\";i:7;s:11:\"file_entity\";i:8;s:5:\"media\";i:9;s:6:\"entity\";i:10;s:10:\"search_api\";i:11;s:8:\"profile2\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_app_links/metatag_app_links.module","metatag_app_links","module","","0","0","-1","0","a:12:{s:4:\"name\";s:18:\"Metatag: App Links\";s:11:\"description\";s:44:\"Provides support for applinks.org meta tags.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:1:{i:0;s:28:\"tests/metatag_app_links.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_context/metatag_context.module","metatag_context","module","","0","0","-1","0","a:13:{s:4:\"name\";s:16:\"Metatag: Context\";s:11:\"description\";s:100:\"Assigned Metatag using Context definitions, allowing them to be assigned by path and other criteria.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:36:\"admin/config/search/metatags/context\";s:12:\"dependencies\";a:2:{i:0;s:7:\"metatag\";i:1;s:7:\"context\";}s:5:\"files\";a:2:{i:0;s:26:\"tests/metatag_context.test\";i:1;s:31:\"tests/metatag_context.i18n.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_context/tests/metatag_context_tests.module","metatag_context_tests","module","","0","0","-1","0","a:13:{s:4:\"name\";s:21:\"Metatag:Context Tests\";s:11:\"description\";s:49:\"Helper module for testing metatag_context.module.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:3:{i:0;s:7:\"context\";i:1;s:7:\"metatag\";i:2;s:15:\"metatag_context\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_dc/metatag_dc.module","metatag_dc","module","","0","0","-1","0","a:12:{s:4:\"name\";s:20:\"Metatag: Dublin Core\";s:11:\"description\";s:197:\"Provides the fifteen <a href=\"http://dublincore.org/documents/dces/\">Dublin Core Metadata Element Set 1.1</a> meta tags from the <a href=\"http://dublincore.org/\">Dublin Core Metadata Institute</a>.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:1:{i:0;s:21:\"tests/metatag_dc.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_dc_advanced/metatag_dc_advanced.module","metatag_dc_advanced","module","","0","0","-1","0","a:12:{s:4:\"name\";s:29:\"Metatag: Dublin Core Advanced\";s:11:\"description\";s:113:\"Provides forty additional meta tags from the <a href=\"http://dublincore.org/\">Dublin Core Metadata Institute</a>.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:7:\"metatag\";i:1;s:10:\"metatag_dc\";}s:5:\"files\";a:1:{i:0;s:30:\"tests/metatag_dc_advanced.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_devel/metatag_devel.module","metatag_devel","module","","0","0","-1","0","a:13:{s:4:\"name\";s:14:\"Metatag: Devel\";s:11:\"description\";s:102:\"Provides development / debugging functionality for the Metatag module. Integrates with Devel Generate.\";s:7:\"package\";s:11:\"Development\";s:4:\"core\";s:3:\"7.x\";s:4:\"tags\";a:1:{i:0;s:9:\"developer\";}s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:1:{i:0;s:24:\"tests/metatag_devel.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_facebook/metatag_facebook.module","metatag_facebook","module","","0","0","-1","0","a:12:{s:4:\"name\";s:17:\"Metatag: Facebook\";s:11:\"description\";s:49:\"Provides support for Facebook\'s custom meta tags.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:1:{i:0;s:27:\"tests/metatag_facebook.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_favicons/metatag_favicons.module","metatag_favicons","module","","0","0","-1","0","a:12:{s:4:\"name\";s:17:\"Metatag: favicons\";s:11:\"description\";s:37:\"Provides support for custom favicons.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:2:{i:0;s:36:\"metatag_favicons.mask-icon.class.inc\";i:1;s:27:\"tests/metatag_favicons.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_google_plus/metatag_google_plus.module","metatag_google_plus","module","","0","0","-1","0","a:12:{s:4:\"name\";s:16:\"Metatag: Google+\";s:11:\"description\";s:51:\"Provides support for Google+ \'itemscope\' meta tags.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:2:{i:0;s:23:\"metatag_google_plus.inc\";i:1;s:30:\"tests/metatag_google_plus.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_hreflang/metatag_hreflang.module","metatag_hreflang","module","","0","0","-1","0","a:12:{s:4:\"name\";s:17:\"Metatag: hreflang\";s:11:\"description\";s:80:\"Provides support for the hreflang meta tag with some extra logic to simplify it.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:7:\"metatag\";i:1;s:6:\"locale\";}s:5:\"files\";a:2:{i:0;s:27:\"tests/metatag_hreflang.test\";i:1;s:45:\"metatag_hreflang.with_entity_translation.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_importer/metatag_importer.module","metatag_importer","module","","0","0","-1","0","a:12:{s:4:\"name\";s:16:\"Metatag Importer\";s:11:\"description\";s:44:\"Import data from other modules into Metatag.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:3:\"SEO\";s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:1:{i:0;s:27:\"tests/metatag_importer.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_mobile/metatag_mobile.module","metatag_mobile","module","","0","0","-1","0","a:12:{s:4:\"name\";s:32:\"Metatag: Mobile & UI Adjustments\";s:11:\"description\";s:77:\"Provides support for meta tags used to control the mobile browser experience.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:1:{i:0;s:25:\"tests/metatag_mobile.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_opengraph/metatag_opengraph.module","metatag_opengraph","module","","0","0","-1","0","a:12:{s:4:\"name\";s:18:\"Metatag: OpenGraph\";s:11:\"description\";s:51:\"Provides support for Open Graph Protocol meta tags.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:1:{i:0;s:28:\"tests/metatag_opengraph.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_opengraph_products/metatag_opengraph_products.module","metatag_opengraph_products","module","","0","0","-1","0","a:12:{s:4:\"name\";s:26:\"Metatag:OpenGraph Products\";s:11:\"description\";s:74:\"Provides additional Open Graph Protocol meta tags for describing products.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:7:\"metatag\";i:1;s:17:\"metatag_opengraph\";}s:5:\"files\";a:1:{i:0;s:37:\"tests/metatag_opengraph_products.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_panels/metatag_panels.module","metatag_panels","module","","0","0","-1","0","a:12:{s:4:\"name\";s:15:\"Metatag: Panels\";s:11:\"description\";s:57:\"Provides Metatag integration within the Panels interface.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:7:\"metatag\";i:1;s:6:\"panels\";}s:5:\"files\";a:2:{i:0;s:25:\"tests/metatag_panels.test\";i:1;s:30:\"tests/metatag_panels.i18n.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_panels/tests/metatag_panels_tests.module","metatag_panels_tests","module","","0","0","-1","0","a:13:{s:4:\"name\";s:20:\"Metatag:Panels Tests\";s:11:\"description\";s:48:\"Helper module for testing metatag_panels.module.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:4:{i:0;s:6:\"ctools\";i:1;s:12:\"page_manager\";i:2;s:7:\"metatag\";i:3;s:14:\"metatag_panels\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_twitter_cards/metatag_twitter_cards.module","metatag_twitter_cards","module","","0","0","-1","0","a:12:{s:4:\"name\";s:22:\"Metatag: Twitter Cards\";s:11:\"description\";s:46:\"Provides support for Twitter\'s Card meta tags.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:1:{i:0;s:32:\"tests/metatag_twitter_cards.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_verification/metatag_verification.module","metatag_verification","module","","0","0","-1","0","a:12:{s:4:\"name\";s:21:\"Metatag: Verification\";s:11:\"description\";s:52:\"Various meta tags for verifying ownership of a site.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:5:\"files\";a:1:{i:0;s:31:\"tests/metatag_verification.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_views/metatag_views.module","metatag_views","module","","0","0","-1","0","a:12:{s:4:\"name\";s:14:\"Metatag: Views\";s:11:\"description\";s:56:\"Provides Metatag integration within the Views interface.\";s:7:\"package\";s:3:\"SEO\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:7:\"metatag\";i:1;s:5:\"views\";}s:5:\"files\";a:4:{i:0;s:17:\"metatag_views.inc\";i:1;s:50:\"metatag_views_plugin_display_extender_metatags.inc\";i:2;s:24:\"tests/metatag_views.test\";i:3;s:29:\"tests/metatag_views.i18n.test\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/metatag_views/tests/metatag_views_tests.module","metatag_views_tests","module","","0","0","-1","0","a:13:{s:4:\"name\";s:19:\"Metatag:Views Tests\";s:11:\"description\";s:47:\"Helper module for testing metatag_views.module.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:3:{i:0;s:7:\"metatag\";i:1;s:13:\"metatag_views\";i:2;s:5:\"views\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/tests/metatag_search_test.module","metatag_search_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:23:\"Metatag Search API test\";s:11:\"description\";s:51:\"Test module for the Metatag Search API integration.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Metatag\";s:12:\"dependencies\";a:2:{i:0;s:7:\"metatag\";i:1;s:10:\"search_api\";}s:6:\"hidden\";b:1;s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/metatag/tests/metatag_test.module","metatag_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:13:\"Meta Tag Test\";s:11:\"description\";s:41:\"Helper module for testing metatag.module.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:7:\"metatag\";}s:7:\"version\";s:8:\"7.x-1.17\";s:7:\"project\";s:7:\"metatag\";s:9:\"datestamp\";s:10:\"1467306248\";s:5:\"mtime\";i:1474356108;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/page_title/page_title.module","page_title","module","","1","0","7200","0","a:13:{s:4:\"name\";s:10:\"Page Title\";s:11:\"description\";s:60:\"Enhanced control over the page title (in the &lt;head> tag).\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:3:\"SEO\";s:12:\"dependencies\";a:1:{i:0;s:5:\"token\";}s:5:\"files\";a:6:{i:0;s:17:\"page_title.module\";i:1;s:20:\"page_title.admin.inc\";i:2;s:21:\"page_title.tokens.inc\";i:3;s:15:\"page_title.test\";i:4;s:64:\"views/plugins/page_title_plugin_display_page_with_page_title.inc\";i:5;s:39:\"views_handler_field_node_page_title.inc\";}s:9:\"configure\";s:30:\"admin/config/search/page-title\";s:7:\"version\";s:7:\"7.x-2.7\";s:7:\"project\";s:10:\"page_title\";s:9:\"datestamp\";s:10:\"1336556786\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/pathauto/pathauto.module","pathauto","module","","1","0","7006","1","a:14:{s:4:\"name\";s:8:\"Pathauto\";s:11:\"description\";s:95:\"Provides a mechanism for modules to automatically generate aliases for the content they manage.\";s:12:\"dependencies\";a:2:{i:0;s:4:\"path\";i:1;s:5:\"token\";}s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:20:\"pathauto.migrate.inc\";i:1;s:13:\"pathauto.test\";}s:9:\"configure\";s:33:\"admin/config/search/path/patterns\";s:10:\"recommends\";a:1:{i:0;s:8:\"redirect\";}s:7:\"version\";s:7:\"7.x-1.3\";s:7:\"project\";s:8:\"pathauto\";s:9:\"datestamp\";s:10:\"1444232655\";s:5:\"mtime\";i:1474356108;s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/redirect/redirect.module","redirect","module","","1","1","7102","0","a:13:{s:4:\"name\";s:8:\"Redirect\";s:11:\"description\";s:51:\"Allows users to redirect from old URLs to new URLs.\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:9:{i:0;s:23:\"redirect.controller.inc\";i:1;s:13:\"redirect.test\";i:2;s:24:\"views/redirect.views.inc\";i:3;s:47:\"views/redirect_handler_filter_redirect_type.inc\";i:4;s:48:\"views/redirect_handler_field_redirect_source.inc\";i:5;s:50:\"views/redirect_handler_field_redirect_redirect.inc\";i:6;s:52:\"views/redirect_handler_field_redirect_operations.inc\";i:7;s:51:\"views/redirect_handler_field_redirect_link_edit.inc\";i:8;s:53:\"views/redirect_handler_field_redirect_link_delete.inc\";}s:9:\"configure\";s:37:\"admin/config/search/redirect/settings\";s:7:\"version\";s:11:\"7.x-1.0-rc3\";s:7:\"project\";s:8:\"redirect\";s:9:\"datestamp\";s:10:\"1436393342\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/search404/search404.module","search404","module","","1","0","0","0","a:13:{s:4:\"name\";s:10:\"Search 404\";s:11:\"description\";s:116:\"Automatically search for the keywords in URLs that result in 404 errors and show results instead of Page-Not-Found. \";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:16:\"search404.module\";i:1;s:17:\"search404.install\";}s:9:\"configure\";s:29:\"admin/config/search/search404\";s:7:\"version\";s:7:\"7.x-1.4\";s:7:\"project\";s:9:\"search404\";s:9:\"datestamp\";s:10:\"1456722437\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/securepages/securepages.module","securepages","module","","1","0","0","0","a:13:{s:4:\"name\";s:12:\"Secure Pages\";s:11:\"description\";s:182:\"Set which pages are always going to be used in secure mode (SSL) Warning: Do not enable this module without configuring your web server to handle SSL with this installation of Drupal\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:31:\"admin/config/system/securepages\";s:5:\"files\";a:1:{i:0;s:16:\"securepages.test\";}s:7:\"version\";s:13:\"7.x-1.0-beta2\";s:7:\"project\";s:11:\"securepages\";s:9:\"datestamp\";s:10:\"1383727115\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/sendgrid_integration/modules/sendgrid_integration_reports/sendgrid_integration_reports.module","sendgrid_integration_reports","module","","0","0","-1","0","a:12:{s:4:\"name\";s:28:\"Sendgrid Integration Reports\";s:11:\"description\";s:23:\"Sendgrid Reports Module\";s:12:\"dependencies\";a:1:{i:0;s:20:\"sendgrid_integration\";}s:7:\"package\";s:4:\"Mail\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:39:\"tests/sendgrid_integration_reports.test\";}s:7:\"version\";s:7:\"7.x-1.0\";s:7:\"project\";s:20:\"sendgrid_integration\";s:9:\"datestamp\";s:10:\"1467467044\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/sendgrid_integration/sendgrid_integration.module","sendgrid_integration","module","","1","0","7002","0","a:14:{s:4:\"name\";s:20:\"SendGrid Integration\";s:11:\"description\";s:56:\"Provides Sendgrid Integration for the Drupal Mail System\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:3:\"5.5\";s:7:\"package\";s:4:\"Mail\";s:9:\"configure\";s:30:\"admin/config/services/sendgrid\";s:5:\"files\";a:3:{i:0;s:21:\"inc/sendgrid.mail.inc\";i:1;s:31:\"tests/sendgrid_integration.test\";i:2;s:41:\"tests/sendgrid_integration.mail_test.test\";}s:12:\"dependencies\";a:2:{i:0;s:18:\"mailsystem (>=2.x)\";i:1;s:16:\"composer_manager\";}s:17:\"test_dependencies\";a:1:{i:0;s:7:\"maillog\";}s:7:\"version\";s:7:\"7.x-1.0\";s:7:\"project\";s:20:\"sendgrid_integration\";s:9:\"datestamp\";s:10:\"1467467044\";s:5:\"mtime\";i:1474356108;s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/token/tests/token_test.module","token_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:10:\"Token Test\";s:11:\"description\";s:39:\"Testing module for token functionality.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:17:\"token_test.module\";}s:6:\"hidden\";b:1;s:7:\"version\";s:7:\"7.x-1.6\";s:7:\"project\";s:5:\"token\";s:9:\"datestamp\";s:10:\"1425149060\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/token/token.module","token","module","","1","0","7001","0","a:12:{s:4:\"name\";s:5:\"Token\";s:11:\"description\";s:73:\"Provides a user interface for the Token API and some missing core tokens.\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"token.test\";}s:7:\"version\";s:7:\"7.x-1.6\";s:7:\"project\";s:5:\"token\";s:9:\"datestamp\";s:10:\"1425149060\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/views/tests/views_test.module","views_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:10:\"Views Test\";s:11:\"description\";s:22:\"Test module for Views.\";s:7:\"package\";s:5:\"Views\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"views\";}s:6:\"hidden\";b:1;s:7:\"version\";s:8:\"7.x-3.14\";s:7:\"project\";s:5:\"views\";s:9:\"datestamp\";s:10:\"1466019588\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/views/views.module","views","module","","1","0","7302","10","a:13:{s:4:\"name\";s:5:\"Views\";s:11:\"description\";s:55:\"Create customized lists and queries from your database.\";s:7:\"package\";s:5:\"Views\";s:4:\"core\";s:3:\"7.x\";s:3:\"php\";s:3:\"5.2\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:13:\"css/views.css\";s:37:\"sites/all/modules/views/css/views.css\";}}s:12:\"dependencies\";a:1:{i:0;s:6:\"ctools\";}s:5:\"files\";a:313:{i:0;s:31:\"handlers/views_handler_area.inc\";i:1;s:40:\"handlers/views_handler_area_messages.inc\";i:2;s:38:\"handlers/views_handler_area_result.inc\";i:3;s:36:\"handlers/views_handler_area_text.inc\";i:4;s:43:\"handlers/views_handler_area_text_custom.inc\";i:5;s:36:\"handlers/views_handler_area_view.inc\";i:6;s:35:\"handlers/views_handler_argument.inc\";i:7;s:40:\"handlers/views_handler_argument_date.inc\";i:8;s:43:\"handlers/views_handler_argument_formula.inc\";i:9;s:47:\"handlers/views_handler_argument_many_to_one.inc\";i:10;s:40:\"handlers/views_handler_argument_null.inc\";i:11;s:43:\"handlers/views_handler_argument_numeric.inc\";i:12;s:42:\"handlers/views_handler_argument_string.inc\";i:13;s:52:\"handlers/views_handler_argument_group_by_numeric.inc\";i:14;s:32:\"handlers/views_handler_field.inc\";i:15;s:40:\"handlers/views_handler_field_counter.inc\";i:16;s:40:\"handlers/views_handler_field_boolean.inc\";i:17;s:49:\"handlers/views_handler_field_contextual_links.inc\";i:18;s:48:\"handlers/views_handler_field_ctools_dropdown.inc\";i:19;s:39:\"handlers/views_handler_field_custom.inc\";i:20;s:37:\"handlers/views_handler_field_date.inc\";i:21;s:39:\"handlers/views_handler_field_entity.inc\";i:22;s:38:\"handlers/views_handler_field_links.inc\";i:23;s:39:\"handlers/views_handler_field_markup.inc\";i:24;s:37:\"handlers/views_handler_field_math.inc\";i:25;s:40:\"handlers/views_handler_field_numeric.inc\";i:26;s:47:\"handlers/views_handler_field_prerender_list.inc\";i:27;s:46:\"handlers/views_handler_field_time_interval.inc\";i:28;s:43:\"handlers/views_handler_field_serialized.inc\";i:29;s:45:\"handlers/views_handler_field_machine_name.inc\";i:30;s:36:\"handlers/views_handler_field_url.inc\";i:31;s:33:\"handlers/views_handler_filter.inc\";i:32;s:50:\"handlers/views_handler_filter_boolean_operator.inc\";i:33;s:57:\"handlers/views_handler_filter_boolean_operator_string.inc\";i:34;s:41:\"handlers/views_handler_filter_combine.inc\";i:35;s:38:\"handlers/views_handler_filter_date.inc\";i:36;s:42:\"handlers/views_handler_filter_equality.inc\";i:37;s:47:\"handlers/views_handler_filter_entity_bundle.inc\";i:38;s:50:\"handlers/views_handler_filter_group_by_numeric.inc\";i:39;s:45:\"handlers/views_handler_filter_in_operator.inc\";i:40;s:45:\"handlers/views_handler_filter_many_to_one.inc\";i:41;s:41:\"handlers/views_handler_filter_numeric.inc\";i:42;s:40:\"handlers/views_handler_filter_string.inc\";i:43;s:48:\"handlers/views_handler_filter_fields_compare.inc\";i:44;s:39:\"handlers/views_handler_relationship.inc\";i:45;s:53:\"handlers/views_handler_relationship_groupwise_max.inc\";i:46;s:31:\"handlers/views_handler_sort.inc\";i:47;s:36:\"handlers/views_handler_sort_date.inc\";i:48;s:39:\"handlers/views_handler_sort_formula.inc\";i:49;s:48:\"handlers/views_handler_sort_group_by_numeric.inc\";i:50;s:46:\"handlers/views_handler_sort_menu_hierarchy.inc\";i:51;s:38:\"handlers/views_handler_sort_random.inc\";i:52;s:17:\"includes/base.inc\";i:53;s:21:\"includes/handlers.inc\";i:54;s:20:\"includes/plugins.inc\";i:55;s:17:\"includes/view.inc\";i:56;s:60:\"modules/aggregator/views_handler_argument_aggregator_fid.inc\";i:57;s:60:\"modules/aggregator/views_handler_argument_aggregator_iid.inc\";i:58;s:69:\"modules/aggregator/views_handler_argument_aggregator_category_cid.inc\";i:59;s:64:\"modules/aggregator/views_handler_field_aggregator_title_link.inc\";i:60;s:62:\"modules/aggregator/views_handler_field_aggregator_category.inc\";i:61;s:70:\"modules/aggregator/views_handler_field_aggregator_item_description.inc\";i:62;s:57:\"modules/aggregator/views_handler_field_aggregator_xss.inc\";i:63;s:67:\"modules/aggregator/views_handler_filter_aggregator_category_cid.inc\";i:64;s:54:\"modules/aggregator/views_plugin_row_aggregator_rss.inc\";i:65;s:56:\"modules/book/views_plugin_argument_default_book_root.inc\";i:66;s:59:\"modules/comment/views_handler_argument_comment_user_uid.inc\";i:67;s:47:\"modules/comment/views_handler_field_comment.inc\";i:68;s:53:\"modules/comment/views_handler_field_comment_depth.inc\";i:69;s:52:\"modules/comment/views_handler_field_comment_link.inc\";i:70;s:60:\"modules/comment/views_handler_field_comment_link_approve.inc\";i:71;s:59:\"modules/comment/views_handler_field_comment_link_delete.inc\";i:72;s:57:\"modules/comment/views_handler_field_comment_link_edit.inc\";i:73;s:58:\"modules/comment/views_handler_field_comment_link_reply.inc\";i:74;s:57:\"modules/comment/views_handler_field_comment_node_link.inc\";i:75;s:56:\"modules/comment/views_handler_field_comment_username.inc\";i:76;s:61:\"modules/comment/views_handler_field_ncs_last_comment_name.inc\";i:77;s:56:\"modules/comment/views_handler_field_ncs_last_updated.inc\";i:78;s:52:\"modules/comment/views_handler_field_node_comment.inc\";i:79;s:57:\"modules/comment/views_handler_field_node_new_comments.inc\";i:80;s:62:\"modules/comment/views_handler_field_last_comment_timestamp.inc\";i:81;s:57:\"modules/comment/views_handler_filter_comment_user_uid.inc\";i:82;s:57:\"modules/comment/views_handler_filter_ncs_last_updated.inc\";i:83;s:53:\"modules/comment/views_handler_filter_node_comment.inc\";i:84;s:53:\"modules/comment/views_handler_sort_comment_thread.inc\";i:85;s:60:\"modules/comment/views_handler_sort_ncs_last_comment_name.inc\";i:86;s:55:\"modules/comment/views_handler_sort_ncs_last_updated.inc\";i:87;s:48:\"modules/comment/views_plugin_row_comment_rss.inc\";i:88;s:49:\"modules/comment/views_plugin_row_comment_view.inc\";i:89;s:52:\"modules/contact/views_handler_field_contact_link.inc\";i:90;s:43:\"modules/field/views_handler_field_field.inc\";i:91;s:59:\"modules/field/views_handler_relationship_entity_reverse.inc\";i:92;s:51:\"modules/field/views_handler_argument_field_list.inc\";i:93;s:57:\"modules/field/views_handler_filter_field_list_boolean.inc\";i:94;s:58:\"modules/field/views_handler_argument_field_list_string.inc\";i:95;s:49:\"modules/field/views_handler_filter_field_list.inc\";i:96;s:57:\"modules/filter/views_handler_field_filter_format_name.inc\";i:97;s:52:\"modules/locale/views_handler_field_node_language.inc\";i:98;s:53:\"modules/locale/views_handler_filter_node_language.inc\";i:99;s:54:\"modules/locale/views_handler_argument_locale_group.inc\";i:100;s:57:\"modules/locale/views_handler_argument_locale_language.inc\";i:101;s:51:\"modules/locale/views_handler_field_locale_group.inc\";i:102;s:54:\"modules/locale/views_handler_field_locale_language.inc\";i:103;s:55:\"modules/locale/views_handler_field_locale_link_edit.inc\";i:104;s:52:\"modules/locale/views_handler_filter_locale_group.inc\";i:105;s:55:\"modules/locale/views_handler_filter_locale_language.inc\";i:106;s:54:\"modules/locale/views_handler_filter_locale_version.inc\";i:107;s:51:\"modules/locale/views_handler_sort_node_language.inc\";i:108;s:53:\"modules/node/views_handler_argument_dates_various.inc\";i:109;s:53:\"modules/node/views_handler_argument_node_language.inc\";i:110;s:48:\"modules/node/views_handler_argument_node_nid.inc\";i:111;s:49:\"modules/node/views_handler_argument_node_type.inc\";i:112;s:48:\"modules/node/views_handler_argument_node_vid.inc\";i:113;s:57:\"modules/node/views_handler_argument_node_uid_revision.inc\";i:114;s:59:\"modules/node/views_handler_field_history_user_timestamp.inc\";i:115;s:41:\"modules/node/views_handler_field_node.inc\";i:116;s:46:\"modules/node/views_handler_field_node_link.inc\";i:117;s:53:\"modules/node/views_handler_field_node_link_delete.inc\";i:118;s:51:\"modules/node/views_handler_field_node_link_edit.inc\";i:119;s:50:\"modules/node/views_handler_field_node_revision.inc\";i:120;s:55:\"modules/node/views_handler_field_node_revision_link.inc\";i:121;s:62:\"modules/node/views_handler_field_node_revision_link_delete.inc\";i:122;s:62:\"modules/node/views_handler_field_node_revision_link_revert.inc\";i:123;s:46:\"modules/node/views_handler_field_node_path.inc\";i:124;s:46:\"modules/node/views_handler_field_node_type.inc\";i:125;s:55:\"modules/node/views_handler_field_node_version_count.inc\";i:126;s:60:\"modules/node/views_handler_filter_history_user_timestamp.inc\";i:127;s:49:\"modules/node/views_handler_filter_node_access.inc\";i:128;s:49:\"modules/node/views_handler_filter_node_status.inc\";i:129;s:47:\"modules/node/views_handler_filter_node_type.inc\";i:130;s:55:\"modules/node/views_handler_filter_node_uid_revision.inc\";i:131;s:56:\"modules/node/views_handler_filter_node_version_count.inc\";i:132;s:54:\"modules/node/views_handler_sort_node_version_count.inc\";i:133;s:51:\"modules/node/views_plugin_argument_default_node.inc\";i:134;s:52:\"modules/node/views_plugin_argument_validate_node.inc\";i:135;s:42:\"modules/node/views_plugin_row_node_rss.inc\";i:136;s:43:\"modules/node/views_plugin_row_node_view.inc\";i:137;s:52:\"modules/profile/views_handler_field_profile_date.inc\";i:138;s:52:\"modules/profile/views_handler_field_profile_list.inc\";i:139;s:58:\"modules/profile/views_handler_filter_profile_selection.inc\";i:140;s:48:\"modules/search/views_handler_argument_search.inc\";i:141;s:51:\"modules/search/views_handler_field_search_score.inc\";i:142;s:46:\"modules/search/views_handler_filter_search.inc\";i:143;s:50:\"modules/search/views_handler_sort_search_score.inc\";i:144;s:47:\"modules/search/views_plugin_row_search_view.inc\";i:145;s:57:\"modules/statistics/views_handler_field_accesslog_path.inc\";i:146;s:65:\"modules/statistics/views_handler_field_node_counter_timestamp.inc\";i:147;s:61:\"modules/statistics/views_handler_field_statistics_numeric.inc\";i:148;s:50:\"modules/system/views_handler_argument_file_fid.inc\";i:149;s:43:\"modules/system/views_handler_field_file.inc\";i:150;s:53:\"modules/system/views_handler_field_file_extension.inc\";i:151;s:52:\"modules/system/views_handler_field_file_filemime.inc\";i:152;s:47:\"modules/system/views_handler_field_file_uri.inc\";i:153;s:50:\"modules/system/views_handler_field_file_status.inc\";i:154;s:51:\"modules/system/views_handler_filter_file_status.inc\";i:155;s:52:\"modules/taxonomy/views_handler_argument_taxonomy.inc\";i:156;s:57:\"modules/taxonomy/views_handler_argument_term_node_tid.inc\";i:157;s:63:\"modules/taxonomy/views_handler_argument_term_node_tid_depth.inc\";i:158;s:68:\"modules/taxonomy/views_handler_argument_term_node_tid_depth_join.inc\";i:159;s:72:\"modules/taxonomy/views_handler_argument_term_node_tid_depth_modifier.inc\";i:160;s:58:\"modules/taxonomy/views_handler_argument_vocabulary_vid.inc\";i:161;s:67:\"modules/taxonomy/views_handler_argument_vocabulary_machine_name.inc\";i:162;s:49:\"modules/taxonomy/views_handler_field_taxonomy.inc\";i:163;s:54:\"modules/taxonomy/views_handler_field_term_node_tid.inc\";i:164;s:55:\"modules/taxonomy/views_handler_field_term_link_edit.inc\";i:165;s:55:\"modules/taxonomy/views_handler_filter_term_node_tid.inc\";i:166;s:61:\"modules/taxonomy/views_handler_filter_term_node_tid_depth.inc\";i:167;s:66:\"modules/taxonomy/views_handler_filter_term_node_tid_depth_join.inc\";i:168;s:56:\"modules/taxonomy/views_handler_filter_vocabulary_vid.inc\";i:169;s:65:\"modules/taxonomy/views_handler_filter_vocabulary_machine_name.inc\";i:170;s:62:\"modules/taxonomy/views_handler_relationship_node_term_data.inc\";i:171;s:65:\"modules/taxonomy/views_plugin_argument_validate_taxonomy_term.inc\";i:172;s:63:\"modules/taxonomy/views_plugin_argument_default_taxonomy_tid.inc\";i:173;s:67:\"modules/tracker/views_handler_argument_tracker_comment_user_uid.inc\";i:174;s:65:\"modules/tracker/views_handler_filter_tracker_comment_user_uid.inc\";i:175;s:65:\"modules/tracker/views_handler_filter_tracker_boolean_operator.inc\";i:176;s:51:\"modules/system/views_handler_filter_system_type.inc\";i:177;s:56:\"modules/translation/views_handler_argument_node_tnid.inc\";i:178;s:63:\"modules/translation/views_handler_field_node_link_translate.inc\";i:179;s:65:\"modules/translation/views_handler_field_node_translation_link.inc\";i:180;s:54:\"modules/translation/views_handler_filter_node_tnid.inc\";i:181;s:60:\"modules/translation/views_handler_filter_node_tnid_child.inc\";i:182;s:62:\"modules/translation/views_handler_relationship_translation.inc\";i:183;s:48:\"modules/user/views_handler_argument_user_uid.inc\";i:184;s:55:\"modules/user/views_handler_argument_users_roles_rid.inc\";i:185;s:41:\"modules/user/views_handler_field_user.inc\";i:186;s:50:\"modules/user/views_handler_field_user_language.inc\";i:187;s:46:\"modules/user/views_handler_field_user_link.inc\";i:188;s:53:\"modules/user/views_handler_field_user_link_cancel.inc\";i:189;s:51:\"modules/user/views_handler_field_user_link_edit.inc\";i:190;s:46:\"modules/user/views_handler_field_user_mail.inc\";i:191;s:46:\"modules/user/views_handler_field_user_name.inc\";i:192;s:53:\"modules/user/views_handler_field_user_permissions.inc\";i:193;s:49:\"modules/user/views_handler_field_user_picture.inc\";i:194;s:47:\"modules/user/views_handler_field_user_roles.inc\";i:195;s:50:\"modules/user/views_handler_filter_user_current.inc\";i:196;s:47:\"modules/user/views_handler_filter_user_name.inc\";i:197;s:54:\"modules/user/views_handler_filter_user_permissions.inc\";i:198;s:48:\"modules/user/views_handler_filter_user_roles.inc\";i:199;s:59:\"modules/user/views_plugin_argument_default_current_user.inc\";i:200;s:51:\"modules/user/views_plugin_argument_default_user.inc\";i:201;s:52:\"modules/user/views_plugin_argument_validate_user.inc\";i:202;s:43:\"modules/user/views_plugin_row_user_view.inc\";i:203;s:31:\"plugins/views_plugin_access.inc\";i:204;s:36:\"plugins/views_plugin_access_none.inc\";i:205;s:36:\"plugins/views_plugin_access_perm.inc\";i:206;s:36:\"plugins/views_plugin_access_role.inc\";i:207;s:41:\"plugins/views_plugin_argument_default.inc\";i:208;s:45:\"plugins/views_plugin_argument_default_php.inc\";i:209;s:47:\"plugins/views_plugin_argument_default_fixed.inc\";i:210;s:45:\"plugins/views_plugin_argument_default_raw.inc\";i:211;s:42:\"plugins/views_plugin_argument_validate.inc\";i:212;s:50:\"plugins/views_plugin_argument_validate_numeric.inc\";i:213;s:46:\"plugins/views_plugin_argument_validate_php.inc\";i:214;s:30:\"plugins/views_plugin_cache.inc\";i:215;s:35:\"plugins/views_plugin_cache_none.inc\";i:216;s:35:\"plugins/views_plugin_cache_time.inc\";i:217;s:32:\"plugins/views_plugin_display.inc\";i:218;s:43:\"plugins/views_plugin_display_attachment.inc\";i:219;s:38:\"plugins/views_plugin_display_block.inc\";i:220;s:40:\"plugins/views_plugin_display_default.inc\";i:221;s:38:\"plugins/views_plugin_display_embed.inc\";i:222;s:41:\"plugins/views_plugin_display_extender.inc\";i:223;s:37:\"plugins/views_plugin_display_feed.inc\";i:224;s:37:\"plugins/views_plugin_display_page.inc\";i:225;s:43:\"plugins/views_plugin_exposed_form_basic.inc\";i:226;s:37:\"plugins/views_plugin_exposed_form.inc\";i:227;s:52:\"plugins/views_plugin_exposed_form_input_required.inc\";i:228;s:42:\"plugins/views_plugin_localization_core.inc\";i:229;s:37:\"plugins/views_plugin_localization.inc\";i:230;s:42:\"plugins/views_plugin_localization_none.inc\";i:231;s:30:\"plugins/views_plugin_pager.inc\";i:232;s:35:\"plugins/views_plugin_pager_full.inc\";i:233;s:35:\"plugins/views_plugin_pager_mini.inc\";i:234;s:35:\"plugins/views_plugin_pager_none.inc\";i:235;s:35:\"plugins/views_plugin_pager_some.inc\";i:236;s:30:\"plugins/views_plugin_query.inc\";i:237;s:38:\"plugins/views_plugin_query_default.inc\";i:238;s:28:\"plugins/views_plugin_row.inc\";i:239;s:35:\"plugins/views_plugin_row_fields.inc\";i:240;s:39:\"plugins/views_plugin_row_rss_fields.inc\";i:241;s:30:\"plugins/views_plugin_style.inc\";i:242;s:38:\"plugins/views_plugin_style_default.inc\";i:243;s:35:\"plugins/views_plugin_style_grid.inc\";i:244;s:35:\"plugins/views_plugin_style_list.inc\";i:245;s:40:\"plugins/views_plugin_style_jump_menu.inc\";i:246;s:38:\"plugins/views_plugin_style_mapping.inc\";i:247;s:34:\"plugins/views_plugin_style_rss.inc\";i:248;s:38:\"plugins/views_plugin_style_summary.inc\";i:249;s:48:\"plugins/views_plugin_style_summary_jump_menu.inc\";i:250;s:50:\"plugins/views_plugin_style_summary_unformatted.inc\";i:251;s:36:\"plugins/views_plugin_style_table.inc\";i:252;s:34:\"tests/handlers/views_handlers.test\";i:253;s:43:\"tests/handlers/views_handler_area_text.test\";i:254;s:47:\"tests/handlers/views_handler_argument_null.test\";i:255;s:49:\"tests/handlers/views_handler_argument_string.test\";i:256;s:39:\"tests/handlers/views_handler_field.test\";i:257;s:47:\"tests/handlers/views_handler_field_boolean.test\";i:258;s:46:\"tests/handlers/views_handler_field_custom.test\";i:259;s:47:\"tests/handlers/views_handler_field_counter.test\";i:260;s:44:\"tests/handlers/views_handler_field_date.test\";i:261;s:54:\"tests/handlers/views_handler_field_file_extension.test\";i:262;s:49:\"tests/handlers/views_handler_field_file_size.test\";i:263;s:44:\"tests/handlers/views_handler_field_math.test\";i:264;s:43:\"tests/handlers/views_handler_field_url.test\";i:265;s:43:\"tests/handlers/views_handler_field_xss.test\";i:266;s:48:\"tests/handlers/views_handler_filter_combine.test\";i:267;s:45:\"tests/handlers/views_handler_filter_date.test\";i:268;s:49:\"tests/handlers/views_handler_filter_equality.test\";i:269;s:52:\"tests/handlers/views_handler_filter_in_operator.test\";i:270;s:48:\"tests/handlers/views_handler_filter_numeric.test\";i:271;s:47:\"tests/handlers/views_handler_filter_string.test\";i:272;s:45:\"tests/handlers/views_handler_sort_random.test\";i:273;s:43:\"tests/handlers/views_handler_sort_date.test\";i:274;s:38:\"tests/handlers/views_handler_sort.test\";i:275;s:46:\"tests/test_handlers/views_test_area_access.inc\";i:276;s:60:\"tests/test_plugins/views_test_plugin_access_test_dynamic.inc\";i:277;s:59:\"tests/test_plugins/views_test_plugin_access_test_static.inc\";i:278;s:59:\"tests/test_plugins/views_test_plugin_style_test_mapping.inc\";i:279;s:39:\"tests/plugins/views_plugin_display.test\";i:280;s:46:\"tests/styles/views_plugin_style_jump_menu.test\";i:281;s:36:\"tests/styles/views_plugin_style.test\";i:282;s:41:\"tests/styles/views_plugin_style_base.test\";i:283;s:44:\"tests/styles/views_plugin_style_mapping.test\";i:284;s:48:\"tests/styles/views_plugin_style_unformatted.test\";i:285;s:23:\"tests/views_access.test\";i:286;s:24:\"tests/views_analyze.test\";i:287;s:22:\"tests/views_basic.test\";i:288;s:33:\"tests/views_argument_default.test\";i:289;s:35:\"tests/views_argument_validator.test\";i:290;s:29:\"tests/views_exposed_form.test\";i:291;s:31:\"tests/field/views_fieldapi.test\";i:292;s:25:\"tests/views_glossary.test\";i:293;s:24:\"tests/views_groupby.test\";i:294;s:25:\"tests/views_handlers.test\";i:295;s:23:\"tests/views_module.test\";i:296;s:22:\"tests/views_pager.test\";i:297;s:40:\"tests/views_plugin_localization_test.inc\";i:298;s:29:\"tests/views_translatable.test\";i:299;s:22:\"tests/views_query.test\";i:300;s:24:\"tests/views_upgrade.test\";i:301;s:34:\"tests/views_test.views_default.inc\";i:302;s:58:\"tests/comment/views_handler_argument_comment_user_uid.test\";i:303;s:56:\"tests/comment/views_handler_filter_comment_user_uid.test\";i:304;s:45:\"tests/node/views_node_revision_relations.test\";i:305;s:61:\"tests/taxonomy/views_handler_relationship_node_term_data.test\";i:306;s:45:\"tests/user/views_handler_field_user_name.test\";i:307;s:43:\"tests/user/views_user_argument_default.test\";i:308;s:44:\"tests/user/views_user_argument_validate.test\";i:309;s:26:\"tests/user/views_user.test\";i:310;s:22:\"tests/views_cache.test\";i:311;s:21:\"tests/views_view.test\";i:312;s:19:\"tests/views_ui.test\";}s:7:\"version\";s:8:\"7.x-3.14\";s:7:\"project\";s:5:\"views\";s:9:\"datestamp\";s:10:\"1466019588\";s:5:\"mtime\";i:1474356108;s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/views/views_ui.module","views_ui","module","","0","0","-1","0","a:13:{s:4:\"name\";s:8:\"Views UI\";s:11:\"description\";s:93:\"Administrative interface to views. Without this module, you cannot create or edit your views.\";s:7:\"package\";s:5:\"Views\";s:4:\"core\";s:3:\"7.x\";s:9:\"configure\";s:21:\"admin/structure/views\";s:12:\"dependencies\";a:1:{i:0;s:5:\"views\";}s:5:\"files\";a:2:{i:0;s:15:\"views_ui.module\";i:1;s:57:\"plugins/views_wizard/views_ui_base_views_wizard.class.php\";}s:7:\"version\";s:8:\"7.x-3.14\";s:7:\"project\";s:5:\"views\";s:9:\"datestamp\";s:10:\"1466019588\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/webform/webform.module","webform","module","","1","0","7430","-1","a:14:{s:4:\"name\";s:7:\"Webform\";s:11:\"description\";s:49:\"Enables the creation of forms and questionnaires.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Webform\";s:9:\"configure\";s:28:\"admin/config/content/webform\";s:3:\"php\";s:3:\"5.3\";s:12:\"dependencies\";a:2:{i:0;s:6:\"ctools\";i:1;s:5:\"views\";}s:17:\"test_dependencies\";a:1:{i:0;s:5:\"token\";}s:5:\"files\";a:26:{i:0;s:40:\"includes/webform.webformconditionals.inc\";i:1;s:49:\"includes/exporters/webform_exporter_delimited.inc\";i:2;s:55:\"includes/exporters/webform_exporter_excel_delimited.inc\";i:3;s:50:\"includes/exporters/webform_exporter_excel_xlsx.inc\";i:4;s:39:\"includes/exporters/webform_exporter.inc\";i:5;s:43:\"views/webform_handler_area_result_pager.inc\";i:6;s:41:\"views/webform_handler_field_form_body.inc\";i:7;s:40:\"views/webform_handler_field_is_draft.inc\";i:8;s:46:\"views/webform_handler_field_node_link_edit.inc\";i:9;s:49:\"views/webform_handler_field_node_link_results.inc\";i:10;s:48:\"views/webform_handler_field_submission_count.inc\";i:11;s:47:\"views/webform_handler_field_submission_data.inc\";i:12;s:47:\"views/webform_handler_field_submission_link.inc\";i:13;s:46:\"views/webform_handler_field_webform_status.inc\";i:14;s:41:\"views/webform_handler_filter_is_draft.inc\";i:15;s:48:\"views/webform_handler_filter_submission_data.inc\";i:16;s:47:\"views/webform_handler_filter_webform_status.inc\";i:17;s:38:\"views/webform_handler_numeric_data.inc\";i:18;s:54:\"views/webform_handler_relationship_submission_data.inc\";i:19;s:44:\"views/webform_plugin_row_submission_view.inc\";i:20;s:23:\"views/webform.views.inc\";i:21;s:21:\"tests/components.test\";i:22;s:23:\"tests/conditionals.test\";i:23;s:22:\"tests/permissions.test\";i:24;s:21:\"tests/submission.test\";i:25;s:18:\"tests/webform.test\";}s:7:\"version\";s:8:\"7.x-4.12\";s:7:\"project\";s:7:\"webform\";s:9:\"datestamp\";s:10:\"1445622245\";s:5:\"mtime\";i:1474356108;s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/xmlsitemap/xmlsitemap.module","xmlsitemap","module","","1","0","7203","1","a:14:{s:4:\"name\";s:11:\"XML sitemap\";s:11:\"description\";s:98:\"Creates an XML sitemap conforming to the <a href=\"http://sitemaps.org/\">sitemaps.org protocol</a>.\";s:7:\"package\";s:11:\"XML sitemap\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:9:{i:0;s:17:\"xmlsitemap.module\";i:1;s:14:\"xmlsitemap.inc\";i:2;s:20:\"xmlsitemap.admin.inc\";i:3;s:20:\"xmlsitemap.drush.inc\";i:4;s:23:\"xmlsitemap.generate.inc\";i:5;s:25:\"xmlsitemap.xmlsitemap.inc\";i:6;s:20:\"xmlsitemap.pages.inc\";i:7;s:18:\"xmlsitemap.install\";i:8;s:15:\"xmlsitemap.test\";}s:10:\"recommends\";a:1:{i:0;s:9:\"robotstxt\";}s:9:\"configure\";s:30:\"admin/config/search/xmlsitemap\";s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:10:\"xmlsitemap\";s:9:\"datestamp\";s:10:\"1464191061\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/xmlsitemap/xmlsitemap_custom/xmlsitemap_custom.module","xmlsitemap_custom","module","","0","0","-1","0","a:13:{s:4:\"name\";s:18:\"XML sitemap custom\";s:11:\"description\";s:44:\"Adds user configurable links to the sitemap.\";s:7:\"package\";s:11:\"XML sitemap\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:10:\"xmlsitemap\";}s:5:\"files\";a:4:{i:0;s:24:\"xmlsitemap_custom.module\";i:1;s:27:\"xmlsitemap_custom.admin.inc\";i:2;s:25:\"xmlsitemap_custom.install\";i:3;s:22:\"xmlsitemap_custom.test\";}s:9:\"configure\";s:37:\"admin/config/search/xmlsitemap/custom\";s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:10:\"xmlsitemap\";s:9:\"datestamp\";s:10:\"1464191061\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/xmlsitemap/xmlsitemap_engines/tests/xmlsitemap_engines_test.module","xmlsitemap_engines_test","module","","0","0","-1","0","a:13:{s:4:\"name\";s:24:\"XML sitemap engines test\";s:11:\"description\";s:47:\"Support module for XML sitemap engines testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:30:\"xmlsitemap_engines_test.module\";}s:7:\"version\";s:7:\"7.x-2.3\";s:6:\"hidden\";b:1;s:7:\"project\";s:10:\"xmlsitemap\";s:9:\"datestamp\";s:10:\"1464191061\";s:5:\"mtime\";i:1474356108;s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/xmlsitemap/xmlsitemap_engines/xmlsitemap_engines.module","xmlsitemap_engines","module","","0","0","-1","0","a:14:{s:4:\"name\";s:19:\"XML sitemap engines\";s:11:\"description\";s:37:\"Submit the sitemap to search engines.\";s:7:\"package\";s:11:\"XML sitemap\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:10:\"xmlsitemap\";}s:5:\"files\";a:4:{i:0;s:25:\"xmlsitemap_engines.module\";i:1;s:28:\"xmlsitemap_engines.admin.inc\";i:2;s:26:\"xmlsitemap_engines.install\";i:3;s:29:\"tests/xmlsitemap_engines.test\";}s:10:\"recommends\";a:1:{i:0;s:11:\"site_verify\";}s:9:\"configure\";s:38:\"admin/config/search/xmlsitemap/engines\";s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:10:\"xmlsitemap\";s:9:\"datestamp\";s:10:\"1464191061\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/xmlsitemap/xmlsitemap_i18n/xmlsitemap_i18n.module","xmlsitemap_i18n","module","","0","0","-1","0","a:12:{s:4:\"name\";s:32:\"XML sitemap internationalization\";s:11:\"description\";s:34:\"Enables multilingual XML sitemaps.\";s:7:\"package\";s:11:\"XML sitemap\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:10:\"xmlsitemap\";i:1;s:4:\"i18n\";}s:5:\"files\";a:2:{i:0;s:22:\"xmlsitemap_i18n.module\";i:1;s:20:\"xmlsitemap_i18n.test\";}s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:10:\"xmlsitemap\";s:9:\"datestamp\";s:10:\"1464191061\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/xmlsitemap/xmlsitemap_menu/xmlsitemap_menu.module","xmlsitemap_menu","module","","0","0","-1","0","a:12:{s:4:\"name\";s:16:\"XML sitemap menu\";s:11:\"description\";s:36:\"Adds menu item links to the sitemap.\";s:7:\"package\";s:11:\"XML sitemap\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:10:\"xmlsitemap\";i:1;s:4:\"menu\";}s:5:\"files\";a:3:{i:0;s:22:\"xmlsitemap_menu.module\";i:1;s:23:\"xmlsitemap_menu.install\";i:2;s:20:\"xmlsitemap_menu.test\";}s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:10:\"xmlsitemap\";s:9:\"datestamp\";s:10:\"1464191061\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/xmlsitemap/xmlsitemap_modal/xmlsitemap_modal.module","xmlsitemap_modal","module","","0","0","-1","0","a:13:{s:4:\"name\";s:20:\"XML sitemap modal UI\";s:11:\"description\";s:55:\"Provides an AJAX modal UI for common XML sitemap tasks.\";s:7:\"package\";s:11:\"XML sitemap\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:10:\"xmlsitemap\";i:1;s:6:\"ctools\";}s:5:\"files\";a:1:{i:0;s:23:\"xmlsitemap_modal.module\";}s:6:\"hidden\";b:1;s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:10:\"xmlsitemap\";s:9:\"datestamp\";s:10:\"1464191061\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/xmlsitemap/xmlsitemap_node/xmlsitemap_node.module","xmlsitemap_node","module","","0","0","-1","0","a:12:{s:4:\"name\";s:16:\"XML sitemap node\";s:11:\"description\";s:34:\"Adds content links to the sitemap.\";s:7:\"package\";s:11:\"XML sitemap\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:10:\"xmlsitemap\";}s:5:\"files\";a:3:{i:0;s:22:\"xmlsitemap_node.module\";i:1;s:23:\"xmlsitemap_node.install\";i:2;s:20:\"xmlsitemap_node.test\";}s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:10:\"xmlsitemap\";s:9:\"datestamp\";s:10:\"1464191061\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/xmlsitemap/xmlsitemap_taxonomy/xmlsitemap_taxonomy.module","xmlsitemap_taxonomy","module","","0","0","-1","0","a:12:{s:4:\"name\";s:20:\"XML sitemap taxonomy\";s:11:\"description\";s:39:\"Add taxonomy term links to the sitemap.\";s:7:\"package\";s:11:\"XML sitemap\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:10:\"xmlsitemap\";i:1;s:8:\"taxonomy\";}s:5:\"files\";a:3:{i:0;s:26:\"xmlsitemap_taxonomy.module\";i:1;s:27:\"xmlsitemap_taxonomy.install\";i:2;s:24:\"xmlsitemap_taxonomy.test\";}s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:10:\"xmlsitemap\";s:9:\"datestamp\";s:10:\"1464191061\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("sites/all/modules/xmlsitemap/xmlsitemap_user/xmlsitemap_user.module","xmlsitemap_user","module","","0","0","-1","0","a:12:{s:4:\"name\";s:16:\"XML sitemap user\";s:11:\"description\";s:39:\"Adds user profile links to the sitemap.\";s:7:\"package\";s:11:\"XML sitemap\";s:12:\"dependencies\";a:1:{i:0;s:10:\"xmlsitemap\";}s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:3:{i:0;s:22:\"xmlsitemap_user.module\";i:1;s:23:\"xmlsitemap_user.install\";i:2;s:20:\"xmlsitemap_user.test\";}s:7:\"version\";s:7:\"7.x-2.3\";s:7:\"project\";s:10:\"xmlsitemap\";s:9:\"datestamp\";s:10:\"1464191061\";s:5:\"mtime\";i:1474356108;s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}"),
("themes/bartik/bartik.info","bartik","theme","themes/engines/phptemplate/phptemplate.engine","1","0","-1","0","a:19:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}"),
("themes/garland/garland.info","garland","theme","themes/engines/phptemplate/phptemplate.engine","0","0","-1","0","a:19:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}"),
("themes/seven/seven.info","seven","theme","themes/engines/phptemplate/phptemplate.engine","1","0","-1","0","a:19:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}"),
("themes/stark/stark.info","stark","theme","themes/engines/phptemplate/phptemplate.engine","0","0","-1","0","a:18:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.43\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1456343506\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:5:\"mtime\";i:1474356108;s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}");




CREATE TABLE `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';






CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores term information.';






CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';






CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';


INSERT INTO taxonomy_vocabulary VALUES
("1","Tags","tags","Use tags to group articles on similar topics into categories.","0","taxonomy","0");




CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';






CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  KEY `access` (`access`),
  KEY `created` (`created`),
  KEY `mail` (`mail`),
  KEY `picture` (`picture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';


INSERT INTO users VALUES
("0","","","","","","","0","0","0","0","","","0","",""),
("1","admin","$S$Dn3CN2azrRXvKux0Oe49y62EZf.j8GuVfLDjZvx5kioZoE8t/OPS","admin@admin.com","","","","1457520044","1457520131","1457520131","1","Asia/Kolkata","","0","admin@admin.com","b:0;");




CREATE TABLE `users_roles` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';


INSERT INTO users_roles VALUES
("1","3");




CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';


INSERT INTO variable VALUES
("admin_theme","s:5:\"seven\";"),
("cache_class_cache_ctools_css","s:14:\"CToolsCssCache\";"),
("clean_url","s:1:\"1\";"),
("comment_page","i:0;"),
("comment_webform","s:1:\"0\";"),
("composer_manager_vendor_dir","s:16:\"sites/all/vendor\";"),
("cron_key","s:43:\"Hg1Hq0ramHxjzm1lzQe7ime7zmmRM0e82Yavi55Uqfk\";"),
("cron_last","i:1457520131;"),
("css_js_query_string","s:6:\"odskhb\";"),
("date_default_timezone","s:12:\"Asia/Kolkata\";"),
("drupal_private_key","s:43:\"hg3suG1wvqpOEcemx7CRBkej24rtnSTQqU0rm0SWnws\";"),
("file_private_path","s:28:\"sites/default/files/.private\""),
("file_public_path","s:19:\"sites/default/files\""),
("file_temporary_path","s:4:\"/tmp\""),
("filter_fallback_format","s:10:\"plain_text\";"),
("install_profile","s:8:\"standard\";"),
("install_task","s:4:\"done\";"),
("install_time","i:1457520131;"),
("mail_system","a:1:{s:14:\"default-system\";s:18:\"SendGridMailSystem\";}"),
("menu_expanded","a:0:{}"),
("menu_masks","a:38:{i:0;i:501;i:1;i:493;i:2;i:250;i:3;i:247;i:4;i:246;i:5;i:245;i:6;i:125;i:7;i:124;i:8;i:123;i:9;i:122;i:10;i:121;i:11;i:117;i:12;i:63;i:13;i:62;i:14;i:61;i:15;i:60;i:16;i:59;i:17;i:58;i:18;i:45;i:19;i:44;i:20;i:31;i:21;i:30;i:22;i:29;i:23;i:28;i:24;i:24;i:25;i:22;i:26;i:21;i:27;i:15;i:28;i:14;i:29;i:13;i:30;i:11;i:31;i:10;i:32;i:7;i:33;i:6;i:34;i:5;i:35;i:3;i:36;i:2;i:37;i:1;}"),
("metatag_enable_comment","b:0;"),
("metatag_enable_node","b:1;"),
("metatag_enable_node__article","b:1;"),
("metatag_enable_node__page","b:1;"),
("metatag_enable_node__webform","b:1;"),
("metatag_enable_taxonomy_term","b:1;"),
("metatag_enable_taxonomy_term__tags","b:1;"),
("metatag_enable_user","b:1;"),
("metatag_enable_user__user","b:1;"),
("metatag_has_revision_id","b:1;"),
("metatag_schema_installed","b:1;"),
("node_admin_theme","s:1:\"1\";"),
("node_options_page","a:1:{i:0;s:6:\"status\";}"),
("node_submitted_page","b:0;"),
("pathauto_blog_pattern","s:17:\"blogs/[user:name]\";"),
("pathauto_forum_pattern","s:29:\"[term:vocabulary]/[term:name]\";"),
("pathauto_node_pattern","s:20:\"content/[node:title]\";"),
("pathauto_punctuation_hyphen","i:1;"),
("pathauto_taxonomy_term_pattern","s:29:\"[term:vocabulary]/[term:name]\";"),
("pathauto_user_pattern","s:17:\"users/[user:name]\";"),
("path_alias_whitelist","a:0:{}"),
("site_404","s:9:\"search404\";"),
("site_default_country","s:2:\"US\";"),
("site_mail","s:15:\"admin@admin.com\";"),
("site_name","s:11:\"prod-test-1\""),
("theme_default","s:6:\"bartik\";"),
("update_last_check","i:1457520133;"),
("update_notify_emails","a:1:{i:0;s:15:\"admin@admin.com\";}"),
("user_admin_role","s:1:\"3\";"),
("user_pictures","s:1:\"1\";"),
("user_picture_dimensions","s:9:\"1024x1024\";"),
("user_picture_file_size","s:3:\"800\";"),
("user_picture_style","s:9:\"thumbnail\";"),
("user_register","i:2;"),
("webform_node_webform","b:1;"),
("xmlsitemap_regenerate_needed","b:1;");




CREATE TABLE `views_display` (
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The view this display is attached to.',
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT 'An identifier for this display; usually generated from the display_plugin, so should be something like page or page_1 or block_2, etc.',
  `display_title` varchar(64) NOT NULL DEFAULT '' COMMENT 'The title of the display, viewable by the administrator.',
  `display_plugin` varchar(64) NOT NULL DEFAULT '' COMMENT 'The type of the display. Usually page, block or embed, but is pluggable so may be other things.',
  `position` int(11) DEFAULT '0' COMMENT 'The order in which this display is loaded.',
  `display_options` longtext COMMENT 'A serialized array of options for this display; it contains options that are generally only pertinent to that display plugin type.',
  PRIMARY KEY (`vid`,`id`),
  KEY `vid` (`vid`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each display attached to a view.';






CREATE TABLE `views_view` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The view ID of the field, defined by the database.',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The unique name of the view. This is the primary field views are loaded from, and is used so that views may be internal and not necessarily in the database. May only be alphanumeric characters plus underscores.',
  `description` varchar(255) DEFAULT '' COMMENT 'A description of the view for the admin interface.',
  `tag` varchar(255) DEFAULT '' COMMENT 'A tag used to group/sort views in the admin interface',
  `base_table` varchar(64) NOT NULL DEFAULT '' COMMENT 'What table this view is based on, such as node, user, comment, or term.',
  `human_name` varchar(255) DEFAULT '' COMMENT 'A human readable name used to be displayed in the admin interface',
  `core` int(11) DEFAULT '0' COMMENT 'Stores the drupal core version of the view.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the general data for a view.';






CREATE TABLE `watchdog` (
  `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.',
  PRIMARY KEY (`wid`),
  KEY `type` (`type`),
  KEY `uid` (`uid`),
  KEY `severity` (`severity`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';


INSERT INTO watchdog VALUES
("1","0","system","%module module installed.","a:1:{s:7:\"%module\";s:5:\"dblog\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("2","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:5:\"dblog\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("3","0","system","%module module installed.","a:1:{s:7:\"%module\";s:8:\"field_ui\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("4","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:8:\"field_ui\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("5","0","system","%module module installed.","a:1:{s:7:\"%module\";s:4:\"file\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("6","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:4:\"file\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("7","0","system","%module module installed.","a:1:{s:7:\"%module\";s:7:\"options\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("8","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:7:\"options\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("9","0","system","%module module installed.","a:1:{s:7:\"%module\";s:8:\"taxonomy\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("10","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:8:\"taxonomy\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("11","0","system","%module module installed.","a:1:{s:7:\"%module\";s:4:\"help\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("12","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:4:\"help\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("13","0","system","%module module installed.","a:1:{s:7:\"%module\";s:5:\"image\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("14","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:5:\"image\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520048"),
("15","0","system","%module module installed.","a:1:{s:7:\"%module\";s:4:\"list\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520049"),
("16","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:4:\"list\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520049"),
("17","0","system","%module module installed.","a:1:{s:7:\"%module\";s:4:\"menu\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520049"),
("18","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:4:\"menu\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520051"),
("19","0","system","%module module installed.","a:1:{s:7:\"%module\";s:6:\"number\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520051"),
("20","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:6:\"number\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520051"),
("21","0","system","%module module installed.","a:1:{s:7:\"%module\";s:7:\"overlay\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520051"),
("22","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:7:\"overlay\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520051"),
("23","0","system","%module module installed.","a:1:{s:7:\"%module\";s:4:\"path\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520051"),
("24","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:4:\"path\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520051"),
("25","0","system","%module module installed.","a:1:{s:7:\"%module\";s:3:\"rdf\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520051"),
("26","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:3:\"rdf\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520051"),
("27","0","system","%module module installed.","a:1:{s:7:\"%module\";s:6:\"search\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520052"),
("28","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:6:\"search\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520052"),
("29","0","system","%module module installed.","a:1:{s:7:\"%module\";s:8:\"shortcut\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520052"),
("30","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:8:\"shortcut\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520052"),
("31","0","system","%module module installed.","a:1:{s:7:\"%module\";s:7:\"toolbar\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520053"),
("32","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:7:\"toolbar\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520053"),
("33","0","system","%module module installed.","a:1:{s:7:\"%module\";s:8:\"standard\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520054"),
("34","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:8:\"standard\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=do","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520054"),
("35","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:15:\"Publish comment\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("36","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:17:\"Unpublish comment\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("37","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:12:\"Save comment\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("38","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:15:\"Publish content\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("39","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:17:\"Unpublish content\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("40","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:19:\"Make content sticky\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("41","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:21:\"Make content unsticky\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("42","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:29:\"Promote content to front page\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("43","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:30:\"Remove content from front page\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("44","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:12:\"Save content\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("45","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:30:\"Ban IP address of current user\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("46","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:18:\"Block current user\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en&id=1&op=finished","http://live.otg.me/install.php?profile=standard&locale=en&op=start&id=1","106.66.75.209","1457520056"),
("47","0","system","%module module installed.","a:1:{s:7:\"%module\";s:6:\"update\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en","http://live.otg.me/install.php?profile=standard&locale=en","106.66.75.209","1457520132"),
("48","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:6:\"update\";}","6","","http://live.otg.me/install.php?profile=standard&locale=en","http://live.otg.me/install.php?profile=standard&locale=en","106.66.75.209","1457520132"),
("49","1","user","Session opened for %name.","a:1:{s:5:\"%name\";s:5:\"admin\";}","5","","http://live.otg.me/install.php?profile=standard&locale=en","http://live.otg.me/install.php?profile=standard&locale=en","106.66.75.209","1457520132"),
("50","0","mail","Error sending e-mail (from %from to %to).","a:2:{s:5:\"%from\";s:15:\"admin@admin.com\";s:3:\"%to\";s:15:\"admin@admin.com\";}","3","","http://live.otg.me/install.php?profile=standard&locale=en","http://live.otg.me/install.php?profile=standard&locale=en","106.66.75.209","1457520133"),
("51","0","cron","Cron run completed.","a:0:{}","5","","http://live.otg.me/install.php?profile=standard&locale=en","http://live.otg.me/install.php?profile=standard&locale=en","106.66.75.209","1457520133"),
("52","0","system","%module module installed.","a:1:{s:7:\"%module\";s:6:\"ctools\";}","6","","http://default/","","127.0.0.1","1474356115"),
("53","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:6:\"ctools\";}","6","","http://default/","","127.0.0.1","1474356115"),
("54","0","system","%module module installed.","a:1:{s:7:\"%module\";s:5:\"views\";}","6","","http://default/","","127.0.0.1","1474356117"),
("55","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:5:\"views\";}","6","","http://default/","","127.0.0.1","1474356117"),
("56","0","system","%module module installed.","a:1:{s:7:\"%module\";s:7:\"webform\";}","6","","http://default/","","127.0.0.1","1474356119"),
("57","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:7:\"webform\";}","6","","http://default/","","127.0.0.1","1474356119"),
("58","0","system","%module module installed.","a:1:{s:7:\"%module\";s:8:\"ckeditor\";}","6","","http://default/","","127.0.0.1","1474356121"),
("59","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:8:\"ckeditor\";}","6","","http://default/","","127.0.0.1","1474356121"),
("60","0","system","%module module installed.","a:1:{s:7:\"%module\";s:5:\"token\";}","6","","http://default/","","127.0.0.1","1474356123"),
("61","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:5:\"token\";}","6","","http://default/","","127.0.0.1","1474356123"),
("62","0","system","%module module installed.","a:1:{s:7:\"%module\";s:7:\"metatag\";}","6","","http://default/","","127.0.0.1","1474356124"),
("63","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:7:\"metatag\";}","6","","http://default/","","127.0.0.1","1474356124"),
("64","0","system","%module module installed.","a:1:{s:7:\"%module\";s:8:\"memcache\";}","6","","http://default/","","127.0.0.1","1474356126"),
("65","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:8:\"memcache\";}","6","","http://default/","","127.0.0.1","1474356126"),
("66","0","system","%module module installed.","a:1:{s:7:\"%module\";s:11:\"securepages\";}","6","","http://default/","","127.0.0.1","1474356128"),
("67","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:11:\"securepages\";}","6","","http://default/","","127.0.0.1","1474356128"),
("68","0","system","%module module installed.","a:1:{s:7:\"%module\";s:8:\"redirect\";}","6","","http://default/","","127.0.0.1","1474356130"),
("69","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:8:\"redirect\";}","6","","http://default/","","127.0.0.1","1474356130"),
("70","0","system","%module module installed.","a:1:{s:7:\"%module\";s:10:\"page_title\";}","6","","http://default/","","127.0.0.1","1474356133"),
("71","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:10:\"page_title\";}","6","","http://default/","","127.0.0.1","1474356133"),
("72","0","system","%module module installed.","a:1:{s:7:\"%module\";s:14:\"globalredirect\";}","6","","http://default/","","127.0.0.1","1474356135"),
("73","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:14:\"globalredirect\";}","6","","http://default/","","127.0.0.1","1474356135"),
("74","0","system","%module module installed.","a:1:{s:7:\"%module\";s:9:\"search404\";}","6","","http://default/","","127.0.0.1","1474356137"),
("75","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:9:\"search404\";}","6","","http://default/","","127.0.0.1","1474356137"),
("76","0","system","%module module installed.","a:1:{s:7:\"%module\";s:10:\"xmlsitemap\";}","6","","http://default/","","127.0.0.1","1474356139"),
("77","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:10:\"xmlsitemap\";}","6","","http://default/","","127.0.0.1","1474356139"),
("78","0","system","%module module installed.","a:1:{s:7:\"%module\";s:8:\"pathauto\";}","6","","http://default/","","127.0.0.1","1474356141"),
("79","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:8:\"pathauto\";}","6","","http://default/","","127.0.0.1","1474356141"),
("80","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:17:\"Update node alias\";}","5","","http://default/","","127.0.0.1","1474356143"),
("81","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:26:\"Update taxonomy term alias\";}","5","","http://default/","","127.0.0.1","1474356143"),
("82","0","actions","Action \'%action\' added.","a:1:{s:7:\"%action\";s:17:\"Update user alias\";}","5","","http://default/","","127.0.0.1","1474356143"),
("83","0","system","%module module installed.","a:1:{s:7:\"%module\";s:16:\"composer_manager\";}","6","","http://default/","","127.0.0.1","1474356144"),
("84","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:16:\"composer_manager\";}","6","","http://default/","","127.0.0.1","1474356144"),
("85","0","system","%module module installed.","a:1:{s:7:\"%module\";s:10:\"mailsystem\";}","6","","http://default/","","127.0.0.1","1474356144"),
("86","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:10:\"mailsystem\";}","6","","http://default/","","127.0.0.1","1474356144"),
("87","0","system","%module module installed.","a:1:{s:7:\"%module\";s:20:\"sendgrid_integration\";}","6","","http://default/","","127.0.0.1","1474356144"),
("88","0","system","%module module enabled.","a:1:{s:7:\"%module\";s:20:\"sendgrid_integration\";}","6","","http://default/","","127.0.0.1","1474356144");




CREATE TABLE `webform` (
  `nid` int(10) unsigned NOT NULL COMMENT 'The node identifier of a webform.',
  `next_serial` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'The serial number to give to the next submission to this webform.',
  `confirmation` text NOT NULL COMMENT 'The confirmation message or URL displayed to the user after submitting a form.',
  `confirmation_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the confirmation message.',
  `redirect_url` varchar(2048) DEFAULT '<confirmation>' COMMENT 'The URL a user is redirected to after submitting a form.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value of a webform for open (1) or closed (0).',
  `block` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether this form be available as a block.',
  `allow_draft` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether submissions to this form be saved as a draft.',
  `auto_save` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether submissions to this form should be auto-saved between pages.',
  `submit_notice` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value for whether to show or hide the previous submissions notification.',
  `confidential` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether to anonymize submissions.',
  `submit_text` varchar(255) DEFAULT NULL COMMENT 'The title of the submit button on the form.',
  `submit_limit` tinyint(4) NOT NULL DEFAULT '-1' COMMENT 'The number of submissions a single user is allowed to submit within an interval. -1 is unlimited.',
  `submit_interval` int(11) NOT NULL DEFAULT '-1' COMMENT 'The amount of time in seconds that must pass before a user can submit another submission within the set limit.',
  `total_submit_limit` int(11) NOT NULL DEFAULT '-1' COMMENT 'The total number of submissions allowed within an interval. -1 is unlimited.',
  `total_submit_interval` int(11) NOT NULL DEFAULT '-1' COMMENT 'The amount of time in seconds that must pass before another submission can be submitted within the set limit.',
  `progressbar_bar` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if the bar should be shown as part of the progress bar.',
  `progressbar_page_number` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if the page number should be shown as part of the progress bar.',
  `progressbar_percent` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if the percentage complete should be shown as part of the progress bar.',
  `progressbar_pagebreak_labels` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if the pagebreak labels should be included as part of the progress bar.',
  `progressbar_include_confirmation` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if the confirmation page should count as a page in the progress bar.',
  `progressbar_label_first` varchar(255) DEFAULT NULL COMMENT 'Label for the first page of the progress bar.',
  `progressbar_label_confirmation` varchar(255) DEFAULT NULL COMMENT 'Label for the last page of the progress bar.',
  `preview` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if this form includes a page for previewing the submission.',
  `preview_next_button_label` varchar(255) DEFAULT NULL COMMENT 'The text for the button that will proceed to the preview page.',
  `preview_prev_button_label` varchar(255) DEFAULT NULL COMMENT 'The text for the button to go backwards from the preview page.',
  `preview_title` varchar(255) DEFAULT NULL COMMENT 'The title of the preview page, as used by the progress bar.',
  `preview_message` text NOT NULL COMMENT 'Text shown on the preview page of the form.',
  `preview_message_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the preview page message.',
  `preview_excluded_components` text NOT NULL COMMENT 'Comma-separated list of component IDs that should not be included in this form’s confirmation page.',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for storing additional properties for webform nodes.';






CREATE TABLE `webform_component` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `cid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'If this component has a parent fieldset, the cid of that component.',
  `form_key` varchar(128) DEFAULT NULL COMMENT 'When the form is displayed and processed, this key can be used to reference the results.',
  `name` text NOT NULL COMMENT 'The label for this component.',
  `type` varchar(16) DEFAULT NULL COMMENT 'The field type of this component (textfield, select, hidden, etc.).',
  `value` text NOT NULL COMMENT 'The default value of the component when displayed to the end-user.',
  `extra` text NOT NULL COMMENT 'Additional information unique to the display or processing of this component.',
  `required` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean flag for if this component is required.',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Determines the position of this component in the form.',
  PRIMARY KEY (`nid`,`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about components for webform nodes.';






CREATE TABLE `webform_conditional` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rgid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The rule group identifier for this group of rules.',
  `andor` varchar(128) DEFAULT NULL COMMENT 'Whether to AND or OR the actions in this group. All actions within the same rgid should have the same andor value.',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Determines the position of this conditional compared to others.',
  PRIMARY KEY (`nid`,`rgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information about conditional logic.';






CREATE TABLE `webform_conditional_actions` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rgid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The rule group identifier for this group of rules.',
  `aid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The rule identifier for this conditional action.',
  `target_type` varchar(128) DEFAULT NULL COMMENT 'The type of target to be affected. Currently always "component". Indicates what type of ID the "target" column contains.',
  `target` varchar(128) DEFAULT NULL COMMENT 'The ID of the target to be affected. Typically a component ID.',
  `invert` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'If inverted, execute when rule(s) are false.',
  `action` varchar(128) DEFAULT NULL COMMENT 'The action to be performed on the target.',
  `argument` text COMMENT 'Optional argument for action.',
  PRIMARY KEY (`nid`,`rgid`,`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information about conditional actions.';






CREATE TABLE `webform_conditional_rules` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rgid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The rule group identifier for this group of rules.',
  `rid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The rule identifier for this conditional rule.',
  `source_type` varchar(128) DEFAULT NULL COMMENT 'The type of source on which the conditional is based. Currently always "component". Indicates what type of ID the "source" column contains.',
  `source` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The component ID being used in this condition.',
  `operator` varchar(128) DEFAULT NULL COMMENT 'Which operator (equal, contains, starts with, etc.) should be used for this comparison between the source and value?',
  `value` text COMMENT 'The value to be compared with source.',
  PRIMARY KEY (`nid`,`rgid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information about conditional logic.';






CREATE TABLE `webform_emails` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `eid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The e-mail identifier for this row’s settings.',
  `email` text COMMENT 'The e-mail address that will be sent to upon submission. This may be an e-mail address, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `subject` text COMMENT 'The e-mail subject that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_name` text COMMENT 'The e-mail "from" name that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_address` text COMMENT 'The e-mail "from" e-mail address that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `template` text COMMENT 'A template that will be used for the sent e-mail. This may be a string or the special key "default", which will use the template provided by the theming layer.',
  `excluded_components` text NOT NULL COMMENT 'A list of components that will not be included in the [submission:values] token. A list of CIDs separated by commas.',
  `html` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will be sent in an HTML format. Requires Mime Mail module.',
  `attachments` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will include file attachments. Requires Mime Mail module.',
  `exclude_empty` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will include component with an empty value.',
  `extra` text NOT NULL COMMENT 'A serialized array of additional options for the e-mail configuration, including value mapping for the TO and FROM addresses for select lists.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'Whether this email is enabled.',
  PRIMARY KEY (`nid`,`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information regarding e-mails that should be sent...';






CREATE TABLE `webform_last_download` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The user identifier.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The last downloaded submission number.',
  `requested` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Timestamp of last download request.',
  PRIMARY KEY (`nid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores last submission number per user download.';






CREATE TABLE `webform_roles` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The role identifier.',
  PRIMARY KEY (`nid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds access information regarding which roles are...';






CREATE TABLE `webform_submissions` (
  `sid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for this submission.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `serial` int(10) unsigned NOT NULL COMMENT 'The serial number of this submission.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The id of the user that completed this submission.',
  `is_draft` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this a draft of the submission?',
  `highest_valid_page` smallint(6) NOT NULL DEFAULT '0' COMMENT 'For drafts, the highest validated page number.',
  `submitted` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the form was first saved as draft or submitted.',
  `completed` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the form was submitted as complete (not draft).',
  `modified` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the form was last saved (complete or draft).',
  `remote_addr` varchar(128) DEFAULT NULL COMMENT 'The IP address of the user that submitted the form.',
  PRIMARY KEY (`sid`),
  UNIQUE KEY `sid_nid` (`sid`,`nid`),
  UNIQUE KEY `nid_serial` (`nid`,`serial`),
  KEY `nid_uid_sid` (`nid`,`uid`,`sid`),
  KEY `nid_sid` (`nid`,`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds general information about submissions outside of...';






CREATE TABLE `webform_submitted_data` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier for this submission.',
  `cid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `no` varchar(128) NOT NULL DEFAULT '0' COMMENT 'Usually this value is 0, but if a field has multiple values (such as a time or date), it may require multiple rows in the database.',
  `data` mediumtext NOT NULL COMMENT 'The submitted value of this field, may be serialized for some components.',
  PRIMARY KEY (`nid`,`sid`,`cid`,`no`),
  KEY `nid` (`nid`),
  KEY `sid_nid` (`sid`,`nid`),
  KEY `data` (`data`(64))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all submitted field data for webform submissions.';






CREATE TABLE `xmlsitemap` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary key with type; a unique id for the item.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary key with id; the type of item (e.g. node, user, etc.).',
  `subtype` varchar(128) NOT NULL DEFAULT '' COMMENT 'A sub-type identifier for the link (node type, menu name, term VID, etc.).',
  `loc` varchar(255) NOT NULL DEFAULT '' COMMENT 'The URL to the item relative to the Drupal path.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this link or an empty string if it is language-neutral.',
  `access` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'A boolean that represents if the item is viewable by the anonymous user. This field is useful to store the result of node_access() so we can retain changefreq and priority_override information.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'An integer that represents if the item is included in the sitemap.',
  `status_override` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean that if TRUE means that the status field has been overridden from its default value.',
  `lastmod` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The UNIX timestamp of last modification of the item.',
  `priority` float DEFAULT NULL COMMENT 'The priority of this URL relative to other URLs on your site. Valid values range from 0.0 to 1.0.',
  `priority_override` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean that if TRUE means that the priority field has been overridden from its default value.',
  `changefreq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The average time in seconds between changes of this item.',
  `changecount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this item has been changed. Used to help calculate the next changefreq value.',
  PRIMARY KEY (`id`,`type`),
  KEY `loc` (`loc`),
  KEY `access_status_loc` (`access`,`status`,`loc`),
  KEY `type_subtype` (`type`,`subtype`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for xmlsitemap links.';


INSERT INTO xmlsitemap VALUES
("0","frontpage","","","und","1","1","0","0","1","0","86400","0");




CREATE TABLE `xmlsitemap_sitemap` (
  `smid` varchar(64) NOT NULL COMMENT 'The sitemap ID (the hashed value of xmlsitemap.context.',
  `context` text NOT NULL COMMENT 'Serialized array with the sitemaps context',
  `updated` int(10) unsigned NOT NULL DEFAULT '0',
  `links` int(10) unsigned NOT NULL DEFAULT '0',
  `chunks` int(10) unsigned NOT NULL DEFAULT '0',
  `max_filesize` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`smid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO xmlsitemap_sitemap VALUES
("NXhscRe0440PFpI5dSznEVgmauL25KojD7u4e9aZwOM","a:0:{}","0","0","0","0");


