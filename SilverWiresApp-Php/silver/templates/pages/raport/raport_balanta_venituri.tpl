<div class="portlet light">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-login font-blue-steel"></i>
										<span class="caption-subject font-blue-steel bold uppercase">Analiza veniturilor</span>
										
									</div>
									<div class="actions">
										<span class="font-grey-salsa">Date grafic:&nbsp;&nbsp;&nbsp;</span>
										<div class="btn-group btn-group-devided" data-toggle="buttons">
											<label class="btn btn-transparent grey-salsa btn-sm active" id="venituri_option_luna">
											<input type="radio" name="options" class="toggle" >{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</label>
											<label class="btn btn-transparent grey-salsa btn-sm"  id="venituri_option_cumulat">
											<input type="radio" name="options" class="toggle">Cumulat Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</label>						
										</div>
									</div>
								</div>
								
											<div class="portlet-body">
												<div class="col-md-1">&nbsp;</div>
												<div class="col-md-5 donut-holder">
													<div id="venituri_graph"></div>
													<div class="donut-label-wrapper" id="donutLabelVenituri">
														<div class="donut-label-perioada">
														{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
														</div>
														<div class="donut-label-text">
														{$TXT['VENITURI_TOTALE']}
														</div>
														<div class="donut-label-value">
														{$TXT['VENITURI_TOTALE']}
														</div>
													</div>
												</div>
												<div class="col-md-4">
													<div id="venituri_details" class="donut_details_text">									
													</div>
												</div>
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
														<th width=5%></th>
													</tr>
													</thead>
													<tbody> 
													<tr>
														<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
														<td style="text-align:left;">{$TXT['CIFRA_DE_AFACERI']}</td>
														<td><span class="money">{$valoriRaportLunar['CIFRA_DE_AFACERI']->value()}</span></td>
														<td >{$valoriRaportLunar['CIFRA_DE_AFACERI']->valuePercent()}%</td>
														<td><span class="money">{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulated()}</span></td>
														<td style="width: 40px">{$valoriRaportLunar['CIFRA_DE_AFACERI']->valueCumulatedPercent()}%</td>
														<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_cifra_afaceri">Afiseaza grafic</button></td>
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
															<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
															<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
															<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
															<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
															<td></td>
														</tr>
													{/foreach}
													<!-- alte venituri -->
													<tr>
														<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
														<td style="text-align:left;">{$TXT['ALTE_VENITURI_DIN_EXPLOATARE']}</td>
														<td><span class="money">{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->value()}</span></td>
														<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->valuePercent()}%</td>
														<td><span class="money">{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->valueCumulated()}</span></td>
														<td>{$valoriRaportLunar['ALTE_VENITURI_DIN_EXPLOATARE']->valueCumulatedPercent()}%</td>
														<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_alte_venituri_exploatare">Afiseaza grafic</button></td>
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
															<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
															<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
															<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
															<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
															<td></td>
														</tr>
													{/foreach}								
													<!-- end alte venituri -->
													<tr>
														<td style="text-align:center;"></td>
														<td style="text-align:left;">{$TXT['TOTAL_VENITURI_DIN_EXPLOATARE']}</td>
														<td><span class="money">{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->value()}</span></td>
														<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->valuePercent()}%</td>
														<td><span class="money">{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->valueCumulated()}</span></td>
														<td>{$valoriRaportLunar['TOTAL_VENITURI_DIN_EXPLOATARE']->valueCumulatedPercent()}%</td>
														<td></td>
													</tr>
													<tr>
														<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
														<td style="text-align:left;">{$TXT['VENITURI_FINANCIARE']}</td>
														<td><span class="money">{$valoriRaportLunar['VENITURI_FINANCIARE']->value()}</span></td>
														<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->valuePercent()}%</td>
														<td><span class="money">{$valoriRaportLunar['VENITURI_FINANCIARE']->valueCumulated()}</span></td>
														<td>{$valoriRaportLunar['VENITURI_FINANCIARE']->valueCumulatedPercent()}%</td>
														<td></td>
													</tr>
													{$venituriFinanciare =['VENITURI_DIN_DOBANZI',
																	'VENITURI_DIN_DIFERENTE_DE_CURS_VALUTAR',
																	'VENITURI_DIN_SCONTURI_OBTINUTE',
																	'ALTE_VENITURI_FINANCIARE']}
													
													
													{foreach from=$venituriFinanciare item=i}
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
														<td style="text-align:left;">{$TXT['VENITURI_EXTRAORDINARE']}</td>
														<td><span class="money">{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->value()}</span></td>
														<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->valuePercent()}%</td>
														<td><span class="money">{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->valueCumulated()}</span></td>
														<td>{$valoriRaportLunar['VENITURI_EXTRAORDINARE']->valueCumulatedPercent()}%</td>
														<td></td>
													</tr>
													<tr>
														<td style="text-align:center;"></td>
														<td style="text-align:left;">{$TXT['VENITURI_TOTALE']}</td>
														<td><span class="money">{$valoriRaportLunar['VENITURI_TOTALE']->value()}</span></td>
														<td>{$valoriRaportLunar['VENITURI_TOTALE']->valuePercent()}%</td>
														<td><span class="money">{$valoriRaportLunar['VENITURI_TOTALE']->valueCumulated()}</span></td>
														<td>{$valoriRaportLunar['VENITURI_TOTALE']->valueCumulatedPercent()}%</td>
														<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_venituriTotale">Afiseaza grafic</button></td>
													</tr>
													</tbody>
												</table>
												
												
											</div>
							</div>