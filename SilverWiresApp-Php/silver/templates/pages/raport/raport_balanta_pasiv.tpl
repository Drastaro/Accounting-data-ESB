<div class="portlet light">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-share font-blue-steel"></i>
										<span class="caption-subject font-blue-steel bold uppercase">Pasivul patrimonial</span>
										
									</div>
									
								</div>
								<div class="portlet-body">
									<div class="col-md-1">&nbsp;</div>
									<div class="col-md-5 donut-holder">
										<div id="graph_pasive"></div>
										<div class="donut-label-wrapper" id="donutLabelPasive">
											<div class="donut-label-perioada">
											{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
											</div>
											<div class="donut-label-text">
											{$TXT['TOTAL_PASIV']}
											</div>
											<div class="donut-label-value">
											{$TXT['TOTAL_PASIV']}<small>{$LABEL['currency']}</small>
											</div>
										</div>								
									</div>
									<div class="col-md-4" >
										<div id="pasive_details" class="donut_details_text">									
										</div>
									</div>
									
									<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_activ" >
											<thead>
											<tr >
												<th colspan=2>
												</th>
												<th colspan=2 style="text-align:center" width=28%>
													 {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
												</th>
												<th width=5%></th>
											</tr>
											</thead>
											<tbody> 
											<tr>
												<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['TOTAL_DATORII']}</td>
												<td><span class="money">{$valoriRaportLunar['TOTAL_DATORII']->value()}</span></td>
												<td>{$valoriRaportLunar['TOTAL_DATORII']->valuePercent()}%</td>
												<td></td>
											</tr>
											<!-- end datorii pe termen scurt-->
											<tr>
												<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
												<td style="text-align:left;">{$TXT['DATORII_PE_TERMEN_SCURT']}</td>
												<td><span class="money">{$valoriRaportLunar['DATORII_PE_TERMEN_SCURT']->value()}</span></td>
												<td>{$valoriRaportLunar['DATORII_PE_TERMEN_SCURT']->valuePercent()}%</td>
												<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_datoriitermscurt">Afiseaza grafic</button></td>
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
													<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
													<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
													<td></td>
												</tr>
											{/foreach}
											<tr class="isChildRow hide">
													<td style="text-align:center;"></td>
													<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['ALTE_DATORII']}</td>
													<td><span class="money">{$valoriRaportLunar['ALTE_DATORII']->value()}</span></td>
													<td>{$valoriRaportLunar['ALTE_DATORII']->valuePercent()}%</td>
													<td></td>
											</tr>
											{$alteDatorii =['CREDITORI_DIVERSI',
															'OPERATIUNI_IN_CURS_DE_CLARIFICARE_PASIV',
															'DECONTARI_IN_CADRUL_UNITATII_PASIV',										
															'VARSAM_DE_EFECTUAT_PENTRU_INVESTITIILE_PE_T_S']}
											{foreach from=$alteDatorii item=i}
												<tr class="isSubChildRow hide">
													<td style="text-align:center;"></td>
													<td style="text-align:left;padding-left:60px;">{$TXT[$i]}</td>
													<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
													<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
													<td></td>
												</tr>
											{/foreach}
											
											<!-- end datorii pe termen scurt-->
											<tr>
												<td style="width: 10px; text-align:center;"></td>
												<td style="text-align:left;">{$TXT['DATORII_PE_TERMEN_MEDIU_SI_LUNG']}</td>
												<td><span class="money">{$valoriRaportLunar['DATORII_PE_TERMEN_MEDIU_SI_LUNG']->value()}</span></td>
												<td>{$valoriRaportLunar['DATORII_PE_TERMEN_MEDIU_SI_LUNG']->valuePercent()}%</td>
												<td></td>
											</tr>	
											<!-- venituri in avans -->
											<tr>
												<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['VENITURI_IN_AVANS']}</td>
												<td><span class="money">{$valoriRaportLunar['VENITURI_IN_AVANS']->value()}</span></td>
												<td>{$valoriRaportLunar['VENITURI_IN_AVANS']->valuePercent()}%</td>
												<td></td>
											</tr>
											{$venituriAvans =['SUBVENTII_PENTRU_INVESTITII',
															'VENITURI_INREGISTRATE_IN_AVANS',
															'FOND_COMERCIAL_NEGATIV']}
											
											{foreach from=$venituriAvans item=i}
												<tr>
													<td style="width: 10px; text-align:center;"></td>
													<td style="text-align:left;">{$TXT[$i]}</td>
													<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
													<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
													<td></td>
												</tr>
											{/foreach}
											<!-- END venituri in avans -->
											<!-- provizioane -->
											<tr>
												<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['PROVIZIOANE']}</td>
												<td><span class="money">{$valoriRaportLunar['PROVIZIOANE']->value()}</span></td>
												<td>{$valoriRaportLunar['PROVIZIOANE']->valuePercent()}%</td>
												<td></td>
											</tr>
											<!-- end provizioane-->
											<!-- capitaluri proprii -->
											<tr>
												<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['CAPITALURI_PROPRII']}</td>
												<td><span class="money">{$valoriRaportLunar['CAPITALURI_PROPRII']->value()}</span></td>
												<td>{$valoriRaportLunar['CAPITALURI_PROPRII']->valuePercent()}%</td>
												<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_capitaluriproprii">Afiseaza grafic</button></td>
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
													<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
													<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
													<td></td>
												</tr>
											{/foreach}
											<!-- END capitaluri proprii -->
											<tr>
												<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['TOTAL_PASIV']}</td>
												<td><span class="money">{$valoriRaportLunar['TOTAL_PASIV']->value()}</span></td>
												<td>{$valoriRaportLunar['TOTAL_PASIV']->valuePercent()}%</td>
												<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_totalpasiv">Afiseaza grafic</button></td>
											</tr>
									</table>
									
								</div>
							</div>