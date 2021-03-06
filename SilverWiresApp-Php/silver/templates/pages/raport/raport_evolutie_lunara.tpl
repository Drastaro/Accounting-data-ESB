<!-- Content Header (Page header) -->
<div class="page-head">
		<!-- BEGIN PAGE TITLE -->
		<div class="page-title">
		 <h1>{$companie->name}</h1>
        <!-- <small>Analiza financiara de management si business intelligence</small></h1>-->
		</div>
		<!-- END PAGE TITLE -->		
</div>

<!-- BEGIN PAGE CONTENT-->
<div class="row">
	<div class="col-md-12">
		<div class="portlet light">
						<div class="portlet-title">
							<div class="caption">
								<i class="icon-bar-chart font-red-sunglo"></i>
								<span class="caption-subject font-red-sunglo bold uppercase">Analiza evolutie lunara</span>
								
							</div>
							
						</div>
						<div class="portlet-body">
							<p>Selectaţi lunile ale caror valori doriţi sa le vizualizaţi. Rapoartele redau informaţii despre datele realizate în cadrul unei luni. Se pot compara rezultate realizate lunar între luni din acelaşi an sau din ani diferiţi. Informaţiile sunt prezentate tabelar sau grafic. </p>
							<p>Se pot face comparaţii pentru 2-12 luni.</p>
							{assign var=nrBalanteExistente value=$balante|@count}
							{if $nrBalanteExistente>0}
							<form action="" class="form-horizontal form-row-seperated" method="post">
								<input type="hidden" name="cid" value="{$companie->id}"/>								
								
							<div class="form-group last">
										<label class="control-label col-md-3">Alege lunile care doresti sa le analizezi</label>
										<div class="col-md-4">											
											<select multiple="multiple" class="multi-select" id="month_multi_select" name="month_multi_select[]">
											{assign var=nr_b value=$submitedBalante|@count}
											{assign var=an value=-1}											
											{foreach item=b from=$balante name=bList}
												{if ($an==-1)}
													{assign var=an value=$b->an}
													<optgroup label="{$b->an}">	
													
												{elseif ($b->an!=$an)}	
														{assign var=an value=$b->an}
														</optgroup>
														<optgroup label="{$b->an}">	
												{/if}
													<option value="{$b->id}" {if $nr_b>0 AND in_array($b->id, $submitedBalante)} selected="selected" {/if} >{$b->luna}.&nbsp;{$lunileAnului[$b->luna]}&nbsp;{$b->an}</option>
												{/foreach}
												</optgroup>	
											</select>
										</div>
										<div class="col-md-5">
											<button type="submit" class="btn btn-primary">Analizeaza</button>
										</div>
										
									</div>																	
								</form>
								{/if}
							</div>
		</div>
	
	</div>
</div>
{if $nrBalanteExistente==0}
		<div class="note note-info">
			<p class="block">Compania <b>{$companie->name}</b> nu are incarcata nici o balanta.</p>
			<p>
				 Pentru a putea accesa analiza evolutiei lunare trebuie sa incarcati cel putin o balanta. <br/><br/>
				 <a class="btn blue btn-xs" href="{'/'|url}balante_add?cid={$companie->id}">Adauga balanta</a>
			</p>
		</div>
{/if}
{assign var=nr_balante value=$balanteSelectate|@count} 
{if $nr_balante > 0}

