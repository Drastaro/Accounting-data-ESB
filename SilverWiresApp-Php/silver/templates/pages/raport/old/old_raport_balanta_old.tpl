<!-- Content Header (Page header) -->
<div class="page-head">
		<!-- BEGIN PAGE TITLE -->
		<div class="page-title">
		 <h1>{$companie->name} - {$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}
         <small>Analiza financiara de management si business intelligence</small></h1>
		</div>
		<!-- END PAGE TITLE -->
</div>

<!-- BEGIN PAGE CONTENT-->
<div class="row">
	<div class="col-md-12">
		<div class="portlet box">
			<div class="portlet-body">
				Raport lunar pentru companie - mici explicatii
			</div>
		</div>
	</div>
</div>

<div class="row">
<div class="col-md-12">
	<div class="portlet box">			
			<div class="portlet-body">
               <div class="row">                     
					<div class="col-md-3">					
						<!-- Navigation - folders-->						
						<ul class="ver-inline-menu tabbable margin-bottom-10">
							<li class="active">
								<a href="#tab_1">
								<i class="fa fa-briefcase"></i> Sumar executiv </a>
								<span class="after">
								</span>
							</li>
							<li class="">
								<a href="#venituri">
								<i class="fa fa-group"></i> Venituri, cheltuieli si profit </a>
							</li>
							<li class="">
								<a href="#activ">
								<i class="fa fa-leaf"></i> Activul patrimonial </a>
							</li>
							<li class="">
								<a href="#pasiv">
								<i class="fa fa-info-circle"></i> Pasivul patrimonial </a>
							</li>
							<li class="">
								<a href="#kpi" >
								<i class="fa fa-tint"></i> Principalii indicatori financiari (KPI) </a>
							</li>														
						</ul>
					</div>
					<div class="col-md-9">
                                            <div class="box box-danger">
												<div class="box-header">
													<a name="sumar_exec"></a>
													<h3 class="box-title">Sumar executiv</h3>
												</div><!-- /.box-header -->
												<div class="box-body">
													<p>In luna <b>{$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}</b>, <b>{$companie->name}</b> a realizat o cifra de afaceri in suma de <b>{$valoareRaport['CIFRA_DE_AFACERI']}</b>. Lei si un profit net in suma de <b>{$valoareRaport['PROFIT_NET']}</b> Lei. Cumulat de la inceputul anului {$balanta->an}, <b>{$companie->name}</b> a realizat o cifra de afaceri in suma de ….. lei si profit net in suma de …  lei. </p>
													<p>Rata a profitabilitatii totale a fost de ??,?%, in luna <b>{$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}</b>, comparativ cu  ???? rata profitabilitatii totale corespunzator intregii activitati a <b>{$companie->name}</b> realizate in perioada ianuarie – {$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}.</p>

														
													</div>
														<div class="box box-info">
															<div class="box-header">
																<a name="venituri"></a>
																<h3 class="box-title">Analiza veniturilor</h3>
															</div><!-- /.box-header -->
															<div class="box-body">
																<table class="table table-striped">
																	<tbody><tr>
																		<th style="width: 10px">#</th>
																		<th>Indicator</th>
																		<th>Valoare (RON)</th>
																		<th style="width: 40px">Procent</th>
																	</tr>
																	<tr>
																		<td>1.</td>
																		<td>Cifra de afaceri</td>
																		<td>{$valoareRaport['CIFRA_DE_AFACERI']}</td>
																		<td><span class="badge bg-red">55%</span></td>
																	</tr>
																	<tr>
																		<td>2.</td>
																		<td>Alte venituri din exploatare</td>
																		<td>{$valoareRaport['ALTE_VENITURI_DIN_EXPLOATARE']}</td>
																		<td><span class="badge bg-red">25%</span></td>
																	</tr>
																	<tr>
																		<td>3.</td>
																		<td>Total venituri din exploatare</td>
																		<td>{$valoareRaport['TOTAL_VENITURI_DIN_EXPLOATARE']}</td>
																		<td><span class="badge bg-red">75%</span></td>
																	</tr>
																	<tr>
																		<td>4.</td>
																		<td>Venituri financiare</td>
																		<td>{$valoareRaport['VENITURI_FINANCIARE']}</td>
																		<td><span class="badge bg-red">15%</span></td>
																	</tr>
																	<tr>
																		<td>5.</td>
																		<td>Venituri extraordinare</td>
																		<td>{$valoareRaport['VENITURI_EXTRAORDINARE']}</td>
																		<td><span class="badge bg-red">55%</span></td>
																	</tr>
																	<tr>
																		<td>6.</td>
																		<td>Venituri totale</td>
																		<td>{$valoareRaport['VENITURI_TOTALE']}</td>
																		<td><span class="badge bg-red">55%</span></td>
																	</tr>
																	
																</tbody></table>
															</div>
														</div>
														
														<div class="col-md-6">
															<!-- Donut chart -->
																<div class="box box-primary">
																	<div class="box-header">
																		<a name="activ"></a>
																		<i class="fa fa-bar-chart-o"></i>
																		<h3 class="box-title">Cifra de afaceri si Profit</h3>
																	</div>
																	<div class="box-body">
																		<div id="donut-chart" style="height: 300px;"></div>
																	</div><!-- /.box-body-->
																</div><!-- /.box -->
														</div>
												</div><!-- /.box-body -->
											</div>
               </div>                        
			</div>
		</div>
	</div>
</div>

