<div class="row">
	<div class="col-md-12">
		<div class="portlet light">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-shuffle font-blue-steel"></i>
					<span class="caption-subject font-blue-steel bold uppercase">Indicatori financiari: Profitabilitate</span>
					
				</div>
				
			</div>
			<div class="portlet-body">
				<div style="width:100%;overflow-x:auto;">
				<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_activ" >
					<thead>
					<tr >
						<th width=40%>
						</th>
						{foreach from=$balanteSelectate item=balanta}
							<th style="text-align:center">
								 {$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}
							</th>
						{/foreach}
					</tr>
					</thead>
					<tbody> 
					
					{$kpiProfitabilitate =['RATA_PROFITULUI_NET',
							'RATA_PROFITULUI_DIN_EXPLOATARE',
							'RATA_PROFITABILITATII_TOTALE',
							'MARJA_EBITDA']}
			
					{foreach from=$kpiProfitabilitate item=i}									
						<tr>
							<td style="text-align:left;">{$TXT[$i]}</td>
							{foreach from=$rapoarteBalante item=kpi}
							<td>{$kpi[$i]->value()}%</td>									
							{/foreach}									
						</tr>
					{/foreach}								
					</tbody>
				</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<div class="portlet light">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-shuffle font-blue-steel"></i>
					<span class="caption-subject font-blue-steel bold uppercase">Indicatori financiari: Lichiditate</span>
					
				</div>
				
			</div>
			<div class="portlet-body">
				<div style="width:100%;overflow-x:auto;">
				<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_activ" >
					<thead>
					<tr>
						<th width=40%>
						</th>
						{foreach from=$balanteSelectate item=balanta}
							<th style="text-align:center">
								 {$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}
							</th>
						{/foreach}
					</tr>
					</thead>
					<tbody> 
					{$kpiLichiditate =['LICHIDITATEA_GENERALA',
							'LICHIDITATEA_IMEDIATA']}
			
					{foreach from=$kpiLichiditate item=i}									
						<tr>
							<td style="text-align:left;">{$TXT[$i]}</td>
							{foreach from=$rapoarteBalante item=kpi}
							<td>{$kpi[$i]->value()}%</td>									
							{/foreach}									
						</tr>
					{/foreach}
					</tbody>
				</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<div class="portlet light">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-shuffle font-blue-steel"></i>
					<span class="caption-subject font-blue-steel bold uppercase">Indicatori de rotatie</span>
				</div>
			</div>
			<div class="portlet-body">
				<div style="width:100%;overflow-x:auto;">
				<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_activ" >
					<thead>
					<tr>
						<th width=40%>
						</th>
						{foreach from=$balanteSelectate item=balanta}
							<th style="text-align:center">
								 {$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}
							</th>
						{/foreach}
					</tr>
					</thead>
					<tbody> 
					{$kpiRotatie =['PERIOADA_DE_STOCARE','PERIOADA_INCASARE_CREANTE_CLIENTI','PERIOADA_PLATA_FURNIZORILOR']}
					{foreach from=$kpiRotatie item=i}									
						<tr>
							<td style="text-align:left;">{$TXT[$i]}</td>
							{foreach from=$rapoarteBalante item=kpi}
							<td>{$kpi[$i]->valueCumulated()} {$LABEL['days']}</td>									
							{/foreach}									
						</tr>
					{/foreach}
					</tbody>
				</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<div class="portlet light">
			<div class="portlet-title">
				<div class="caption">
					<i class="icon-shuffle font-blue-steel"></i>
					<span class="caption-subject font-blue-steel bold uppercase">Indicatori financiari: Structura capitalului</span>
					
				</div>
			</div>
			<div class="portlet-body">
				<div style="width:100%;overflow-x:auto;">
				<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_activ" >
					<thead>
					<tr >
						<th width=40%>
						</th>
						{foreach from=$balanteSelectate item=balanta}
							<th style="text-align:center">
								 {$lunileAnului[$balanta->luna]}&nbsp;{$balanta->an}
							</th>
						{/foreach}
					</tr>
					</thead>
					<tbody> 
					{$kpiStructuraCapital =['GRAD_DE_INDATORARE_TOTAL',
							'GRAD_DE_INDATORARE_LA_TERMEN',
							'GRAD_DE_INDATORARE_PE_TERMEN_SCURT',
							'SOLVABILITATE']}
			
					{foreach from=$kpiStructuraCapital item=i}									
						<tr>
							<td style="text-align:left;">{$TXT[$i]}</td>
							{foreach from=$rapoarteBalante item=kpi}
							<td>{$kpi[$i]->value()}%</td>									
							{/foreach}									
						</tr>
					{/foreach}
					</tbody>
				</table>
				</div>
			</div>
		</div>
	</div>
</div>
