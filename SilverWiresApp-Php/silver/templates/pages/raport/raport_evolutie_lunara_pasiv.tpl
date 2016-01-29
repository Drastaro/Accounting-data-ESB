<div class="portlet light">
	<div class="portlet-title">
		<div class="caption">
			<i class="icon-share font-blue-steel"></i>
			<span class="caption-subject font-blue-steel bold uppercase">Pasivul patrimonial</span>
			
		</div>
	</div>
	<div class="portlet-body">
		<div id="evolutie_graph_pasive"></div>
		<div id="pasive_choices"><br/><strong>Filtrare grafic:</strong></div>
		<div style="width:100%;overflow-x:auto;">
		<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_activ" >
				<thead>
				<tr >
					<th colspan=2 width=40%>
					</th>
					{foreach from=$balanteSelectate item=balanta}
						<th colspan=2 style="text-align:center">
							 {$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}
						</th>
					{/foreach}
				</tr>
				</thead>
				<tbody> 
				<tr>
					<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['TOTAL_DATORII']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['TOTAL_DATORII']->value()}</span></td>
					<td>{$rap['TOTAL_DATORII']->valuePercent()}%</td>
					{/foreach}
				</tr>
				<!-- end datorii pe termen scurt-->
				<tr>
					<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
					<td style="text-align:left;">{$TXT['DATORII_PE_TERMEN_SCURT']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['DATORII_PE_TERMEN_SCURT']->value()}</span></td>
					<td>{$rap['DATORII_PE_TERMEN_SCURT']->valuePercent()}%</td>
					{/foreach}
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
						{foreach from=$rapoarteBalante item=rap}
						<td><span class="money">{$rap[$i]->value()}</span></td>
						<td>{$rap[$i]->valuePercent()}%</td>
						{/foreach}
					</tr>
				{/foreach}
				<tr class="isChildRow hide">
						<td style="text-align:center;"></td>
						<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['ALTE_DATORII']}</td>
						{foreach from=$rapoarteBalante item=rap}
						<td><span class="money">{$rap['ALTE_DATORII']->value()}</span></td>
						<td>{$rap['ALTE_DATORII']->valuePercent()}%</td>
						{/foreach}
				</tr>
				{$alteDatorii =['CREDITORI_DIVERSI',
								'OPERATIUNI_IN_CURS_DE_CLARIFICARE_PASIV',
								'DECONTARI_IN_CADRUL_UNITATII_PASIV',										
								'VARSAM_DE_EFECTUAT_PENTRU_INVESTITIILE_PE_T_S']}
				{foreach from=$alteDatorii item=i}
					<tr class="isSubChildRow hide">
						<td style="text-align:center;"></td>
						<td style="text-align:left;padding-left:60px;">{$TXT[$i]}</td>
						{foreach from=$rapoarteBalante item=rap}
						<td><span class="money">{$rap[$i]->value()}</span></td>
						<td>{$rap[$i]->valuePercent()}%</td>
						{/foreach}
					</tr>
				{/foreach}
				
				<!-- end datorii pe termen scurt-->
				<tr>
					<td style="width: 10px; text-align:center;"></td>
					<td style="text-align:left;">{$TXT['DATORII_PE_TERMEN_MEDIU_SI_LUNG']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['DATORII_PE_TERMEN_MEDIU_SI_LUNG']->value()}</span></td>
					<td>{$rap['DATORII_PE_TERMEN_MEDIU_SI_LUNG']->valuePercent()}%</td>
					{/foreach}
				</tr>	
				<!-- venituri in avans -->
				<tr>
					<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['VENITURI_IN_AVANS']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['VENITURI_IN_AVANS']->value()}</span></td>
					<td>{$rap['VENITURI_IN_AVANS']->valuePercent()}%</td>
					{/foreach}
				</tr>
				{$venituriAvans =['SUBVENTII_PENTRU_INVESTITII',
								'VENITURI_INREGISTRATE_IN_AVANS',
								'FOND_COMERCIAL_NEGATIV']}
				
				{foreach from=$venituriAvans item=i}
					<tr>
						<td style="width: 10px; text-align:center;"></td>
						<td style="text-align:left;">{$TXT[$i]}</td>
						{foreach from=$rapoarteBalante item=rap}
						<td><span class="money">{$rap[$i]->value()}</span></td>
						<td>{$rap[$i]->valuePercent()}%</td>
						{/foreach}
					</tr>
				{/foreach}
				<!-- END venituri in avans -->
				<!-- provizioane -->
				<tr>
					<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['PROVIZIOANE']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['PROVIZIOANE']->value()}</span></td>
					<td>{$rap['PROVIZIOANE']->valuePercent()}%</td>
					{/foreach}
				</tr>
				<!-- end provizioane-->
				<!-- capitaluri proprii -->
				<tr>
					<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['CAPITALURI_PROPRII']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['CAPITALURI_PROPRII']->value()}</span></td>
					<td>{$rap['CAPITALURI_PROPRII']->valuePercent()}%</td>
					{/foreach}
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
						{foreach from=$rapoarteBalante item=rap}
						<td><span class="money">{$rap[$i]->value()}</span></td>
						<td>{$rap[$i]->valuePercent()}%</td>
						{/foreach}
					</tr>
				{/foreach}
				<!-- END capitaluri proprii -->
				<tr>
					<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['TOTAL_PASIV']}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['TOTAL_PASIV']->value()}</span></td>
					<td>{$rap['TOTAL_PASIV']->valuePercent()}%</td>
					{/foreach}
				</tr>
		</table>	
		</div>	
		</div>
</div>