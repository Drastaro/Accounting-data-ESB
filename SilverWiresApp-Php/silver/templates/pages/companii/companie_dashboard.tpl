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
				<button type="button" class="btn btn-fit-height red-sunglo dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000" data-close-others="true" aria-expanded="false">
				Actiuni <i class="fa fa-angle-down"></i>
				</button>
				<ul class="dropdown-menu pull-right" role="menu">
					<li>
						<a href="{'/'|url}balante_add?cid={$companie->id}">Adauga balanta</a>
					</li>
					<li>
						<a href="{'/'|url}companii_detalii?cid={$companie->id}">Editeaza companie</a>
					</li>										
				</ul>
			</div>
		</div>
		<!-- END PAGE TOOLBAR -->
</div>
{if $areMessages==true}
<div class="note {$messageClass}">
	<span>{$pageMessages}</span>	
</div>
{/if}

{if $balantaCurenta!=null}
<!-- BEGIN PAGE CONTENT-->
<div class="note note-info">
	<p>
		{assign var=first value = $companie->balante|@key}
		 Cea mai recenta balanta: {$lunileAnului[$companie->balante[$first]->luna]} {$companie->balante[$first]->an}  
		 &nbsp;&nbsp;<a class="btn blue btn-xs" href="{'/'|url}balante_add?cid={$companie->id}">Vezi toate balantele </a>
	</p>
</div>

<div class="row margin-top-10">
	<div class="col-md-12">
		{include file="pages/companii/companie_dashboard_rezultate.tpl"}
	</div>
</div>
{else}
<div class="note note-info">
	<p class="block">Compania <b>{$companie->name}</b> nu are incarcata nici o balanta.</p>
	<p>
		 Pentru a putea accesa indicatorii financiari si analiza financiara trebuie sa incarcati cel putin o balanta. <br/>
		 <a class="btn blue btn-xs" href="{'/'|url}balante_add?cid={$companie->id}">Adauga balanta</a>
	</p>
</div>

{/if}


{literal}
<script>
{/literal}
			{if $balantaCurenta==null}
			{literal}
var CompanyDashboard = function() {

    return {
        //main function
        init: function() {
			
        }
	}
}();
{/literal}
{else}
{literal}
	
