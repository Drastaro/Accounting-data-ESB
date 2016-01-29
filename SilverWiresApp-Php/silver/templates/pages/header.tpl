
	
<header class="main-header">
        <!-- Logo -->
        <a href="" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>A</b>LT</span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><img src="/img/logo_alb2.png" alt="logo" class="logo-default"/></span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
      <nav class="navbar navbar-static-top" role="navigation">
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img src="/adminlte/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
                  <span class="hidden-xs">{$user->getName()}</span>
                </a>
                <ul class="dropdown-menu">
                  <li class="user-header">
                    <p>
                      {$user->getName()}
                    </p>
                  </li>
                  <li class="user-body">
                    <div class="col-xs-12 text-center">
                      <a href="/parola"><i class="icon-user"></i> Schimbare parola </a>
                    </div>
                    
                  </li>
                  <li class="user-footer">
                    <div class="pull-left">
                      <a href="/contact" class="btn btn-default btn-flat">Contact</a>
                    </div>
                    <div class="pull-right">
                      <a href="/logout" class="btn btn-default btn-flat">Sign out</a>
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </nav> 
      </header>	
	