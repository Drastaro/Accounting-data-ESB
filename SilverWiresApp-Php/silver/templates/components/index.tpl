<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    

	<title>{$page_meta->title|htmlspecialchars}</title>
	<meta name="description" content="{$page_meta->description|htmlspecialchars}" />
	<meta name="keywords" content="{$page_meta->keywords|htmlspecialchars}" />
    
	
	<!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="/adminlte/bootstrap/css/bootstrap.min.css">
   
    <!-- Theme style -->
    <link rel="stylesheet" href="/adminlte/dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="/adminlte/dist/css/skins/_all-skins.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="/adminlte/plugins/iCheck/flat/blue.css">
    <!-- Morris chart -->
    <link rel="stylesheet" href="/adminlte/plugins/morris/morris.css">
    <!-- jvectormap -->
    <link rel="stylesheet" href="/adminlte/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
    <!-- Date Picker -->
    <link rel="stylesheet" href="/adminlte/plugins/datepicker/datepicker3.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="/adminlte/plugins/daterangepicker/daterangepicker-bs3.css">
   <!-- jQuery 2.1.4 -->
    <script src="/adminlte/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]--> 
	<link rel="stylesheet" href="/css/custom.css">
	
	<link rel="shortcut icon" href="favicon.ico"/>

</head>
<body class="hold-transition skin-blue sidebar-mini {$pageName}">	
	
{if $user}
<div class="wrapper">
	{include file="pages/header.tpl"}	
	
	
	<!-- BEGIN CONTAINER -->
	
		{include file="pages/left_menu.tpl"}  
		
		<!-- Begin page content -->
		<div class="content-wrapper">
				
					<!-- Main content -->			   
					{include file="$CONTENT"}
				
		</div>
		<!-- END CONTENT -->
	
	<!-- END CONTAINER -->
	<!-- BEGIN FOOTER -->
	<footer class="main-footer">
        <strong>Copyright &copy; {$smarty.now|date_format:"%Y"} FINTECH BUSINESS SOLUTIONS</strong> All rights reserved.
     </footer>
	<!-- END FOOTER -->
	</div>
{else}
	{include file="$CONTENT"}
{/if}
	

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	  
    <!-- jQuery UI 1.11.4 -->
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
      $.widget.bridge('uibutton', $.ui.button);
    </script>
    <!-- Bootstrap 3.3.5 -->
    <script src="/adminlte/bootstrap/js/bootstrap.min.js"></script>
    
    <!-- Sparkline -->
    <script src="/adminlte/plugins/sparkline/jquery.sparkline.min.js"></script>
    <!-- jvectormap -->
    <script src="/adminlte/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="/adminlte/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="/adminlte/plugins/knob/jquery.knob.js"></script>
    
    <!-- datepicker -->
    <script src="/adminlte/plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- Bootstrap WYSIHTML5 -->
    <script src="/adminlte/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Slimscroll -->
    <script src="/adminlte/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="/adminlte/plugins/fastclick/fastclick.min.js"></script>
    <!-- AdminLTE App -->
    <script src="/adminlte/dist/js/app.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) 
    <script src="/adminlte/dist/js/pages/dashboard.js"></script>-->
    <!-- AdminLTE for demo purposes -->
    <script src="/adminlte/dist/js/demo.js"></script>


<!-- END PAGE LEVEL SCRIPTS -->



<!-- END JAVASCRIPTS -->
</body>
</html>