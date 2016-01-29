<!-- Content Header (Page header) -->
<div class="page-head">
		<!-- BEGIN PAGE TITLE -->
		<div class="page-title">
			<h1>{$companie->name} <small>Analiza financiara comparativa</small></h1>						
		</div>
		<!-- END PAGE TITLE -->
		<!-- BEGIN PAGE TOOLBAR -->
		<div class="page-toolbar">
			<div class="btn-group pull-right">
				<button type="button" class="btn btn-fit-height grey-salt dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000" data-close-others="true" aria-expanded="false">
				Actiuni <i class="fa fa-angle-down"></i>
				</button>
				<ul class="dropdown-menu pull-right" role="menu">
					<li>
						<a href="{'/'|url}balante_add?cid={$companie->id}">Adauga balanta</a>
					</li>
					<li>
						<a href="{'/'|url}companii_detalii?cid={$companie->id}">Editeaza companie</a>
					</li>										
					<li class="divider">
					</li>
					<li>
						<a href="#">Sterge companie</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- END PAGE TOOLBAR -->
</div>

<!-- BEGIN PAGE CONTENT-->
<div class="row">
	<div class="col-md-12">
		<div class="portlet box">
			<div class="portlet-body">
				<p>Aici ar trebui afisate datele agregate de pe firma selectata pentru ultimele 3 luni</p>
				<div class="note note-info">
								<p>
									{assign var=first value = $companie->balante|@key}
									 Cea mai recenta balanta: {$lunileAnului[$companie->balante[$first]->luna]} {$companie->balante[$first]->an}  
									 &nbsp;&nbsp;<a class="btn blue btn-xs" href="{'/'|url}balante_add?cid={$companie->id}">Vezi toate balantele </a>
								</p>
							</div>
			</div>
		</div>
	</div>
</div>

