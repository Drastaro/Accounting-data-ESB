<div class="login-box">
      <div class="login-logo">
       <b>SilverWIRE</b>
      </div><!-- /.login-logo -->
      <div class="login-box-body">
        <p class="login-box-msg">Sign in to start your session</p>
		{if $areMessages==true}
		<div class="alert alert-dangerS">
					<button class="close" data-close="alert"></button>
					<span>
					{if $areMessages==true} {$pageMessages} {/if}
					</span>
				</div>
		{/if}

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
		{literal}
       
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
		{/literal}
