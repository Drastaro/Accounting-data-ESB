<!-- Content Header (Page header) -->
<div class="page-head">
		<!-- BEGIN PAGE TITLE -->
		<div class="page-title">
		 <h1>{$companie->name} - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</h1>
        <!-- <small>Analiza financiara de management si business intelligence</small></h1>-->		
		</div>
		<!-- END PAGE TITLE -->
		<!-- BEGIN PAGE TOOLBAR -->
		<div class="page-toolbar">			
			<div class="btn-group pull-right">								
				<a class="btn btn-md blue hidden-print margin-bottom-5 margin-right-5" onclick="javascript:window.print();">
						Print <i class="fa fa-print"></i>
				</a>
				<button type="button" class="btn btn-fit-height red-haze dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000" data-close-others="true" aria-expanded="false">
				Alege o alta luna<i class="fa fa-angle-down"></i>
				</button>
				<ul class="dropdown-menu pull-right" role="menu">
					{assign var=balante value=$companie->balante}
						{foreach item=b from=$balante name=bList}
							<li>
								<a href="/raport_balanta?cid={$companie->id}&bid={$b->id}">{$b->an}&nbsp;{$lunileAnului[$b->luna]}</a>
							</li>														
						{/foreach}
				</ul>
			</div>
		</div>
		<!-- END PAGE TOOLBAR -->
</div>

<!-- BEGIN PAGE CONTENT-->
<div class="row margin-top-10">
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat2">
			<div class="display">
				<div class="number">
					<h3 class="font-green-sharp">{$valoriRaportLunar['CREANTE']->value()}<small class="font-green-sharp">{$LABEL['currency']}</small></h3>
					<small>{$TXT['CREANTE']}</small>
				</div>
				<div class="icon">
					<i class="icon-wallet"></i>
				</div>
			</div>
			<div class="progress-info padding-bottom-20">
				<div class="progress">
					<span style="width: 100%;" class="progress-bar progress-bar-success green-sharp">
					</span>
				</div>
			</div>
			
		</div>
	</div>
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat2">
			<div class="display">
				<div class="number">
					<h3 class="font-red-haze">{$valoriRaportLunar['DATORII_FATA_DE_FURNIZORI']->value()}<small class="font-red-haze">{$LABEL['currency']}</small></h3>
					<small>{$TXT['DATORII_FATA_DE_FURNIZORI']}</small>
				</div>
				<div class="icon">
					<i class=" icon-doc"></i>
				</div>
			</div>
			<div class="progress-info padding-bottom-20">
				<div class="progress">
					<span style="width: 100%;" class="progress-bar progress-bar-success red-haze">
					</span>
				</div>
			</div>
			
		</div>
	</div>
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat2">
			<div class="display">
				<div class="number">
					<h3 class="font-blue-sharp">{$valoriRaportLunar['STOCURI']->value()}<small class="font-blue-sharp">{$LABEL['currency']}</small></h3>
					<small>{$TXT['STOCURI']}</small>
				</div>
				<div class="icon">
					<i class="icon-layers"></i>
				</div>
			</div>
			<div class="progress-info padding-bottom-20">
				<div class="progress">
					<span style="width: 100%;" class="progress-bar progress-bar-success blue-sharp">
					</span>
				</div>
			</div>
			
		</div>
	</div>
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat2">
			<div class="display">
				<div class="number">
					<h3 class="font-purple-soft">000</h3>
					<small>LICHIDITATEA GENERALA</small>
				</div>
				<div class="icon">
					<i class="icon-credit-card"></i>
				</div>
			</div>
			<div class="progress-info padding-bottom-20">
				<div class="progress">
					<span style="width: 100%;" class="progress-bar progress-bar-success purple-soft">
					</span>
				</div>
			</div>			
		</div>
	</div>
	</div>
<div class="row margin-top-10">
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat2">
			<div class="display">
				<div class="number">
					<h3 class="font-yellow-casablanca">{$valoriRaportLunar['PROFIT_NET']->value()}<small class="font-yellow-casablanca">{$LABEL['currency']}</small></h3>
					<small>PROFIT NET</small>
				</div>
				<div class="icon">
					<i class="icon-speedometer"></i>
				</div>
			</div>
			<div class="progress-info padding-bottom-20">
				<div class="progress">
					<span style="width: 100%;" class="progress-bar progress-bar-success yellow-casablanca">
					</span>
				</div>
			</div>
			<div class="display">
				<div class="number">
					<h3 class="font-yellow-casablanca">{$valoriRaportLunar['PROFIT_NET']->valueCumulated()}<small class="font-yellow-casablanca">{$LABEL['currency']}</small></h3>
					<small>PROFIT NET  IANUARIE - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</small>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat2">
			<div class="display">
				<div class="number">
					<h3 class="font-blue-chambray">{$valoriRaportLunar['EBITDA']->value()}<small class="font-blue-chambray">{$LABEL['currency']}</small></h3>
					<small>EBITDA</small>
				</div>
				<div class="icon">
					<i class="icon-bar-chart"></i>
				</div>
			</div>
			<div class="progress-info padding-bottom-20">
				<div class="progress">
					<span style="width: 100%;" class="progress-bar progress-bar-success blue-chambray">
					</span>
				</div>
			</div>
			<div class="display">
				<div class="number">
					<h3 class="font-blue-chambray">{$valoriRaportLunar['EBITDA']->valueCumulated()}<small class="font-blue-chambray">{$LABEL['currency']}</small></h3>
					<small>EBITDA IANUARIE - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</small>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat2">
			<div class="display">
				<div class="number">
					<h3 class="font-green-seagreen">{$valoriRaportLunar['VENITURI_TOTALE']->value()}<small class="font-green-seagreen">{$LABEL['currency']}</small></h3>
					<small>VENITURI TOTALE</small>
				</div>
				<div class="icon">
					<i class="icon-login"></i>
				</div>
			</div>
			<div class="progress-info padding-bottom-20">
				<div class="progress">
					<span style="width: 100%;" class="progress-bar progress-bar-success green-seagreen">
					</span>
				</div>
			</div>
			<div class="display">
				<div class="number">
					<h3 class="font-green-seagreen">{$valoriRaportLunar['VENITURI_TOTALE']->valueCumulated()}<small class="font-green-seagreen">{$LABEL['currency']}</small></h3>
					<small>VENITURI TOTALE IANUARIE - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</small>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat2">
			<div class="display">
				<div class="number">
					<h3 class="font-red-pink">{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->value()}<small class="font-red-pink">{$LABEL['currency']}</small></h3>
					<small>CHELTUIELI TOTALE</small>
				</div>
				<div class="icon">
					<i class="icon-logout"></i>
				</div>
			</div>
			<div class="progress-info padding-bottom-20">
				<div class="progress">
					<span style="width: 100%;" class="progress-bar progress-bar-success red-pink">
					</span>
				</div>
			</div>
			<div class="display">
				<div class="number">
					<h3 class="font-red-pink">{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->valueCumulated()}<small class="font-red-pink">{$LABEL['currency']}</small></h3>
					<small>CHELTUIELI TOTALE IANUARIE - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</small>
				</div>
			</div>
		</div>
	</div>
	</div>
	


