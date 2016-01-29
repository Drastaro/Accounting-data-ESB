<div class="portlet light">
	<div class="portlet-title">
		<div class="caption">
			<i class="icon-speedometer font-blue-steel"></i>
			<span class="caption-subject font-blue-steel bold uppercase">Analiza rezultatelor - profit/pierdere</span>
			
		</div>
		<div class="actions">
			<span class="font-grey-salsa">Date grafic:&nbsp;&nbsp;&nbsp;</span>
			<div class="btn-group btn-group-devided" data-toggle="buttons">
				<label class="btn btn-transparent grey-salsa btn-sm active" id="rezultate_option_luna">
				<input type="radio" name="options" class="toggle" >{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</label>
				<label class="btn btn-transparent grey-salsa btn-sm"  id="rezultate_option_cumulat">
				<input type="radio" name="options" class="toggle">Cumulat Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</label>						
			</div>
		</div>
	</div>
	<div class="portlet-body">
		<div class="col-md-5 donut-holder">
			<div id="rezultate_graph"></div>
			<div class="donut-label-wrapper" id="donutLabelRezultate">
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
				<div id="rezultate_details2">									
				</div>	
				<br/><br/>
				<div id="rezultate_details">
				</div>
			</div>
			<div class="col-md-3">
				
			</div>									
		<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_rezultate" >
			<thead>
			<tr >
				<th colspan=2 width=40%>
					 
				</th>
				<th colspan=2 style="text-align:center" width=30%>
					 {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
				</th>
				<th colspan=2 style="text-align:center">
					 Ianuarie - {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
				</th>
			</tr>
			</thead>										
			<tr>
				<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['VENITURI_TOTALE']}</td>
				<td><span class="money">{$valoriRaportLunar['VENITURI_TOTALE']->value()}</span></td>
				<td>{$valoriRaportLunar['VENITURI_TOTALE']->valuePercent()}%</td>
				<td><span class="money">{$valoriRaportLunar['VENITURI_TOTALE']->valueCumulated()}</span></td>
				<td>{$valoriRaportLunar['VENITURI_TOTALE']->valueCumulatedPercent()}%</td>
			</tr>
			{$rezVenituri =['CIFRA_DE_AFACERI',
							'ALTE_VENITURI_DIN_EXPLOATARE', 
							'VENITURI_FINANCIARE', 
							'VENITURI_EXTRAORDINARE']}
			{foreach from=$rezVenituri item=i}
				<tr>
					<td style="text-align:center;"></td>
					<td style="text-align:left;">{$TXT[$i]}</td>
					<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
					<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
					<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
					<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
				</tr>
			{/foreach}										
			<tr>
				<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['CHELTUIELI_TOTALE']}</span></td>
				<td><span class="money">{$valoriRaportLunar['CHELTUIELI_TOTALE']->value()}</td>
				<td>{$valoriRaportLunar['CHELTUIELI_TOTALE']->valuePercent()}%</td>
				<td><span class="money">{$valoriRaportLunar['CHELTUIELI_TOTALE']->valueCumulated()}</span></td>
				<td>{$valoriRaportLunar['CHELTUIELI_TOTALE']->valueCumulatedPercent()}%</td>
			</tr>
			
			<tr>
				<td style="width:10px;text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
				<td style="text-align:left;">{$TXT['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']}</td>
				<td><span class="money">{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->value()}</span></td>
				<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valuePercent()}%</td>
				<td><span class="money">{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valueCumulated()}</span></td>
				<td>{$valoriRaportLunar['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI']->valueCumulatedPercent()}%</td>
		</tr>
		
		{$rezCheltuieliCifraAfaceri =['CHELTUIELI_MATERIALE', 'CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI','CHELTUIELI_DE_PERSONAL',
						'SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE']}
		{foreach from=$rezCheltuieliCifraAfaceri item=i}
			<tr class="isChildRow hide">
				<td style="text-align:center;"></td>
				<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
				<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
				<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
				<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
				<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
			</tr>
		{/foreach}
		<!--END Cheltuieli pentru realizarea cifrei de afaceri-->
		{$rezCheltuieli =['ALTE_CHELTUIELI_DE_EXPLOATARE', 'CHELTUIELI_FINANCIARE','CHELTUIELI_EXTRAORDINARE',
						'IMPOZIT_PE_PROFIT']}
		{foreach from=$rezCheltuieli item=i}
			<tr>
				<td style="text-align:center;"></td>
				<td style="text-align:left;">{$TXT[$i]}</td>
				<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
				<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
				<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
				<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
			</tr>
		{/foreach}
		{$rezFinal =['EBITDA', 'EBIT','PROFIT_NET']}
		{foreach from=$rezFinal item=i}
			<tr>
				<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT[$i]}</td>
				<td><span class="money">{$valoriRaportLunar[$i]->value()}</span></td>
				<td>{$valoriRaportLunar[$i]->valuePercent()}%</td>
				<td><span class="money">{$valoriRaportLunar[$i]->valueCumulated()}</span></td>
				<td>{$valoriRaportLunar[$i]->valueCumulatedPercent()}%</td>
			</tr>
		{/foreach}
		</table>				
	</div>
</div>