<!-- ROW no 2 --->
<div class="row">
	<div class="col-md-6 col-sm-12">
		<!-- BEGIN PORTLET-->
		<div class="portlet light ">
			<div class="portlet-title">
				<div class="caption caption-md">
					<i class="icon-bar-chart theme-font-color hide"></i>
					<span class="caption-subject theme-font-color bold uppercase">Analiza lunara</span>
				</div>
				<div class="actions">
					<div class="btn-group btn-group-devided" data-toggle="buttons">
						
						<label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
						<input type="radio" name="options" class="toggle" id="option1">{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}</label>
					
					
						<!-- {assign var=balante value=$companie->balante}
						{foreach item=b from=$balante name=bList}
							{if $smarty.foreach.bList.index == 3}
								{break}
							  {/if}
								<label class="btn btn-transparent grey-salsa btn-circle btn-sm {($smarty.foreach.bList.index==0)? 'active':''}">
								<input type="radio" name="options" class="toggle" id="option1">{$lunileAnului[$b->luna]} {$b->an}</label>
						{/foreach} -->
					</div>
				</div>
			</div>
			
				
			
			<div class="portlet-body">
				<p> Descriere a raportului... cam un paragraf</p>
				<div class="row list-separated">
					<div class="col-md-4 col-sm-4 text-center">
						<div class="uppercase font-md font-grey-mint">
							{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}
						</div>
					</div>
					<div class="col-md-4 col-sm-4">
						
					</div>
					<div class="col-md-4 col-sm-4 text-center">
						<div class="uppercase font-md font-grey-mint">
							Ianuarie - {$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an} 
						</div>
						
					</div>
				</div>
				<div class="row list-separated">
					<div class="col-md-4 col-sm-4 text-center">
						<div class="uppercase font-hg theme-font-color">
							{$valoriRaportLunar['CIFRA_DE_AFACERI']->tableReportItemValue} <span class="font-lg font-grey-mint">RON</span>
						</div>
					</div>
					<div class="col-md-4 col-sm-4 text-center">
						<div class="uppercase font-hg theme-font-color">
							<span class="font-lg">Cifra de afaceri</span>
						</div>
					</div>
					<div class="col-md-4 text-center">
						<div class="uppercase font-hg theme-font-color">
							{$valoriRaportLunar['CIFRA_DE_AFACERI']->tableReportItemValueCumulated} <span class="font-lg font-grey-mint">RON</span>
						</div>
						
					</div>
					<div class="col-md-4 col-sm-4 text-center">
						<div class="uppercase font-hg font-purple">
							{$valoriRaportLunar['VENITURI_TOTALE']->tableReportItemValue} <span class="font-lg font-grey-mint">RON</span>
						</div>
					</div>
					<div class="col-md-4 col-sm-4 text-center">
						<div class="uppercase font-hg font-purple">
							<span class="font-lg">Total venituri</span>
						</div>
					</div>
					<div class="col-md-4 col-sm-4 text-center">
						<div class="uppercase font-hg font-purple">
							{$valoriRaportLunar['VENITURI_TOTALE']->tableReportItemValueCumulated} <span class="font-lg font-grey-mint">RON</span>
						</div>
						
					</div>
					<div class="col-md-4 col-sm-4 text-center">
						<div class="uppercase font-hg font-green">
							{$valoriRaportLunar['PROFIT_NET']->tableReportItemValue} <span class="font-lg font-grey-mint">RON</span>
						</div>
					</div>
					<div class="col-md-4 col-sm-4 text-center">
						<div class="uppercase font-hg font-green">
							<span class="font-lg ">Profit net</span>
						</div>
					</div>
					<div class="col-md-4 col-sm-4 text-center">
						<div class="uppercase font-hg font-green">
							{$valoriRaportLunar['PROFIT_NET']->tableReportItemValueCumulated} <span class="font-lg font-grey-mint">RON</span>
						</div>
						
					</div>
					
				</div>
				
				<div class="row">
					<div class="col-md-12 col-sm-12 text-center">
						
						
							
							<div class="uppercase font-hg font-red-flamingo">
							<span class="font-lg ">Venituri {$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}</span>
							<div id="donut_luna" class="chart">
							</div>
						</div>
					</div>
					<!--<div class="col-md-6 col-sm-6 text-center">
						<div class="uppercase font-hg font-red-flamingo">
							<span class="font-lg ">Venituri Ianuarie - {$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an} </span>
						</div>
						
						<div id="donut_cumulat" class="chart">
							</div>
							
						
					</div>-->
				
				
				</div>
				
				<a href="/raport_balanta?cid={$companie->id}&bid={$balantaCurenta->id}" class="btn btn-primary btn-block">Analizeaza in detaliu luna curenta sau o alta luna</a>
			</div>
		</div>
		<!-- END PORTLET-->
	</div>
		<div class="col-md-6 col-sm-12">
		<!-- BEGIN PORTLET-->
		<div class="portlet light ">
			<div class="portlet-title">
				<div class="caption caption-md">
					<i class="icon-bar-chart theme-font-color hide"></i>
					<span class="caption-subject theme-font-color bold uppercase">Evolutie lunara</span>
					<span class="caption-helper hide">weekly stats...</span>
				</div>
				<div class="actions">
					<div class="btn-group btn-group-devided" data-toggle="buttons">
						<label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
						<input type="radio" name="options" class="toggle" id="option1">3 Luni</label>
						<label class="btn btn-transparent grey-salsa btn-circle btn-sm">
						<input type="radio" name="options" class="toggle" id="option2">6 luni</label>
						<label class="btn btn-transparent grey-salsa btn-circle btn-sm">
						<input type="radio" name="options" class="toggle" id="option2">12 luni</label>
					</div>
				</div>
			</div>
			<div class="portlet-body">
				<div class="row list-separated">
				<p>Text cu descriere ce face analiza asta si la ce se foloseste
				</p>
					<div class="col-md-4 col-sm-3 col-xs-6">
						<div class="font-grey-mint font-sm">
							Cifra de afaceri
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
						
					</div>
					<div class="col-md-4 col-sm-3 col-xs-6">
						<div class="font-grey-mint font-sm">
							Ttal venituri
						</div>
						<div class="uppercase font-hg theme-font-color">
							4,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</div>
					<div class="col-md-4 col-sm-3 col-xs-6">
						<div class="font-grey-mint font-sm">
							Profit Net
						</div>
						<div class="uppercase font-hg font-purple">
							11,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</div>
				</div>
				<ul class="list-separated list-inline-xs hide">
					<li>
						<div class="font-grey-mint font-sm">
							Total Sales
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
					<li>
					</li>
					<li class="border">
						<div class="font-grey-mint font-sm">
							Revenue
						</div>
						<div class="uppercase font-hg theme-font-color">
							4,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
					<li class="divider">
					</li>
					<li>
						<div class="font-grey-mint font-sm">
							Expenses
						</div>
						<div class="uppercase font-hg font-purple">
							11,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
					<li class="divider">
					</li>
					<li>
						<div class="font-grey-mint font-sm">
							Growth
						</div>
						<div class="uppercase font-hg font-blue-sharp">
							9,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
				</ul>
				<div id="sales_statistics2" class="portlet-body-morris-fit morris-chart" style="height: 260px">
				</div>
			</div>
		</div>
		<!-- END PORTLET-->
	</div>
