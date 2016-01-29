<div class="portlet light">
	<div class="portlet-title">
		<div class="caption">
			<i class="icon-speedometer font-blue-steel"></i>
			<span class="caption-subject font-blue-steel bold uppercase">Analiza rezultatelor - profit/pierdere</span>
		</div>
	</div>
	<div class="portlet-body">
		<div id="evolutie_graph_rezultate"></div>
		<div id="rezultate_choices"><br/><strong>Filtrare grafic:</strong></div>
		<div style="width:100%;overflow-x:auto;">
		<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_rezultate" >
			<thead>
			<tr >
				<th colspan=2 width=40%>
					 
				</th>
				{foreach from=$balanteSelectate item=balanta}
				<th colspan=2 style="text-align:center">
					 {if $balanta->luna>1} Ianuarie - {/if}{$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}
				</th>
				{/foreach}						
			</tr>
			</thead>
			<tr>
				<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['VENITURI_TOTALE']}</td>
				{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['VENITURI_TOTALE']->valueCumulated()}</span></td>
					<td>{$rap['VENITURI_TOTALE']->valueCumulatedPercent()}%</td>
				{/foreach}
			</tr>
			{$rezVenituri =['CIFRA_DE_AFACERI',
							'ALTE_VENITURI_DIN_EXPLOATARE', 
							'VENITURI_FINANCIARE', 
							'VENITURI_EXTRAORDINARE']}
			{foreach from=$rezVenituri item=i}
				<tr>
					<td style="text-align:center;"></td>
					<td style="text-align:left;">{$TXT[$i]}</td>
					{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap[$i]->valueCumulated()}</span></td>
					<td>{$rap[$i]->valueCumulatedPercent()}%</td>
					{/foreach}
				</tr>
			{/foreach}										
			<tr>
				<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['CHELTUIELI_TOTALE']}</td>
				{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['CHELTUIELI_TOTALE']->valueCumulated()}</span></td>
					<td>{$rap['CHELTUIELI_TOTALE']->valueCumulatedPercent()}%</td>
				{/foreach}
			</tr>
			
			<tr>
				<td style="width:10px;text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
				<td style="text-align:left;">{$TXT['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']}</td>
				{foreach from=$rapoarteBalante item=rap}
					<td><span class="money">{$rap['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valueCumulated()}</span></td>
					<td>{$rap['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valueCumulatedPercent()}%</td>
				{/foreach}
		</tr>
		
		{$rezCheltuieliCifraAfaceri =['CHELTUIELI_MATERIALE', 'CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI','CHELTUIELI_DE_PERSONAL',
						'SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE']}
		{foreach from=$rezCheltuieliCifraAfaceri item=i}
			<tr class="isChildRow hide">
				<td style="text-align:center;"></td>
				<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap[$i]->valueCumulated()}</span></td>
				<td>{$rap[$i]->valueCumulatedPercent()}%</td>
				{/foreach}
			</tr>
		{/foreach}
		{$rezCheltuieli =['ALTE_CHELTUIELI_DE_EXPLOATARE', 'CHELTUIELI_FINANCIARE','CHELTUIELI_EXTRAORDINARE',
						'IMPOZIT_PE_PROFIT']}
		{foreach from=$rezCheltuieli item=i}
			<tr>
				<td style="text-align:center;"></td>
				<td style="text-align:left;">{$TXT[$i]}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap[$i]->valueCumulated()}</span></td>
				<td>{$rap[$i]->valueCumulatedPercent()}%</td>
				{/foreach}
			</tr>
		{/foreach}
		{$rezFinal =['EBITDA', 'EBIT','PROFIT_NET']}
		{foreach from=$rezFinal item=i}
			<tr>
				<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT[$i]}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap[$i]->valueCumulated()}</span></td>
				<td>{$rap[$i]->valueCumulatedPercent()}%</td>
				{/foreach}
			</tr>
		{/foreach}
			
			
			
		</table>
		</div>
	</div>
</div>