<div class="row">
	<div class="col-md-6">
		<div class="portlet light">
						<div class="portlet-title">
							<div class="caption">
								<i class="icon-bar-chart font-red-sunglo"></i>
								<span class="caption-subject font-red-sunglo bold uppercase">Sumar executiv</span>
								
							</div>
							
						</div>
						<div class="portlet-body">
							<p>In luna <b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b>, <b>{$companie->name}</b> a realizat o cifra de afaceri in suma de <b>{$valoriRaportLunar['CIFRA_DE_AFACERI']->value()}</b> Lei si un profit net in suma de <b>{$valoriRaportLunar['PROFIT_NET']->value()}</b> Lei. Cumulat de la inceputul anului {$balantaCurenta->an}, <b>{$companie->name}</b> a realizat o cifra de afaceri in suma de <b>{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulated()}</b> lei si profit net in suma de <b>{$valoriRaportLunar['PROFIT_NET']->valueCumulated()}</b> lei. </p>
										<p>Rata a profitabilitatii totale a fost de ??,?%, in luna <b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b>, comparativ cu  ???? rata profitabilitatii totale corespunzator intregii activitati a <b>{$companie->name}</b> realizate in perioada Ianuarie – {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}.</p>
										
										<p> SA MAI ADAUGAM 2-3 PARAGRAFE AICI SI O SA FIE FRUMOS</p>
										<p> SA MAI ADAUGAM 2-3 PARAGRAFE AICI SI O SA FIE FRUMOS</p>
										<p> SA MAI ADAUGAM 2-3 PARAGRAFE AICI SI O SA FIE FRUMOS</p>
							
							</div>
		</div>
	
	</div>
	<div class="col-md-6">
		<div class="portlet light">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-speedometer font-green-sharp"></i>
					<span class="caption-subject font-green-sharp bold uppercase">Analiza rezultatelor - profit/pierdere</span>
					
				</div>
				
			</div>
			<div class="portlet-body">
				<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_rezultate" >
					<thead>
					<tr >
						<th width=40%>
							 
						</th>
						<th colspan=2 style="text-align:center" width=30%>
							 {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
						</th>
						<th colspan=2 style="text-align:center">
							 Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
						</th>
					</tr>
					</thead>
					{$venituriCifraAfaceri =['PROFIT_DIN_EXPLOATARE',
											'PROFIT_DIN_ACTIVITATEA_FINANCIARA',
											'PROFIT_DIN_ACTIVITATEA_EXTRAORDINARA',
											'PROFIT_BRUT',
											'IMPOZIT_PE_PROFIT',
											'PROFIT_NET']}
									
					{foreach from=$venituriCifraAfaceri item=i}
						{assign var=valoare value=$valoriRaportLunar[$i]->value()}
						{if $valoare != 0}
						<tr>
							<td style="text-align:left;">{$TXT[$i]}</td>
							<td>{$valoriRaportLunar[$i]->value()}</td>
							<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
							<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
							<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
						</tr>
						{/if}
					{/foreach}
				</table>				
			</div>
		</div>
	
	</div>
</div>
<div class="row">
	<div class="col-md-6">
		<div class="portlet light">
						<div class="portlet-title">
							<div class="caption">
								<i class="icon-login font-blue-steel"></i>
								<span class="caption-subject font-blue-steel bold uppercase">Analiza veniturilor</span>
								
							</div>
							
						</div>
						<div class="portlet-body">
							<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_venituri" >
								<thead>
								<tr >
									<th>
									</th>
									<th>
									</th>
									<th colspan=2 style="text-align:center" width=28%>
										 {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
									</th>
									<th colspan=2 style="text-align:center" width=28%>
										 Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
									</th>
								</tr>
								</thead>
								<tbody> 
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['CIFRA_DE_AFACERI']}</td>
									<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->value()}</td>
									<td >{$valoriRaportLunar['CIFRA_DE_AFACERI']->valuePercent()}%</td>
									<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulated()}</td>
									<td style="width: 40px">{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulatedPercent()}%</td>
								</tr>
								{$venituriCifraAfaceri =['VENITURI_DIN_VANZAREA_PRODUSELOR_FINITE',
												'VENITURI_DIN_VANZAREA_SEMIFABRICATELOR_SI_PRODUSELOR_REZIDUALE',
												'VENITURI_DIN_SERVICII_PRESTATE',
												'VENITURI_DIN_STUDII_SI_CERCETARI',
												'VENITURI_DIN_REDEVENTE_LOCATII_DE_GESTIUNE_SI_CHIRII',
												'VENITURI_DIN_VANZAREA_MARFURILOR',
												'VENITURI_DIN_ACTIVITATI_DIVERSE',
												'REDUCERI_COMERCIALE_ACORDATE',
												'VENITURI_DIN_SUBVENTII_DE_EXPLOATARE_AFERENTE_CIFREI_DE_AFACERI']}
								
								{foreach from=$venituriCifraAfaceri item=i}
									<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
										<td>{$valoriRaportLunar[$i]->value()}</td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
										<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
										<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
									</tr>
								{/foreach}
								<!-- alte venituri -->
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['ALTE_VENITURI_DIN_EXPLOATARE']}</td>
									<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->value()}</td>
									<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->valuePercent()}%</td>
									<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->valueCumulated()}</td>
									<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->valueCumulatedPercent()}%</td>
								</tr>
								
								{$alteVenituri =['VENITURI_AFERENTE_COSTULUI_PRODUCTIEI_IN_CURS_DE_EXECUTIE',
												'VENITURI_DIN_PRODUCTIA_DE_IMOBILIZARI',
												'VENITURI_DIN_DESPAGUBIRI_AMENZI_SI_PENALITATI',
												'VENITURI_DIN_DONATII_PRIMITE',
												'VENITURI_DIN_VANZAREA_ACTIVELOR_SI_ALTE_OPERATII_DE_CAPITAL',
												'VENITURI_DIN_SUBVENTII_PENTRU_INVESTITII',
												'ALTE_VENITURI_OCAZIONALE_DIN_EXPLOATARE']}
								{foreach from=$alteVenituri item=i}
									
									<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
										<td>{$valoriRaportLunar[$i]->value()}</td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
										<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
										<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
									</tr>
								{/foreach}								
								<!-- end alte venituri -->
								<tr>
									<td style="text-align:center;"></td>
									<td style="text-align:left;">{$TXT['TOTAL_VENITURI_DIN_EXPLOATARE']}</td>
									<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->value()}</td>
									<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->valuePercent()}%</td>
									<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->valueCumulated()}</td>
									<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->valueCumulatedPercent()}%</td>
								</tr>
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['VENITURI_FINANCIARE']}</td>
									<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->value()}</td>
									<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->valuePercent()}%</td>
									<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->valueCumulated()}</td>
									<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->valueCumulatedPercent()}%</td>
								</tr>
								{$venituriFinanciare =['VENITURI_DIN_DOBANZI',
												'VENITURI_DIN_DIFERENTE_DE_CURS_VALUTAR',
												'VENITURI_DIN_SCONTURI_OBTINUTE',
												'ALTE_VENITURI_FINANCIARE']}
								
								
								{foreach from=$venituriFinanciare item=i}
									<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
										<td>{$valoriRaportLunar[$i]->value()}</td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
										<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
										<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
									</tr>
								{/foreach}
								<tr>
									<td style="text-align:center;"></td>
									<td style="text-align:left;">{$TXT['VENITURI_EXTRAORDINARE']}</td>
									<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->value()}</td>
									<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->valuePercent()}%</td>
									<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->valueCumulated()}</td>
									<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->valueCumulatedPercent()}%</td>
								</tr>
								<tr>
									<td style="text-align:center;"></td>
									<td style="text-align:left;">{$TXT['VENITURI_TOTALE']}</td>
									<td>{$valoriRaportLunar['VENITURI_TOTALE']->value()}</td>
									<td>{$valoriRaportLunar['VENITURI_TOTALE']->valuePercent()}%</td>
									<td>{$valoriRaportLunar['VENITURI_TOTALE']->valueCumulated()}</td>
									<td>{$valoriRaportLunar['VENITURI_TOTALE']->valueCumulatedPercent()}%</td>
								</tr>
								</tbody>
							</table>
							
							<div id="rezultate_graph"></div>
						</div>
		</div>
	
	</div>
	<div class="col-md-6">
		<div class="portlet light">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-logout font-purple-soft"></i>
					<span class="caption-subject font-purple-soft bold uppercase">Analiza cheltuielilor</span>
					
				</div>
				
			</div>
			<div class="portlet-body">
				<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_cheltuieli" >
								<thead>
								<tr >
									<th>
									</th>
									<th>
									</th>
									<th colspan=2 style="text-align:center" width=28%>
										 {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
									</th>
									<th colspan=2 style="text-align:center" width=28%>
										 Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
									</th>
								</tr>
								</thead>
								<tbody>
									<!-- Cheltuieli pentru realizarea cifrei de afaceri-->
									<tr>
										<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
										<td style="text-align:left;">{$TXT['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']}</td>
										<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->value()}</td>
										<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valuePercent()}%</td>
										<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valueCumulated()}</td>
										<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valueCumulatedPercent()}%</td>
									</tr>
									<tr class="isChildRow hide">
											<td style="text-align:center;"></td>
											<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['CHELTUIELI_MATERIALE']}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_MATERIALE']->value()}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_MATERIALE']->valuePercent()}%</td>
											<td>{$valoriRaportLunar['CHELTUIELI_MATERIALE']->valueCumulated()}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_MATERIALE']->valueCumulatedPercent()}%</td>
									</tr>
									{$chetuieliMateriale =['CHELTUIELI_CU_MATERIILE_PRIME',
													'CHELTUIELI_CU_MATERIALELE_CONSUMABILE',
													'CHELTUIELI_CU_OBIECTELE_DE_INVENTAR_MATERIALELE_NESTOCATE_SI_AMBALAJELE',
													'CHELTUIELI_PRIVIND_ENERGIA_SI_APA',
													'CHELTUIELI_PRIVIND_ANIMALELE_SI_PASARILE',
													'CHELTUIELI_PRIVIND_MARFURILE',
													'REDUCERI_COMERCIALE_PRIMITE']}
									{foreach from=$chetuieliMateriale item=i}
										
										<tr class="isSubChildRow hide">
											<td style="text-align:center;"></td>
											<td style="text-align:left;padding-left:60px;">{$TXT[$i]}</td>
											<td>{$valoriRaportLunar[$i]->value()}</td>
											<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
											<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
											<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
										</tr>
									{/foreach}
									
									<tr class="isChildRow hide">
											<td style="text-align:center;"></td>
											<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->value()}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->valuePercent()}%</td>
											<td>{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->valueCumulated()}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->valueCumulatedPercent()}%</td>
									</tr>
									{$chetuieliServiciiTerti =['CHELTUIELI_CU_INTRETINEREA_SI_REPARATIILE',
													'CHELTUIELI_CU_REDEVENTE_SI_CHIRII',
													'CHELTUIELI_CU_PRIMELE_DE_ASIGURARE',
													'CHELTUIELI_CU_STUDIILE_SI_CERCETARILE',
													'CHELTUIELI_CU_COLABORATORII',
													'CHELTUIELI_PRIVIND_COMISIOANELE_SI_ONORARIILE',
													'CHELTUIELI_DE_PROTOCOL_RECLAMA_SI_PUBLICITATE',
													'CHELTUIELI_CU_TRANSPORTUL_DE_BUNURI_SI_PERSONAL_DETASARI_TRASFERARI',
													'CHELTUIELI_POSTALE_SI_TAXE_DE_TELECOMUNICATII',
													'CHELTUIELI_CU_SERVICIILE_BANCARE',
													'ALTE_CHELTUIELI_CU_SERVICIILE_EXECUTATE_DE_TERTI']}
									{foreach from=$chetuieliServiciiTerti item=i}
										
										<tr class="isSubChildRow hide">
											<td style="text-align:center;"></td>
											<td style="text-align:left;padding-left:60px;">{$TXT[$i]}</td>
											<td>{$valoriRaportLunar[$i]->value()}</td>
											<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
											<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
											<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
										</tr>
									{/foreach}
									
									
									{$chetuieliCifraAfaceri =['CHELTUIELI_DE_PERSONAL',
													'SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE']}
									{foreach from=$chetuieliCifraAfaceri item=i}
										<tr class="isChildRow hide">
											<td style="text-align:center;"></td>
											<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
											<td>{$valoriRaportLunar[$i]->value()}</td>
											<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
											<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
											<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
										</tr>
									{/foreach}
									<!--END Cheltuieli pentru realizarea cifrei de afaceri-->
									<!-- ALTE cheltuieli de exploatare -->
										<tr>
											<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
											<td style="text-align:left;">{$TXT['ALTE_CHELTUIELI_DE_EXPLOATARE']}</td>
											<td>{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->value()}</td>
											<td>{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->valuePercent()}%</td>
											<td>{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->valueCumulated()}</td>
											<td>{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->valueCumulatedPercent()}%</td>
										</tr>
										{$alteCheltuieli =['CHELTUIELI_CU_ALTE_IMPOZITE_TAXE_SI_VARSAMINTE_ASIMILATE',
														'CHELTUIELI_CU_PROTECTIA_MEDIULUI_INCONJURATOR',
														'DESPAGUBIRI_AMENZI_SI_PENALITATI',
														'DONATII_ACORDATE',
														'CHELTUIELI_PRIVIND_ACTIVELE_CEDATE_SI_ALTE_OPERATII_DE_CAPITAL',
														'ALTE_CHELTUIELI_OCAZIONALE_DE_EXPLOATARE',
														'CHELTUIELI_CU_AMORTIZAREA_AJUSTARI_DE_VALOARE_SI_PROVIZIOANELE']}
										
										
										{foreach from=$alteCheltuieli item=i}
											<tr class="isChildRow hide">
												<td style="text-align:center;"></td>
												<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
												<td>{$valoriRaportLunar[$i]->value()}</td>
												<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
												<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
												<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
											</tr>
										{/foreach}
										<tr>
											<td style="text-align:center;"></td>
											<td style="text-align:left;">{$TXT['TOTAL_CHELTUIELI_DE_EXPLOATARE']}</td>
											<td>{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->value()}</td>
											<td>{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->valuePercent()}%</td>
											<td>{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->valueCumulated()}</td>
											<td>{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->valueCumulatedPercent()}%</td>
										</tr>
									<!-- END ALTE cheltuieli de exploatare -->
									<!-- Cheltuieli Financiare -->
										<tr>
											<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
											<td style="text-align:left;">{$TXT['CHELTUIELI_FINANCIARE']}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->value()}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->valuePercent()}%</td>
											<td>{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->valueCumulated()}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->valueCumulatedPercent()}%</td>
										</tr>
										{$cheltuieliFinanciare =['CHELTUIELI_PRIVIND_DOBANZILE',
														'CHELTUIELI_DIN_DIFERENTE_DE_CURS_VALUTAR',
														'CHELTUIELI_PRIVIND_SCONTURILE_ACORDATE',
														'ALTE_CHELTUIELI_FINANCIARE']}
										
										
										{foreach from=$cheltuieliFinanciare item=i}
											<tr class="isChildRow hide">
												<td style="text-align:center;"></td>
												<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
												<td>{$valoriRaportLunar[$i]->value()}</td>
												<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
												<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
												<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
											</tr>
										{/foreach}									
									<!-- END Cheltuieli financiare-->
										<tr>
											<td style="text-align:center;"></td>
											<td style="text-align:left;">{$TXT['CHELTUIELI_EXTRAORDINARE']}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->value()}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->valuePercent()}%</td>
											<td>{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->valueCumulated()}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->valueCumulatedPercent()}%</td>
										</tr>
										<tr>
											<td style="text-align:center;"></td>
											<td style="text-align:left;">{$TXT['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->value()}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->valuePercent()}%</td>
											<td>{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->valueCumulated()}</td>
											<td>{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->valueCumulatedPercent()}%</td>
										</tr>
						</tbody>
				</table>
				<div id="cheltuieli_graph"></div>
				
			</div>
		</div>
	
	</div>
</div>
<div class="row">
	<div class="col-md-6">
		<div class="portlet light">
						<div class="portlet-title">
							<div class="caption">
								<i class="icon-shuffle font-yellow-gold"></i>
								<span class="caption-subject font-yellow-gold bold uppercase">Activul patrimonial</span>
								
							</div>
							
						</div>
						<div class="portlet-body">
							<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_activ" >
								<thead>
								<tr >
									<th colspan=2>
									</th>
									<th colspan=2 style="text-align:center" width=28%>
										 {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
									</th>
								</tr>
								</thead>
								<tbody> 
								<tr>
									<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['ACTIVE_CIRCULANTE']}</td>
									<td>{$valoriRaportLunar['ACTIVE_CIRCULANTE']->value()}</td>
									<td >{$valoriRaportLunar['ACTIVE_CIRCULANTE']->valuePercent()}%</td>
								</tr>
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['DISPONIBIL_IN_CASERIE_SI_BANCA']}</td>
									<td>{$valoriRaportLunar['DISPONIBIL_IN_CASERIE_SI_BANCA']->value()}</td>
									<td>{$valoriRaportLunar['DISPONIBIL_IN_CASERIE_SI_BANCA']->valuePercent()}%</td>
								</tr>
								{$disponibilCaserie =['CONTURI_LA_BANCI',
												'CASA',
												'ACREDITIVE_ALTE_VALORI_VIRAMENTE_INTERNE',
												'AVANSURI_DE_TREZORERIE']}
								
								{foreach from=$disponibilCaserie item=i}
									<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
										<td>{$valoriRaportLunar[$i]->value()}</td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>										
									</tr>
								{/foreach}
								<!-- investitii termen scurt -->
								<tr>
									<td style="width: 10px; text-align:center;"></td>
									<td style="text-align:left;">{$TXT['INVESTITII_PE_TERMEN_SCURT']}</td>
									<td>{$valoriRaportLunar['INVESTITII_PE_TERMEN_SCURT']->value()}</td>
									<td>{$valoriRaportLunar['INVESTITII_PE_TERMEN_SCURT']->valuePercent()}%</td>
								</tr>				
								<!-- end investitii termen scurt -->
								<!-- Creante -->
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['CREANTE']}</td>
									<td>{$valoriRaportLunar['CREANTE']->value()}</td>
									<td>{$valoriRaportLunar['CREANTE']->valuePercent()}%</td>
								</tr>
								{$creante =['CLIENTI',
												'FURNIZORI_DEBITORI',
												'CREANTE_FATA_DE_PERSONALUL_ANGAJAT',
												'CREANTE_FATA_DE_BUGETUL_DE_STAT',
												'SUBVENTII',
												'CREANTE_FATA_DE_GRUP']}
								
								
								{foreach from=$creante item=i}
									<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
										<td>{$valoriRaportLunar[$i]->value()}</td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
									</tr>
								{/foreach}
								<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['ALTE_CREANTE']}</td>
										<td>{$valoriRaportLunar['ALTE_CREANTE']->value()}</td>
										<td>{$valoriRaportLunar['ALTE_CREANTE']->valuePercent()}%</td>
								</tr>
								{$alteCreante =['DEBITORI_DIVERSI',
												'OPERATIUNI_IN_CURS_DE_CLARIFICARE_ACTIV',
												'DECONTARI_IN_CADRUL_UNITATII_ACTIV',
												'DOBANZI_DE_PRIMIT']}
								{foreach from=$alteCreante item=i}
									
									<tr class="isSubChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:60px;">{$TXT[$i]}</td>
										<td>{$valoriRaportLunar[$i]->value()}</td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
									</tr>
								{/foreach}
								
								
								<tr class="isChildRow hide">
									<td style="text-align:center;"></td>
									<td style="text-align:left;padding-left:30px;">{$TXT['AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR']}</td>
									<td>{$valoriRaportLunar['AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR']->value()}</td>
									<td>{$valoriRaportLunar['AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR']->valuePercent()}%</td>
								</tr>
								<!-- END creante -->
								<!-- Stocuri -->
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['STOCURI']}</td>
									<td>{$valoriRaportLunar['STOCURI']->value()}</td>
									<td>{$valoriRaportLunar['STOCURI']->valuePercent()}%</td>
								</tr>
								{$stocuri =['STOCURI_DE_MATERII_PRIME_SI_MATERIALE',
											'STOCURI_IN_CURS_DE_APROVIZIONARE',
											'PRODUCTIA_IN_CURS_DE_EXECUTIE',
											'PRODUSE',
											'STOCURI_AFLATE_LA_TERTI',
											'ANIMALE_SI_PASARI',
											'MARFURI',
											'AMBALAJE',
											'AJUSTARI_PENTRU_DEPREC_STOCURILOR']}
								{foreach from=$stocuri item=i}
									<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
										<td>{$valoriRaportLunar[$i]->value()}</td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
									</tr>
								{/foreach}
								<!-- END stocuri -->
								<tr>
									<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['CHELTUIELI_IN_AVANS']}</td>
									<td>{$valoriRaportLunar['CHELTUIELI_IN_AVANS']->value()}</td>
									<td>{$valoriRaportLunar['CHELTUIELI_IN_AVANS']->valuePercent()}%</td>
								</tr>
								<tr>
									<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['ACTIVE_IMOBILIZATE']}</td>
									<td>{$valoriRaportLunar['ACTIVE_IMOBILIZATE']->value()}</td>
									<td>{$valoriRaportLunar['ACTIVE_IMOBILIZATE']->valuePercent()}%</td>
								</tr>
								<!-- Imobilizari necorporale  -->
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['IMOBILIZARI_NECORPORALE']}</td>
									<td>{$valoriRaportLunar['IMOBILIZARI_NECORPORALE']->value()}</td>
									<td>{$valoriRaportLunar['IMOBILIZARI_NECORPORALE']->valuePercent()}%</td>
								</tr>
								{$imobilizariNecorporale =['IMOBILIZARI_NECOROPRALE_VALOARE_DE_INTRARE',
															'AMORTIZARE_SI_AJUSTARI_IMOBILIZARI_NECORPORALE']}
								{foreach from=$imobilizariNecorporale item=i}
									<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
										<td>{$valoriRaportLunar[$i]->value()}</td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
									</tr>
								{/foreach}
								<!-- END Imobilizari necorporale  -->
								<!-- Imobilizari corporale  -->
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['IMOBILIZARI_CORPORALE']}</td>
									<td>{$valoriRaportLunar['IMOBILIZARI_CORPORALE']->value()}</td>
									<td>{$valoriRaportLunar['IMOBILIZARI_CORPORALE']->valuePercent()}%</td>
								</tr>
								{$imobilizariCorporale =['TERENURI_SI_AMENAJARI_LA_TERENURI',
														'CONSTRUCTII',
														'INSTALATII_TEHNICE_MIJ_TRANS',
														'MOBILIER_BIROTICA_ECHIP_PROTECTIE',
														'IMOBILIZARI_IN_CURS_DE_APROVIZIONARE_AVANSURI_ACORDATE',
														'AMORTIZARI_PRIVIND_IMOBILIZARILE_CORPORALE']}
								{foreach from=$imobilizariCorporale item=i}
									<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
										<td>{$valoriRaportLunar[$i]->value()}</td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
									</tr>
								{/foreach}
								<!-- END Imobilizari corporale  -->
								<!-- Imobilizari financiare  -->
								<tr>
									<td style="width: 10px; text-align:center;" ></td>
									<td style="text-align:left;">{$TXT['IMOBILIZARI_FINANCIARE']}</td>
									<td>{$valoriRaportLunar['IMOBILIZARI_FINANCIARE']->value()}</td>
									<td>{$valoriRaportLunar['IMOBILIZARI_FINANCIARE']->valuePercent()}%</td>
								</tr>
								<!-- END Imobilizari necorporale  -->
								<tr>
									<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['TOTAL_ACTIV']}</td>
									<td>{$valoriRaportLunar['TOTAL_ACTIV']->value()}</td>
									<td>{$valoriRaportLunar['TOTAL_ACTIV']->valuePercent()}%</td>
								</tr>
								
								</tbody>
							</table>
							<div id="graph_active"></div>
		</div>
	</div>
	</div>
	<div class="col-md-6">
		<div class="portlet light">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-share font-yellow-casablanca"></i>
					<span class="caption-subject font-yellow-casablanca bold uppercase">Pasivul patrimonial</span>
					
				</div>
				
			</div>
			<div class="portlet-body">
				<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_activ" >
						<thead>
						<tr >
							<th colspan=2>
							</th>
							<th colspan=2 style="text-align:center" width=28%>
								 {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
							</th>
						</tr>
						</thead>
						<tbody> 
						<tr>
							<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['TOTAL_DATORII']}</td>
							<td>{$valoriRaportLunar['TOTAL_DATORII']->value()}</td>
							<td>{$valoriRaportLunar['TOTAL_DATORII']->valuePercent()}%</td>
						</tr>
						<!-- end datorii pe termen scurt-->
						<tr>
							<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
							<td style="text-align:left;">{$TXT['DATORII_PE_TERMEN_SCURT']}</td>
							<td>{$valoriRaportLunar['DATORII_PE_TERMEN_SCURT']->value()}</td>
							<td>{$valoriRaportLunar['DATORII_PE_TERMEN_SCURT']->valuePercent()}%</td>
						</tr>
						{$datoriiTS =['DATORII_FATA_DE_FURNIZORI',
										'CLIENTI_CREDITORI',
										'DATORII_FATA_DE_PERSONAL_PASIV',
										'DATORII_FATA_DE_BUGETUL_DE_STAT',
										'DATORII_FATA_DE_GRUP',
										'DATORII_FATA_DE_ASOCIATI',
										'DATORII_FATA_DE_BANCI']}
						
						{foreach from=$datoriiTS item=i}
							<tr class="isChildRow hide">
								<td style="text-align:center;"></td>
								<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
								<td>{$valoriRaportLunar[$i]->value()}</td>
								<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
							</tr>
						{/foreach}
						<tr class="isChildRow hide">
								<td style="text-align:center;"></td>
								<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['ALTE_DATORII']}</td>
								<td>{$valoriRaportLunar['ALTE_DATORII']->value()}</td>
								<td>{$valoriRaportLunar['ALTE_DATORII']->valuePercent()}%</td>
						</tr>
						{$alteDatorii =['CREDITORI_DIVERSI',
										'OPERATIUNI_IN_CURS_DE_CLARIFICARE_PASIV',
										'DECONTARI_IN_CADRUL_UNITATII_PASIV',										
										'VARSAM_DE_EFECTUAT_PENTRU_INVESTITIILE_PE_T_S']}
						{foreach from=$alteDatorii item=i}
							<tr class="isSubChildRow hide">
								<td style="text-align:center;"></td>
								<td style="text-align:left;padding-left:60px;">{$TXT[$i]}</td>
								<td>{$valoriRaportLunar[$i]->value()}</td>
								<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
							</tr>
						{/foreach}
						
						<!-- end datorii pe termen scurt-->
						<tr>
							<td style="width: 10px; text-align:center;"></td>
							<td style="text-align:left;">{$TXT['DATORII_PE_TERMEN_MEDIU_SI_LUNG']}</td>
							<td>{$valoriRaportLunar['DATORII_PE_TERMEN_MEDIU_SI_LUNG']->value()}</td>
							<td>{$valoriRaportLunar['DATORII_PE_TERMEN_MEDIU_SI_LUNG']->valuePercent()}%</td>
						</tr>	
						<!-- venituri in avans -->
						<tr>
							<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['VENITURI_IN_AVANS']}</td>
							<td>{$valoriRaportLunar['VENITURI_IN_AVANS']->value()}</td>
							<td>{$valoriRaportLunar['VENITURI_IN_AVANS']->valuePercent()}%</td>
						</tr>
						{$venituriAvans =['SUBVENTII_PENTRU_INVESTITII',
										'VENITURI_INREGISTRATE_IN_AVANS',
										'FOND_COMERCIAL_NEGATIV']}
						
						{foreach from=$venituriAvans item=i}
							<tr>
								<td style="width: 10px; text-align:center;"></td>
								<td style="text-align:left;">{$TXT[$i]}</td>
								<td>{$valoriRaportLunar[$i]->value()}</td>
								<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
							</tr>
						{/foreach}
						<!-- END venituri in avans -->
						<!-- provizioane -->
						<tr>
							<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['PROVIZIOANE']}</td>
							<td>{$valoriRaportLunar['PROVIZIOANE']->value()}</td>
							<td>{$valoriRaportLunar['PROVIZIOANE']->valuePercent()}%</td>
						</tr>
						<!-- end provizioane-->
						<!-- capitaluri proprii -->
						<tr>
							<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['CAPITALURI_PROPRII']}</td>
							<td>{$valoriRaportLunar['CAPITALURI_PROPRII']->value()}</td>
							<td>{$valoriRaportLunar['CAPITALURI_PROPRII']->valuePercent()}%</td>
						</tr>
						{$capitaluriProprii =['CAPITAL_SI_REZERVE',
										'REZULTAT_REPORTAT',
										'REZULTATUL_EXERCITIULUI',
										'ALTE_CASTIGURI_PASIV',
										'REPARTIZAREA_PROFITULUI']}
						
						{foreach from=$capitaluriProprii item=i}							
							<tr>
								<td style="width: 10px; text-align:center;"></td>
								<td style="text-align:left;">{$TXT[$i]}</td>
								<td>{$valoriRaportLunar[$i]->value()}</td>
								<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
							</tr>
						{/foreach}
						<!-- END capitaluri proprii -->
						<tr>
							<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['TOTAL_PASIV']}</td>
							<td>{$valoriRaportLunar['TOTAL_PASIV']->value()}</td>
							<td>{$valoriRaportLunar['TOTAL_PASIV']->valuePercent()}%</td>
						</tr>
				</table>
				<div id="graph_pasive"></div>
			</div>
		</div>
	
	</div>
