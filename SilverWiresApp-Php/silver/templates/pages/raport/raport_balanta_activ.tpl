<div class="portlet light">
						<div class="portlet-title">
							<div class="caption">
								<i class="icon-shuffle font-blue-steel"></i>
								<span class="caption-subject font-blue-steel bold uppercase">Activul patrimonial</span>
								
							</div>
							
						</div>
						<div class="portlet-body">
							<div class="col-md-1">&nbsp;</div>
							<div class="col-md-5 donut-holder">
								<div id="graph_active"></div>
								<div class="donut-label-wrapper" id="donutLabelActive">
									<div class="donut-label-perioada">
									{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
									</div>
									<div class="donut-label-text">
									{$TXT['TOTAL_ACTIV']}
									</div>
									<div class="donut-label-value">
									{$TXT['TOTAL_ACTIV']}<small>{$LABEL['currency']}</small>
									</div>
								</div>								
							</div>
							<div class="col-md-4">
								<div id="active_details" class="donut_details_text">									
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
									<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['ACTIVE_CIRCULANTE']}</td>
									<td><span class="money">{$valoriRaportLunar['ACTIVE_CIRCULANTE']->value()}</span></td>
									<td >{$valoriRaportLunar['ACTIVE_CIRCULANTE']->valuePercent()}%</td>
									<td></td>
								</tr>
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['DISPONIBIL_IN_CASERIE_SI_BANCA']}</td>
									<td><span class="money">{$valoriRaportLunar['DISPONIBIL_IN_CASERIE_SI_BANCA']->value()}</span></td>
									<td>{$valoriRaportLunar['DISPONIBIL_IN_CASERIE_SI_BANCA']->valuePercent()}%</td>
									<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_caserie">Afiseaza grafic</button></td>
								</tr>
								{$disponibilCaserie =['CONTURI_LA_BANCI',
												'CASA',
												'ACREDITIVE_ALTE_VALORI_VIRAMENTE_INTERNE',
												'AVANSURI_DE_TREZORERIE']}
								
								{foreach from=$disponibilCaserie item=i}
									<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
										<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
										<td></td>
									</tr>
								{/foreach}
								<!-- investitii termen scurt -->
								<tr>
									<td style="width: 10px; text-align:center;"></td>
									<td style="text-align:left;">{$TXT['INVESTITII_PE_TERMEN_SCURT']}</td>
									<td><span class="money">{$valoriRaportLunar['INVESTITII_PE_TERMEN_SCURT']->value()}</span></td>
									<td>{$valoriRaportLunar['INVESTITII_PE_TERMEN_SCURT']->valuePercent()}%</td>
									<td></td>
								</tr>				
								<!-- end investitii termen scurt -->
								<!-- Creante -->
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['CREANTE']}</td>
									<td><span class="money">{$valoriRaportLunar['CREANTE']->value()}</span></td>
									<td>{$valoriRaportLunar['CREANTE']->valuePercent()}%</td>
									<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_creante">Afiseaza grafic</button></td>
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
										<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
										<td></td>
									</tr>
								{/foreach}
								<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['ALTE_CREANTE']}</td>
										<td><span class="money">{$valoriRaportLunar['ALTE_CREANTE']->value()}</span></td>
										<td>{$valoriRaportLunar['ALTE_CREANTE']->valuePercent()}%</td>
										<td></td>
								</tr>
								{$alteCreante =['DEBITORI_DIVERSI',
												'OPERATIUNI_IN_CURS_DE_CLARIFICARE_ACTIV',
												'DECONTARI_IN_CADRUL_UNITATII_ACTIV',
												'DOBANZI_DE_PRIMIT']}
								{foreach from=$alteCreante item=i}
									
									<tr class="isSubChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:60px;">{$TXT[$i]}</td>
										<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
										<td></td>
									</tr>
								{/foreach}
								
								
								<tr class="isChildRow hide">
									<td style="text-align:center;"></td>
									<td style="text-align:left;padding-left:30px;">{$TXT['AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR']}</td>
									<td><span class="money">{$valoriRaportLunar['AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR']->value()}</span></td>
									<td>{$valoriRaportLunar['AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR']->valuePercent()}%</td>
									<td></td>
								</tr>
								<!-- END creante -->
								<!-- Stocuri -->
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['STOCURI']}</td>
									<td><span class="money">{$valoriRaportLunar['STOCURI']->value()}</span></td>
									<td>{$valoriRaportLunar['STOCURI']->valuePercent()}%</td>
									<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_stocuri">Afiseaza grafic</button></td>
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
										<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
										<td></td>
									</tr>
								{/foreach}
								<!-- END stocuri -->
								<tr>
									<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['CHELTUIELI_IN_AVANS']}</td>
									<td><span class="money">{$valoriRaportLunar['CHELTUIELI_IN_AVANS']->value()}</span></td>
									<td>{$valoriRaportLunar['CHELTUIELI_IN_AVANS']->valuePercent()}%</td>
									<td></td>
								</tr>
								<tr>
									<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['ACTIVE_IMOBILIZATE']}</td>
									<td><span class="money">{$valoriRaportLunar['ACTIVE_IMOBILIZATE']->value()}</span></td>
									<td>{$valoriRaportLunar['ACTIVE_IMOBILIZATE']->valuePercent()}%</td>
									<td></td>
								</tr>
								<!-- Imobilizari necorporale  -->
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['IMOBILIZARI_NECORPORALE']}</td>
									<td><span class="money">{$valoriRaportLunar['IMOBILIZARI_NECORPORALE']->value()}</span></td>
									<td>{$valoriRaportLunar['IMOBILIZARI_NECORPORALE']->valuePercent()}%</td>
									<td></td>
								</tr>
								{$imobilizariNecorporale =['IMOBILIZARI_NECOROPRALE_VALOARE_DE_INTRARE',
															'AMORTIZARE_SI_AJUSTARI_IMOBILIZARI_NECORPORALE']}
								{foreach from=$imobilizariNecorporale item=i}
									<tr class="isChildRow hide">
										<td style="text-align:center;"></td>
										<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
										<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
										<td></td>
									</tr>
								{/foreach}
								<!-- END Imobilizari necorporale  -->
								<!-- Imobilizari corporale  -->
								<tr>
									<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
									<td style="text-align:left;">{$TXT['IMOBILIZARI_CORPORALE']}</td>
									<td><span class="money">{$valoriRaportLunar['IMOBILIZARI_CORPORALE']->value()}</span></td>
									<td>{$valoriRaportLunar['IMOBILIZARI_CORPORALE']->valuePercent()}%</td>
									<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_imobilizaricorporale">Afiseaza grafic</button></td>
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
										<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
										<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
										<td></td>
									</tr>
								{/foreach}
								<!-- END Imobilizari corporale  -->
								<!-- Imobilizari financiare  -->
								<tr>
									<td style="width: 10px; text-align:center;" ></td>
									<td style="text-align:left;">{$TXT['IMOBILIZARI_FINANCIARE']}</td>
									<td><span class="money">{$valoriRaportLunar['IMOBILIZARI_FINANCIARE']->value()}</span></td>
									<td>{$valoriRaportLunar['IMOBILIZARI_FINANCIARE']->valuePercent()}%</td>
									<td></td>
								</tr>
								<!-- END Imobilizari necorporale  -->
								<tr>
									<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['TOTAL_ACTIV']}</td>
									<td><span class="money">{$valoriRaportLunar['TOTAL_ACTIV']->value()}</span></td>
									<td>{$valoriRaportLunar['TOTAL_ACTIV']->valuePercent()}%</td>
									<td><button type="button" href="#" class="btn default btn-xs red" id="graph_show_totalactiv">Afiseaza grafic</button></td>
								</tr>
								
								</tbody>
							</table>
							
		</div>
	</div>