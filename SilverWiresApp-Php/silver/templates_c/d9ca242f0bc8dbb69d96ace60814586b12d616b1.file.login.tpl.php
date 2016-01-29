<?php /* Smarty version Smarty-3.0.6, created on 2015-10-27 14:34:52
         compiled from "D:\wamp\www\silver//templates/pages/login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:22227562f6f6cdca818-82822139%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'd9ca242f0bc8dbb69d96ace60814586b12d616b1' => 
    array (
      0 => 'D:\\wamp\\www\\silver//templates/pages/login.tpl',
      1 => 1441957536,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '22227562f6f6cdca818-82822139',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<div class="login-box">
      <div class="login-logo">
       <b>SilverWIRE</b>
      </div><!-- /.login-logo -->
      <div class="login-box-body">
        <p class="login-box-msg">Sign in to start your session</p>
		<?php if ($_smarty_tpl->getVariable('areMessages')->value==true){?>
		<div class="alert alert-dangerS">
					<button class="close" data-close="alert"></button>
					<span>
					<?php if ($_smarty_tpl->getVariable('areMessages')->value==true){?> <?php echo $_smarty_tpl->getVariable('pageMessages')->value;?>
 <?php }?>
					</span>
				</div>
		<?php }?>

			<form method="post">
            <input type="hidden" name="mode" value="login">
          
                <div class="form-group has-feedback">
					<input type="email" class="form-control" name="email" placeholder="Email">
					<span class="glyphicon glyphicon-envelope form-control-feedback"></span>                   
                </div>
                <div class="form-group has-feedback">
					<input type="password" class="form-control" name="password" placeholder="Password">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
				<div class="row">
           
				<div class="col-xs-4 pull-right">
				  <button type="submit" class="btn btn-success btn-block btn-flat">Sign In</button>
				</div><!-- /.col -->
			  </div>
				
                
				<div class="create-account">
					<p>
							<br/>
												 
					</p>
				</div>				

            
        


        <div class="social-auth-links text-center">
          <a href="javascript:;" id="register-btn" class="btn btn-info btn-block btn-social btn-flat uppercase"><i class="fa fa-plus"></i> Register a new account</a>
        </div>
		<a href="javascript:;" id="forget-password" class="forget-password">I forgot my password</a>
        </form>			
		
		 <form class="forget-form" style="display: none;" method="post">		
            <input  type="hidden" name="mode" value="recover">
        
                <h3>Recover your password</h3>
                <p>
					Enter your email address to receive a new password
				</p>
				<div class="form-group">
					<input class="form-control placeholder-no-fix" id="inputEmail" placeholder="Adresa de e-mail" type="text"/>					
				</div>
				<div class="form-actions">
					<button type="button" id="back-btn" class="btn btn-default">Back to login</button>
					<button type="submit" class="btn btn-success uppercase pull-right">Send</button>					
				</div>
        </form>


        <form  class="register-form" style="display: none;" method="post">
            <input type="hidden" name="mode" value="signup">

				<h3>Register new account</h3>
				<p class="hint">
					 Enter the following registration data:
				</p>
				<div class="form-group">
                    <input class="form-control placeholder-no-fix" name="first_name" id="inputFirstName" placeholder="First name" type="text">
                </div>
				
		        <div class="form-group">
                    <input class="form-control placeholder-no-fix" name="last_name" id="inputLastName" placeholder="Last name" type="text">
                </div>

                <div class="form-group">
                    <input class="form-control placeholder-no-fix" name="telephone" id="inputTelephone" placeholder="Phone" type="text">
                </div>

                <div class="form-group">
                    <input class="form-control placeholder-no-fix" autocomplete="off" name="email" id="inputEmail" placeholder="Email" type="text">
                </div>

                <div class="form-group">
                    <input class="form-control placeholder-no-fix" autocomplete="off" name="password" id="inputPassword" placeholder="Password" type="password">
                </div>

                <div class="form-group">
                    <input class="form-control placeholder-no-fix" name="password_confirmation" id="inputPassword2" placeholder="Confirm password" type="password">
                </div>

				<div class="form-actions">
					<button type="button" id="register-back-btn" class="btn btn-default">Back to login</button>
					<button type="submit" id="register-submit-btn" class="btn btn-success uppercase pull-right">Register</button>
				</div>
        </form>
<div class="copyright">
<br/><br/><br/>
	For any information or inquiry please contact us at contact@fintech-solutions.ro <br/><br/>
	 2015 © Fintech Business Solutions. Finboard - Analiza financiara.
</div>
      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->

    
	   
        <!-- Form slide script -->
		
       
           <script src="/js/pages/login.js" type="text/javascript"></script>
       
	    <script type="text/javascript">
            
			var LoginFunc = function() {

    return {
        //main function
        init: function() {
			
		
                document.getElementById('inputEmail').focus();
                $('.form-horizontal.hide').hide().removeClass('hide');

				$('.create-account').click(function(){
                    $('.form-horizontal:visible').fadeOut(200, function(){
                        $('.register-form').fadeIn(200, function(){
                            $(this).find(".form-control:first").focus();
                        });
                    });
                    return false;
                });
			   
                $('.forget-pass-link').click(function(){
                    $('.form-horizontal:visible').fadeOut(200, function(){
                        $('.form-password').fadeIn(200, function(){
                            $(this).find(".form-control:first").focus();
                        });
                    });
                    return false;
                });

                $('.back-to-login-link').click(function(){
                    $('.form-horizontal:visible').fadeOut(200, function(){
                        $('.form-login').fadeIn(200, function(){
                            $(this).find(".form-control:first").focus();
                        });
                    });
                    return false;
                });

                
            }
	}
}();
	</script>
		