</div>
<!-- ROW no 2 --->
<div class="row">
	<div class="col-md-6 col-sm-12">
		<!-- BEGIN PORTLET-->
		<div class="portlet light ">
			<div class="portlet-title">
				<div class="caption caption-md">
					<i class="icon-bar-chart theme-font-color hide"></i>
					<span class="caption-subject theme-font-color bold uppercase">Analiza comparativa anuala - Decembrie</span>
				</div>
				<div class="actions">
					<div class="btn-group btn-group-devided" data-toggle="buttons">
						<label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
						<input type="radio" name="options" class="toggle" id="option1">2 Ani</label>
						<label class="btn btn-transparent grey-salsa btn-circle btn-sm">
						<input type="radio" name="options" class="toggle" id="option2">3 Ani</label>
						<label class="btn btn-transparent grey-salsa btn-circle btn-sm">
						<input type="radio" name="options" class="toggle" id="option2">4 Ani</label>
					</div>
				</div>
			</div>
			<div class="portlet-body">
				<div class="row list-separated">
					<div class="col-md-4 col-sm-3 col-xs-6">
						<div class="font-grey-mint font-sm">
							Cifra de afaceri
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
						
						
					</div>
					<div class="col-md-4 col-sm-3 col-xs-6">
						<div class="font-grey-mint font-sm">
							Ttal venituri
						</div>
						<div class="uppercase font-hg theme-font-color">
							4,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</div>
					<div class="col-md-4 col-sm-3 col-xs-6">
						<div class="font-grey-mint font-sm">
							Profit Net
						</div>
						<div class="uppercase font-hg font-purple">
							11,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</div>
				</div>
				<ul class="list-separated list-inline-xs hide">
					<li>
						<div class="font-grey-mint font-sm">
							Total Sales
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
					<li>
					</li>
					<li class="border">
						<div class="font-grey-mint font-sm">
							Revenue
						</div>
						<div class="uppercase font-hg theme-font-color">
							4,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
					<li class="divider">
					</li>
					<li>
						<div class="font-grey-mint font-sm">
							Expenses
						</div>
						<div class="uppercase font-hg font-purple">
							11,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
					<li class="divider">
					</li>
					<li>
						<div class="font-grey-mint font-sm">
							Growth
						</div>
						<div class="uppercase font-hg font-blue-sharp">
							9,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
				</ul>
				<div id="sales_statistics" class="portlet-body-morris-fit morris-chart" style="height: 260px">
				</div>
			</div>
		</div>
		<!-- END PORTLET-->
	</div>
		<div class="col-md-6 col-sm-12">
		<!-- BEGIN PORTLET-->
		<div class="portlet light ">
			<div class="portlet-title">
				<div class="caption caption-md">
					<i class="icon-bar-chart theme-font-color hide"></i>
					<span class="caption-subject theme-font-color bold uppercase">Analiza comparativa a doua perioade</span>
					<span class="caption-helper hide">weekly stats...</span>
				</div>
				<div class="actions">
					<div class="btn-group btn-group-devided" data-toggle="buttons">
						<label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
						<input type="radio" name="options" class="toggle" id="option1">Today</label>
						<label class="btn btn-transparent grey-salsa btn-circle btn-sm">
						<input type="radio" name="options" class="toggle" id="option2">Week</label>
						<label class="btn btn-transparent grey-salsa btn-circle btn-sm">
						<input type="radio" name="options" class="toggle" id="option2">Month</label>
					</div>
				</div>
			</div>
			<div class="portlet-body">
				<div class="row list-separated">
					<div class="col-md-3 col-sm-3 col-xs-6">
						<div class="font-grey-mint font-sm">
							Total Sales
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</div>
					<div class="col-md-3 col-sm-3 col-xs-6">
						<div class="font-grey-mint font-sm">
							Revenue
						</div>
						<div class="uppercase font-hg theme-font-color">
							4,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</div>
					<div class="col-md-3 col-sm-3 col-xs-6">
						<div class="font-grey-mint font-sm">
							Expenses
						</div>
						<div class="uppercase font-hg font-purple">
							11,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</div>
					<div class="col-md-3 col-sm-3 col-xs-6">
						<div class="font-grey-mint font-sm">
							Growth
						</div>
						<div class="uppercase font-hg font-blue-sharp">
							9,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</div>
				</div>
				<ul class="list-separated list-inline-xs hide">
					<li>
						<div class="font-grey-mint font-sm">
							Total Sales
						</div>
						<div class="uppercase font-hg font-red-flamingo">
							13,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
					<li>
					</li>
					<li class="border">
						<div class="font-grey-mint font-sm">
							Revenue
						</div>
						<div class="uppercase font-hg theme-font-color">
							4,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
					<li class="divider">
					</li>
					<li>
						<div class="font-grey-mint font-sm">
							Expenses
						</div>
						<div class="uppercase font-hg font-purple">
							11,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
					<li class="divider">
					</li>
					<li>
						<div class="font-grey-mint font-sm">
							Growth
						</div>
						<div class="uppercase font-hg font-blue-sharp">
							9,760 <span class="font-lg font-grey-mint">$</span>
						</div>
					</li>
				</ul>
				<div id="sales_statistics2" class="portlet-body-morris-fit morris-chart" style="height: 260px">
				</div>
			</div>
		</div>
		<!-- END PORTLET-->
	</div>
