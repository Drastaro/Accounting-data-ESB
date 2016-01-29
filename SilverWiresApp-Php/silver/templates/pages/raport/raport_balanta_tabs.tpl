<!-- Content Header (Page header) -->
<div class="page-head">
		<!-- BEGIN PAGE TITLE -->
		<div class="page-title">
		 <h1>{$companie->name} {if $balantaCurenta!=null}- {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}{/if}</h1>
        <!-- <small>Analiza financiara de management si business intelligence</small></h1>-->		
		</div>
		<!-- END PAGE TITLE -->
		<!-- BEGIN PAGE TOOLBAR -->
		<div class="page-toolbar">			
			<div class="btn-group pull-right">								
				<!--<a class="btn btn-md blue hidden-print margin-bottom-5 margin-right-5" onclick="javascript:window.print();">
						Print <i class="fa fa-print"></i>
				</a>-->
				<button type="button" class="btn btn-fit-height red-haze dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000" data-close-others="true" aria-expanded="false">
				Alege o alta luna<i class="fa fa-angle-down"></i>
				</button>
				<ul class="dropdown-menu pull-right" role="menu">
					{assign var=balante value=$companie->balante}
						{foreach item=b from=$balante name=bList}
							<li>
								<a href="/raport_balanta?cid={$companie->id}&bid={$b->id}">{$b->an}&nbsp;{$lunileAnului[$b->luna]}</a>
							</li>														
						{/foreach}
				</ul>
			</div>
		</div>
		<!-- END PAGE TOOLBAR -->
</div>

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
			{if $balantaCurenta!=null}
			<div class="tab-content">
				<div class="tab-pane active" id="tab_1">
					<div class="row">
						<div class="col-md-12">
							{include file="pages/raport/raport_balanta_rezultate.tpl"}
						</div>
					</div>
				</div>
				<div class="tab-pane" id="tab_2">
					<div class="row">
						<div class="col-md-12">
							{include file="pages/raport/raport_balanta_venituri.tpl"}
						</div>
					</div>
				</div>
			
				<div class="tab-pane" id="tab_3">
					<div class="row">
						<div class="col-md-12">
							{include file="pages/raport/raport_balanta_cheltuieli.tpl"}
						</div>
					</div>
				</div>
				
				<div class="tab-pane" id="tab_4">
					<div class="row">
						<div class="col-md-12">
							{include file="pages/raport/raport_balanta_activ.tpl"}
						</div>
					</div>
				</div>
				
				<div class="tab-pane" id="tab_5">
					<div class="row">
						<div class="col-md-12">
							{include file="pages/raport/raport_balanta_pasiv.tpl"}
						</div>
					</div>
				</div>
				
				<div class="tab-pane" id="tab_6">
					{include file="pages/raport/raport_balanta_indicatori.tpl"}
				</div>
			</div>
			{else}
				<div class="tab-content">
					<div class="tab-pane active">
						<div class="note note-info">
							<p class="block">Compania <b>{$companie->name}</b> nu are incarcata nici o balanta.</p>
							<p>
								 Pentru a putea accesa analiza financiara trebuie sa incarcati cel putin o balanta. <br/><br/>
								 <a class="btn blue btn-xs" href="{'/'|url}balante_add?cid={$companie->id}">Adauga balanta</a>
							</p>
						</div>
					</div>
				</div>
			{/if}
		</div>
	</div>
</div>


