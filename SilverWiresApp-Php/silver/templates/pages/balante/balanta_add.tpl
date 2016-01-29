<!-- Content Header (Page header) -->
<div class="page-head">
		<!-- BEGIN PAGE TITLE -->
		<div class="page-title">
		<h1>{$companie->name} <small>Adaugare balanta</small></h1>						
		</div>
		<!-- END PAGE TITLE -->
</div>

<!-- BEGIN PAGE CONTENT-->
<div class="row">
	<div class="col-md-12">
		<div class="portlet box">
			<div class="portlet-body">
				Incarcati balante contabila de verificare (varianta sintetica) in format XLS
				<br/><br/>
				<div class="note note-info">
								<h4 class="alert-heading">Model balante</h4>
								<p>Pentru a asigura o incarcare corecta si completa a datelor din balanta de verificare folositi la incarcare fisiere similare cu modelele de mai jos. Este obligatoriu ca primul rand (capul de tabel) sa fie identic cu cel din modelele de mai jos (atat ordinea coloanelor cat si numele coloanelor).</p>
								<p>
									<a class="btn btn-primary" href="/model/model-balanta-gol.xls">
									Descarcati model balanta gol </a>
									<a class="btn btn-primary" href="/model/model-balanta.xls">
									Descarcati model balanta cu date </a>
								</p>
							</div>
			</div>
		</div>
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
		 Pentru a putea incarca balante sau a modifica datele companiei creati o companie sau folositi una creata de dumneavoastra. <br/>
	</p>
</div>
{else if $user->isActive==0}
<div class="note note-info">
	<p class="block">Contul dumneavoastra este inactiv.</p>
	<p>
		 Dezactivarea se realizeaza automat in caz neplatii facturii curente. Pentru a putea incarca balante trebuie sa va reactivati contul. Contactati-ne pe email la contact@fintech-solutions.ro sau folosind formularul de <a href="/contact">contact</a>.  <br/>
	</p>
</div>
{else}
<div class="row">
	<div class="col-md-6">
		<div class="portlet light">
				<div class="portlet-title">
					<div class="caption">
						<span class="caption-subject text-primary bold uppercase">Balantele incarcate</span>
					</div>
				</div>
						<div class="portlet-body">
							{assign var=nrBalante value=$balante|@count}							
							{if $nrBalante>0}
							<div class="panel-group accordion" id="accordion1">
									{assign var=an value=-1}
									{foreach item=b from=$balante name=bList}
											{if ($an==-1)}
												{assign var=an value=$b->an}
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapse_{$b->an}">
														{$b->an} </a>
														</h4>
													</div>
													<div id="collapse_{$b->an}" class="panel-collapse in">
														<div class="panel-body">
															<ul class="list-group">
												
											{elseif ($b->an!=$an)}	
												{assign var=an value=$b->an}
														</ul>
											
														</div>
													</div>
												</div>
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
														<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#collapse_{$b->an}">
														{$b->an} </a>
														</h4>
													</div>
													<div id="collapse_{$b->an}" class="panel-collapse collapse">
														<div class="panel-body">
															<ul class="list-group">
											
											{/if}
											
											
																<li class="list-group-item">
																{$b->luna}.&nbsp;{$lunileAnului[$b->luna]}&nbsp;{$b->an} (incarcat in {$b->updated_on})
																</li>
															
										
									{/foreach}
															</ul>
															
														</div>
													</div>
									
											</div>
							</div>
							{else}
							<div class="note note-info">
								<span class="block">Compania <b>{$companie->name}</b> nu are incarcata nici o balanta.</span>
							</div>
							{/if}
						</div>
					</div>
	</div>
	<div class="col-md-6">
		<div class="portlet light">
			<div class="portlet-title">
				<div class="caption">
					<span class="caption-subject text-primary bold uppercase">Incarca o balanta</span>
				</div>
			</div>
			<div class="portlet-body">
				{if ($succes=='true')} 
				<div class="note note-success">			
					<p>
						 Balanta a fost incarcata cu succes.
					</p>
				</div>		
				{/if}
				<form role=form method="post" enctype="multipart/form-data" action="/balante_add">
					<input type="hidden" name="mode" value="add-balanta">
					<input type="hidden" name="companyId" value="{$companie->id}">
					
					<fieldset>
						<div class="form-group">
							<label for="inputAn">An</label>
							<select class="form-control" id="inputAn" name="an">
								<option value="2012">2012</option>
								<option value="2013">2013</option>
								<option value="2014" selected>2014</option>
								<option value="2015">2015</option>
							</select>							
						</div>
						<div class="form-group">
							<label for="inputLuna">Luna</label>
							<select class="form-control" id="inputLuna" name="luna">
								<option value="1">Ianuarie</option>
								<option value="2">Februarie</option>
								<option value="3">Martie</option>
								<option value="4">Aprilie</option>
								<option value="5">Mai</option>
								<option value="6">Iunie</option>
								<option value="7">Iulie</option>
								<option value="8">August</option>
								<option value="9">Septembrie</option>
								<option value="10">Octombrie</option>
								<option value="11">Noiembrie</option>
								<option value="12">Decembrie</option>
							</select>
						</div>
						<div class="form-group">
							<label for="inputFisier">Selecteaza fisierul</label>
							<input id="inputFisier" name="fisier" placeholder="Selecteaza fisier" type="file">
							<p class="help-block">Pentru a putea fi analizata, balanta trebuie sa fie exportata in fisier cu extensia XLS sau XLSX</p>
						</div>
						<div class="box-footer">
							 <button type="submit" class="btn btn-primary">Adaugă</button>
						 </div>
					</fieldset>
				</form>								   

			</div><!-- /.box-body -->
		</div>
	</div>
</div>
{/if}
