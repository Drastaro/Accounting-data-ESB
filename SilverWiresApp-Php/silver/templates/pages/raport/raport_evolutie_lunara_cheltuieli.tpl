<div class="portlet light">
<div class="portlet-title">
	<div class="caption">
		<i class="icon-logout font-blue-steel"></i>
		<span class="caption-subject font-blue-steel bold uppercase">Analiza cheltuielilor</span>
		
	</div>
	
</div>
<div class="portlet-body">
	<div id="evolutie_graph_cheltuieli"></div>
	<div id="cheltuieli_choices"><br/><strong>Filtrare grafic:</strong></div>
	<div style="width:100%;overflow-x:auto;">
	<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_cheltuieli" >
		<thead>
		<tr >
			<th>
			</th>
			<th width=40%>
			</th>
			{foreach from=$balanteSelectate item=balanta}
				<th colspan=2 style="text-align:center">
					 {$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}
				</th>
			{/foreach}
		</tr>
		</thead>
		<tbody>
			<!-- Cheltuieli pentru realizarea cifrei de afaceri-->
			<tr>
				<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
				<td style="text-align:left;">{$TXT['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->value()}</span></td>
				<td>{$rap['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valuePercent()}%</td>
				{/foreach}
			</tr>
			<tr class="isChildRow hide">
					<td style="text-align:center;"></td>
					<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['CHELTUIELI_MATERIALE']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['CHELTUIELI_MATERIALE']->value()}</span></td>
					<td>{$rap['CHELTUIELI_MATERIALE']->valuePercent()}%</td>
					{/foreach}
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
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap[$i]->value()}</span></td>
					<td>{$rap[$i]->valuePercent()}%</td>
					{/foreach}
				</tr>
			{/foreach}
			
			<tr class="isChildRow hide">
					<td style="text-align:center;"></td>
					<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->value()}</span></td>
					<td>{$rap['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']->valuePercent()}%</td>
					{/foreach}
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
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap[$i]->value()}</span></td>
					<td>{$rap[$i]->valuePercent()}%</td>
					{/foreach}
				</tr>
			{/foreach}
			
			
			{$chetuieliCifraAfaceri =['CHELTUIELI_DE_PERSONAL',
							'SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE']}
			{foreach from=$chetuieliCifraAfaceri item=i}
				<tr class="isChildRow hide">
					<td style="text-align:center;"></td>
					<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap[$i]->value()}</span></td>
					<td>{$rap[$i]->valuePercent()}%</td>
					{/foreach}
				</tr>
			{/foreach}
			<!--END Cheltuieli pentru realizarea cifrei de afaceri-->
			<!-- ALTE cheltuieli de exploatare -->
				<tr>
					<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
					<td style="text-align:left;">{$TXT['ALTE_CHELTUIELI_DE_EXPLOATARE']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['ALTE_CHELTUIELI_DE_EXPLOATARE']->value()}</span></td>
					<td>{$rap['ALTE_CHELTUIELI_DE_EXPLOATARE']->valuePercent()}%</td>
					{/foreach}
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
						{foreach from=$rapoarteBalante item=rap}
						<td><span class="money">{$rap[$i]->value()}</span></td>
						<td>{$rap[$i]->valuePercent()}%</td>
						{/foreach}
					</tr>
				{/foreach}
				<tr>
					<td style="text-align:center;"></td>
					<td style="text-align:left;">{$TXT['TOTAL_CHELTUIELI_DE_EXPLOATARE']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['TOTAL_CHELTUIELI_DE_EXPLOATARE']->value()}</span></td>
					<td>{$rap['TOTAL_CHELTUIELI_DE_EXPLOATARE']->valuePercent()}%</td>
					{/foreach}
				</tr>
			<!-- END ALTE cheltuieli de exploatare -->
			<!-- Cheltuieli Financiare -->
				<tr>
					<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
					<td style="text-align:left;">{$TXT['CHELTUIELI_FINANCIARE']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['CHELTUIELI_FINANCIARE']->value()}</span></td>
					<td>{$rap['CHELTUIELI_FINANCIARE']->valuePercent()}%</td>
					{/foreach}
				</tr>
				{$cheltuieliFinanciare =['CHELTUIELI_PRIVIND_DOBANZILE',
								'CHELTUIELI_DIN_DIFERENTE_DE_CURS_VALUTAR',
								'CHELTUIELI_PRIVIND_SCONTURILE_ACORDATE',
								'ALTE_CHELTUIELI_FINANCIARE']}
				
				
				{foreach from=$cheltuieliFinanciare item=i}
					<tr class="isChildRow hide">
						<td style="text-align:center;"></td>
						<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
						{foreach from=$rapoarteBalante item=rap}
						<td><span class="money">{$rap[$i]->value()}</span></td>
						<td>{$rap[$i]->valuePercent()}%</td>
						{/foreach}
					</tr>
				{/foreach}									
			<!-- END Cheltuieli financiare-->
				<tr>
					<td style="text-align:center;"></td>
					<td style="text-align:left;">{$TXT['CHELTUIELI_EXTRAORDINARE']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['CHELTUIELI_EXTRAORDINARE']->value()}</span></td>
					<td>{$rap['CHELTUIELI_EXTRAORDINARE']->valuePercent()}%</td>
					{/foreach}
				</tr>
				<tr>
					<td style="text-align:center;"></td>
					<td style="text-align:left;">{$TXT['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->value()}</span></td>
					<td>{$rap['CHELTUIELI_TOTALE_INAINTE_IMPOZITARE']->valuePercent()}%</td>
					{/foreach}
				</tr>
				<tr>
					<td style="text-align:center;"></td>
					<td style="text-align:left;">{$TXT['IMPOZIT_PE_PROFIT']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['IMPOZIT_PE_PROFIT']->value()}</span></td>
					<td>{$rap['IMPOZIT_PE_PROFIT']->valuePercent()}%</td>
					{/foreach}
				</tr>
				<tr>
					<td style="text-align:center;"></td>
					<td style="text-align:left;">{$TXT['CHELTUIELI_TOTALE']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['CHELTUIELI_TOTALE']->value()}</span></td>
					<td>{$rap['CHELTUIELI_TOTALE']->valuePercent()}%</td>
					{/foreach}
				</tr>
			</tbody>
		</table>
		</div>
	</div>
</div>