<!doctype html>
<html>
<head>
	<meta charset="UTF-8">

	<title>{$config->page_meta->title}</title>
	<link rel="icon" type="image/png" href="{'/'|url}admin/img/favicon.png" />

	<link href="{'/'|url}admin/css/jquery-ui-1.10.0.custom.css" type="text/css" rel="stylesheet" />
	<link href="{'/'|url}admin/css/index.css" type="text/css" rel="stylesheet" />
	
	<script type="text/javascript" src="{'/'|url}admin/js/jquery-1.9.0.js"></script>
	<script type="text/javascript" src="{'/'|url}admin/js/jquery-ui-1.10.0.custom.js"></script>
	<script type="text/javascript" src="{'/'|url}admin/js/generic.js"></script>
</head>
<body>
	<div id="topBar">
		<div class="topBreadcrumb">
            <a href="{'/'|url}admin/" class="topBreadcrumbLogo">{$config->project_name}</a> :: {$breadCrumbHtml}
		</div>
		<div class="topMenu">
			{if $ADMIN}
				<a href='?page=logout'>Logout</a> [{$ADMIN->name}]
			{/if}
		</div>
	</div>
	<div id="noticeBox" class="{$noticeBoxColor}">
		<a id="noticeBoxClose" href="#">x</a>
		<div id="noticeBoxText">{$noticeBoxMessages}</div>
	</div>
	{include file=$CONTENT}
</body>
</html>