</div>


<!-- END PAGE CONTENT-->
{literal}
<script>
var CompanyDashboard = function() {

    var dashboardMainChart = null;
	var dashboardMainChart2 = null;

    return {

        //main function
        init: function() {
            Metronic.addResizeHandler(function() {
                jQuery('.vmaps').each(function() {
                    var map = jQuery(this);
                    map.width(map.parent().width());
                });
            });

            CompanyDashboard.initCharts();
			CompanyDashboard.initPieCharts();
			
        },

        initCharts: function() {
            if (Morris.EventEmitter) {
                // Use Morris.Area instead of Morris.Line
                dashboardMainChart = Morris.Area({
                    element: 'sales_statistics',
                    padding: 0,
                    behaveLikeLine: false,
                    gridEnabled: false,
                    gridLineColor: false,
                    axes: false,
                    fillOpacity: 1,
                    data: [{
                        period: '2011 Q1',
                        sales: 1400,
                        profit: 400
                    }, {
                        period: '2011 Q2',
                        sales: 1100,
                        profit: 600
                    }, {
                        period: '2011 Q3',
                        sales: 1600,
                        profit: -500
                    }, {
                        period: '2011 Q4',
                        sales: 1200,
                        profit: 400
                    }, {
                        period: '2012 Q1',
                        sales: 1550,
                        profit: 800
                    }],
                    lineColors: ['#399a8c', '#92e9dc'],
                    xkey: 'period',
                    ykeys: ['sales', 'profit'],
                    labels: ['Sales', 'Profit'],
                    pointSize: 0,
                    lineWidth: 0,
                    hideHover: 'auto',
                    resize: true
                });
				 // Use Morris.Area instead of Morris.Line
                dashboardMainChart2 = Morris.Area({
                    element: 'sales_statistics2',
                    padding: 0,
                    behaveLikeLine: false,
                    gridEnabled: false,
                    gridLineColor: false,
                    axes: true,
                    fillOpacity: 1,
                    data: [{
                        period: '2011 Q1',
                        sales: 1400,
                        profit: 400
                    }, {
                        period: '2011 Q2',
                        sales: 1100,
                        profit: 600
                    }, {
                        period: '2011 Q3',
                        sales: -600,
                        profit: 500
                    }, {
                        period: '2011 Q4',
                        sales: 1200,
                        profit: 400
                    }, {
                        period: '2012 Q1',
                        sales: 1550,
                        profit: 800
                    }],
                    lineColors: ['#399a8c', '#92e9dc'],
                    xkey: 'period',
                    ykeys: ['sales', 'profit'],
                    labels: ['Sales', 'Profit'],
                    pointSize: 0,
                    lineWidth: 0,
                    hideHover: 'auto',
                    resize: true
                });

            }
        },

        redrawCharts: function() {
            dashboardMainChart.resizeHandler();
			dashboardMainChart2.resizeHandler();
        },
		
		initPieCharts: function () {
			
			//series for cumulated
			var cumulatedData = [];
			//cifra de afaceri
			cumulatedData[0] = {label: "Vanzarea produselor finite", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_vanzarea_produselor_finite')]->valueCumulated()}{literal}};
			cumulatedData[1] = {label: "Vanzarea semifabricatelor si produselor reziduale", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_vanzarea_semifabricatelor_si_produselor_reziduale')]->valueCumulated()}{literal}};
			cumulatedData[2] = {label: "Servicii prestate  ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_servicii_prestate')]->valueCumulated()}{literal}};
			cumulatedData[3] = {label: "Studii si cercetari  ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_studii_si_cercetari')]->valueCumulated()}{literal}};
			cumulatedData[4] = {label: "Redevente, locatii de gestiune si chirii  ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_redevente_locatii_de_gestiune_si_chirii')]->valueCumulated()}{literal}};
			cumulatedData[5] = {label: "Vanzarea marfurilor    ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_vanzarea_marfurilor')]->valueCumulated()}{literal}};
			cumulatedData[6] = {label: "Activitati diverse  ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_activitati_diverse')]->valueCumulated()}{literal}};
			cumulatedData[7] = {label: "Reduceri comerciale acordate   ", data: {/literal}{$valoriRaportLunar[strtoupper('Reduceri_comerciale_acordate')]->valueCumulated()}{literal}};
			cumulatedData[8] = {label: "Subventii de exploatare aferente cifrei de afaceri", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_subventii_de_exploatare_aferente_cifrei_de_afaceri')]->valueCumulated()}{literal}};
			
			//alte venituri
			cumulatedData[9] = {label: "Venituri aferente costului productiei in curs de executie", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_aferente_costului_productiei_in_curs_de_executie')]->valueCumulated()}{literal}};
			cumulatedData[10] = {label: "Productia de imobilizari ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_productia_de_imobilizari')]->valueCumulated()}{literal}};
			cumulatedData[11] = {label: "Despagubiri, amenzi si penalitati ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_despagubiri_amenzi_si_penalitati')]->valueCumulated()}{literal}};
			cumulatedData[12] = {label: "Donatii primite", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_donatii_primite')]->valueCumulated()}{literal}};
			cumulatedData[13] = {label: "Vanzarea activelor si alte operatii de capital", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_vanzarea_activelor_si_alte_operatii_de_capital')]->valueCumulated()}{literal}};
			cumulatedData[14] = {label: "Subventii pentru investitii  ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_subventii_pentru_investitii')]->valueCumulated()}{literal}};
			cumulatedData[15] = {label: "Alte venituri ocazionale din exploatare", data: {/literal}{$valoriRaportLunar[strtoupper('Alte_venituri_ocazionale_din_exploatare')]->valueCumulated()}{literal}};
			
			//venituri financiare
			cumulatedData[16] = {label: "Venituri din dobanzi", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_dobanzi')]->valueCumulated()}{literal}};
			cumulatedData[17] = {label: "Venituri din diferente de curs valutar ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_diferente_de_curs_valutar')]->valueCumulated()}{literal}};
			cumulatedData[18] = {label: "Venituri din sconturi obtinute", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_sconturi_obtinute')]->valueCumulated()}{literal}};
			cumulatedData[19] = {label: "Alte venituri financiare", data: {/literal}{$valoriRaportLunar[strtoupper('Alte_venituri_financiare')]->valueCumulated()}{literal}};
			
			//!!!series for curent month
			var lunaCurentaData = [];
			//cifra de afaceri
			lunaCurentaData[0] = {label: "Vanzarea produselor finite", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_vanzarea_produselor_finite')]->value()}{literal}};
			lunaCurentaData[1] = {label: "Vanzarea semifabricatelor si produselor reziduale", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_vanzarea_semifabricatelor_si_produselor_reziduale')]->value()}{literal}};
			lunaCurentaData[2] = {label: "Servicii prestate  ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_servicii_prestate')]->value()}{literal}};
			lunaCurentaData[3] = {label: "Studii si cercetari  ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_studii_si_cercetari')]->value()}{literal}};
			lunaCurentaData[4] = {label: "Redevente, locatii de gestiune si chirii  ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_redevente_locatii_de_gestiune_si_chirii')]->value()}{literal}};
			lunaCurentaData[5] = {label: "Vanzarea marfurilor    ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_vanzarea_marfurilor')]->value()}{literal}};
			lunaCurentaData[6] = {label: "Activitati diverse  ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_activitati_diverse')]->value()}{literal}};
			lunaCurentaData[7] = {label: "Reduceri comerciale acordate   ", data: {/literal}{$valoriRaportLunar[strtoupper('Reduceri_comerciale_acordate')]->value()}{literal}};
			lunaCurentaData[8] = {label: "Subventii de exploatare aferente cifrei de afaceri", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_subventii_de_exploatare_aferente_cifrei_de_afaceri')]->value()}{literal}};
			
			//alte venituri
			lunaCurentaData[9] = {label: "Venituri aferente costului productiei in curs de executie", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_aferente_costului_productiei_in_curs_de_executie')]->value()}{literal}};
			lunaCurentaData[10] = {label: "Productia de imobilizari ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_productia_de_imobilizari')]->value()}{literal}};
			lunaCurentaData[11] = {label: "Despagubiri, amenzi si penalitati ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_despagubiri_amenzi_si_penalitati')]->value()}{literal}};
			lunaCurentaData[12] = {label: "Donatii primite", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_donatii_primite')]->value()}{literal}};
			lunaCurentaData[13] = {label: "Vanzarea activelor si alte operatii de capital", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_vanzarea_activelor_si_alte_operatii_de_capital')]->value()}{literal}};
			lunaCurentaData[14] = {label: "Subventii pentru investitii  ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_subventii_pentru_investitii')]->value()}{literal}};
			lunaCurentaData[15] = {label: "Alte venituri ocazionale din exploatare", data: {/literal}{$valoriRaportLunar[strtoupper('Alte_venituri_ocazionale_din_exploatare')]->value()}{literal}};
			
			//venituri financiare
			lunaCurentaData[16] = {label: "Venituri din dobanzi", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_dobanzi')]->value()}{literal}};
			lunaCurentaData[17] = {label: "Venituri din diferente de curs valutar ", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_diferente_de_curs_valutar')]->value()}{literal}};
			lunaCurentaData[18] = {label: "Venituri din sconturi obtinute", data: {/literal}{$valoriRaportLunar[strtoupper('Venituri_din_sconturi_obtinute')]->value()}{literal}};
			lunaCurentaData[19] = {label: "Alte venituri financiare", data: {/literal}{$valoriRaportLunar[strtoupper('Alte_venituri_financiare')]->value()}{literal}};
            

            // DONUT
			if (!jQuery.plot) {
                return;
            }
            $.plot($("#donut_luna"), lunaCurentaData, {
                    series: {
                        pie: {
							innerRadius: 0.4,
                            show: true,
                            combine: {
                                color: '#999',
								label: 'Altele',
                                threshold: 0.1
                            }
                        }
                    },
                    legend: {
                        show: false
                    }
                });
			
			
	/*	$.plot($("#donut_cumulat"), cumulatedData, {
                    series: {
                        pie: {
							innerRadius: 0.4,
                            show: true,
                            combine: {
                                color: '#999',
								label: 'Altele',
                                threshold: 0.1
                            }
                        }
                    },
                    legend: {
                        show: false
                    }
                });*/

			
          

        }

    };

}();

</script>

{/literal}


