<!-- Content Header (Page header) -->
<div class="page-head">
		<!-- BEGIN PAGE TITLE -->
		<div class="page-title">
		<h1>{if $mode=='add-companie'} Adaugare companie {else} {$companie->name} <small>Editare date companie</small> {/if}</h1>
		</div>
</div>


{if $areMessages==true}
<div class="note {$messageClass}">
	<span>{$pageMessages}</span>	
</div>
{/if}

{if $companie->isDemo==1}
<div class="note note-info">
	<p class="block">Compania <b>{$companie->name}</b> este o companie demonstrativa si nu poate fi editata.</p>
	<p>
		 Pentru a putea incarca balante sau a modifica datele companiei creati o companie sau folositi un creata de dumneavoastra.<br/>
	</p>
</div>
{else}

<div class="row">
	<div class="col-md-12">
		<div class="portlet light">	
			<div class="portlet-title">
					<div class="caption">
						<span class="caption-subject text-primary bold uppercase">Editare date</span>
					</div>
				</div>
			<div class="portlet-body">							   
				<form role="form" method="post">
					<input type="hidden" name="mode" value="{$mode}">
					<input type="hidden" name="id" value="{$companie->id}">
					<fieldset>
						<div class="form-group">
							<label for="inputNume">Nume companie</label>
							<input class="form-control" id="inputNume" name="name"  type="text" value="{$companie->name}">
						</div>
						<div class="form-group">
							<label for="companie_cui">CUI Companie</label>
							<input type="text" class="form-control" name="companie_cui" id="companie_cui" value="{$companie->cui}">
						</div>
						<div class="box-footer">							
							 <button type="submit" class="btn btn-primary">{if $mode=='add-companie'} Adaugă {else} Salvează {/if}</button>
							{if $mode=='edit-companie'}<a data-toggle="modal" data-target="#confirm-delete" href="#" class="btn btn-danger pull-right">Sterge companie</a>{/if}
						 </div>

					</fieldset>
					</form>	
					<form role="form" method="post" name="deleteForm">
							<input type="hidden" name="mode" value="delete-companie">
							<input type="hidden" name="id" value="{$companie->id}">						   
						</form>

			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Confirmare stergere</h4>
			</div>
		
			<div class="modal-body">
				<p>Va rugam sa confirmati stergerea acestei companii. Aceasta procedura este ireversibila.</p>
				<p>Sunteti sigur ca doriti sa continuati ?</p>                    
			</div>
			
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Anuleaza</button>
				<a href="#" class="btn btn-danger danger" onclick="javascript:document.deleteForm.submit();">Sterge</a>
			</div>
		</div>
	</div>
</div>
{/if}
