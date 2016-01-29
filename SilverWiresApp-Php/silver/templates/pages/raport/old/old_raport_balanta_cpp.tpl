
<!--

<div class="row">
	<div class="col-md-12">
		<div class="portlet box">
						<div class="portlet-title tabbable-line">
				<div class="caption">
					<i class="icon-share font-green-sharp"></i>
					<span class="caption-subject font-green-sharp bold uppercase">Revenue</span>
					<span class="caption-helper">weekly stats...</span>
				</div>
				
			</div>
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
									
									<h4 id="venituri">Venituri, cheltuieli</h4>
									<table class="table table-bordered table-hover" style="text-align:right" id="table_cpp" >
									<thead>
            <tr>
                <th>1</th>
                <th>2</th>
                <th>3</th>
               
                
            </tr>
        </thead>
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
													<td style="width: 10px; text-align:center;" class="details-control"><span class="row-details row-details-close"></span></td>
													<td style="text-align:left;width:50%;"><b>{$TXT['CIFRA_DE_AFACERI']}</b></td>
													<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->value()}</td>
													<td style="width: 40px;">luna%</td>
													<td>{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulated()}</td>
													<td style="width: 40px">anual%</td>
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
														<td>luna%</td>
														<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
														<td>anual%</td>
													</tr>
												{/foreach}
												
												
												
												<tr>
													<td style="width: 10px; text-align:center;" class="details-control"><span class="row-details row-details-close"></span></td>
													<td style="text-align:left;"><b>Cheltuieli pentru realizarea cifrei de afaceri</b></td>
													<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr class="isChildRow hide">
														<td style="text-align:center;"></td>
														<td style="text-align:left;padding-left:9px;" class="sub-details-control"><span class="row-details row-details-close" style="padding-right:21px;"></span>{$TXT['CHELTUIELI_MATERIALE']}</td>
														<td>{$valoriRaportLunar['CHELTUIELI_MATERIALE']->value()}</td>
														<td>luna%</td>
														<td>{$valoriRaportLunar['CHELTUIELI_MATERIALE']->valueCumulated()}</td>
														<td>anual%</td>
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
														<td>luna%</td>
														<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
														<td>anual%</td>
													</tr>
												{/foreach}
												
												<tr class="isChildRow hide">
														<td style="text-align:center;"></td>
														<td style="text-align:left;padding-left:9px;" class="sub-details-control"><span class="row-details row-details-close" style="padding-right:21px;"></span>{$TXT['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']}</td>
														<td>{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->value()}</td>
														<td>luna%</td>
														<td>{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->valueCumulated()}</td>
														<td>anual%</td>
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
														<td>luna%</td>
														<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
														<td>anual%</td>
													</tr>
												{/foreach}
												
												
												{$chetuieliCifraAfaceri =['CHELTUIELI_DE_PERSONAL',
																'SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE']}
												{foreach from=$chetuieliCifraAfaceri item=i}
													<tr class="isChildRow hide">
														<td style="text-align:center;"></td>
														<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
														<td>{$valoriRaportLunar[$i]->value()}</td>
														<td>luna%</td>
														<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
														<td>anual%</td>
													</tr>
												{/foreach}
																				
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;"><b>{$TXT['PROFIT_AFERENT_ACTIVITATII_DE_BAZA']}</b></td>
													<td>{$valoriRaportLunar['PROFIT_AFERENT_ACTIVITATII_DE_BAZA']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['PROFIT_AFERENT_ACTIVITATII_DE_BAZA']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												
												
												<tr>
													<td style="width: 10px; text-align:center;" class="details-control"><span class="row-details row-details-close"></span></td>
													<td style="text-align:left;"><b>{$TXT['ALTE_VENITURI_DIN_EXPLOATARE']}</b></td>
													<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
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
														<td>luna%</td>
														<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
														<td>anual%</td>
													</tr>
												{/foreach}
												
												
												<tr>
													<td style="width: 10px; text-align:center;" class="details-control"><span class="row-details row-details-close"></span></td>
													<td style="text-align:left;"><b>{$TXT['ALTE_CHELTUIELI_DE_EXPLOATARE']}</b></td>
													<td>{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
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
														<td>luna%</td>
														<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
														<td>anual%</td>
													</tr>
												{/foreach}
												
												
												<tr>
													<td style="text-align:center;">6</td>
													<td style="text-align:left;">{$TXT['TOTAL_VENITURI_DIN_EXPLOATARE']}</td>
													<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">7</td>
													<td style="text-align:left;">{$TXT['TOTAL_CHELTUIELI_DE_EXPLOATARE']}</td>
													<td>{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">8</td>
													<td style="text-align:left;">{$TXT['PROFIT_DIN_EXPLOATARE']}</td>
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
													<td style="width: 10px; text-align:center;" class="details-control"><span class="row-details row-details-close"></span></td>
													<td style="text-align:left;">{$TXT['VENITURI_FINANCIARE']}</td>
													<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->valueCumulated()}</td>
													<td>anual%</td>
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
														<td>luna%</td>
														<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
														<td>anual%</td>
													</tr>
												{/foreach}
												
												
												<tr>
													<td style="width: 10px; text-align:center;" class="details-control"><span class="row-details row-details-close"></span></td>
													<td style="text-align:left;">{$TXT['CHELTUIELI_FINANCIARE']}</td>
													<td>{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->valueCumulated()}</td>
													<td>anual%</td>
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
														<td>luna%</td>
														<td>{$valoriRaportLunar[$i]->valueCumulated()}</td>
														<td>anual%</td>
													</tr>
												{/foreach}
												
												
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;"><b>{$TXT['PROFIT_DIN_ACTIVITATEA_FINANCIARA']}</b></td>
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
													<td style="text-align:left;">{$TXT['VENITURI_EXTRAORDINARE']}</td>
													<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">13</td>
													<td style="text-align:left;">{$TXT['CHELTUIELI_EXTRAORDINARE']}</td>
													<td>{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">14</td>
													<td style="text-align:left;">{$TXT['PROFIT_DIN_ACTIVITATEA_EXTRAORDINARA']}</td>
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
													<td style="text-align:left;">{$TXT['VENITURI_TOTALE']}</td>
													<td>{$valoriRaportLunar['VENITURI_TOTALE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['VENITURI_TOTALE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">16</td>
													<td style="text-align:left;">{$TXT['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']}</td>
													<td>{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;">{$TXT['EBITDA']}</td>
													<td>{$valoriRaportLunar['EBITDA']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['EBITDA']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;"></td>
													<td style="text-align:left;">{$TXT['EBIT']}</td>
													<td>{$valoriRaportLunar['EBIT']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['EBIT']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">17</td>
													<td style="text-align:left;">{$TXT['PROFIT_BRUT']}</td>
													<td>{$valoriRaportLunar['PROFIT_BRUT']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['PROFIT_BRUT']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">18</td>
													<td style="text-align:left;">{$TXT['IMPOZIT_PE_PROFIT']}</td>
													<td>{$valoriRaportLunar['IMPOZIT_PE_PROFIT']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['IMPOZIT_PE_PROFIT']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												<tr>
													<td style="text-align:center;">19</td>
													<td style="text-align:left;">{$TXT['PROFIT_NET']}</td>
													<td>{$valoriRaportLunar['PROFIT_NET']->value()}</td>
													<td>luna%</td>
													<td>{$valoriRaportLunar['PROFIT_NET']->valueCumulated()}</td>
													<td>anual%</td>
												</tr>
												
											</tbody>
										</table>
								
										<h3 id="sumar_exec">Sumar executiv</h3>
										<p>In luna <b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b>, <b>{$companie->name}</b> a realizat o cifra de afaceri in suma de <b>{$valoriRaportLunar['CIFRA_DE_AFACERI']->value()}</b> Lei si un profit net in suma de <b>{$valoriRaportLunar['PROFIT_NET']->value()}</b> Lei. Cumulat de la inceputul anului {$balantaCurenta->an}, <b>{$companie->name}</b> a realizat o cifra de afaceri in suma de <b>{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulated()}</b> lei si profit net in suma de <b>{$valoriRaportLunar['PROFIT_NET']->valueCumulated()}</b> lei. </p>
										<p>Rata a profitabilitatii totale a fost de ??,?%, in luna <b>{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</b>, comparativ cu  ???? rata profitabilitatii totale corespunzator intregii activitati a <b>{$companie->name}</b> realizate in perioada Ianuarie – {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}.</p>
										
										<div id="demo"></div>
										
										
										
										
										
									
									
							</div>
							</div>
						
						</div>
		</div>
	</div>
</div> -->