<!-- BEGIN PAGE CONTENT-->
<div class="row">
	<div class="col-md-12">
		<div class="tabbable tabbable-custom tabbable-noborder">
			<ul class="nav nav-tabs">				
				<li class="active">
					<a href="#tab_1" data-toggle="tab">
					Analiza rezultatelor </a>
				</li>
				<li>
					<a href="#tab_2" data-toggle="tab">
					Analiza veniturilor </a>
				</li>
				<li>
					<a href="#tab_3" data-toggle="tab">
					Analiza cheltuielilor </a>
				</li>
				<li>
					<a href="#tab_4" data-toggle="tab">
					Activul patrimonial </a>
				</li>
				<li>
					<a href="#tab_5" data-toggle="tab">
					Pasivul patrimonial </a>
				</li>
				<li>
					<a href="#tab_6" data-toggle="tab">
					Indicatori financiari </a>
				</li>
			</ul>
			<div class="tab-content">	
				<div class="tab-pane active" id="tab_1">
					<div class="row">
						<div class="col-md-12">
							{include file="pages/raport/raport_evolutie_lunara_rezultate.tpl"}
						</div>
					</div>
				</div>
				<div class="tab-pane" id="tab_2">
					<div class="row">
						<div class="col-md-12">
							{include file="pages/raport/raport_evolutie_lunara_venituri.tpl"}
						</div>
					</div>
				</div>
				<div class="tab-pane" id="tab_3">
					<div class="row">
						<div class="col-md-12">
							{include file="pages/raport/raport_evolutie_lunara_cheltuieli.tpl"}
						</div>
					</div>
				</div>
				<div class="tab-pane" id="tab_4">
					<div class="row">
						<div class="col-md-12">
							{include file="pages/raport/raport_evolutie_lunara_activ.tpl"}
						</div>
					</div>
				</div>
				<div class="tab-pane" id="tab_5">
					<div class="row">
						<div class="col-md-12">
							{include file="pages/raport/raport_evolutie_lunara_pasiv.tpl"}
						</div>
					</div>
				</div>
				<div class="tab-pane" id="tab_6">
					{include file="pages/raport/raport_evolutie_lunara_indicatori.tpl"}
				</div>
			</div>
		</div>
	</div>
</div>
<div style="position: absolute; left: -2000px;width:100%;height:100%;">
	<div id="rezultate_offscreen"></div>
	<div id="venituri_offscreen"></div>
	<div id="cheltuieli_offscreen"></div>
	<div id="activ_offscreen"></div>
	<div id="pasiv_offscreen"></div>
