<!-- Content Header (Page header) -->
<div class="page-head">
		<!-- BEGIN PAGE TITLE -->
		<div class="page-title">
		<h1>Schimbare parola</h1>						
		</div>
		<!-- END PAGE TITLE -->
</div>

<!-- BEGIN PAGE CONTENT-->
{if $areMessages==true}
<div class="note {$messageClass}">
	<span>{$pageMessages}</span>	
</div>
{/if}
<div class="row">
	<div class="col-md-6">
		<div class="portlet light">
			<div class="portlet-body">
			<p>Folosiți formularul de mai jos pentru a va schimba parola!</p>
			
			<form method="POST" action="">
                <input type="hidden" name="mode" value="login">

                <div class="form-group">
                    <label for="inputPassword">Parola actuala</label>
                    <input type="password" name="pass1" class="form-control" id="inputPassword" placeholder="Introduceți parola de acces actuala">
                </div>

                <div class="form-group">
                    <small>Obs: Parola noua trebuie sa aiba minim 6 caractere.</small>
                </div>

                <div class="form-group">
                    <label for="inputPassword">Parola noua</label>
                    <input type="password" name="pass2" class="form-control" placeholder="Introduceți noua parola">
                </div>

                <div class="form-group">
                    <label for="inputPassword">Confirmare parola</label>
                    <input type="password" name="pass3" class="form-control" placeholder="Reintroduceți noua parola">
                </div>

                <div class="form-group clearfix">
                    <button type="submit" class="btn btn-primary pull-right">Efectuati</button>
                </div>
                <br><br>

            </form>
				
			</div>
		</div>
	</div>
</div>




<script type="text/javascript">
    document.getElementById('inputPassword').focus();
</script>
