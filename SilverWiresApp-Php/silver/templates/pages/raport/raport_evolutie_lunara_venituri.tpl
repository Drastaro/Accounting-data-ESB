<div class="portlet light">
	<div class="portlet-title">
		<div class="caption">
			<i class="icon-login font-blue-steel"></i>
			<span class="caption-subject font-blue-steel bold uppercase">Analiza veniturilor</span>
		</div>
	</div>
	<div class="portlet-body">
		<div id="evolutie_graph_venituri"></div>
		<div id="venituri_choices"><br/><strong>Filtrare grafic:</strong></div>
		<div style="width:100%;overflow-x:auto;">
		<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_venituri" >
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
			<tr>
				<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
				<td style="text-align:left;">{$TXT['CIFRA_DE_AFACERI']}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap['CIFRA_DE_AFACERI']->value()}</span></td>
				<td>{$rap['CIFRA_DE_AFACERI']->valuePercent()}%</td>
				{/foreach}
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
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap[$i]->value()}</span></td>
					<td>{$rap[$i]->valuePercent()}%</td>
					{/foreach}
				</tr>
			{/foreach}
			<!-- alte venituri -->
			<tr>
				<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
				<td style="text-align:left;">{$TXT['ALTE_VENITURI_DIN_EXPLOATARE']}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap['ALTE_VENITURI_DIN_EXPLOATARE']->value()}</span></td>
				<td>{$rap['ALTE_VENITURI_DIN_EXPLOATARE']->valuePercent()}%</td>
				{/foreach}
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
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap[$i]->value()}</span></td>
					<td>{$rap[$i]->valuePercent()}%</td>
					{/foreach}
				</tr>
			{/foreach}								
			<!-- end alte venituri -->
			<tr>
				<td style="text-align:center;"></td>
				<td style="text-align:left;">{$TXT['TOTAL_VENITURI_DIN_EXPLOATARE']}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap['TOTAL_VENITURI_DIN_EXPLOATARE']->value()}</span></td>
				<td>{$rap['TOTAL_VENITURI_DIN_EXPLOATARE']->valuePercent()}%</td>
				{/foreach}
			</tr>
			<tr>
				<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
				<td style="text-align:left;">{$TXT['VENITURI_FINANCIARE']}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap['VENITURI_FINANCIARE']->value()}</span></td>
				<td>{$rap['VENITURI_FINANCIARE']->valuePercent()}%</td>
				{/foreach}
			</tr>
			{$venituriFinanciare =['VENITURI_DIN_DOBANZI',
							'VENITURI_DIN_DIFERENTE_DE_CURS_VALUTAR',
							'VENITURI_DIN_SCONTURI_OBTINUTE',
							'ALTE_VENITURI_FINANCIARE']}
			
			
			{foreach from=$venituriFinanciare item=i}
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
				<td style="text-align:left;">{$TXT['VENITURI_EXTRAORDINARE']}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap['VENITURI_EXTRAORDINARE']->value()}</span></td>
				<td>{$rap['VENITURI_EXTRAORDINARE']->valuePercent()}%</td>
				{/foreach}
			</tr>
			<tr>
				<td style="text-align:center;"></td>
				<td style="text-align:left;">{$TXT['VENITURI_TOTALE']}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap['VENITURI_TOTALE']->value()}</span></td>
				<td>{$rap['VENITURI_TOTALE']->valuePercent()}%</td>
				{/foreach}
			</tr>
			</tbody>
		</table>
	</div>		
	</div>
</div>