<!-- Content Header (Page header) -->
<div class="page-head">
		<!-- BEGIN PAGE TITLE -->
		<div class="page-title">
		 <h1>{$companie->name} - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
        <!-- <small>Analiza financiara de management si business intelligence</small></h1>-->
		</div>
		<!-- END PAGE TITLE -->
</div>

<!-- BEGIN PAGE CONTENT-->
<div class="row">
	<div class="col-md-12">
		<div class="portlet box">
			<div class="portlet-body">
				Raport lunar pentru companie - mici explicatii<br/>
				Luna selectata: {$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}
				
				<div class="btn-group">
					<button id="btn7" type="button" class="btn btn-sm red dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
					Alege o alta luna <i class="fa fa-angle-down"></i>
					</button>
					<ul class="dropdown-menu" role="menu" aria-labelledby="btn7">
						{assign var=balante value=$companie->balante}
						{foreach item=b from=$balante name=bList}
							<li>
								<a href="/raport_balanta?cid={$companie->id}&bid={$b->id}">{$b->an}&nbsp;{$lunileAnului[$b->luna]}</a>
							</li>														
						{/foreach}						
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<div class="portlet box">
						
						<div class="portlet-body">
							<div id="navbar-example2" class="navbar navbar-default navbar-static" role="navigation">
								<div class="navbar-header">
									<button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-js-navbar-scrollspy">
									<span class="sr-only">
									Toggle navigation </span>
									<span class="icon-bar">
									</span>
									<span class="icon-bar">
									</span>
									<span class="icon-bar">
									</span>
									</button>
									<a class="navbar-brand">
									Navigare rapida: </a>
								</div>
								<div class="collapse navbar-collapse bs-js-navbar-scrollspy">
									<ul class="nav navbar-nav">
										<li class="active">
											<a href="#sumar_exec">
											Sumar executiv </a>
										</li>
										<li>
											<a href="#venituri">
											Venituri, cheltuieli, profit </a>
										</li>
										<li>
											<a href="#activ">
											Activ patrimonial </a>
										</li>
										<li>
											<a href="#pasiv">
											Pasiv patrimonial </a>
										</li>
										<li class="dropdown">
											<a href="#" id="navbarDrop1" class="dropdown-toggle" data-toggle="dropdown">
											Options <i class="fa fa-angle-down"></i>
											</a>
											<ul class="dropdown-menu" role="menu" aria-labelledby="navbarDrop1">
												<li>
													<a href="#section1" tabindex="-1">
													section 1 </a>
												</li>
												<li>
													<a href="#section2" tabindex="-1">
													section 2 </a>
												</li>
												<li class="divider">
												</li>
												<li>
													<a href="#section3" tabindex="-1">
													section 1 </a>
												</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>						
							<div data-spy="scroll" data-target="#navbar-example2" data-offset="0" class="scrollspy-raport">
								<div class="row">
									<div class="col-md-12">
										<h3 id="sumar_exec">Sumar executiv</h3>
										<p>In luna <b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b>, <b>{$companie->name}</b> a realizat o cifra de afaceri in suma de <b>{$valoriRaportLunar['CIFRA_DE_AFACERI']->value()}</b> Lei si un profit net in suma de <b>{$valoriRaportLunar['PROFIT_NET']->value()}</b> Lei. Cumulat de la inceputul anului {$balantaCurenta->an}, <b>{$companie->name}</b> a realizat o cifra de afaceri in suma de <b>{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulated()}</b> lei si profit net in suma de <b>{$valoriRaportLunar['PROFIT_NET']->valueCumulated()}</b> lei. </p>
										<p>Rata a profitabilitatii totale a fost de ??,?%, in luna <b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b>, comparativ cu  ???? rata profitabilitatii totale corespunzator intregii activitati a <b>{$companie->name}</b> realizate in perioada Ianuarie – {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}.</p>
										
										<p>La sfarsit de <b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b>, <b>{$companie->name}</b> detine active totale in suma de {$valoriRaportLunar['TOTAL_ACTIV']->value()} Lei.  Firma un grad de indatorare de ??,??%, lichiditatea imediata este de ??,??,  perioada de incasare a creantelor de la clienti este  de ??,?? zile, iar perioada de plata a datoriilor catre furnizori este de ???? zile. </p>
										<h3>Analiza detaliata a situatiei financiare a <b>{$companie->name}</b></h3>
										<p>Analiza situatiei financiare a <b>{$companie->name}</b> la sfarsit de <b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b> include:
										<ol>
											<li>Analiza  veniturilor, cheltuielilor si a profitului</li>
											<li>Analiza activului patrimonial</li>
											<li>Analiza pasivului patrimonial</li>
											<li>Prezentarea principalilor indicatori economico-financiari</li>
										</ol>
										<br/>
										<h4><b>1.	Analiza  veniturilor,  cheltuielilor si a profitului</b> </h4>
										<h4>1.1 Prezentarea  contului de profit si pierderi</h4>
										<p>Veniturile si cheltuielile realizate de <b>{$companie->name}</b> in  luna <b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b> si cumulat in perioada <b>Ianuarie – {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b> sunt prezentate in tabelul urmator.  In tabel este prezentata si ponderea fiecarui element de venit si cheltuiala in total venituri pentru a putea compara modul in care a evoluat ponderea fiecarui element analizat. </p>
										<table class="table table-bordered table-hover" style="text-align:right">
											<tbody>
												<tr class="active">
													<td colspan=2 style="text-align:left;"><b>Cont de profit si pierderi</b></td>
													<td colspan=2 style="text-align:center;"><b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b></td>
													<td colspan=2 style="text-align:center;"><b>Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b></td>
												</tr>
												<tr>
													<td colspan=2 style="text-align:left;"><b>ACTIVITATEA DE EXPLOATARE</b></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td style="width: 10px; text-align:center;">1</td>
													<td style="text-align:left;width:50%;">Cifra de afaceri</td>
													<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->value()}</td>
													<td style="width: 40px;">luna%</td>
													<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulated()}</td>
													<td style="width: 40px">anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">2</td>
													<td style="text-align:left;">Cheltuieli pentru realizarea cifrei de afaceri </td>
													<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;">2.1. Cheltuieli materiale </td>
													<td>{$valoriRaportLunar['CHELTUIELI_MATERIALE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_MATERIALE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;">2.2. Cheltuieli cu servicii prestate de terti</td>
													<td>{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;">2.3. Cheltuieli de personal</td>
													<td>{$valoriRaportLunar['CHELTUIELI_DE_PERSONAL']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_DE_PERSONAL']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;">2.4 Subventii primite pentru cheltuieli de exploatare </td>
													<td>{$valoriRaportLunar['SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">3</td>
													<td style="text-align:left;">Profit aferent activitatii de baza</td>
													<td>{$valoriRaportLunar['PROFIT_AFERENT_ACTIVITATII_DE_BAZA']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['PROFIT_AFERENT_ACTIVITATII_DE_BAZA']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">4</td>
													<td style="text-align:left;">Alte venituri din exploatare</td>
													<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">5</td>
													<td style="text-align:left;">Alte cheltuieli de exploatare</td>
													<td>{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">6</td>
													<td style="text-align:left;">Total venituri din exploatare </td>
													<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">7</td>
													<td style="text-align:left;">Total cheltuieli de exploatare </td>
													<td>{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">8</td>
													<td style="text-align:left;">Profit din  exploatare</td>
													<td>{$valoriRaportLunar['PROFIT_DIN_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['PROFIT_DIN_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td colspan=2 style="text-align:left;"><b>ACTIVITATEA FINANCIARA</b></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td style="text-align:center;">9</td>
													<td style="text-align:left;">Venituri financiare</td>
													<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">10</td>
													<td style="text-align:left;">Cheltuieli financiare</td>
													<td>{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">11</td>
													<td style="text-align:left;">Profit din activitatea financiara</td>
													<td>{$valoriRaportLunar['PROFIT_DIN_ACTIVITATEA_FINANCIARA']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['PROFIT_DIN_ACTIVITATEA_FINANCIARA']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td colspan=2 style="text-align:left;"><b>ACTIVITATEA EXTRAORDINARA</b></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td style="text-align:center;">12</td>
													<td style="text-align:left;">Venituri extraordinare</td>
													<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">13</td>
													<td style="text-align:left;">Cheltuieli extraordinare</td>
													<td>{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">14</td>
													<td style="text-align:left;">Profit din activitatea extraordinara extraordinara </td>
													<td>{$valoriRaportLunar['PROFIT_DIN_ACTIVITATEA_EXTRAORDINARA']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['PROFIT_DIN_ACTIVITATEA_EXTRAORDINARA']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td colspan=2 style="text-align:left;"><b>ACTIVITATEA TOTALA</b></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td style="text-align:center;">15</td>
													<td style="text-align:left;">Venituri totale</td>
													<td>{$valoriRaportLunar['VENITURI_TOTALE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_TOTALE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">16</td>
													<td style="text-align:left;">Cheltuieli totale</td>
													<td>{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;">EBITDA</td>
													<td>{$valoriRaportLunar['EBITDA']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['EBITDA']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;">EBIT</td>
													<td>{$valoriRaportLunar['EBIT']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['EBIT']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">17</td>
													<td style="text-align:left;">Profit brut</td>
													<td>{$valoriRaportLunar['PROFIT_BRUT']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['PROFIT_BRUT']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">18</td>
													<td style="text-align:left;">Impozit pe profit</td>
													<td>{$valoriRaportLunar['IMPOZIT_PE_PROFIT']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['IMPOZIT_PE_PROFIT']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">19</td>
													<td style="text-align:left;">Profit net </td>
													<td>{$valoriRaportLunar['PROFIT_NET']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['PROFIT_NET']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												
											</tbody>
										</table>
										<h4>1.2 Analiza veniturilor </h4>
										<p>Veniturile realizate de <b>{$companie->name}</b> in  luna <b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b> si cumulat in perioada <b>Ianuarie – {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b> sunt prezentate in tabelul urmator.</p>
										<table class="table table-bordered table-hover" style="text-align:right">
											<tbody>
												<tr class="active">
													<td></td>
													<td></td>
													<td colspan=2 style="text-align:center;"><b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b></td>
													<td colspan=2 style="text-align:center;"><b>Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b></td>
												</tr>							
												<tr>
													<td style="width: 10px; text-align:center;">1</td>
													<td style="text-align:left;width:50%;">Cifra de afaceri</td>
													<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->value()}</td>
													<td style="width: 40px;">luna%</td>
													<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulated()}</td>
													<td style="width: 40px">anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">2</td>
													<td style="text-align:left;">Alte venituri din exploatare</td>
													<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">3</td>
													<td style="text-align:left;">Total venituri din exploatare  </td>
													<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">4</td>
													<td style="text-align:left;">Venituri financiare</td>
													<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">5</td>
													<td style="text-align:left;">Venituri extraordinare</td>
													<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">6</td>
													<td style="text-align:left;">Venituri totale</td>
													<td>{$valoriRaportLunar['VENITURI_TOTALE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_TOTALE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
											</tbody>
										</table>
										<p>Cifra de afaceri a fost realizata din urmatoarele venituri:</p>
										<table class="table table-bordered table-hover" style="text-align:right">
											<tbody>
												<tr class="active">
													<td></td>
													<td></td>
													<td colspan=2 style="text-align:center;"><b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b></td>
													<td colspan=2 style="text-align:center;"><b>Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b></td>
												</tr>												
												<tr>
													<td style="width: 10px; text-align:center;">1</td>
													<td style="text-align:left;width:50%;"><b>Cifra de afaceri</b></td>
													<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->value()}</td>
													<td style="width: 40px;">luna%</td>
													<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulated()}</td>
													<td style="width: 40px">anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;padding-left:30px;">Venituri din vanzarea produselor finite</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_VANZAREA_PRODUSELOR_FINITE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_VANZAREA_PRODUSELOR_FINITE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">	</td>
													<td style="text-align:left;padding-left:30px;">Venituri din vanzarea semifabricatelor si produselor reziduale</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_VANZAREA_SEMIFABRICATELOR_SI_PRODUSELOR_REZIDUALE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_VANZAREA_SEMIFABRICATELOR_SI_PRODUSELOR_REZIDUALE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;padding-left:30px;">Venituri din servicii prestate</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_SERVICII_PRESTATE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_SERVICII_PRESTATE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;padding-left:30px;">Venituri din studii si cercetari</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_STUDII_SI_CERCETARI']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_STUDII_SI_CERCETARI']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;padding-left:30px;">Venituri din redevente, locatii de gestiune si chirii</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_REDEVENTE_LOCATII_DE_GESTIUNE_SI_CHIRII']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_REDEVENTE_LOCATII_DE_GESTIUNE_SI_CHIRII']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;padding-left:30px;">Venituri din vanzarea marfurilor</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_VANZAREA_MARFURILOR']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_VANZAREA_MARFURILOR']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;padding-left:30px;">Venituri din activitati diverse</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_ACTIVITATI_DIVERSE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_ACTIVITATI_DIVERSE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;padding-left:30px;">Reduceri comerciale acordate</td>
													<td>{$valoriRaportLunar['REDUCERI_COMERCIALE_ACORDATE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['REDUCERI_COMERCIALE_ACORDATE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;padding-left:30px;">Venituri din subventii de exploatare aferente cifrei de afaceri</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_SUBVENTII_DE_EXPLOATARE_AFERENTE_CIFREI_DE_AFACERI']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_DIN_SUBVENTII_DE_EXPLOATARE_AFERENTE_CIFREI_DE_AFACERI']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
											</tbody>
										</table>
										
										
										
										
										
										
										<h4 id="venituri">Venituri, cheltuieli</h4>
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
																				<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->value()}</td>
																				<td><span class="badge bg-red">55%</span></td>
																			</tr>
																			<tr>
																				<td>2.</td>
																				<td>Alte venituri din exploatare</td>
																				<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->value()}</td>
																				<td><span class="badge bg-red">25%</span></td>
																			</tr>
																			<tr>
																				<td>3.</td>
																				<td>Total venituri din exploatare</td>
																				<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->value()}</td>
																				<td><span class="badge bg-red">75%</span></td>
																			</tr>
																			<tr>
																				<td>4.</td>
																				<td>Venituri financiare</td>
																				<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->value()}</td>
																				<td><span class="badge bg-red">15%</span></td>
																			</tr>
																			<tr>
																				<td>5.</td>
																				<td>Venituri extraordinare</td>
																				<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->value()}</td>
																				<td><span class="badge bg-red">55%</span></td>
																			</tr>
																			<tr>
																				<td>6.</td>
																				<td>Venituri totale</td>
																				<td>{$valoriRaportLunar['VENITURI_TOTALE']->value()}</td>
																				<td><span class="badge bg-red">55%</span></td>
																			</tr>
																			
																		</tbody>
												</table>
										<h4 id="section1">Section 1</h4>
										<p>
											 Occaecat commodo aliqua delectus. Fap craft beer deserunt skateboard ea. Lomo bicycle rights adipisicing banh mi, velit ea sunt next level locavore single-origin coffee in magna veniam. High life id vinyl, echo park consequat quis aliquip banh mi pitchfork. Vero VHS est adipisicing. Consectetur nisi DIY minim messenger bag. Cred ex in, sustainable delectus consectetur fanny pack iphone.
										</p>
										<h4 id="section2">Section 2</h4>
										<p>
											 In incididunt echo park, officia deserunt mcsweeney's proident master cleanse thundercats sapiente veniam. Excepteur VHS elit, proident shoreditch +1 biodiesel laborum craft beer. Single-origin coffee wayfarers irure four loko, cupidatat terry richardson master cleanse. Assumenda you probably haven't heard of them art party fanny pack, tattooed nulla cardigan tempor ad. Proident wolf nesciunt sartorial keffiyeh eu banh mi sustainable. Elit wolf voluptate, lo-fi ea portland before they sold out four loko. Locavore enim nostrud mlkshk brooklyn nesciunt.
										</p>
										<h4 id="section3">Section 3</h4>
										<p>
											 Ad leggings keytar, brunch id art party dolor labore. Pitchfork yr enim lo-fi before they sold out qui. Tumblr farm-to-table bicycle rights whatever. Anim keffiyeh carles cardigan. Velit seitan mcsweeney's photo booth 3 wolf moon irure. Cosby sweater lomo jean shorts, williamsburg hoodie minim qui you probably haven't heard of them et cardigan trust fund culpa biodiesel wes anderson aesthetic. Nihil tattooed accusamus, cred irony biodiesel keffiyeh artisan ullamco consequat.
										</p>
										<p>
											 Keytar twee blog, culpa messenger bag marfa whatever delectus food truck. Sapiente synth id assumenda. Locavore sed helvetica cliche irony, thundercats you probably haven't heard of them consequat hoodie gluten-free lo-fi fap aliquip. Labore elit placeat before they sold out, terry richardson proident brunch nesciunt quis cosby sweater pariatur keffiyeh ut helvetica artisan. Cardigan craft beer seitan readymade velit. VHS chambray laboris tempor veniam. Anim mollit minim commodo ullamco thundercats.
										</p>
									</div>
									
							</div>
							</div>
						
						</div>
		</div>
	</div>
</div>