</div>
{/if}
{literal}
<script>
var RaportEvolutieLunara = function() {

   return {

        //main function to initiate the module
        init: function () {
		
			if (!jQuery().plot) {
                return;
            }
		
			moneyFormat();
			            
           RaportEvolutieLunara.initTables();
           RaportEvolutieLunara.handleMultiSelect();
		   RaportEvolutieLunara.initGraphVenituri();
		   RaportEvolutieLunara.initGraphCheltuieli();
		   RaportEvolutieLunara.initGraphRezultateLine();
		   RaportEvolutieLunara.initGraphActive();
		   RaportEvolutieLunara.initGraphPasive();
            
        },

		initTables: function () {  
			 // Add event listener for opening and closing details on FIRST level
			$('tbody').on('click', 'td.details-control', function () {	
			
				if($(this).children(".fa").hasClass("fa-plus-square-o")) {
					//open the row marker
					$(this).children(".fa").removeClass("fa-plus-square-o");
					$(this).children(".fa").addClass("fa-minus-square-o");
				} else {
					//close the row marker
					$(this).children(".fa").removeClass("fa-minus-square-o");
					$(this).children(".fa").addClass("fa-plus-square-o");
				}
			
				var tr = $(this).closest('tr');	
				var nextTr = tr.next('tr');
			   // var row = table.row( tr );
				while(nextTr.hasClass('isChildRow') || nextTr.hasClass('isSubChildRow')) {
					if(nextTr.hasClass('isChildRow')) {
						//is child row (second level)
						if(nextTr.hasClass('hide')) {
							nextTr.removeClass('hide');
						} else {
							nextTr.addClass('hide');
							//if expandalble than set row marker on closed
							if(nextTr.find('i').hasClass("fa-minus-square-o")) {
								nextTr.find('i').removeClass("fa-minus-square-o");
								nextTr.find('i').addClass("fa-plus-square-o");
								
							}
						}
					} else {
						//is subchild row (third level)
						if(nextTr.hasClass('hide')) {
							//nextTr.removeClass('hide');
						} else {
							nextTr.addClass('hide');
						}
					}
					nextTr = nextTr.next('tr');
				}
			} );
			
			// Add event listener for opening and closing details on SECOND level
			$('tbody').on('click', 'td.sub-details-control', function () {	
				if($(this).children(".fa").hasClass("fa-plus-square-o")) {
					//open the row marker
					$(this).children(".fa").removeClass("fa-plus-square-o");
					$(this).children(".fa").addClass("fa-minus-square-o");
				} else {
					//close the row marker
					$(this).children(".fa").removeClass("fa-minus-square-o");
					$(this).children(".fa").addClass("fa-plus-square-o");
				}
				var tr = $(this).closest('tr');	
				var nextTr = tr.next('tr');
			   // var row = table.row( tr );
				while(nextTr.hasClass('isSubChildRow')) {		
						if(nextTr.hasClass('hide') ) {
							// Open this row
							nextTr.removeClass('hide');
						}
						else {
							// This row is already open - close it
							nextTr.addClass('hide');
						}
					nextTr = nextTr.next('tr');
				}
		} );
	 
	 },

	handleMultiSelect: function () {
    
        $('#month_multi_select').multiSelect({
            selectableOptgroup: true
        });
    },
	
	initGraphVenituri: function () {  
				{/literal}{assign var=listaItems value=['CIFRA_DE_AFACERI','ALTE_VENITURI_DIN_EXPLOATARE','VENITURI_FINANCIARE', 'VENITURI_EXTRAORDINARE', 'VENITURI_TOTALE']}{literal}
				var datasets= {
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
						"{/literal}{$TXT[$i]}{literal}" : {
								label: "{/literal}{$TXT[$i]}{literal}",
								data: [
											{/literal}
												{foreach from=$balanteSelectate item=balanta name=balantaLoop}										
													[ "{$lunileAnului[$balanta->luna]} {$balanta->an}", {$rapoarteBalante[$smarty.foreach.balantaLoop.iteration-1][$i]->value()}]
													{if not $smarty.foreach.balantaLoop.last} , {/if} 
												{/foreach}
											{literal}
										]
								}
						{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
					{/foreach}{literal}					
				};	
									
				RaportEvolutieLunara.createLineGraph(datasets,"#venituri_offscreen","#evolutie_graph_venituri" , "#venituri_choices", -180);			
	},
	initGraphCheltuieli: function () {  
				{/literal}{assign var=listaItems value=['CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI','ALTE_CHELTUIELI_DE_EXPLOATARE','CHELTUIELI_FINANCIARE', 'CHELTUIELI_EXTRAORDINARE','CHELTUIELI_TOTALE', 'CHELTUIELI_MATERIALE','CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI', 'CHELTUIELI_DE_PERSONAL', 'SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE', 'CHELTUIELI_TOTALE_INAINTE_IMPOZITARE' ]}{literal}
				var datasets= {
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
						"{/literal}{$TXT[$i]}{literal}" : {
								label: "{/literal}{$TXT[$i]}{literal}",
								data: [
											{/literal}
												{foreach from=$balanteSelectate item=balanta name=balantaLoop}										
													[ "{$lunileAnului[$balanta->luna]} {$balanta->an}", {$rapoarteBalante[$smarty.foreach.balantaLoop.iteration-1][$i]->value()}]
													{if not $smarty.foreach.balantaLoop.last} , {/if} 
												{/foreach}
											{literal}
										]
								}
						{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
					{/foreach}{literal}					
				};
				
				RaportEvolutieLunara.createLineGraph(datasets, "#cheltuieli_offscreen", "#evolutie_graph_cheltuieli" , "#cheltuieli_choices", -290, 5);
	},
	initGraphActive: function () {  
				{/literal}{assign var=listaItems value=['ACTIVE_CIRCULANTE','CHELTUIELI_IN_AVANS', 'ACTIVE_IMOBILIZATE', 'TOTAL_ACTIV','DISPONIBIL_IN_CASERIE_SI_BANCA','INVESTITII_PE_TERMEN_SCURT', 'CREANTE', 'STOCURI',  'IMOBILIZARI_NECORPORALE', 'IMOBILIZARI_CORPORALE', 'IMOBILIZARI_FINANCIARE' ]}{literal}
				var datasets= {
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
						"{/literal}{$TXT[$i]}{literal}" : {
								label: "{/literal}{$TXT[$i]}{literal}",
								data: [
											{/literal}
												{foreach from=$balanteSelectate item=balanta name=balantaLoop}										
													[ "{$lunileAnului[$balanta->luna]} {$balanta->an}", {$rapoarteBalante[$smarty.foreach.balantaLoop.iteration-1][$i]->value()}]
													{if not $smarty.foreach.balantaLoop.last} , {/if} 
												{/foreach}
											{literal}
										]
								}
						{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
					{/foreach}{literal}					
				};
				
				RaportEvolutieLunara.createLineGraph(datasets, "#activ_offscreen", "#evolutie_graph_active" , "#active_choices", -185,4);
	},
	initGraphPasive: function () {  
				{/literal}{assign var=listaItems value=['TOTAL_DATORII','VENITURI_IN_AVANS','PROVIZIOANE', 'CAPITALURI_PROPRII', 'TOTAL_PASIV']}{literal}
				var datasets= {
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
						"{/literal}{$TXT[$i]}{literal}" : {
								label: "{/literal}{$TXT[$i]}{literal}",
								data: [
											{/literal}
												{foreach from=$balanteSelectate item=balanta name=balantaLoop}										
													[ "{$lunileAnului[$balanta->luna]} {$balanta->an}", {$rapoarteBalante[$smarty.foreach.balantaLoop.iteration-1][$i]->value()}]
													{if not $smarty.foreach.balantaLoop.last} , {/if} 
												{/foreach}
											{literal}
										]
								}
						{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
					{/foreach}{literal}					
				};
				
				RaportEvolutieLunara.createLineGraph(datasets, "#pasiv_offscreen", "#evolutie_graph_pasive" , "#pasive_choices", -120);
	},
	//createLineGraph : function(datasets, targetId, targetChoisesId, legendRightMargin, noOfPreselectedItems) {
	createLineGraph : function(datasets, targetOffscreenId, targetId, targetChoisesId, legendRightMargin, noOfPreselectedItems) {
				// hard-code color indices to prevent them from shifting as we remove items
				var i = 0;
				$.each(datasets, function(key, val) {
					val.color = i;
					++i;
				});	

				// insert checkboxes 
				var choiceContainer = $(targetChoisesId);
				var count=0;
				choiceContainer.append("<table class=\"table table-bordered\">");
				choiceContainer.append("</table>");	
				var tableContainer = choiceContainer.find("table");
				var tableContainerTR;
				$.each(datasets, function(key, val) {					
					if(count==0) {
						tableContainer.append("<tr>");
						tableContainerTR = tableContainer.find("tr:last");
					}
					tableContainerTR.append("<td><input type='checkbox' name='" + key +
						"' id='id" + key + "'></input>" +
						"<label for='id" + key + "'>"
						+ val.label + "</label></td>");
						count++;
					if(count==5) {						
						count=0;
					}
				});
				choiceContainer.find("input").slice(0,noOfPreselectedItems).prop( "checked", true );
				//choiceContainer.find("input").prop( "checked", true );
				choiceContainer.find("input").click(plotAccordingToChoices);

				function plotAccordingToChoices() {

					var data = [];

					choiceContainer.find("input:checked").each(function () {
						var key = $(this).attr("name");
						if (key && datasets[key]) {
							data.push(datasets[key]);
						}
					});

					if (data.length > 0) {
							var plot = $.plot($(targetOffscreenId),data, {
							series: {
								lines: {
									show: true,
									lineWidth: 2,
									fill: true,
									fillColor: {
										colors: [{
												opacity: 0.05
											}, {
												opacity: 0.01
											}
										]
									}
								},
								points: {
									show: true,
									radius: 3,
									lineWidth: 1
								},
								shadowSize: 2
							},
							grid: {
								hoverable: true,
								clickable: true,
								tickColor: "#eee",
								borderColor: "#eee",
								borderWidth: 1
								
							},
							xaxis: {
								mode: "categories",
								tickLength: 0
								
							},
							
							legend: {
								margin:[legendRightMargin,0]
							},
							colors: ['#2090a8','#f68352','#f6b32c','#b6c951','#89cda7','#f69090','#ef405d','#951757'] 
						});
					}
				}

				plotAccordingToChoices();
				//move the offscreen in the screen
				$(targetId).append( $(targetOffscreenId) );

               function showTooltip(x, y, contents) {
                    $('<div id="tooltip">' + contents + '</div>').css({
                            position: 'absolute',
                            display: 'none',
                            top: y + 5,
                            left: x + 15,
                            border: '1px solid #333',
                            padding: '4px',
                            color: '#fff',                           
                            'background-color': '#333',
                            opacity: 0.80
                        }).appendTo("body").fadeIn(200);
                }

                var previousPoint = null;
                $(targetOffscreenId).bind("plothover", function (event, pos, item) {
                    $("#x").text(pos.x.toFixed(2));
                    $("#y").text(pos.y.toFixed(2));

                    if (item) {
                        if (previousPoint != item.dataIndex) {
                            previousPoint = item.dataIndex;

                            $("#tooltip").remove();							
                            var x = item.series.data[item.dataIndex][0],
                                y = item.datapoint[1].toFixed(2);

                            showTooltip(item.pageX, item.pageY, item.series.label + "<br/>" + x + " = " + '<span class="money_top">'+y+'</span>');
							moneyTopFormat();
                        }
                    } else {
                        $("#tooltip").remove();
                        previousPoint = null;
                    }
                });
	},
	initGraphRezultateLine: function () {
		{/literal}{assign var=listaItems value=['VENITURI_TOTALE','CHELTUIELI_TOTALE','PROFIT_NET','EBITDA', 'EBIT']}{literal}
				var datasets= {
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
						"{/literal}{$TXT[$i]}{literal}" : {
								label: "{/literal}{$TXT[$i]}{literal}",
								data: [
											{/literal}
												{foreach from=$balanteSelectate item=balanta name=balantaLoop}										
													[ "{$lunileAnului[$balanta->luna]} {$balanta->an}", {$rapoarteBalante[$smarty.foreach.balantaLoop.iteration-1][$i]->value()}]
													{if not $smarty.foreach.balantaLoop.last} , {/if} 
												{/foreach}
											{literal}
										]
								}
						{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
					{/foreach}{literal}					
				};
								
				RaportEvolutieLunara.createLineGraph(datasets,"#rezultate_offscreen", "#evolutie_graph_rezultate" , "#rezultate_choices", -120,3);
	
	},
	initGraphRezultate: function () {  	
			{/literal}{assign var=listaItems value=['CHELTUIELI_TOTALE', 'PROFIT_NET' ]}{literal}
					
			var dataRezultate= [
				{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
							{
							label: "{/literal}{$TXT[$i]}{literal}",
							data: [
										{/literal}
											{foreach from=$balanteSelectate item=balanta name=balantaLoop}
												[ {$smarty.foreach.balantaLoop.index}, {$rapoarteBalante[$smarty.foreach.balantaLoop.iteration-1][$i]->value()} ]
												{if not $smarty.foreach.balantaLoop.last} , {/if} 
											{/foreach}
										{literal}
								]
								,last :{/literal}{if not $smarty.foreach.itemsLoop.last} false {else} true {/if}{literal}
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
				{/foreach}{literal}
			];
			
			var dataVenituriLabel = [
				{/literal}
					{foreach from=$balanteSelectate item=balanta name=balantaLoop}
						{$rapoarteBalante[$smarty.foreach.balantaLoop.iteration-1]['VENITURI_TOTALE']->value()}
						{if not $smarty.foreach.balantaLoop.last} , {/if} 
					{/foreach}
				{literal}
			];
								
				
				var data = [
        { label: 'One', data: [[1, 12], [2, 4], [3, 5], [4, 25], [5, 16]], last:false },
        { label: 'Two', data: [[1, 5], [2, 25], [3, 4], [4, 16], [5, 12]], last:true }
     ];
    var clickTips;
	var hoverTip;
	


function toolTipHTML( stat, series ) {

   var html = '';

   html += '<div class="bars-tooltip">';
   html += '<div>';

   if ( series )
      html += '<span class="series">'+series+'</span>';

   html += '<span class="stats">'+stat+'</span>';
   html += '</div>';
   html += '</div>';

   return html;

}

function clearTooltips() {

   if ( hoverTip )
      hoverTip.remove();

   if ( clickTips )
      $.each( clickTips, function ( i, t ) { t.remove(); });

   hoverTip = null;
   clickTips = null;

}

function bindEvents ( plot ) {

   $('#evolutie_graph_rezultate').on('plothover', function ( event, pos, item ) {
       var ofs = { height: 0, width: 0 },fmtd;
       if ( clickTips ) return;
       clearTooltips();
       if (item) {
          fmtd = item.series.data[item.dataIndex][1];
          hoverTip = $(toolTipHTML( fmtd, item.series.label ));
          $('.bars-wrapper').append(hoverTip);
          ofs.height = hoverTip.outerHeight();
          ofs.width = hoverTip.outerWidth();
          hoverTip.offset({ left: item.pageX - ofs.width / 2, top: item.pageY - ofs.height + 15 });
       }
   });

  $('#evolutie_graph_rezultate').on('plotclick', function ( event, pos, item ) {
      var x = 0, ttip, fmtd, dp, pz, tmp, xtickl,
          ofs = { pageX: 0, pageY: 0, height: 0, width: 0, plotX: 0, plotY: 0 },
          axis = plot.getAxes(),
          series = plot.getData(),
          xcnt = series[0].data.length;
      plot.unhighlight();
      clearTooltips();
      if ( item ) {
         clickTips = [];
         tmp = $('#evolutie_graph_rezultate').offset();
         ofs.plotX = tmp.left;
         ofs.plotY = tmp.top;

         tmp = plot.getPlotOffset();
         ofs.plotX += tmp.left;
         ofs.plotY += tmp.top;

         xtickl = Math.ceil(xcnt / 12);
         for ( ;x<xcnt;x+=xtickl ) {
            plot.highlight(item.seriesIndex, x);
            pz = series[item.seriesIndex].datapoints.pointsize;
            dp = [ series[item.seriesIndex].datapoints.points[x*pz], series[item.seriesIndex].datapoints.points[x*pz+1] ];
            fmtd = series[item.seriesIndex].data[x][1];
            ofs.pageX = parseInt(axis.xaxis.p2c(dp[0]) + ofs.plotX);
            ofs.pageY = parseInt(axis.yaxis.p2c(dp[1]) + ofs.plotY);
            ttip = $(toolTipHTML( fmtd, (item.dataIndex == x ? item.series.label : null) ));
            $('.bars-wrapper').append(ttip);
            ofs.width = ttip.outerWidth();
            ofs.height = ttip.outerHeight();
            ttip.offset({ left: ofs.pageX - ofs.width / 2, top: ofs.pageY - ofs.height - 15 });
            clickTips[x] = ttip;
         }
      }
   });
}

function drawSeriesHook(plot, canvascontext, series) {
      
            var ctx = canvascontext,
                plotOffset = plot.offset(),
                labelText = 'VALUES', // customise this text, maybe to series.label
                points = series.datapoints.points,
                ps = series.datapoints.pointsize,
                xaxis = series.xaxis,
                yaxis = series.yaxis,
                textWidth, textHeight, textX, textY;
            // only draw label for top yellow series
            if (series.last) {
                    
                ctx.save();
                ctx.translate(7, 3);

                ctx.lineWidth = series.bars.lineWidth;
                ctx.fillStyle = '#000'; // customise the colour here
				
				var j=0;
                for (var i = 0; i < points.length; i += ps) {
                    if (points[i] == null) continue;

					//set the hook LABEL
					
                    labelText = '{/literal}{$TXT['VENITURI_TOTALE']}{literal}: '+dataVenituriLabel[j];
                    
					
                    textWidth = ctx.measureText(labelText).width; // measure how wide the label will be
                    textHeight = parseInt(ctx.font); // extract the font size from the context.font string
                    textX = xaxis.p2c(points[i] + series.bars.barWidth / 2) - textWidth/2;
                    textY = yaxis.p2c(points[i + 1]) - textHeight / 2;
                    ctx.fillText(labelText, textX, textY); // draw the label
					j++;
                }
                ctx.restore();
            }
        }
   clearTooltips();
  
	//dataRezultate
   var plot = $.plot($('#evolutie_graph_rezultate'), dataRezultate , {
         legend: { show: false },
         lines: { show: false },
         series: { stack: true, bars: { show: true, barWidth: 0.7, align: 'center',fillColor: {colors: [{opacity: 1}, {opacity: 0.7}]}}},
         yaxis: { min: 0 },
         xaxis: {  
			ticks:[
				{/literal}{foreach from=$balanteSelectate item=balanta name=balantaLoop}
					[ {$smarty.foreach.balantaLoop.index}, "{$lunileAnului[$balanta->luna]} {$balanta->an}"]
					{if not $smarty.foreach.balantaLoop.last} , {/if} 
				{/foreach}{literal}
			]},
         grid: { hoverable: true, clickable: true, autoHighlight: true },
		 hooks: { drawSeries: [drawSeriesHook]}
      });

   bindEvents( plot );



			
			 
			

				

			 
				
		
		}

    };

}();
</script>

{/literal}