var CompanyDashboard = function() {

    return {
        //main function
        init: function() {
			
			moneyFormat();
				
			CompanyDashboard.initRezultate();
        },
		
		initRezultate: function () {
			{/literal}{assign var=listaItems value=['CHELTUIELI_TOTALE', 'PROFIT_NET']}{literal}
				var dataRezultateTotale= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
								{
									label: "{/literal}{$TXT[$i]}{literal}",
									data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
									percentOf: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"								
								}
										{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];	
				var dataRezultateTotaleCumulat= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
							{
								label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->valueCumulated()}{literal},
								percentOf: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"								
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];
				
				var plot=CompanyDashboard.generateDonutChart("#rezultate_graph","#rezultate_details",dataRezultateTotale, false, false);
				CompanyDashboard.showItemDetailsOne("#rezultate_details",plot.getData()[0]);
				CompanyDashboard.showItemDetailsOne("#rezultate_details2",plot.getData()[1]);
				CompanyDashboard.updatePlotLabel("#donutLabelRezultate",'{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}','{/literal}{$TXT["VENITURI_TOTALE"]}{literal}', '{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->value()}{literal}');
				
				$("#rezultate_option_luna").click(function() {					
					var period='{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
					var labelText='{/literal}{$TXT["VENITURI_TOTALE"]}{literal}';
					var labelValue='{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->value()}{literal}';
					CompanyDashboard.updatePlotLabel("#donutLabelRezultate",period,labelText,labelValue);					
					plot.setData(dataRezultateTotale);
					plot.draw();
					CompanyDashboard.showItemDetailsOne("#rezultate_details",plot.getData()[0]);
					CompanyDashboard.showItemDetailsOne("#rezultate_details2",plot.getData()[1]);
				});
				$("#rezultate_option_cumulat").click(function() {
					var period='IANUARIE - {/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
					var labelText='{/literal}{$TXT["VENITURI_TOTALE"]}{literal}';
					var labelValue='{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->valueCumulated()}{literal}';
					CompanyDashboard.updatePlotLabel("#donutLabelRezultate",period,labelText,labelValue);					
					plot.setData(dataRezultateTotaleCumulat);
					plot.draw();
					CompanyDashboard.showItemDetailsOne("#rezultate_details",plot.getData()[0]);
					CompanyDashboard.showItemDetailsOne("#rezultate_details2",plot.getData()[1]);
				});
		},
		
		updatePlotLabel: function (labelID,period,text,value) {
			$(labelID).find('.donut-label-perioada').text(period);
			$(labelID).find('.donut-label-text').text(text);
			$(labelID).find('.donut-label-value').html('<span class="money_top">'+value+'</span>'+'{/literal}<small>{$LABEL['currency']}</small>{literal}');
			moneyTopFormat();
		},
		
		generateDonutChart: function(targetGraphId, targetDetailsId, data, showTwoPercentValues, showItemOnHover) {
			if (typeof showItemOnHover === "undefined") { var showItemOnHover=true;}
			var graphPlot=$.plot($(targetGraphId), data, {
                    series: {
                        pie: {
							innerRadius: 0.6,
                            show: true,
                            combine: {
                                color: '#999',
								label: 'Altele',
                                threshold: 0.01
                            }
                        }
                    },
                    legend: {
                        show: true,
						 container:$("#legendContainer"),            
						 noColumns: 0
                    },
					 grid: {
						hoverable: true,
						clickable: false
					},
					colors: ['#2090a8','#f68352','#f6b32c','#b6c951','#89cda7','#f69090','#ef405d','#951757'] 					
                });
				
				
				function showTooltip2(x,y,series) {	
					var percent = parseFloat(series.percent).toFixed(2);
					 $('<div id="flot-tooltip2">' + series.label + '&nbsp;'+percent+ '%</div>').css( {
							position: 'absolute',
							top: y + 5,
							left: x + 5,
							border: '1px solid #ddd',							
							'text-align': 'center',
							'background-color': '#cecece',
							padding: '5px',							
							opacity: 0.80
						}).appendTo("body");
				}
				
				
				//show first element
				if(showTwoPercentValues) {
					CompanyDashboard.showItemDetailsTwo(targetDetailsId,graphPlot.getData()[0]);					
				} else {
					CompanyDashboard.showItemDetailsOne(targetDetailsId,graphPlot.getData()[0]);
				}				
				
	
				$(targetGraphId).bind("plothover", function (event, pos, item) {
					var previousPoint2;
					if (item) {
						if (previousPoint2 != item.datapoint) {
							previousPoint2 = item.datapoint;
							$("#flot-tooltip2").remove();
							showTooltip2(pos.pageX, pos.pageY, item.series );							
							if(showItemOnHover) {
								if(showTwoPercentValues) {
									CompanyDashboard.showItemDetailsTwo(targetDetailsId,item.series);
								} else {
									CompanyDashboard.showItemDetailsOne(targetDetailsId,item.series);
								}
							}
						}
					} else {
						$("#flot-tooltip2").remove();						
						previousPoint2 = null;
					}
				});
				
				return graphPlot;
		
		},
		
		showItemDetailsOne: function (targetDetailsId,itemSeries) {			
			var percent = parseFloat(itemSeries.percent).toFixed(2);					
			var percentOf=itemSeries.percentOf? itemSeries.percentOf:"";
			var htmlContent=
				'<div class="dashboard-stat2">'+
					'<div class="display"><div class="number"><h3 style="color:'+itemSeries.color+'"><span class="money_top">'+itemSeries.data[0][1]+'</span><small>{/literal}{$LABEL["currency"]}{literal}</small></h3><small>'+ itemSeries.label+'</small></div></div>'+
					'<div class="progress-info"><div class="progress"><span style="width: '+percent+'%;background:'+itemSeries.color+'" class="progress-bar progress-bar-success"></span></div>'+
					'<div class="status"><div class="status-title">Procent din '+percentOf+'</div><div class="status-number">'+percent+'%</div></div></div>'+
				'</div>';			
			/*htmlContent=htmlContent+'<div class="item_details">'+
						'Descriere pe cateva randuri ce inseamna fiecare valoare si cum influenteaza mersul afacerii. Descriere pe cateva randuri ce inseamna fiecare valoare si cum influenteaza mersul afacerii.'+
						'</div>';*/
			$(targetDetailsId).html(htmlContent);
			moneyTopFormat();
			$(targetDetailsId).show();
		}
	}
}();

{/literal}
{/if}
{literal}
</script>
{/literal}

