<div class="portlet light">
	<div class="portlet-title">
		<div class="caption">
			<i class="icon-speedometer font-blue-steel"></i>
			<span class="caption-subject font-blue-madison bold uppercase">Rezultate financiare {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}</span>
			
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
		<div class="row">
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
		</div>		
	</div>
</div>