{if $balantaCurenta==null}
{literal}
<script>
var TabeleRaportLunar = function() {
	var cheltuieliValLunara=true;
	var cheltuieliSelectedData='cheltuieli_totale';
	var venituriValLunara=true;
	var venituriSelectedData='venituri_totale';
	
   return {

        //main function to initiate the module
        init: function () {
        }
	}
}();
</script>
{/literal}
{else}
{literal}
<script>
var TabeleRaportLunar = function() {
	var cheltuieliValLunara=true;
	var cheltuieliSelectedData='cheltuieli_totale';
	var venituriValLunara=true;
	var venituriSelectedData='venituri_totale';
	
   return {

        //main function to initiate the module
        init: function () {
			
            if (!jQuery().plot) {
                return;
            }
		
			moneyFormat();
			
           TabeleRaportLunar.initTables();
           TabeleRaportLunar.initGraphRezultate();
           TabeleRaportLunar.initGraphVenituri();
		   TabeleRaportLunar.initGraphCheltuieli();
		   TabeleRaportLunar.initGraphActive();
		   TabeleRaportLunar.initGraphPasive();
            
        },

		initGraphRezultate: function () {  
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
				
				var plot=TabeleRaportLunar.generateDonutChart("#rezultate_graph","#rezultate_details",dataRezultateTotale, false, false);
				TabeleRaportLunar.showItemDetailsOne("#rezultate_details",plot.getData()[0]);
				TabeleRaportLunar.showItemDetailsOne("#rezultate_details2",plot.getData()[1]);
				TabeleRaportLunar.updatePlotLabel("#donutLabelRezultate",'{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}','{/literal}{$TXT["VENITURI_TOTALE"]}{literal}', '{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->value()}{literal}');
				
				$("#rezultate_option_luna").click(function() {					
					var period='{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
					var labelText='{/literal}{$TXT["VENITURI_TOTALE"]}{literal}';
					var labelValue='{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->value()}{literal}';
					TabeleRaportLunar.updatePlotLabel("#donutLabelRezultate",period,labelText,labelValue);					
					plot.setData(dataRezultateTotale);
					plot.draw();
					TabeleRaportLunar.showItemDetailsOne("#rezultate_details",plot.getData()[0]);
					TabeleRaportLunar.showItemDetailsOne("#rezultate_details2",plot.getData()[1]);
				});
				$("#rezultate_option_cumulat").click(function() {
					var period='IANUARIE - {/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
					var labelText='{/literal}{$TXT["VENITURI_TOTALE"]}{literal}';
					var labelValue='{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->valueCumulated()}{literal}';
					TabeleRaportLunar.updatePlotLabel("#donutLabelRezultate",period,labelText,labelValue);					
					plot.setData(dataRezultateTotaleCumulat);
					plot.draw();
					TabeleRaportLunar.showItemDetailsOne("#rezultate_details",plot.getData()[0]);
					TabeleRaportLunar.showItemDetailsOne("#rezultate_details2",plot.getData()[1]);
				});
				
		},
	
		initGraphVenituri: function () {  
				{/literal}{assign var=listaItems value=['CIFRA_DE_AFACERI', 'ALTE_VENITURI_DIN_EXPLOATARE', 'VENITURI_FINANCIARE', 'VENITURI_EXTRAORDINARE']}{literal}
				var dataVenituriTotale= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
								{
									label: "{/literal}{$TXT[$i]}{literal}",
									data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
									percentOf: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"								
								}
										{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];	
				var dataVenituriTotaleCumulat= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
							{
								label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->valueCumulated()}{literal},
								percentOf: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"								
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];	
				{/literal}{assign var=listaItems value=['VENITURI_DIN_VANZAREA_PRODUSELOR_FINITE', 'VENITURI_DIN_VANZAREA_SEMIFABRICATELOR_SI_PRODUSELOR_REZIDUALE', 'VENITURI_DIN_SERVICII_PRESTATE', 'VENITURI_DIN_STUDII_SI_CERCETARI', 'VENITURI_DIN_REDEVENTE_LOCATII_DE_GESTIUNE_SI_CHIRII', 'VENITURI_DIN_VANZAREA_MARFURILOR', 'VENITURI_DIN_ACTIVITATI_DIVERSE', 'REDUCERI_COMERCIALE_ACORDATE', 'VENITURI_DIN_SUBVENTII_DE_EXPLOATARE_AFERENTE_CIFREI_DE_AFACERI']}{literal}
				var dataCifraAfaceri= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
								{
									label: "{/literal}{$TXT[$i]}{literal}",
									data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
									percentOf: "{/literal}{$TXT['CIFRA_DE_AFACERI']}{literal}",
									percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
									percentOf2: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"									
								}
										{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];	
				var dataCifraAfaceriCumulat= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
							{
								label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->valueCumulated()}{literal},
								percentOf: "{/literal}{$TXT['CIFRA_DE_AFACERI']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valueCumulatedPercent()}{literal},
								percentOf2: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"								
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];	
				{/literal}{assign var=listaItems value=['VENITURI_AFERENTE_COSTULUI_PRODUCTIEI_IN_CURS_DE_EXECUTIE','VENITURI_DIN_PRODUCTIA_DE_IMOBILIZARI','VENITURI_DIN_DESPAGUBIRI_AMENZI_SI_PENALITATI','VENITURI_DIN_DONATII_PRIMITE','VENITURI_DIN_VANZAREA_ACTIVELOR_SI_ALTE_OPERATII_DE_CAPITAL','VENITURI_DIN_SUBVENTII_PENTRU_INVESTITII','ALTE_VENITURI_OCAZIONALE_DIN_EXPLOATARE']}{literal}
				var dataAlteVenituriExploatare= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
								{
									label: "{/literal}{$TXT[$i]}{literal}",
									data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
									percentOf: "{/literal}{$TXT['ALTE_VENITURI_DIN_EXPLOATARE']}{literal}",
									percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
									percentOf2: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"									
								}
										{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];	
				var dataAlteVenituriExploatareCumulat= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
							{
								label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->valueCumulated()}{literal},
								percentOf: "{/literal}{$TXT['ALTE_VENITURI_DIN_EXPLOATARE']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valueCumulatedPercent()}{literal},
								percentOf2: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"								
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];					
			 
				var plot=TabeleRaportLunar.generateDonutChart("#venituri_graph","#venituri_details",dataVenituriTotale, false);
				TabeleRaportLunar.updatePlotLabel("#donutLabelVenituri",'{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}','{/literal}{$TXT["VENITURI_TOTALE"]}{literal}', '{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->value()}{literal}');
				TabeleRaportLunar.venituriValLunara=true;
				
				$("#venituri_option_luna").click(function() {					
					var period='{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
					var labelText='';
					var labelValue='';
					switch(TabeleRaportLunar.venituriSelectedData) {						
						case 'venituri_cifra_afaceri':
								labelText='{/literal}{$TXT["CIFRA_DE_AFACERI"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["CIFRA_DE_AFACERI"]->value()}{literal}';
								plot=TabeleRaportLunar.generateDonutChart("#venituri_graph","#venituri_details",dataCifraAfaceri, true);
								break;
						case 'alte_venituri_exploatare':
								labelText='{/literal}{$TXT["ALTE_VENITURI_DIN_EXPLOATARE"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["ALTE_VENITURI_DIN_EXPLOATARE"]->value()}{literal}';
								plot=TabeleRaportLunar.generateDonutChart("#venituri_graph","#venituri_details",dataAlteVenituriExploatare, true);
								break;
						default:
								labelText='{/literal}{$TXT["VENITURI_TOTALE"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->value()}{literal}';
								plot=TabeleRaportLunar.generateDonutChart("#venituri_graph","#venituri_details",dataVenituriTotale, false);
								break;
					}
					TabeleRaportLunar.updatePlotLabel("#donutLabelVenituri",period,labelText,labelValue);					
					TabeleRaportLunar.venituriValLunara=true;
				});
				$("#venituri_option_cumulat").click(function() {
					var period='IANUARIE - {/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
					var labelText='';
					var labelValue='';
					switch(TabeleRaportLunar.venituriSelectedData) {						
						case 'venituri_cifra_afaceri':
								labelText='{/literal}{$TXT["CIFRA_DE_AFACERI"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["CIFRA_DE_AFACERI"]->valueCumulated()}{literal}';
								plot=TabeleRaportLunar.generateDonutChart("#venituri_graph","#venituri_details",dataCifraAfaceri, true);
								break;
						case 'alte_venituri_exploatare':
								labelText='{/literal}{$TXT["ALTE_VENITURI_DIN_EXPLOATARE"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["ALTE_VENITURI_DIN_EXPLOATARE"]->valueCumulated()}{literal}';
								plot=TabeleRaportLunar.generateDonutChart("#venituri_graph","#venituri_details",dataAlteVenituriExploatareCumulat, true);
								break;
						default:
								labelText='{/literal}{$TXT["VENITURI_TOTALE"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->valueCumulated()}{literal}';
								plot=TabeleRaportLunar.generateDonutChart("#venituri_graph","#venituri_details",dataVenituriTotaleCumulat, false);
								break;
					}
					TabeleRaportLunar.updatePlotLabel("#donutLabelVenituri",period,labelText,labelValue);
					TabeleRaportLunar.venituriValLunara=false;
				});
				$("#graph_show_cifra_afaceri").click( function () {
								updateGraphDataAndLabel(dataCifraAfaceri, dataCifraAfaceriCumulat,'{/literal}{$TXT["CIFRA_DE_AFACERI"]}{literal}','{/literal}{$valoriRaportLunar["CIFRA_DE_AFACERI"]->value()}{literal}','{/literal}{$valoriRaportLunar["CIFRA_DE_AFACERI"]->valueCumulated()}{literal}',"venituri_cifra_afaceri",true)}); 
				
				$("#graph_show_alte_venituri_exploatare").click(function () {
								updateGraphDataAndLabel(dataAlteVenituriExploatare, dataAlteVenituriExploatareCumulat,'{/literal}{$TXT["ALTE_VENITURI_DIN_EXPLOATARE"]}{literal}','{/literal}{$valoriRaportLunar["ALTE_VENITURI_DIN_EXPLOATARE"]->value()}{literal}','{/literal}{$valoriRaportLunar["ALTE_VENITURI_DIN_EXPLOATARE"]->valueCumulated()}{literal}',"alte_venituri_exploatare",true)}); 
				
				$("#graph_show_venituriTotale").click(function () {
								updateGraphDataAndLabel(dataVenituriTotale, dataVenituriTotaleCumulat,'{/literal}{$TXT["VENITURI_TOTALE"]}{literal}','{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->value()}{literal}','{/literal}{$valoriRaportLunar["VENITURI_TOTALE"]->valueCumulated()}{literal}',"venituri_totale",false)}); 
				
				function updateGraphDataAndLabel(data, dataCumulat, labelText, labelValue, labelValueCumulat, selectedDataVal, hasTwoItems) {
					var period='';
					if(TabeleRaportLunar.venituriValLunara) {
						period='{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';						
						TabeleRaportLunar.updatePlotLabel("#donutLabelVenituri",period,labelText,labelValue);
						plot=TabeleRaportLunar.generateDonutChart("#venituri_graph","#venituri_details",data, hasTwoItems);
					} else {
						period='IANUARIE - {/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
						TabeleRaportLunar.updatePlotLabel("#donutLabelVenituri",period,labelText,labelValueCumulat);
						plot=TabeleRaportLunar.generateDonutChart("#venituri_graph","#venituri_details",dataCumulat,hasTwoItems);
					}					
					TabeleRaportLunar.venituriSelectedData=selectedDataVal;	
				}
		
		},
		initGraphCheltuieli: function () {  
				{/literal}{assign var=listaItems value=['CHELTUIELI_MATERIALE', 'CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI','CHELTUIELI_DE_PERSONAL','SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE','ALTE_CHELTUIELI_DE_EXPLOATARE','CHELTUIELI_FINANCIARE', 'CHELTUIELI_EXTRAORDINARE', 'IMPOZIT_PE_PROFIT' ]}{literal}
				var dataCheltuieliTotale= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
							{
								label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
								percentOf: "{/literal}{$TXT['CHELTUIELI_TOTALE']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
								percentOf2: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];								
				var dataCheltuieliTotaleCumulat= [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
							{
								label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->valueCumulated()}{literal},
								percentOf: "{/literal}{$TXT['CHELTUIELI_TOTALE']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valueCumulatedPercent()}{literal},
								percentOf2: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];	
				{/literal}{assign var=listaItemsCheltuieliMateriale value=['CHELTUIELI_CU_MATERIILE_PRIME', 'CHELTUIELI_CU_MATERIALELE_CONSUMABILE','CHELTUIELI_CU_OBIECTELE_DE_INVENTAR_MATERIALELE_NESTOCATE_SI_AMBALAJELE','CHELTUIELI_PRIVIND_ENERGIA_SI_APA','CHELTUIELI_PRIVIND_ANIMALELE_SI_PASARILE','CHELTUIELI_PRIVIND_MARFURILE', 'REDUCERI_COMERCIALE_PRIMITE' ]}{literal}
				var dataCheltuieliMateriale	= [
					{/literal}{foreach from=$listaItemsCheltuieliMateriale item=i name=itemsLoop}{literal}
							{
								label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
								percentOf: "{/literal}{$TXT['CHELTUIELI_MATERIALE']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
								percentOf2: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];	
				var dataCheltuieliMaterialeCumulat	= [
					{/literal}{foreach from=$listaItemsCheltuieliMateriale item=i name=itemsLoop}{literal}
							{
								label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->valueCumulated()}{literal},
								percentOf: "{/literal}{$TXT['CHELTUIELI_MATERIALE']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valueCumulatedPercent()}{literal},
								percentOf2: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];
				{/literal}{assign var=listaItemsCheltuieliServicii value=['CHELTUIELI_CU_INTRETINEREA_SI_REPARATIILE','CHELTUIELI_CU_REDEVENTE_SI_CHIRII','CHELTUIELI_CU_PRIMELE_DE_ASIGURARE','CHELTUIELI_CU_STUDIILE_SI_CERCETARILE','CHELTUIELI_CU_COLABORATORII','CHELTUIELI_PRIVIND_COMISIOANELE_SI_ONORARIILE','CHELTUIELI_DE_PROTOCOL_RECLAMA_SI_PUBLICITATE','CHELTUIELI_CU_TRANSPORTUL_DE_BUNURI_SI_PERSONAL_DETASARI_TRASFERARI','CHELTUIELI_POSTALE_SI_TAXE_DE_TELECOMUNICATII','CHELTUIELI_CU_SERVICIILE_BANCARE','ALTE_CHELTUIELI_CU_SERVICIILE_EXECUTATE_DE_TERTI']}{literal}
				var dataCheltuieliServicii	= [
					{/literal}{foreach from=$listaItemsCheltuieliServicii item=i name=itemsLoop}{literal}
							{
								label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
								percentOf: "{/literal}{$TXT['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
								percentOf2: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];	
				var dataCheltuieliServiciiCumulat	= [
					{/literal}{foreach from=$listaItemsCheltuieliServicii item=i name=itemsLoop}{literal}
							{
								label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->valueCumulated()}{literal},
								percentOf: "{/literal}{$TXT['CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valueCumulatedPercent()}{literal},
								percentOf2: "{/literal}{$TXT['VENITURI_TOTALE']}{literal}"
							}
							{/literal}{if not $smarty.foreach.itemsLoop.last},{/if} 
					{/foreach}{literal}
				];

				var plot=TabeleRaportLunar.generateDonutChart("#cheltuieli_graph","#cheltuieli_details",dataCheltuieliTotale, true);
				TabeleRaportLunar.updatePlotLabel("#donutLabelCheltuieli",'{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}','{/literal}{$TXT["CHELTUIELI_TOTALE"]}{literal}', '{/literal}{$valoriRaportLunar["CHELTUIELI_TOTALE"]->value()}{literal}');
				TabeleRaportLunar.cheltuieliValLunara=true;				
				
				$("#cheltuieli_option_luna").click(function() {					
					var period='{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
					var labelText='';
					var labelValue='';
					switch(TabeleRaportLunar.cheltuieliSelectedData) {						
						case 'cheltuieli_materiale':
								plot.setData(dataCheltuieliMateriale);
								labelText='{/literal}{$TXT["CHELTUIELI_MATERIALE"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["CHELTUIELI_MATERIALE"]->value()}{literal}';
								break;
						case 'cheltuieli_servicii':
								plot.setData(dataCheltuieliServicii);
								labelText='{/literal}{$TXT["CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI"]->value()}{literal}';
								break;
						default:
								plot.setData(dataCheltuieliTotale);
								labelText='{/literal}{$TXT["CHELTUIELI_TOTALE"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["CHELTUIELI_TOTALE"]->value()}{literal}';
								break;
					}	
					TabeleRaportLunar.updatePlotLabel("#donutLabelCheltuieli",period,labelText,labelValue);					
					plot.draw();
					TabeleRaportLunar.showItemDetailsTwo("#cheltuieli_details",plot.getData()[0]);
					TabeleRaportLunar.cheltuieliValLunara=true;
				});
				$("#cheltuieli_option_cumulat").click(function() {
					var period='IANUARIE - {/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
					var labelText='';
					var labelValue='';
					switch(TabeleRaportLunar.cheltuieliSelectedData) {						
						case 'cheltuieli_materiale':
								plot.setData(dataCheltuieliMaterialeCumulat);
								labelText='{/literal}{$TXT["CHELTUIELI_MATERIALE"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["CHELTUIELI_MATERIALE"]->valueCumulated()}{literal}';
								break;
						case 'cheltuieli_servicii':
								plot.setData(dataCheltuieliServiciiCumulat);
								labelText='{/literal}{$TXT["CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI"]->valueCumulated()}{literal}';
								break;
						default:
								plot.setData(dataCheltuieliTotaleCumulat);
								labelText='{/literal}{$TXT["CHELTUIELI_TOTALE"]}{literal}';
								labelValue='{/literal}{$valoriRaportLunar["CHELTUIELI_TOTALE"]->valueCumulated()}{literal}';
								break;
					}
					TabeleRaportLunar.updatePlotLabel("#donutLabelCheltuieli",period,labelText,labelValue);
					plot.draw();
					TabeleRaportLunar.showItemDetailsTwo("#cheltuieli_details",plot.getData()[0]);
					TabeleRaportLunar.cheltuieliValLunara=false;
				});
				$("#graph_show_cheltuieliMateriale").click( function () {
								updateGraphDataAndLabel(dataCheltuieliMateriale, dataCheltuieliMaterialeCumulat,'{/literal}{$TXT["CHELTUIELI_MATERIALE"]}{literal}','{/literal}{$valoriRaportLunar["CHELTUIELI_MATERIALE"]->value()}{literal}','{/literal}{$valoriRaportLunar["CHELTUIELI_MATERIALE"]->valueCumulated()}{literal}',"cheltuieli_materiale")}); 
				
				$("#graph_show_cheltuieliTotale").click(function () {
								updateGraphDataAndLabel(dataCheltuieliTotale, dataCheltuieliTotaleCumulat,'{/literal}{$TXT["CHELTUIELI_TOTALE"]}{literal}','{/literal}{$valoriRaportLunar["CHELTUIELI_TOTALE"]->value()}{literal}','{/literal}{$valoriRaportLunar["CHELTUIELI_TOTALE"]->valueCumulated()}{literal}',"cheltuieli_totale")}); 
				
				$("#graph_show_cheltuieliServicii").click(function () {
								updateGraphDataAndLabel(dataCheltuieliServicii, dataCheltuieliServiciiCumulat,'{/literal}{$TXT["CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI"]}{literal}','{/literal}{$valoriRaportLunar["CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI"]->value()}{literal}','{/literal}{$valoriRaportLunar["CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI"]->valueCumulated()}{literal}',"cheltuieli_servicii")}); 
				
				function updateGraphDataAndLabel(data, dataCumulat, labelText, labelValue, labelValueCumulat, selectedDataVal) {
					var period='';
					if(TabeleRaportLunar.cheltuieliValLunara) {
						period='{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
						plot.setData(data);
						TabeleRaportLunar.updatePlotLabel("#donutLabelCheltuieli",period,labelText,labelValue);
					} else {
						period='IANUARIE - {/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
						plot.setData(dataCumulat);						
						TabeleRaportLunar.updatePlotLabel("#donutLabelCheltuieli",period,labelText,labelValueCumulat);
					}
					plot.draw();
					TabeleRaportLunar.showItemDetailsTwo("#cheltuieli_details",plot.getData()[0]);
					TabeleRaportLunar.cheltuieliSelectedData=selectedDataVal;	
				}
				
				
		
		},
		
		createBarChart: function(targetId, data) {
			$.plot(targetId, data, {	
					legend: {
						labelBoxBorderColor: "none",
						position: "right"
					},
					series: {
						bars: {
							show: true,
							barWidth: 0.07,
							lineWidth: 0,
							order: 1, // Include this line to ensure the bars will appear side by side.
							fillColor: {
								colors: [{
									opacity: 1
								}, {
									opacity: 0.7
								}]
							}
						}
					},
					xaxis: {
						mode: "categories", // Include this line so the bars are grouped.
						tickLength: 0
					},
					grid: {
						hoverable: true,
						clickable: false,
						borderWidth: 0
					}
				});

				function showTooltip(x, y, contents) {
					$('<div id="flot-tooltip1">' + contents + '</div>').css({
						position: 'absolute',
						top: y - 20,
						left: x - 90,						
						display: 'none',
						border: '1px solid #333',
						'text-align': 'center',
						padding: '4px',
						color: "#fff",
						'background-color': '#333',
						opacity: '0.8'
					}).appendTo("body").show();
				}

			 
				$(targetId).bind("plothover", function (event, pos, item) {
					var previousPoint;					
					if (item) {
						if (previousPoint != item.datapoint) {
							previousPoint = item.datapoint;
							$("#flot-tooltip1").remove();
			 
							var originalPoint;
			 
							if (item.datapoint[0] == item.series.data[0][3]) {
								originalPoint = item.series.data[0][0];
							} else if (item.datapoint[0] == item.series.data[1][3]){
								originalPoint = item.series.data[1][0];
							} else if (item.datapoint[0] == item.series.data[2][3]){
								originalPoint = item.series.data[2][0];
							} else if (item.datapoint[0] == item.series.data[3][3]){
								originalPoint = item.series.data[3][0];
							} else if (item.datapoint[0] == item.series.data[4][3]){
								originalPoint = item.series.data[4][0];
							}
			 
							var x = originalPoint;
							y = item.datapoint[1];
							z = item.series.color;
			 
							showTooltip(item.pageX, item.pageY,
								"<b>" + item.series.label + "</b><br /> " + x + " = " + y,
								z);
						}
					} else {
						$("#flot-tooltip1").remove();
						previousPoint = null;
					}
				});
		
		},
		initGraphActive: function () {
				{/literal}{assign var=listaItems value=['DISPONIBIL_IN_CASERIE_SI_BANCA','INVESTITII_PE_TERMEN_SCURT','CREANTE', 'STOCURI', 'CHELTUIELI_IN_AVANS', 'IMOBILIZARI_NECORPORALE','IMOBILIZARI_CORPORALE','IMOBILIZARI_FINANCIARE' ]}{literal}
				var dataTotalActiv = [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
						{		label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
								percentOf: "{/literal}{$TXT['TOTAL_ACTIV']}{literal}"
						}{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
					{/foreach}{literal}];
				{/literal}{assign var=listaItems value=['CONTURI_LA_BANCI','CASA','ACREDITIVE_ALTE_VALORI_VIRAMENTE_INTERNE','AVANSURI_DE_TREZORERIE']}{literal}
				var dataCaserie = [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
						{		label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
								percentOf: "{/literal}{$TXT['DISPONIBIL_IN_CASERIE_SI_BANCA']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
								percentOf2: "{/literal}{$TXT['TOTAL_ACTIV']}{literal}"
						}{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
					{/foreach}{literal}];
				{/literal}{assign var=listaItems value=['CLIENTI','FURNIZORI_DEBITORI','CREANTE_FATA_DE_PERSONALUL_ANGAJAT','CREANTE_FATA_DE_BUGETUL_DE_STAT','SUBVENTII','CREANTE_FATA_DE_GRUP','ALTE_CREANTE','AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR']}{literal}
				var dataCreante = [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
						{		label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
								percentOf: "{/literal}{$TXT['CREANTE']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
								percentOf2: "{/literal}{$TXT['TOTAL_ACTIV']}{literal}"
						}{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
					{/foreach}{literal}];
				{/literal}{assign var=listaItems value=['STOCURI_DE_MATERII_PRIME_SI_MATERIALE','STOCURI_IN_CURS_DE_APROVIZIONARE','PRODUCTIA_IN_CURS_DE_EXECUTIE','PRODUSE','STOCURI_AFLATE_LA_TERTI','ANIMALE_SI_PASARI','MARFURI','AMBALAJE','AJUSTARI_PENTRU_DEPREC_STOCURILOR']}{literal}
				var dataStocuri = [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
						{		label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
								percentOf: "{/literal}{$TXT['STOCURI']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
								percentOf2: "{/literal}{$TXT['TOTAL_ACTIV']}{literal}"
						}{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
					{/foreach}{literal}];
				{/literal}{assign var=listaItems value=['TERENURI_SI_AMENAJARI_LA_TERENURI','CONSTRUCTII','INSTALATII_TEHNICE_MIJ_TRANS','MOBILIER_BIROTICA_ECHIP_PROTECTIE','IMOBILIZARI_IN_CURS_DE_APROVIZIONARE_AVANSURI_ACORDATE','AMORTIZARI_PRIVIND_IMOBILIZARILE_CORPORALE']}{literal}
				var dataImobilizariCorporale = [
					{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
						{		label: "{/literal}{$TXT[$i]}{literal}",
								data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
								percentOf: "{/literal}{$TXT['IMOBILIZARI_CORPORALE']}{literal}",
								percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
								percentOf2: "{/literal}{$TXT['TOTAL_ACTIV']}{literal}"
						}{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
					{/foreach}{literal}];
						
				TabeleRaportLunar.generateDonutChart("#graph_active","#active_details",dataTotalActiv,false);
				TabeleRaportLunar.updatePlotLabel("#donutLabelActive",'{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}','{/literal}{$TXT["TOTAL_ACTIV"]}{literal}', '{/literal}{$valoriRaportLunar["TOTAL_ACTIV"]->value()}{literal}');
				
				$("#graph_show_caserie").click( function () {
								updateGraphDataAndLabel(dataCaserie, '{/literal}{$TXT["DISPONIBIL_IN_CASERIE_SI_BANCA"]}{literal}','{/literal}{$valoriRaportLunar["DISPONIBIL_IN_CASERIE_SI_BANCA"]->value()}{literal}',true)}); 
				
				$("#graph_show_creante").click(function () {
								updateGraphDataAndLabel(dataCreante, '{/literal}{$TXT["CREANTE"]}{literal}','{/literal}{$valoriRaportLunar["CREANTE"]->value()}{literal}',true)}); 
				
				$("#graph_show_stocuri").click(function () {
								updateGraphDataAndLabel(dataStocuri, '{/literal}{$TXT["STOCURI"]}{literal}','{/literal}{$valoriRaportLunar["STOCURI"]->value()}{literal}',true)}); 				
				$("#graph_show_imobilizaricorporale").click(function () {
								updateGraphDataAndLabel(dataImobilizariCorporale, '{/literal}{$TXT["IMOBILIZARI_CORPORALE"]}{literal}','{/literal}{$valoriRaportLunar["IMOBILIZARI_CORPORALE"]->value()}{literal}',true)});
				$("#graph_show_totalactiv").click(function () {
								updateGraphDataAndLabel(dataTotalActiv, '{/literal}{$TXT["TOTAL_ACTIV"]}{literal}','{/literal}{$valoriRaportLunar["TOTAL_ACTIV"]->value()}{literal}',false)});
				
				function updateGraphDataAndLabel(data, labelText, labelValue,hasTwoItems) {
					var period='{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
					TabeleRaportLunar.updatePlotLabel("#donutLabelActive",period,labelText,labelValue);	
					TabeleRaportLunar.generateDonutChart("#graph_active","#active_details",data,hasTwoItems);
				}
						
		},
		
		initGraphPasive: function () {
			
			{/literal}{assign var=listaItems value=['DATORII_PE_TERMEN_SCURT','DATORII_PE_TERMEN_MEDIU_SI_LUNG','SUBVENTII_PENTRU_INVESTITII', 'VENITURI_INREGISTRATE_IN_AVANS', 'FOND_COMERCIAL_NEGATIV', 'PROVIZIOANE','CAPITALURI_PROPRII']}{literal}
			var dataTotalPasiv = [
				{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
					{
							label: "{/literal}{$TXT[$i]}{literal}",
							data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
							percentOf: "{/literal}{$TXT['TOTAL_PASIV']}{literal}"
						}
							{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
				{/foreach}{literal}
				];
			{/literal}{assign var=listaItems value=['DATORII_FATA_DE_FURNIZORI','CLIENTI_CREDITORI','DATORII_FATA_DE_PERSONAL_PASIV',
										'DATORII_FATA_DE_BUGETUL_DE_STAT','DATORII_FATA_DE_GRUP','DATORII_FATA_DE_ASOCIATI','DATORII_FATA_DE_BANCI']}{literal}
			var dataDatoriiTermScurt = [
				{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
					{		label: "{/literal}{$TXT[$i]}{literal}",
							data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
							percentOf: "{/literal}{$TXT['DATORII_PE_TERMEN_SCURT']}{literal}",
							percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
							percentOf2: "{/literal}{$TXT['TOTAL_PASIV']}{literal}"
					}{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
				{/foreach}{literal}];
			{/literal}{assign var=listaItems value=['CAPITAL_SI_REZERVE','REZULTAT_REPORTAT', 'REZULTATUL_EXERCITIULUI','ALTE_CASTIGURI_PASIV','REPARTIZAREA_PROFITULUI']}{literal}
			var dataCapitaluri = [
			{/literal}{foreach from=$listaItems item=i name=itemsLoop}{literal}
				{		label: "{/literal}{$TXT[$i]}{literal}",
						data: {/literal}{$valoriRaportLunar[$i]->value()}{literal},
						percentOf: "{/literal}{$TXT['CAPITALURI_PROPRII']}{literal}",
						percent2: {/literal}{$valoriRaportLunar[$i]->valuePercent()}{literal},
						percentOf2: "{/literal}{$TXT['TOTAL_PASIV']}{literal}"
				}{/literal}{if not $smarty.foreach.itemsLoop.last} , {/if} 
			{/foreach}{literal}];
						
			TabeleRaportLunar.generateDonutChart("#graph_pasive","#pasive_details",dataTotalPasiv,false);				
			TabeleRaportLunar.updatePlotLabel("#donutLabelPasive",'{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}','{/literal}{$TXT["TOTAL_PASIV"]}{literal}', '{/literal}{$valoriRaportLunar["TOTAL_PASIV"]->value()}{literal}');
				
			$("#graph_show_datoriitermscurt").click( function () {
							updateGraphDataAndLabel(dataDatoriiTermScurt, '{/literal}{$TXT["DATORII_PE_TERMEN_SCURT"]}{literal}','{/literal}{$valoriRaportLunar["DATORII_PE_TERMEN_SCURT"]->value()}{literal}',true)}); 
			
			$("#graph_show_capitaluriproprii").click(function () {
							updateGraphDataAndLabel(dataCapitaluri, '{/literal}{$TXT["CAPITALURI_PROPRII"]}{literal}','{/literal}{$valoriRaportLunar["CAPITALURI_PROPRII"]->value()}{literal}',true)}); 				
			$("#graph_show_totalpasiv").click(function () {
							updateGraphDataAndLabel(dataTotalPasiv, '{/literal}{$TXT["TOTAL_PASIV"]}{literal}','{/literal}{$valoriRaportLunar["TOTAL_PASIV"]->value()}{literal}',false)});
							
			function updateGraphDataAndLabel(data, labelText, labelValue,hasTwoItems) {
					var period='{/literal}{$lunileAnului[$balantaCurenta->luna]} {$balantaCurenta->an}{literal}';
					TabeleRaportLunar.updatePlotLabel("#donutLabelPasive",period,labelText,labelValue);	
					TabeleRaportLunar.generateDonutChart("#graph_pasive","#pasive_details",data,hasTwoItems);
				}
				
		},
		
		updatePlotLabel: function (labelID,period,text,value) {
			$(labelID).find('.donut-label-perioada').text(period);
			$(labelID).find('.donut-label-text').text(text);
			$(labelID).find('.donut-label-value').html('<span class="money_top">'+value+'</span>'+'{/literal}<small>{$LABEL['currency']}</small>{literal}');
		},
		
		generateDonutChart: function(targetGraphId, targetDetailsId, data, showTwoPercentValues, showItemOnHover) {
			if (typeof showItemOnHover === "undefined") { var showItemOnHover=true;}
			var graphPlot=$.plot($(targetGraphId), data, {
                    series: {
                        pie: {
							innerRadius: 0.6,
                            show: true/*,
                            combine: {
                                color: '#999',
								label: 'Altele',
                                threshold: 0.01
                            }*/
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
					TabeleRaportLunar.showItemDetailsTwo(targetDetailsId,graphPlot.getData()[0]);					
				} else {
					TabeleRaportLunar.showItemDetailsOne(targetDetailsId,graphPlot.getData()[0]);
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
									TabeleRaportLunar.showItemDetailsTwo(targetDetailsId,item.series);
								} else {
									TabeleRaportLunar.showItemDetailsOne(targetDetailsId,item.series);
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
					'<div class="display"><div class="number"><h3 style="color:'+itemSeries.color+'"><span class="money_top">'+itemSeries.data[0][1]+'</span><small>{/literal}{$LABEL["currency"]}{literal}</small></h3></span><small>'+ itemSeries.label+'</small></div></div>'+
					'<div class="progress-info"><div class="progress"><span style="width: '+percent+'%;background:'+itemSeries.color+'" class="progress-bar progress-bar-success"></span></div>'+
					'<div class="status"><div class="status-title">Procent din '+percentOf+'</div><div class="status-number">'+percent+'%</div></div></div>'+
				'</div>';			
			/*htmlContent=htmlContent+'<div class="item_details">'+
						'Descriere pe cateva randuri ce inseamna fiecare valoare si cum influenteaza mersul afacerii. Descriere pe cateva randuri ce inseamna fiecare valoare si cum influenteaza mersul afacerii.'+
						'</div>';*/
			$(targetDetailsId).html(htmlContent);	
			moneyTopFormat();			
			$(targetDetailsId).show();
		},
				
		showItemDetailsTwo: function (targetDetailsId,itemSeries) {				
			var percent = parseFloat(itemSeries.percent).toFixed(2);					
			var percentOf=itemSeries.percentOf? itemSeries.percentOf:"";
			
			var percent2 = parseFloat(itemSeries.percent2).toFixed(2);					
			var percentOf2=itemSeries.percentOf2? itemSeries.percentOf2:"";
			
			$(targetDetailsId).html(
				'<div class="dashboard-stat2">'+
					'<div class="display"><div class="number"><h3 style="color:'+itemSeries.color+'"><span class="money_top">'+itemSeries.data[0][1]+'</span><small>{/literal}{$LABEL["currency"]}{literal}</small></h3><small>'+ itemSeries.label+'</small></div></div>'+
					'<div class="progress-info"><div class="progress"><span style="width: '+percent+'%;background:'+itemSeries.color+'" class="progress-bar progress-bar-success"></span></div>'+
					'<div class="status"><div class="status-title">Procent din '+percentOf+'</div><div class="status-number">'+percent+'%</div></div></div>'+
					'<div class="progress-info" style="padding-top:10px"><div class="progress"><span style="width: '+percent2+'%;background:'+itemSeries.color+'" class="progress-bar progress-bar-success"></span></div>'+
					'<div class="status"><div class="status-title">Procent din '+percentOf2+'</div><div class="status-number">'+percent2+'%</div></div></div>'+
				'</div>'/*+
				'<div class="item_details">'+
								'Descriere pe cateva randuri ce inseamna fiecare valoare si cum influenteaza mersul afacerii. Descriere pe cateva randuri ce inseamna fiecare valoare si cum influenteaza mersul afacerii.'+
				'</div>'*/
			);
			moneyTopFormat();
			$(targetDetailsId).show();
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
	 
	 }

    };

}();

</script>
{/literal}
{/if}