</div>
<div class="row">
	<div class="col-md-4">
		<div class="portlet light">
						<div class="portlet-title">
							<div class="caption">
								<i class="icon-shuffle font-blue-hoki"></i>
								<span class="caption-subject font-blue-hoki bold uppercase">Indicatori financiari: Profitabilitate</span>
								
							</div>
							
						</div>
						<div class="portlet-body">
							<table class="table table-striped table-hover table-bordered" style="text-align:right" >
								<thead>
								<tr >
									<th>
									</th>
									<th style="text-align:center" width=28%>
										 {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
									</th>
									<th style="text-align:center" width=28%>
										 Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
									</th>
								</tr>
								</thead>
								<tbody> 
								{$kpiProfitabilitate =['RATA_PROFITULUI_NET',
										'RATA_PROFITULUI_DIN_EXPLOATARE',
										'RATA_PROFITABILITATII_TOTALE',
										'MARJA_EBITDA']}
						
								{foreach from=$kpiProfitabilitate item=i}									
									<tr>
										<td style="text-align:left;">{$TXT[$i]}</td>
										<td>{$valoriKPI[$i]->value()}%</td>
										<td>{$valoriKPI[$i]->valueCumulated()}%</td>
									</tr>
								{/foreach}								
								</tbody>
							</table>
		</div>
	</div>
	</div>
	<div class="col-md-4">
		<div class="portlet light">
						<div class="portlet-title">
							<div class="caption">
								<i class="icon-shuffle font-blue-hoki"></i>
								<span class="caption-subject font-blue-hoki bold uppercase">Indicatori financiari: Structura capitalului</span>
								
							</div>
							
						</div>
						<div class="portlet-body">
							<table class="table table-striped table-hover table-bordered" style="text-align:right">
								<thead>
								<tr >
									<th>
									</th>
									<th style="text-align:center" width=38%>
										 {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
									</th>
								</tr>
								</thead>
								<tbody> 
								{$kpiStructuraCapital =['GRAD_DE_INDATORARE_TOTAL',
										'GRAD_DE_INDATORARE_LA_TERMEN',
										'GRAD_DE_INDATORARE_PE_TERMEN_SCURT',
										'SOLVABILITATE']}
						
								{foreach from=$kpiStructuraCapital item=i}									
									<tr>
										<td style="text-align:left;">{$TXT[$i]}</td>
										<td>{$valoriKPI[$i]->value()}%</td>
									</tr>
								{/foreach}
								</tbody>
							</table>
		</div>
	</div>
	</div>
	<div class="col-md-4">
		<div class="portlet light">
						<div class="portlet-title">
							<div class="caption">
								<i class="icon-shuffle font-blue-hoki"></i>
								<span class="caption-subject font-blue-hoki bold uppercase">Indicatori financiari: Lichiditate</span>
								
							</div>
							
						</div>
						<div class="portlet-body">
							<table class="table table-striped table-hover table-bordered" style="text-align:right">
								<thead>
								<tr >
									<th>
									</th>
									<th style="text-align:center" width=38%>
										 {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
									</th>
								</tr>
								</thead>
								<tbody> 
								{$kpiLichiditate =['LICHIDITATEA_GENERALA',
										'LICHIDITATEA_IMEDIATA',
										'ECHILIBRUL_FINANCIAR_PE_TERMEN_LUNG']}
						
								{foreach from=$kpiLichiditate item=i}									
									<tr>
										<td style="text-align:left;">{$TXT[$i]}</td>
										<td>{$valoriKPI[$i]->value()}%</td>									
									</tr>
								{/foreach}
								</tbody>
							</table>
		</div>
	</div>
	</div>
</div>

{literal}
<script>
var TabeleRaportLunar = function() {

   return {

        //main function to initiate the module
        init: function () {
			
            if (!jQuery().plot) {
                return;
            }
		
			
           TabeleRaportLunar.initTables();
           TabeleRaportLunar.initGraphVenituri();
		   TabeleRaportLunar.initGraphCheltuieli();
		   TabeleRaportLunar.initGraphActive();
		   TabeleRaportLunar.initGraphPasive();
            
        },

		initGraphVenituri: function () {  
				{/literal}{assign var=listaItems value=['CIFRA_DE_AFACERI','VENITURI_TOTALE','PROFIT_NET' ]}{literal}
				var dataNew= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
								{label: "{/literal}{$TXT[$i]}{literal}",
								 data: [
											
												["{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}", 
												 {/literal}{$valoriRaportLunar[$i]->value()}{literal}],
												["{/literal}Ianuarie-{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}", 
												{/literal}{$valoriRaportLunar[$i]->valueCumulated()}{literal}]
										]}  
										{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];				
			 
				TabeleRaportLunar.createBarChart("#rezultate_graph", dataNew);
		
		},
		initGraphCheltuieli: function () {  
				{/literal}{assign var=listaItems value=['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI','ALTE_CHELTUIELI_DE_EXPLOATARE','CHELTUIELI_FINANCIARE', 'CHELTUIELI_EXTRAORDINARE', 'CHELTUIELI_TOTALE_INAINTE_IMPOZITARE' ]}{literal}
				var dataNew= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
								{label: "{/literal}{$TXT[$i]}{literal}",
								 data: [
											
												["{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}", 
												 {/literal}{$valoriRaportLunar[$i]->value()}{literal}],
												["{/literal}Ianuarie-{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}", 
												{/literal}{$valoriRaportLunar[$i]->valueCumulated()}{literal}]
										]}  
										{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];				
			 
				TabeleRaportLunar.createBarChart("#cheltuieli_graph", dataNew);
		
		},
		createBarChart: function(targetId, data) {
			$.plot(targetId, data, {	
					legend: {
						labelBoxBorderColor: "none",
						position: "right"
					},
					series: {
						bars: {
							show: true,
							barWidth: 0.07,
							lineWidth: 0,
							order: 1, // Include this line to ensure the bars will appear side by side.
							fillColor: {
								colors: [{
									opacity: 1
								}, {
									opacity: 0.7
								}]
							}
						}
					},
					xaxis: {
						mode: "categories", // Include this line so the bars are grouped.
						tickLength: 0
					},
					grid: {
						hoverable: true,
						clickable: false,
						borderWidth: 0
					}
				});

				function showTooltip(x, y, contents) {
					$('<div id="flot-tooltip1">' + contents + '</div>').css({
						position: 'absolute',
						top: y - 20,
						left: x - 90,						
						display: 'none',
						border: '1px solid #333',
						'text-align': 'center',
						padding: '4px',
						color: "#fff",
						'background-color': '#333',
						opacity: '0.8'
					}).appendTo("body").show();
				}

			 
				$(targetId).bind("plothover", function (event, pos, item) {
					var previousPoint;					
					if (item) {
						if (previousPoint != item.datapoint) {
							previousPoint = item.datapoint;
							$("#flot-tooltip1").remove();
			 
							var originalPoint;
			 
							if (item.datapoint[0] == item.series.data[0][3]) {
								originalPoint = item.series.data[0][0];
							} else if (item.datapoint[0] == item.series.data[1][3]){
								originalPoint = item.series.data[1][0];
							} else if (item.datapoint[0] == item.series.data[2][3]){
								originalPoint = item.series.data[2][0];
							} else if (item.datapoint[0] == item.series.data[3][3]){
								originalPoint = item.series.data[3][0];
							} else if (item.datapoint[0] == item.series.data[4][3]){
								originalPoint = item.series.data[4][0];
							}
			 
							var x = originalPoint;
							y = item.datapoint[1];
							z = item.series.color;
			 
							showTooltip(item.pageX, item.pageY,
								"<b>" + item.series.label + "</b><br /> " + x + " = " + y,
								z);
						}
					} else {
						$("#flot-tooltip1").remove();
						previousPoint = null;
					}
				});
		
		},
		initGraphActive: function () {
			var lunaCurentaData = [
					{ label: "{/literal}{$TXT['DISPONIBIL_IN_CASERIE_SI_BANCA']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['DISPONIBIL_IN_CASERIE_SI_BANCA']->value()}{literal}
					},
					{ label: "{/literal}{$TXT['INVESTITII_PE_TERMEN_SCURT']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['INVESTITII_PE_TERMEN_SCURT']->value()}{literal}
					},
					{ label: "{/literal}{$TXT['CREANTE']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['CREANTE']->value()}{literal}
					},
					{ label: "{/literal}{$TXT['STOCURI']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['STOCURI']->value()}{literal}
					},
					{ label: "{/literal}{$TXT['CHELTUIELI_IN_AVANS']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['CHELTUIELI_IN_AVANS']->value()}{literal}
					},
					{ label: "{/literal}{$TXT['IMOBILIZARI_NECORPORALE']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['IMOBILIZARI_NECORPORALE']->value()}{literal}
					},
					{ label: "{/literal}{$TXT['IMOBILIZARI_CORPORALE']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['IMOBILIZARI_CORPORALE']->value()}{literal}
					},
					{ label: "{/literal}{$TXT['IMOBILIZARI_FINANCIARE']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['IMOBILIZARI_FINANCIARE']->value()}{literal}
					}
				];
						
			$.plot($("#graph_active"), lunaCurentaData, {
                    series: {
                        pie: {
							innerRadius: 0.4,
                            show: true,
                            combine: {
                                color: '#999',
								label: 'Altele',
                                threshold: 0.1
                            }
                        }
                    },
                    legend: {
                        show: true
                    },
					 grid: {
						hoverable: true,
						clickable: false
					}
                });
				
				function showTooltip2(x,y,series) {					
					 $('<div id="flot-tooltip2">' + series.label + '&nbsp;'+Math.round(series.percent)+ '%</div>').css( {
							position: 'absolute',
							top: y + 5,
							left: x + 5,
							border: '1px solid #ddd',							
							'text-align': 'center',
							'background-color': '#cecece',
							padding: '5px',							
							opacity: 0.80
						}).appendTo("body");
				}
			 
				$("#graph_active").bind("plothover", function (event, pos, item) {
					var previousPoint2;
					if (item) {
						if (previousPoint2 != item.datapoint) {
							previousPoint2 = item.datapoint;
							$("#flot-tooltip2").remove();
							showTooltip2(pos.pageX, pos.pageY, item.series );
						}
					} else {
						$("#flot-tooltip2").remove();
						previousPoint2 = null;
					}
				});
				
		},
		
		initGraphPasive: function () {
			var lunaCurentaData = [
					{ label: "{/literal}{$TXT['DATORII_PE_TERMEN_SCURT']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['DATORII_PE_TERMEN_SCURT']->valuePercent()}{literal}
					},
					{ label: "{/literal}{$TXT['DATORII_PE_TERMEN_MEDIU_SI_LUNG']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['DATORII_PE_TERMEN_MEDIU_SI_LUNG']->valuePercent()}{literal}
					},
					{ label: "{/literal}{$TXT['SUBVENTII_PENTRU_INVESTITII']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['SUBVENTII_PENTRU_INVESTITII']->valuePercent()}{literal}
					},
					{ label: "{/literal}{$TXT['VENITURI_INREGISTRATE_IN_AVANS']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['VENITURI_INREGISTRATE_IN_AVANS']->valuePercent()}{literal}
					},
					{ label: "{/literal}{$TXT['FOND_COMERCIAL_NEGATIV']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['FOND_COMERCIAL_NEGATIV']->valuePercent()}{literal}
					},
					{ label: "{/literal}{$TXT['PROVIZIOANE']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['PROVIZIOANE']->valuePercent()}{literal}
					},
					{ label: "{/literal}{$TXT['CAPITAL_SI_REZERVE']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['CAPITAL_SI_REZERVE']->valuePercent()}{literal}
					},
					{ label: "{/literal}{$TXT['REZULTAT_REPORTAT']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['REZULTAT_REPORTAT']->valuePercent()}{literal}
					},
					{ label: "{/literal}{$TXT['REZULTATUL_EXERCITIULUI']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['REZULTATUL_EXERCITIULUI']->valuePercent()}{literal}
					},
					{ label: "{/literal}{$TXT['ALTE_CASTIGURI_PASIV']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['ALTE_CASTIGURI_PASIV']->valuePercent()}{literal}
					},
					{ label: "{/literal}{$TXT['REPARTIZAREA_PROFITULUI']}{literal}", 
					  data: {/literal}{$valoriRaportLunar['REPARTIZAREA_PROFITULUI']->valuePercent()}{literal}
					}
				];
						
			$.plot($("#graph_pasive"), lunaCurentaData, {
                    series: {
                        pie: {
							innerRadius: 0.4,
                            show: true,
                            combine: {
                                color: '#999',
								label: 'Altele',
                                threshold: 0.1
                            }
                        }
                    },
                    legend: {
                        show: true
                    },
					 grid: {
						hoverable: true,
						clickable: false
					}
                });
				
				function showTooltip3(x,y,series) {					
					 $('<div id="flot-tooltip3">' + series.label + '&nbsp;'+Math.round(series.percent)+ '%</div>').css( {
							position: 'absolute',
							top: y + 5,
							left: x + 5,
							border: '1px solid #ddd',							
							'text-align': 'center',
							'background-color': '#cecece',
							padding: '5px',							
							opacity: 0.80
						}).appendTo("body");
				}
			 
				$("#graph_pasive").bind("plothover", function (event, pos, item) {
					var previousPoint3;
					if (item) {
						if (previousPoint3 != item.datapoint) {
							previousPoint3 = item.datapoint;
							$("#flot-tooltip3").remove();
							showTooltip3(pos.pageX, pos.pageY, item.series );
						}
					} else {
						$("#flot-tooltip3").remove();
						previousPoint3 = null;
					}
				});
				
		},
		
		initTables: function () {  
			 
			 // Add event listener for opening and closing details on FIRST level
			$('tbody').on('click', 'td.details-control', function () {	
			
				if($(this).children(".fa").hasClass("fa-plus-square-o")) {
					//open the row marker
					$(this).children(".fa").removeClass("fa-plus-square-o");
					$(this).children(".fa").addClass("fa-minus-square-o");
				} else {
					//close the row marker
					$(this).children(".fa").removeClass("fa-minus-square-o");
					$(this).children(".fa").addClass("fa-plus-square-o");
				}
			
				var tr = $(this).closest('tr');	
				var nextTr = tr.next('tr');
			   // var row = table.row( tr );
				while(nextTr.hasClass('isChildRow') || nextTr.hasClass('isSubChildRow')) {
					if(nextTr.hasClass('isChildRow')) {
						//is child row (second level)
						if(nextTr.hasClass('hide')) {
							nextTr.removeClass('hide');
						} else {
							nextTr.addClass('hide');
							//if expandalble than set row marker on closed
							if(nextTr.find('i').hasClass("fa-minus-square-o")) {
								nextTr.find('i').removeClass("fa-minus-square-o");
								nextTr.find('i').addClass("fa-plus-square-o");
								
							}
						}
					} else {
						//is subchild row (third level)
						if(nextTr.hasClass('hide')) {
							//nextTr.removeClass('hide');
						} else {
							nextTr.addClass('hide');
						}
					}
					nextTr = nextTr.next('tr');
				}
			} );
			
			// Add event listener for opening and closing details on SECOND level
			$('tbody').on('click', 'td.sub-details-control', function () {	
				if($(this).children(".fa").hasClass("fa-plus-square-o")) {
					//open the row marker
					$(this).children(".fa").removeClass("fa-plus-square-o");
					$(this).children(".fa").addClass("fa-minus-square-o");
				} else {
					//close the row marker
					$(this).children(".fa").removeClass("fa-minus-square-o");
					$(this).children(".fa").addClass("fa-plus-square-o");
				}
				var tr = $(this).closest('tr');	
				var nextTr = tr.next('tr');
			   // var row = table.row( tr );
				while(nextTr.hasClass('isSubChildRow')) {		
						if(nextTr.hasClass('hide') ) {
							// Open this row
							nextTr.removeClass('hide');
						}
						else {
							// This row is already open - close it
							nextTr.addClass('hide');
						}
					nextTr = nextTr.next('tr');
				}
			} );
	 
	 }

    };

}();

</script>

{/literal}