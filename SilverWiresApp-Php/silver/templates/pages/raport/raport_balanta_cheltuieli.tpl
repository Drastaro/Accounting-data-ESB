<div class="portlet light">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-logout font-blue-steel"></i>
					<span class="caption-subject font-blue-steel bold uppercase">Analiza cheltuielilor</span>					
				</div>
				<div class="actions">
					<span class="font-grey-salsa">Date grafic:&nbsp;&nbsp;&nbsp;</span>
					<div class="btn-group btn-group-devided" data-toggle="buttons">
						<label class="btn btn-transparent grey-salsa btn-sm active" id="cheltuieli_option_luna">
						<input type="radio" name="options" class="toggle" >{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</label>
						<label class="btn btn-transparent grey-salsa btn-sm"  id="cheltuieli_option_cumulat">
						<input type="radio" name="options" class="toggle">Cumulat Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</label>						
					</div>
				</div>
				
			</div>
			<div class="portlet-body">				
				<div class="col-md-1">&nbsp;</div>
				<div class="col-md-5 donut-holder">
					<div id="cheltuieli_graph"></div>
					<div class="donut-label-wrapper" id="donutLabelCheltuieli">
						<div class="donut-label-perioada">
						{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
						</div>
						<div class="donut-label-text">
						{$TXT['CHELTUIELI_TOTALE']}
						</div>
						<div class="donut-label-value">
						{$TXT['CHELTUIELI_TOTALE']}<small>{$LABEL['currency']}</small>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div id="cheltuieli_details" class="donut_details_text">									
					</div>
				</div>
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
									<th width=5%></th>
								</tr>
								</thead>
								<tbody>
									<!-- Cheltuieli pentru realizarea cifrei de afaceri-->
									<tr>
										<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-minus-square-o fa-lg"></i></td>
										<td style="text-align:left;">{$TXT['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']}</td>
										<td><span class="money">{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->value()}</span></td>
										<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valuePercent()}%</td>
										<td><span class="money">{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valueCumulated()}</span></td>
										<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valueCumulatedPercent()}%</td>
										<td></td>
									</tr>
									<tr class="isChildRow">
											<td style="text-align:center;"></td>
											<td style="text-align:left;padding-left:9px;" class="sub-details-control">
												<i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['CHELTUIELI_MATERIALE']}												
											</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_MATERIALE']->value()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_MATERIALE']->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_MATERIALE']->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_MATERIALE']->valueCumulatedPercent()}%</td>
											<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_cheltuieliMateriale">Afiseaza grafic</button></td>
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
											<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
											<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
											<td></td>
										</tr>
									{/foreach}
									
									<tr class="isChildRow">
											<td style="text-align:center;"></td>
											<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']}</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->value()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->valueCumulatedPercent()}%</td>
											<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_cheltuieliServicii">Afiseaza grafic</button></td>
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
											<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
											<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
											<td></td>
										</tr>
									{/foreach}
									
									{$chetuieliCifraAfaceri =['CHELTUIELI_DE_PERSONAL',
													'SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE']}
									{foreach from=$chetuieliCifraAfaceri item=i}
										<tr class="isChildRow">
											<td style="text-align:center;"></td>
											<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
											<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
											<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
											<td></td>
										</tr>
									{/foreach}
									<!--END Cheltuieli pentru realizarea cifrei de afaceri-->
									<!-- ALTE cheltuieli de exploatare -->
										<tr>
											<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
											<td style="text-align:left;">{$TXT['ALTE_CHELTUIELI_DE_EXPLOATARE']}</td>
											<td><span class="money">{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->value()}</span></td>
											<td>{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar['ALTE_CHELTUIELI_DE_EXPLOATARE']->valueCumulatedPercent()}%</td>
											<td></td>
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
												<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
												<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
												<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
												<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
												<td></td>
											</tr>
										{/foreach}
										<tr>
											<td style="text-align:center;"></td>
											<td style="text-align:left;">{$TXT['TOTAL_CHELTUIELI_DE_EXPLOATARE']}</td>
											<td><span class="money">{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->value()}</span></td>
											<td>{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar['TOTAL_CHELTUIELI_DE_EXPLOATARE']->valueCumulatedPercent()}%</td>
											<td></td>
										</tr>
									<!-- END ALTE cheltuieli de exploatare -->
									<!-- Cheltuieli Financiare -->
										<tr>
											<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
											<td style="text-align:left;">{$TXT['CHELTUIELI_FINANCIARE']}</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->value()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_FINANCIARE']->valueCumulatedPercent()}%</td>
											<td></td>
										</tr>
										{$cheltuieliFinanciare =['CHELTUIELI_PRIVIND_DOBANZILE',
														'CHELTUIELI_DIN_DIFERENTE_DE_CURS_VALUTAR',
														'CHELTUIELI_PRIVIND_SCONTURILE_ACORDATE',
														'ALTE_CHELTUIELI_FINANCIARE']}
										
										
										{foreach from=$cheltuieliFinanciare item=i}
											<tr class="isChildRow hide">
												<td style="text-align:center;"></td>
												<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
												<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
												<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
												<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
												<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
												<td></td>
											</tr>
										{/foreach}									
									<!-- END Cheltuieli financiare-->
										<tr>
											<td style="text-align:center;"></td>
											<td style="text-align:left;">{$TXT['CHELTUIELI_EXTRAORDINARE']}</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->value()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_EXTRAORDINARE']->valueCumulatedPercent()}%</td>
											<td></td>
										</tr>
										<tr>
											<td style="text-align:center;"></td>
											<td style="text-align:left;">{$TXT['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']}</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->value()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->valueCumulatedPercent()}%</td>
											<td></td>
										</tr>
										<tr>
											<td style="text-align:center;"></td>
											<td style="text-align:left;">{$TXT['IMPOZIT_PE_PROFIT']}</td>
											<td><span class="money">{$valoriRaportLunar['IMPOZIT_PE_PROFIT']->value()}</span></td>
											<td>{$valoriRaportLunar['IMPOZIT_PE_PROFIT']->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar['IMPOZIT_PE_PROFIT']->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar['IMPOZIT_PE_PROFIT']->valueCumulatedPercent()}%</td>
											<td></td>
										</tr>
										<tr>
											<td style="text-align:center;"></td>
											<td style="text-align:left;">{$TXT['CHELTUIELI_TOTALE']}</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_TOTALE']->value()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_TOTALE']->valuePercent()}%</td>
											<td><span class="money">{$valoriRaportLunar['CHELTUIELI_TOTALE']->valueCumulated()}</span></td>
											<td>{$valoriRaportLunar['CHELTUIELI_TOTALE']->valueCumulatedPercent()}%</td>
											<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_cheltuieliTotale">Afiseaza grafic</button></td>
										</tr>
						</tbody>
				</table>
				
				
			</div>
		</div>