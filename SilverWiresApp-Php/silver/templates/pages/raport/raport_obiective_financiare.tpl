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
				<button type="button" class="btn btn-fit-height red-sunglo dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="100" data-close-others="true" aria-expanded="false">
				Alege o alta luna <i class="fa fa-angle-down"></i>
				</button>
				<ul class="dropdown-menu pull-right" role="menu">
					{assign var=balante value=$companie->balante}
								{foreach item=b from=$balante name=bList}
									<li>
										<a href="/obiective_financiare?cid={$companie->id}&bid={$b->id}">{$b->an}&nbsp;{$lunileAnului[$b->luna]}</a>
									</li>														
								{/foreach}										
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

{if $balantaCurenta!=null && $balantaPrecedenta!=null}
<!-- BEGIN PAGE CONTENT-->

<div class="row margin-top-10">
	<div class="col-md-12">
		<div class="portlet light">
			<div class="portlet-title">
				<div class="caption font-purple-plum">
					<i class="icon-pie-chart font-blue-madison"></i>
					<span class="caption-subject text-primary bold uppercase font-blue-madison">
					Obiective financiare {$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
					</span>
					<span class="caption-helper">Evolutie fata de {$lunileAnului[$balantaPrecedenta->luna]}&nbsp;{$balantaPrecedenta->an}</span>
				</div>
			</div>
			<div class="portlet-body">
				<div class="row">
					{foreach item=c from=$cards name=cList}	
					<form action="" method="post" id="form_{$c->id}">
						<input type="hidden" name="id" value="{$c->id}" id="">
						<input type="hidden" name="company_id" value="{$c->company_id}" id="">
						<input type="hidden" name="balanta_id" value="{$balantaCurenta->id}" id="">
						<input type="hidden" name="type" value="{$c->type}" id="">
						<input type="hidden" name="item_id" value="{$c->item_id}" id="">
						<input type="hidden" name="item_label" value="{$c->item_label}" id="">
						<input type="hidden" name="operation" value="{$c->operation}" id="">
						<input type="hidden" name="target_value" value="{$c->target_value}" id="">
						<input type="hidden" name="valueType_label" value="{$c->valueType_label}" id="">
					</form>					
					<div class="col-md-3">
						<div class="portlet light kpi-portlet bordered-card">
							<div class="kpi-stat-obiectiv">
								<h4 class="profile-desc-title">
									Obiectiv&nbsp;&nbsp;<a href="#basic" data-toggle="modal" onclick="showCard('#form_{$c->id}');" class="btn btn-sm btn-default"><i class="icon-pencil"></i></a>					
								</h4>
								<span class="profile-desc-text"> {$c->objectiveText()} </span>
							</div>
							<div class="kpi-stat-realizare">
								<h4 class="profile-desc-title">Realizare</h4>
							</div>
							<div class="kpi-knob" align=center>						
									<input class="knob" value="{$c->realizationPercent($valoriRaportLunar,$valoriRaportPrecedent)}">
							</div>			
							<div class="kpi-title">
								<div class="kpi-title-month">
									{$lunileAnului[$balantaCurenta->luna]}&nbsp;{$balantaCurenta->an}
								</div>
								<div class="kpi-title-name">
									  {$c->itemLabel()}
								</div>				
								<div class="kpi-title-value">
									 {$c->reportValue($valoriRaportLunar)}
								</div>
								{if $c->type==2}
								<div class="kpi-title-value2">
									{$c->reportValuePercent($valoriRaportLunar)} <small>din {$TXT['VENITURI_TOTALE']}</small>
								</div>
								{/if}
							</div>		
							<div class="row list-separated kpi-stat">
								<div class="col-md-6 col-sm-6 col-xs-6">
									<div class="uppercase kpi-stat-title">
										{if $c->type==2}
											{$c->reportValuePercent($valoriRaportPrecedent)}
										{else}
											{$c->reportValue($valoriRaportPrecedent)}
										{/if}
									</div>
									<div class="uppercase kpi-stat-text">
										 {$lunileAnului[$balantaPrecedenta->luna]}&nbsp;{$balantaPrecedenta->an}
									</div>
								</div>
								<div class="col-md-4 col-sm-4 col-xs-4">
									<div class="uppercase kpi-stat-title">
									{if $c->trendDirection($valoriRaportLunar,$valoriRaportPrecedent)==-1}
										 <span class="glyphicon glyphicon-arrow-down">
										</span>
									{else if $c->trendDirection($valoriRaportLunar,$valoriRaportPrecedent)==1}
										 <span class="glyphicon glyphicon-arrow-up">
										</span>
									{else}
										<span class="glyphicon glyphicon-arrow-minus">
										</span>
									{/if}
										{$c->trendPercent($valoriRaportLunar,$valoriRaportPrecedent)}%
									</div>
									<div class="uppercase kpi-stat-text">
										 Trend
									</div>
								</div>
								<div class="col-md-2 col-sm-2 col-xs-2">
									<div class="uppercase kpi-stat-title">
										{if $c->status($valoriRaportLunar,$valoriRaportPrecedent)==1}
											<span class=" glyphicon glyphicon-ok font-green"></span>
										{else}
											<span class=" glyphicon glyphicon-remove font-red-sunglo"></span>
										{/if}
									</div>
									<div class="uppercase kpi-stat-text">
										 Status
									</div>
								</div>
							</div>
							
						</div>
					</div>
					{if $smarty.foreach.cList.iteration is div by 4}						
						</div>
						<div class="row">
					{/if}
					{/foreach}
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="basic" tabindex="-1" role="basic" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title">Modal Title</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form" id="form_type0"  method="post">
					<input type="hidden" name="id" value=""/>
					<input type="hidden" name="cid" value=""/>
					<input type="hidden" name="bid" value=""/>
					<input type="hidden" name="mode" value="edit-card"/>
					<input type="hidden" name="item_label" value=""/>
					<input type="hidden" name="valueType_label" value="currency"/>
					
					
					<div class="form-group">
						<label class="col-md-3 control-label">Tip card</label>
						<div class="col-md-9">
							<select class="form-control" name="type">
								<option value=0 selected>Crestere/reducere lunara</option>
								<option value=1>Valoare lunara</option>
								<option value=2>Valoare pondere lunara din total venituri</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Indicatorul</label>
						<div class="col-md-9">
							<select class="form-control input-large select2me input-sm" data-placeholder="Alege indicatorul..." name="item">
								<option value="1" data-label="CAPITALURI_PROPRII">Capitaluri proprii</option>		
<option value="2" data-label="CAPITAL_SI_REZERVE">Capital si rezerve</option>		
<option value="3" data-label="REZULTAT_REPORTAT">Rezultatul reportat</option>		
<option value="4" data-label="REZULTATUL_EXERCITIULUI">Rezultatul exercitiului</option>		
<option value="5" data-label="ALTE_CASTIGURI_PASIV">Alte castiguri/pierderi din operatii de capital, actiuni proprii</option>
<option value="6" data-label="PROVIZIOANE">Provizioane</option>		
<option value="7" data-label="SUBVENTII_PENTRU_INVESTITII">Subventii pentru investitii</option>		
<option value="8" data-label="VENITURI_INREGISTRATE_IN_AVANS">Venituri inregistrate in avans</option>		
<option value="9" data-label="FOND_COMERCIAL_NEGATIV">Fond comercial negativ</option>		
<option value="10" data-label="DATORII_PE_TERMEN_MEDIU_SI_LUNG">DATORII pe termen mediu si lung (scadenta peste 1 an)</option>
<option value="11" data-label="DATORII_FATA_DE_FURNIZORI">Datorii fata de furnizori</option>		
<option value="12" data-label="CLIENTI_CREDITORI">Clienti creditori</option>		
<option value="13" data-label="DATORII_FATA_DE_PERSONAL_PASIV">Datorii fata de personal</option>		
<option value="14" data-label="DATORII_FATA_DE_BUGETUL_DE_STAT">Datorii fata de bugetul de stat</option>		
<option value="17" data-label="DATORII_FATA_DE_GRUP">Datorii fata de grup</option>		
<option value="18" data-label="DATORII_FATA_DE_ASOCIATI">Datorii fata de asociati si dividende de plata</option>		
<option value="19" data-label="CREDITORI_DIVERSI">Creditori diversi</option>		
<option value="20" data-label="DECONTARI_IN_CADRUL_UNITATII_PASIV">Decontari in cadrul unitatii</option>		
<option value="21" data-label="OPERATIUNI_IN_CURS_DE_CLARIFICARE_PASIV">Operatiuni in curs de clarificare</option>		
<option value="22" data-label="VARSAM_DE_EFECTUAT_PENTRU_INVESTITIILE_PE_T_S">Varsam. de efectuat pentru investitiile pe t.s.</option>		
<option value="23" data-label="DATORII_FATA_DE_BANCI">Datorii fata de banci</option>		
<option value="24" data-label="IMOBILIZARI_NECORPORALE">Imobilizari necorporale</option>		
<option value="25" data-label="IMOBILIZARI_NECOROPRALE_VALOARE_DE_INTRARE">Imobilizari necoroprale - valoare de intrare</option>		
<option value="26" data-label="AMORTIZARE_SI_AJUSTARI_IMOBILIZARI_NECORPORALE">Amortizare si ajustari privind imobilizarile necorporale</option>		
<option value="27" data-label="IMOBILIZARI_CORPORALE">Imobilizari corporale</option>		
<option value="28" data-label="TERENURI_SI_AMENAJARI_LA_TERENURI">Terenuri si amenajari la terenuri</option>		
<option value="29" data-label="CONSTRUCTII">Constructii</option>		
<option value="30" data-label="INSTALATII_TEHNICE_MIJ_TRANS">Instalatii tehnice, mij trans, animale si plantatii</option>		
<option value="31" data-label="MOBILIER_BIROTICA_ECHIP_PROTECTIE">Mobilier, ap birotica, echip de protectie</option>		
<option value="33" data-label="IMOBILIZARI_IN_CURS_DE_APROVIZIONARE_AVANSURI_ACORDATE">Imobilizari in curs de aprovizionare/executie, avansuri acordate</option>		
<option value="34" data-label="AMORTIZARI_PRIVIND_IMOBILIZARILE_CORPORALE">Amortizari si ajustari privind imobilizarile corporale</option>		
<option value="35" data-label="IMOBILIZARI_FINANCIARE">Imobilizari financiare</option>		
<option value="36" data-label="ACTIVE_IMOBILIZATE">Active imobilizate</option>		
<option value="37" data-label="STOCURI">Stocuri</option>		
<option value="38" data-label="STOCURI_DE_MATERII_PRIME_SI_MATERIALE">Stocuri de materii prime si materiale</option>		
<option value="39" data-label="STOCURI_IN_CURS_DE_APROVIZIONARE">Stocuri in curs de aprovizionare</option>		
<option value="40" data-label="PRODUCTIA_IN_CURS_DE_EXECUTIE">Productia in curs de executie</option>		
<option value="41" data-label="PRODUSE">Produse (semifabricate, finite, reziduale)</option>		
<option value="42" data-label="STOCURI_AFLATE_LA_TERTI">Stocuri aflate la terti</option>		
<option value="43" data-label="ANIMALE_SI_PASARI">Animale si pasari</option>		
<option value="44" data-label="MARFURI">Marfuri</option>		
<option value="45" data-label="AMBALAJE">Ambalaje</option>		
<option value="46" data-label="AJUSTARI_PENTRU_DEPREC_STOCURILOR">Ajustari pentru deprec. stocurilor</option>		
<option value="47" data-label="CREANTE">Creante</option>		
<option value="48" data-label="CLIENTI">Clienti</option>		
<option value="49" data-label="FURNIZORI_DEBITORI">Furnizori debitori</option>		
<option value="50" data-label="CREANTE_FATA_DE_PERSONALUL_ANGAJAT">Creante fata de personalul angajat</option>		
<option value="51" data-label="CREANTE_FATA_DE_BUGETUL_DE_STAT">Creante fata de bugetul de stat</option>		
<option value="54" data-label="SUBVENTII">Subventii</option>		
<option value="55" data-label="CREANTE_FATA_DE_GRUP">Creante fata de grup</option>		
<option value="56" data-label="DEBITORI_DIVERSI">Debitori diversi</option>		
<option value="57" data-label="OPERATIUNI_IN_CURS_DE_CLARIFICARE_ACTIV">Operatiuni in curs de clarificare</option>		
<option value="58" data-label="DECONTARI_IN_CADRUL_UNITATII_ACTIV">Decontari in cadrul unitatii</option>		
<option value="59" data-label="DOBANZI_DE_PRIMIT">Dobanzi de primit</option>		
<option value="60" data-label="AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR">Ajustari pentru deprecierea creantelor</option>		
<option value="61" data-label="INVESTITII_PE_TERMEN_SCURT">Investitii pe termen scurt</option>		
<option value="62" data-label="DISPONIBIL_IN_CASERIE_SI_BANCA">Disponibil in caserie si banca</option>		
<option value="63" data-label="CONTURI_LA_BANCI">Conturi la banci</option>		
<option value="64" data-label="CASA">Casa</option>		
<option value="65" data-label="ACREDITIVE_ALTE_VALORI_VIRAMENTE_INTERNE">Acreditive, alte valori, viramente interne</option>		
<option value="66" data-label="AVANSURI_DE_TREZORERIE">Avansuri de trezorerie</option>		
<option value="67" data-label="ACTIVE_CIRCULANTE">Active circulante</option>		
<option value="68" data-label="CHELTUIELI_IN_AVANS">Cheltuieli in avans</option>		
<option value="69" data-label="TOTAL_ACTIV">Total activ</option>		
<option value="70" data-label="CIFRA_DE_AFACERI">Cifra de afaceri</option>		
<option value="71" data-label="VENITURI_DIN_VANZAREA_PRODUSELOR_FINITE">Venituri din vanzarea produselor finite</option>		
<option value="72" data-label="VENITURI_DIN_VANZAREA_SEMIFABRICATELOR_SI_PRODUSELOR_REZIDUALE">Venituri din vanzarea semifabricatelor si produselor reziduale</option>		
<option value="73" data-label="VENITURI_DIN_SERVICII_PRESTATE">Venituri din servicii prestate</option>		
<option value="74" data-label="VENITURI_DIN_STUDII_SI_CERCETARI">Venituri din studii si cercetari</option>		
<option value="75" data-label="VENITURI_DIN_REDEVENTE_LOCATII_DE_GESTIUNE_SI_CHIRII">Venituri din redevente, locatii de gestiune si chirii</option>		
<option value="76" data-label="VENITURI_DIN_VANZAREA_MARFURILOR">Venituri din vanzarea marfurilor</option>		
<option value="77" data-label="VENITURI_DIN_ACTIVITATI_DIVERSE">Venituri din activitati diverse</option>		
<option value="78" data-label="REDUCERI_COMERCIALE_ACORDATE">Reduceri comerciale acordate</option>		
<option value="79" data-label="VENITURI_DIN_SUBVENTII_DE_EXPLOATARE_AFERENTE_CIFREI_DE_AFACERI">Venituri din subventii de exploatare aferente cifrei de afaceri</option>		
<option value="80" data-label="CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI">Cheltuieli pentru realizarea cifrei de afaceri</option>		
<option value="81" data-label="CHELTUIELI_MATERIALE">Cheltuieli materiale</option>		
<option value="82" data-label="CHELTUIELI_CU_MATERIILE_PRIME">Cheltuieli cu materiile prime</option>		
<option value="83" data-label="CHELTUIELI_CU_MATERIALELE_CONSUMABILE">Cheltuieli cu materialele consumabile</option>		
<option value="84" data-label="CHELTUIELI_CU_OBIECTELE_DE_INVENTAR_MATERIALELE_NESTOCATE_SI_AMBALAJELE">Cheltuieli cu obiectele de inventar , materialele nestocate si ambalajele</option>		
<option value="85" data-label="CHELTUIELI_PRIVIND_ENERGIA_SI_APA">Cheltuieli privind energia si apa</option>		
<option value="86" data-label="CHELTUIELI_PRIVIND_ANIMALELE_SI_PASARILE">Cheltuieli privind animalele si pasarile</option>		
<option value="87" data-label="CHELTUIELI_PRIVIND_MARFURILE">Cheltuieli privind marfurile</option>		
<option value="88" data-label="REDUCERI_COMERCIALE_PRIMITE">Reduceri comerciale primite</option>		
<option value="89" data-label="CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI">Cheltuieli cu servicii prestate de terti</option>		
<option value="90" data-label="CHELTUIELI_CU_INTRETINEREA_SI_REPARATIILE">Cheltuieli cu intretinerea si reparatiile</option>		
<option value="91" data-label="CHELTUIELI_CU_REDEVENTE_SI_CHIRII">Cheltuieli cu redevente si chirii</option>		
<option value="92" data-label="CHELTUIELI_CU_PRIMELE_DE_ASIGURARE">Cheltuieli cu primele de asigurare</option>		
<option value="93" data-label="CHELTUIELI_CU_STUDIILE_SI_CERCETARILE">Cheltuieli cu studiile si cercetarile</option>		
<option value="94" data-label="CHELTUIELI_CU_COLABORATORII">Cheltuieli cu colaboratorii</option>		
<option value="95" data-label="CHELTUIELI_PRIVIND_COMISIOANELE_SI_ONORARIILE">Cheltuieli privind comisioanele si onorariile</option>		
<option value="96" data-label="CHELTUIELI_DE_PROTOCOL_RECLAMA_SI_PUBLICITATE">Cheltuieli de protocol, reclama si publicitate</option>		
<option value="97" data-label="CHELTUIELI_CU_TRANSPORTUL_DE_BUNURI_SI_PERSONAL_DETASARI_TRASFERARI">Cheltuieli cu transportul de bunuri si personal, detasari, trasferari</option>		
<option value="98" data-label="CHELTUIELI_POSTALE_SI_TAXE_DE_TELECOMUNICATII">Cheltuieli postale si taxe de telecomunicatii</option>		
<option value="99" data-label="CHELTUIELI_CU_SERVICIILE_BANCARE">Cheltuieli cu serviciile bancare</option>		
<option value="100" data-label="ALTE_CHELTUIELI_CU_SERVICIILE_EXECUTATE_DE_TERTI">Alte cheltuieli cu serviciile executate de terti</option>		
<option value="101" data-label="CHELTUIELI_DE_PERSONAL">Cheltuieli de personal</option>		
<option value="102" data-label="PROFIT_AFERENT_ACTIVITATII_DE_BAZA">Profit aferent activitatii de baza</option>		
<option value="103" data-label="ALTE_VENITURI_DIN_EXPLOATARE">Alte venituri din exploatare</option>		
<option value="104" data-label="VENITURI_AFERENTE_COSTULUI_PRODUCTIEI_IN_CURS_DE_EXECUTIE">Venituri aferente costului productiei in curs de executie</option>		
<option value="105" data-label="VENITURI_DIN_PRODUCTIA_DE_IMOBILIZARI">Venituri din productia de imobilizari</option>		
<option value="106" data-label="SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE">Subventii primite pentru cheltuieli de exploatare</option>		
<option value="108" data-label="VENITURI_DIN_DESPAGUBIRI_AMENZI_SI_PENALITATI">Venituri din despagubiri, amenzi si penalitati</option>		
<option value="109" data-label="VENITURI_DIN_DONATII_PRIMITE">Venituri din donatii primite</option>		
<option value="110" data-label="VENITURI_DIN_VANZAREA_ACTIVELOR_SI_ALTE_OPERATII_DE_CAPITAL">Venituri din vanzarea activelor si alte operatii de capital</option>		
<option value="111" data-label="VENITURI_DIN_SUBVENTII_PENTRU_INVESTITII">Venituri din subventii pentru investitii</option>		
<option value="112" data-label="ALTE_VENITURI_OCAZIONALE_DIN_EXPLOATARE">Alte venituri ocazionale din exploatare</option>		
<option value="114" data-label="ALTE_CHELTUIELI_DE_EXPLOATARE">Alte cheltuieli de exploatare</option>		
<option value="115" data-label="CHELTUIELI_CU_ALTE_IMPOZITE_TAXE_SI_VARSAMINTE_ASIMILATE">Cheltuieli cu alte impozite, taxe si varsaminte asimilate</option>		
<option value="116" data-label="CHELTUIELI_CU_PROTECTIA_MEDIULUI_INCONJURATOR">Cheltuieli cu protectia mediului inconjurator</option>		
<option value="118" data-label="DESPAGUBIRI_AMENZI_SI_PENALITATI">Despagubiri, amenzi si penalitati</option>		
<option value="119" data-label="DONATII_ACORDATE">Donatii acordate</option>		
<option value="120" data-label="CHELTUIELI_PRIVIND_ACTIVELE_CEDATE_SI_ALTE_OPERATII_DE_CAPITAL">Cheltuieli privind activele cedate si alte operatii de capital</option>		
<option value="121" data-label="ALTE_CHELTUIELI_OCAZIONALE_DE_EXPLOATARE">Alte cheltuieli ocazionale de exploatare</option>		
<option value="122" data-label="CHELTUIELI_CU_AMORTIZAREA_AJUSTARI_DE_VALOARE_SI_PROVIZIOANELE">Cheltuieli cu amortizarea, ajustari de valoare si provizioanele </option>		
<option value="123" data-label="TOTAL_VENITURI_DIN_EXPLOATARE">Total venituri din exploatare</option>		
<option value="124" data-label="TOTAL_CHELTUIELI_DE_EXPLOATARE">Total cheltuieli de exploatare</option>		
<option value="125" data-label="PROFIT_DIN_EXPLOATARE">Profit din  exploatare</option>		
<option value="126" data-label="VENITURI_FINANCIARE">Venituri financiare</option>		
<option value="127" data-label="VENITURI_DIN_DOBANZI">Venituri din dobanzi</option>		
<option value="128" data-label="VENITURI_DIN_DIFERENTE_DE_CURS_VALUTAR">Venituri din diferente de curs valutar</option>		
<option value="129" data-label="VENITURI_DIN_SCONTURI_OBTINUTE">Venituri din sconturi obtinute</option>		
<option value="130" data-label="ALTE_VENITURI_FINANCIARE">Alte venituri financiare</option>		
<option value="131" data-label="VENITURI_EXTRAORDINARE">Venituri extraordinare</option>		
<option value="132" data-label="CHELTUIELI_FINANCIARE">Cheltuieli financiare</option>		
<option value="133" data-label="CHELTUIELI_PRIVIND_DOBANZILE">Cheltuieli privind dobanzile</option>		
<option value="134" data-label="CHELTUIELI_DIN_DIFERENTE_DE_CURS_VALUTAR">Cheltuieli din diferente de curs valutar </option>
<option value="135" data-label="CHELTUIELI_PRIVIND_SCONTURILE_ACORDATE">Cheltuieli privind sconturile acordate </option>		
<option value="136" data-label="ALTE_CHELTUIELI_FINANCIARE">Alte cheltuieli financiare</option>		
<option value="137" data-label="CHELTUIELI_EXTRAORDINARE">Cheltuieli extraordinare</option>		
<option value="138" data-label="PROFIT_DIN_ACTIVITATEA_FINANCIARA">Profit din activitatea financiara</option>		
<option value="139" data-label="VENITURI_TOTALE">Venituri totale</option>		
<option value="140" data-label="CHELTUIELI_TOTALE_INAINTE_IMPOZITARE">Cheltuieli totale inainte  de impozitare</option>		
<option value="141" data-label="PROFIT_BRUT">Profit brut</option>		
<option value="142" data-label="IMPOZIT_PE_PROFIT">Cheltuieli cu impozitul pe profit</option>		
<option value="143" data-label="PROFIT_NET">Profit net</option>		
<option value="145" data-label="VENITURI_IN_AVANS">Venituri in avans</option>		
<option value="146" data-label="DATORII_PE_TERMEN_SCURT">DATORII pe termen scurt (scadenta sub 1 an)</option>		
<option value="147" data-label="TOTAL_DATORII">Total datorii</option>		
<option value="148" data-label="ALTE_DATORII">Alte datorii</option>		
<option value="149" data-label="REPARTIZAREA_PROFITULUI">Repartizarea profitului</option>		
<option value="150" data-label="TOTAL_PASIV">Total pasiv</option>		
<option value="160" data-label="ALTE_CREANTE">Alte creante</option>		
<option value="161" data-label="PROFIT_DIN_ACTIVITATEA_EXTRAORDINARA">Profit din activitatea extraordinara</option>		
<option value="162" data-label="EBITDA">EBITDA</option>		
<option value="164" data-label="EBIT">EBIT</option>		
<option value="165" data-label="CHELTUIELI_TOTALE">Cheltuieli totale</option>		
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Evolutie</label>
						<div class="col-md-9">
							<div class="radio-list">
								<label class="radio-inline">
								<input type="radio" name="operation"  value="0" checked="">sa cresca </label>
								<label class="radio-inline">
								<input type="radio" name="operation"  value="1" checked="">sa scada </label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Valoare tinta</label>
						<div class="col-md-9">
							<input type="text" name="target_value" class="form-control input-inline input-medium" placeholder="Valoarea tinta">%
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label"></label>
						<div class="col-md-9">
							<p class="form-control-static">
								 fata de luna precedenta
							</p>
						</div>
					</div>
				</form>
				<form class="form-horizontal" role="form" id="form_type1" method="post">
					<input type="hidden" name="id" value=""/>
					<input type="hidden" name="cid" value=""/>
					<input type="hidden" name="bid" value=""/>
					<input type="hidden" name="mode" value="edit-card"/>
					<input type="hidden" name="item_label" value=""/>
					<input type="hidden" name="valueType_label" value="currency"/>
					<div class="form-group">
						<label class="col-md-3 control-label">Tip card</label>
						<div class="col-md-9">
							<select class="form-control" name="type">
								<option value=0>Crestere/reducere lunara</option>
								<option value=1 selected>Valoare lunara</option>
								<option value=2>Valoare pondere lunara din total venituri</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Indicatorul</label>
						<div class="col-md-9">							
							<select class="form-control input-large select2me input-sm" data-placeholder="Alege indicatorul..." name="item">
<option value="1" data-label="CAPITALURI_PROPRII">Capitaluri proprii</option>		
<option value="2" data-label="CAPITAL_SI_REZERVE">Capital si rezerve</option>		
<option value="3" data-label="REZULTAT_REPORTAT">Rezultatul reportat</option>		
<option value="4" data-label="REZULTATUL_EXERCITIULUI">Rezultatul exercitiului</option>		
<option value="5" data-label="ALTE_CASTIGURI_PASIV">Alte castiguri/pierderi din operatii de capital, actiuni proprii</option>
<option value="6" data-label="PROVIZIOANE">Provizioane</option>		
<option value="7" data-label="SUBVENTII_PENTRU_INVESTITII">Subventii pentru investitii</option>		
<option value="8" data-label="VENITURI_INREGISTRATE_IN_AVANS">Venituri inregistrate in avans</option>		
<option value="9" data-label="FOND_COMERCIAL_NEGATIV">Fond comercial negativ</option>		
<option value="10" data-label="DATORII_PE_TERMEN_MEDIU_SI_LUNG">DATORII pe termen mediu si lung (scadenta peste 1 an)</option>
<option value="11" data-label="DATORII_FATA_DE_FURNIZORI">Datorii fata de furnizori</option>		
<option value="12" data-label="CLIENTI_CREDITORI">Clienti creditori</option>		
<option value="13" data-label="DATORII_FATA_DE_PERSONAL_PASIV">Datorii fata de personal</option>		
<option value="14" data-label="DATORII_FATA_DE_BUGETUL_DE_STAT">Datorii fata de bugetul de stat</option>		
<option value="17" data-label="DATORII_FATA_DE_GRUP">Datorii fata de grup</option>		
<option value="18" data-label="DATORII_FATA_DE_ASOCIATI">Datorii fata de asociati si dividende de plata</option>		
<option value="19" data-label="CREDITORI_DIVERSI">Creditori diversi</option>		
<option value="20" data-label="DECONTARI_IN_CADRUL_UNITATII_PASIV">Decontari in cadrul unitatii</option>		
<option value="21" data-label="OPERATIUNI_IN_CURS_DE_CLARIFICARE_PASIV">Operatiuni in curs de clarificare</option>		
<option value="22" data-label="VARSAM_DE_EFECTUAT_PENTRU_INVESTITIILE_PE_T_S">Varsam. de efectuat pentru investitiile pe t.s.</option>		
<option value="23" data-label="DATORII_FATA_DE_BANCI">Datorii fata de banci</option>		
<option value="24" data-label="IMOBILIZARI_NECORPORALE">Imobilizari necorporale</option>		
<option value="25" data-label="IMOBILIZARI_NECOROPRALE_VALOARE_DE_INTRARE">Imobilizari necoroprale - valoare de intrare</option>		
<option value="26" data-label="AMORTIZARE_SI_AJUSTARI_IMOBILIZARI_NECORPORALE">Amortizare si ajustari privind imobilizarile necorporale</option>		
<option value="27" data-label="IMOBILIZARI_CORPORALE">Imobilizari corporale</option>		
<option value="28" data-label="TERENURI_SI_AMENAJARI_LA_TERENURI">Terenuri si amenajari la terenuri</option>		
<option value="29" data-label="CONSTRUCTII">Constructii</option>		
<option value="30" data-label="INSTALATII_TEHNICE_MIJ_TRANS">Instalatii tehnice, mij trans, animale si plantatii</option>		
<option value="31" data-label="MOBILIER_BIROTICA_ECHIP_PROTECTIE">Mobilier, ap birotica, echip de protectie</option>		
<option value="33" data-label="IMOBILIZARI_IN_CURS_DE_APROVIZIONARE_AVANSURI_ACORDATE">Imobilizari in curs de aprovizionare/executie, avansuri acordate</option>		
<option value="34" data-label="AMORTIZARI_PRIVIND_IMOBILIZARILE_CORPORALE">Amortizari si ajustari privind imobilizarile corporale</option>		
<option value="35" data-label="IMOBILIZARI_FINANCIARE">Imobilizari financiare</option>		
<option value="36" data-label="ACTIVE_IMOBILIZATE">Active imobilizate</option>		
<option value="37" data-label="STOCURI">Stocuri</option>		
<option value="38" data-label="STOCURI_DE_MATERII_PRIME_SI_MATERIALE">Stocuri de materii prime si materiale</option>		
<option value="39" data-label="STOCURI_IN_CURS_DE_APROVIZIONARE">Stocuri in curs de aprovizionare</option>		
<option value="40" data-label="PRODUCTIA_IN_CURS_DE_EXECUTIE">Productia in curs de executie</option>		
<option value="41" data-label="PRODUSE">Produse (semifabricate, finite, reziduale)</option>		
<option value="42" data-label="STOCURI_AFLATE_LA_TERTI">Stocuri aflate la terti</option>		
<option value="43" data-label="ANIMALE_SI_PASARI">Animale si pasari</option>		
<option value="44" data-label="MARFURI">Marfuri</option>		
<option value="45" data-label="AMBALAJE">Ambalaje</option>		
<option value="46" data-label="AJUSTARI_PENTRU_DEPREC_STOCURILOR">Ajustari pentru deprec. stocurilor</option>		
<option value="47" data-label="CREANTE">Creante</option>		
<option value="48" data-label="CLIENTI">Clienti</option>		
<option value="49" data-label="FURNIZORI_DEBITORI">Furnizori debitori</option>		
<option value="50" data-label="CREANTE_FATA_DE_PERSONALUL_ANGAJAT">Creante fata de personalul angajat</option>		
<option value="51" data-label="CREANTE_FATA_DE_BUGETUL_DE_STAT">Creante fata de bugetul de stat</option>		
<option value="54" data-label="SUBVENTII">Subventii</option>		
<option value="55" data-label="CREANTE_FATA_DE_GRUP">Creante fata de grup</option>		
<option value="56" data-label="DEBITORI_DIVERSI">Debitori diversi</option>		
<option value="57" data-label="OPERATIUNI_IN_CURS_DE_CLARIFICARE_ACTIV">Operatiuni in curs de clarificare</option>		
<option value="58" data-label="DECONTARI_IN_CADRUL_UNITATII_ACTIV">Decontari in cadrul unitatii</option>		
<option value="59" data-label="DOBANZI_DE_PRIMIT">Dobanzi de primit</option>		
<option value="60" data-label="AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR">Ajustari pentru deprecierea creantelor</option>		
<option value="61" data-label="INVESTITII_PE_TERMEN_SCURT">Investitii pe termen scurt</option>		
<option value="62" data-label="DISPONIBIL_IN_CASERIE_SI_BANCA">Disponibil in caserie si banca</option>		
<option value="63" data-label="CONTURI_LA_BANCI">Conturi la banci</option>		
<option value="64" data-label="CASA">Casa</option>		
<option value="65" data-label="ACREDITIVE_ALTE_VALORI_VIRAMENTE_INTERNE">Acreditive, alte valori, viramente interne</option>		
<option value="66" data-label="AVANSURI_DE_TREZORERIE">Avansuri de trezorerie</option>		
<option value="67" data-label="ACTIVE_CIRCULANTE">Active circulante</option>		
<option value="68" data-label="CHELTUIELI_IN_AVANS">Cheltuieli in avans</option>		
<option value="69" data-label="TOTAL_ACTIV">Total activ</option>		
<option value="70" data-label="CIFRA_DE_AFACERI">Cifra de afaceri</option>		
<option value="71" data-label="VENITURI_DIN_VANZAREA_PRODUSELOR_FINITE">Venituri din vanzarea produselor finite</option>		
<option value="72" data-label="VENITURI_DIN_VANZAREA_SEMIFABRICATELOR_SI_PRODUSELOR_REZIDUALE">Venituri din vanzarea semifabricatelor si produselor reziduale</option>		
<option value="73" data-label="VENITURI_DIN_SERVICII_PRESTATE">Venituri din servicii prestate</option>		
<option value="74" data-label="VENITURI_DIN_STUDII_SI_CERCETARI">Venituri din studii si cercetari</option>		
<option value="75" data-label="VENITURI_DIN_REDEVENTE_LOCATII_DE_GESTIUNE_SI_CHIRII">Venituri din redevente, locatii de gestiune si chirii</option>		
<option value="76" data-label="VENITURI_DIN_VANZAREA_MARFURILOR">Venituri din vanzarea marfurilor</option>		
<option value="77" data-label="VENITURI_DIN_ACTIVITATI_DIVERSE">Venituri din activitati diverse</option>		
<option value="78" data-label="REDUCERI_COMERCIALE_ACORDATE">Reduceri comerciale acordate</option>		
<option value="79" data-label="VENITURI_DIN_SUBVENTII_DE_EXPLOATARE_AFERENTE_CIFREI_DE_AFACERI">Venituri din subventii de exploatare aferente cifrei de afaceri</option>		
<option value="80" data-label="CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI">Cheltuieli pentru realizarea cifrei de afaceri</option>		
<option value="81" data-label="CHELTUIELI_MATERIALE">Cheltuieli materiale</option>		
<option value="82" data-label="CHELTUIELI_CU_MATERIILE_PRIME">Cheltuieli cu materiile prime</option>		
<option value="83" data-label="CHELTUIELI_CU_MATERIALELE_CONSUMABILE">Cheltuieli cu materialele consumabile</option>		
<option value="84" data-label="CHELTUIELI_CU_OBIECTELE_DE_INVENTAR_MATERIALELE_NESTOCATE_SI_AMBALAJELE">Cheltuieli cu obiectele de inventar , materialele nestocate si ambalajele</option>		
<option value="85" data-label="CHELTUIELI_PRIVIND_ENERGIA_SI_APA">Cheltuieli privind energia si apa</option>		
<option value="86" data-label="CHELTUIELI_PRIVIND_ANIMALELE_SI_PASARILE">Cheltuieli privind animalele si pasarile</option>		
<option value="87" data-label="CHELTUIELI_PRIVIND_MARFURILE">Cheltuieli privind marfurile</option>		
<option value="88" data-label="REDUCERI_COMERCIALE_PRIMITE">Reduceri comerciale primite</option>		
<option value="89" data-label="CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI">Cheltuieli cu servicii prestate de terti</option>		
<option value="90" data-label="CHELTUIELI_CU_INTRETINEREA_SI_REPARATIILE">Cheltuieli cu intretinerea si reparatiile</option>		
<option value="91" data-label="CHELTUIELI_CU_REDEVENTE_SI_CHIRII">Cheltuieli cu redevente si chirii</option>		
<option value="92" data-label="CHELTUIELI_CU_PRIMELE_DE_ASIGURARE">Cheltuieli cu primele de asigurare</option>		
<option value="93" data-label="CHELTUIELI_CU_STUDIILE_SI_CERCETARILE">Cheltuieli cu studiile si cercetarile</option>		
<option value="94" data-label="CHELTUIELI_CU_COLABORATORII">Cheltuieli cu colaboratorii</option>		
<option value="95" data-label="CHELTUIELI_PRIVIND_COMISIOANELE_SI_ONORARIILE">Cheltuieli privind comisioanele si onorariile</option>		
<option value="96" data-label="CHELTUIELI_DE_PROTOCOL_RECLAMA_SI_PUBLICITATE">Cheltuieli de protocol, reclama si publicitate</option>		
<option value="97" data-label="CHELTUIELI_CU_TRANSPORTUL_DE_BUNURI_SI_PERSONAL_DETASARI_TRASFERARI">Cheltuieli cu transportul de bunuri si personal, detasari, trasferari</option>		
<option value="98" data-label="CHELTUIELI_POSTALE_SI_TAXE_DE_TELECOMUNICATII">Cheltuieli postale si taxe de telecomunicatii</option>		
<option value="99" data-label="CHELTUIELI_CU_SERVICIILE_BANCARE">Cheltuieli cu serviciile bancare</option>		
<option value="100" data-label="ALTE_CHELTUIELI_CU_SERVICIILE_EXECUTATE_DE_TERTI">Alte cheltuieli cu serviciile executate de terti</option>		
<option value="101" data-label="CHELTUIELI_DE_PERSONAL">Cheltuieli de personal</option>		
<option value="102" data-label="PROFIT_AFERENT_ACTIVITATII_DE_BAZA">Profit aferent activitatii de baza</option>		
<option value="103" data-label="ALTE_VENITURI_DIN_EXPLOATARE">Alte venituri din exploatare</option>		
<option value="104" data-label="VENITURI_AFERENTE_COSTULUI_PRODUCTIEI_IN_CURS_DE_EXECUTIE">Venituri aferente costului productiei in curs de executie</option>		
<option value="105" data-label="VENITURI_DIN_PRODUCTIA_DE_IMOBILIZARI">Venituri din productia de imobilizari</option>		
<option value="106" data-label="SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE">Subventii primite pentru cheltuieli de exploatare</option>		
<option value="108" data-label="VENITURI_DIN_DESPAGUBIRI_AMENZI_SI_PENALITATI">Venituri din despagubiri, amenzi si penalitati</option>		
<option value="109" data-label="VENITURI_DIN_DONATII_PRIMITE">Venituri din donatii primite</option>		
<option value="110" data-label="VENITURI_DIN_VANZAREA_ACTIVELOR_SI_ALTE_OPERATII_DE_CAPITAL">Venituri din vanzarea activelor si alte operatii de capital</option>		
<option value="111" data-label="VENITURI_DIN_SUBVENTII_PENTRU_INVESTITII">Venituri din subventii pentru investitii</option>		
<option value="112" data-label="ALTE_VENITURI_OCAZIONALE_DIN_EXPLOATARE">Alte venituri ocazionale din exploatare</option>		
<option value="114" data-label="ALTE_CHELTUIELI_DE_EXPLOATARE">Alte cheltuieli de exploatare</option>		
<option value="115" data-label="CHELTUIELI_CU_ALTE_IMPOZITE_TAXE_SI_VARSAMINTE_ASIMILATE">Cheltuieli cu alte impozite, taxe si varsaminte asimilate</option>		
<option value="116" data-label="CHELTUIELI_CU_PROTECTIA_MEDIULUI_INCONJURATOR">Cheltuieli cu protectia mediului inconjurator</option>		
<option value="118" data-label="DESPAGUBIRI_AMENZI_SI_PENALITATI">Despagubiri, amenzi si penalitati</option>		
<option value="119" data-label="DONATII_ACORDATE">Donatii acordate</option>		
<option value="120" data-label="CHELTUIELI_PRIVIND_ACTIVELE_CEDATE_SI_ALTE_OPERATII_DE_CAPITAL">Cheltuieli privind activele cedate si alte operatii de capital</option>		
<option value="121" data-label="ALTE_CHELTUIELI_OCAZIONALE_DE_EXPLOATARE">Alte cheltuieli ocazionale de exploatare</option>		
<option value="122" data-label="CHELTUIELI_CU_AMORTIZAREA_AJUSTARI_DE_VALOARE_SI_PROVIZIOANELE">Cheltuieli cu amortizarea, ajustari de valoare si provizioanele </option>		
<option value="123" data-label="TOTAL_VENITURI_DIN_EXPLOATARE">Total venituri din exploatare</option>		
<option value="124" data-label="TOTAL_CHELTUIELI_DE_EXPLOATARE">Total cheltuieli de exploatare</option>		
<option value="125" data-label="PROFIT_DIN_EXPLOATARE">Profit din  exploatare</option>		
<option value="126" data-label="VENITURI_FINANCIARE">Venituri financiare</option>		
<option value="127" data-label="VENITURI_DIN_DOBANZI">Venituri din dobanzi</option>		
<option value="128" data-label="VENITURI_DIN_DIFERENTE_DE_CURS_VALUTAR">Venituri din diferente de curs valutar</option>		
<option value="129" data-label="VENITURI_DIN_SCONTURI_OBTINUTE">Venituri din sconturi obtinute</option>		
<option value="130" data-label="ALTE_VENITURI_FINANCIARE">Alte venituri financiare</option>		
<option value="131" data-label="VENITURI_EXTRAORDINARE">Venituri extraordinare</option>		
<option value="132" data-label="CHELTUIELI_FINANCIARE">Cheltuieli financiare</option>		
<option value="133" data-label="CHELTUIELI_PRIVIND_DOBANZILE">Cheltuieli privind dobanzile</option>		
<option value="134" data-label="CHELTUIELI_DIN_DIFERENTE_DE_CURS_VALUTAR">Cheltuieli din diferente de curs valutar </option>
<option value="135" data-label="CHELTUIELI_PRIVIND_SCONTURILE_ACORDATE">Cheltuieli privind sconturile acordate </option>		
<option value="136" data-label="ALTE_CHELTUIELI_FINANCIARE">Alte cheltuieli financiare</option>		
<option value="137" data-label="CHELTUIELI_EXTRAORDINARE">Cheltuieli extraordinare</option>		
<option value="138" data-label="PROFIT_DIN_ACTIVITATEA_FINANCIARA">Profit din activitatea financiara</option>		
<option value="139" data-label="VENITURI_TOTALE">Venituri totale</option>		
<option value="140" data-label="CHELTUIELI_TOTALE_INAINTE_IMPOZITARE">Cheltuieli totale inainte  de impozitare</option>		
<option value="141" data-label="PROFIT_BRUT">Profit brut</option>		
<option value="142" data-label="IMPOZIT_PE_PROFIT">Cheltuieli cu impozitul pe profit</option>		
<option value="143" data-label="PROFIT_NET">Profit net</option>		
<option value="145" data-label="VENITURI_IN_AVANS">Venituri in avans</option>		
<option value="146" data-label="DATORII_PE_TERMEN_SCURT">DATORII pe termen scurt (scadenta sub 1 an)</option>		
<option value="147" data-label="TOTAL_DATORII">Total datorii</option>		
<option value="148" data-label="ALTE_DATORII">Alte datorii</option>		
<option value="149" data-label="REPARTIZAREA_PROFITULUI">Repartizarea profitului</option>		
<option value="150" data-label="TOTAL_PASIV">Total pasiv</option>		
<option value="160" data-label="ALTE_CREANTE">Alte creante</option>		
<option value="161" data-label="PROFIT_DIN_ACTIVITATEA_EXTRAORDINARA">Profit din activitatea extraordinara</option>		
<option value="162" data-label="EBITDA">EBITDA</option>		
<option value="164" data-label="EBIT">EBIT</option>		
<option value="165" data-label="CHELTUIELI_TOTALE">Cheltuieli totale</option>	
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Evolutie</label>
						<div class="col-md-9">
							<div class="radio-list">
								<label class="radio-inline">
								<input type="radio" name="operation"  value="2" checked="">minim </label>
								<label class="radio-inline">
								<input type="radio" name="operation"  value="3" checked="">maxim </label>
							</div>
						</div>
					</div>					
					<div class="form-group">
						<label class="col-md-3 control-label">Valoare tinta</label>
						<div class="col-md-9">
							<input type="text" name="target_value" class="form-control input-inline input-medium" placeholder="Valoarea tinta">
						</div>
					</div>					
				</form>
				<form class="form-horizontal" role="form" id="form_type2" method="post">
					<input type="hidden" name="id" value=""/>
					<input type="hidden" name="cid" value=""/>
					<input type="hidden" name="bid" value=""/>
					<input type="hidden" name="mode" value="edit-card"/>
					<input type="hidden" name="item_label" value=""/>
					<input type="hidden" name="valueType_label" value="currency"/>
					<div class="form-group">
						<label class="col-md-3 control-label">Tip card</label>
						<div class="col-md-9">
							<select class="form-control" name="type">
								<option value=0>Crestere/reducere lunara</option>
								<option value=1>Valoare lunara</option>
								<option value=2 selected>Valoare pondere lunara din total venituri</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Indicatorul</label>
						<div class="col-md-9">							
							<select class="form-control input-large select2me input-sm" data-placeholder="Alege indicatorul..." name="item">
<option value="1" data-label="CAPITALURI_PROPRII">Capitaluri proprii</option>		
<option value="2" data-label="CAPITAL_SI_REZERVE">Capital si rezerve</option>		
<option value="3" data-label="REZULTAT_REPORTAT">Rezultatul reportat</option>		
<option value="4" data-label="REZULTATUL_EXERCITIULUI">Rezultatul exercitiului</option>		
<option value="5" data-label="ALTE_CASTIGURI_PASIV">Alte castiguri/pierderi din operatii de capital, actiuni proprii</option>
<option value="6" data-label="PROVIZIOANE">Provizioane</option>		
<option value="7" data-label="SUBVENTII_PENTRU_INVESTITII">Subventii pentru investitii</option>		
<option value="8" data-label="VENITURI_INREGISTRATE_IN_AVANS">Venituri inregistrate in avans</option>		
<option value="9" data-label="FOND_COMERCIAL_NEGATIV">Fond comercial negativ</option>		
<option value="10" data-label="DATORII_PE_TERMEN_MEDIU_SI_LUNG">DATORII pe termen mediu si lung (scadenta peste 1 an)</option>
<option value="11" data-label="DATORII_FATA_DE_FURNIZORI">Datorii fata de furnizori</option>		
<option value="12" data-label="CLIENTI_CREDITORI">Clienti creditori</option>		
<option value="13" data-label="DATORII_FATA_DE_PERSONAL_PASIV">Datorii fata de personal</option>		
<option value="14" data-label="DATORII_FATA_DE_BUGETUL_DE_STAT">Datorii fata de bugetul de stat</option>		
<option value="17" data-label="DATORII_FATA_DE_GRUP">Datorii fata de grup</option>		
<option value="18" data-label="DATORII_FATA_DE_ASOCIATI">Datorii fata de asociati si dividende de plata</option>		
<option value="19" data-label="CREDITORI_DIVERSI">Creditori diversi</option>		
<option value="20" data-label="DECONTARI_IN_CADRUL_UNITATII_PASIV">Decontari in cadrul unitatii</option>		
<option value="21" data-label="OPERATIUNI_IN_CURS_DE_CLARIFICARE_PASIV">Operatiuni in curs de clarificare</option>		
<option value="22" data-label="VARSAM_DE_EFECTUAT_PENTRU_INVESTITIILE_PE_T_S">Varsam. de efectuat pentru investitiile pe t.s.</option>		
<option value="23" data-label="DATORII_FATA_DE_BANCI">Datorii fata de banci</option>		
<option value="24" data-label="IMOBILIZARI_NECORPORALE">Imobilizari necorporale</option>		
<option value="25" data-label="IMOBILIZARI_NECOROPRALE_VALOARE_DE_INTRARE">Imobilizari necoroprale - valoare de intrare</option>		
<option value="26" data-label="AMORTIZARE_SI_AJUSTARI_IMOBILIZARI_NECORPORALE">Amortizare si ajustari privind imobilizarile necorporale</option>		
<option value="27" data-label="IMOBILIZARI_CORPORALE">Imobilizari corporale</option>		
<option value="28" data-label="TERENURI_SI_AMENAJARI_LA_TERENURI">Terenuri si amenajari la terenuri</option>		
<option value="29" data-label="CONSTRUCTII">Constructii</option>		
<option value="30" data-label="INSTALATII_TEHNICE_MIJ_TRANS">Instalatii tehnice, mij trans, animale si plantatii</option>		
<option value="31" data-label="MOBILIER_BIROTICA_ECHIP_PROTECTIE">Mobilier, ap birotica, echip de protectie</option>		
<option value="33" data-label="IMOBILIZARI_IN_CURS_DE_APROVIZIONARE_AVANSURI_ACORDATE">Imobilizari in curs de aprovizionare/executie, avansuri acordate</option>		
<option value="34" data-label="AMORTIZARI_PRIVIND_IMOBILIZARILE_CORPORALE">Amortizari si ajustari privind imobilizarile corporale</option>		
<option value="35" data-label="IMOBILIZARI_FINANCIARE">Imobilizari financiare</option>		
<option value="36" data-label="ACTIVE_IMOBILIZATE">Active imobilizate</option>		
<option value="37" data-label="STOCURI">Stocuri</option>		
<option value="38" data-label="STOCURI_DE_MATERII_PRIME_SI_MATERIALE">Stocuri de materii prime si materiale</option>		
<option value="39" data-label="STOCURI_IN_CURS_DE_APROVIZIONARE">Stocuri in curs de aprovizionare</option>		
<option value="40" data-label="PRODUCTIA_IN_CURS_DE_EXECUTIE">Productia in curs de executie</option>		
<option value="41" data-label="PRODUSE">Produse (semifabricate, finite, reziduale)</option>		
<option value="42" data-label="STOCURI_AFLATE_LA_TERTI">Stocuri aflate la terti</option>		
<option value="43" data-label="ANIMALE_SI_PASARI">Animale si pasari</option>		
<option value="44" data-label="MARFURI">Marfuri</option>		
<option value="45" data-label="AMBALAJE">Ambalaje</option>		
<option value="46" data-label="AJUSTARI_PENTRU_DEPREC_STOCURILOR">Ajustari pentru deprec. stocurilor</option>		
<option value="47" data-label="CREANTE">Creante</option>		
<option value="48" data-label="CLIENTI">Clienti</option>		
<option value="49" data-label="FURNIZORI_DEBITORI">Furnizori debitori</option>		
<option value="50" data-label="CREANTE_FATA_DE_PERSONALUL_ANGAJAT">Creante fata de personalul angajat</option>		
<option value="51" data-label="CREANTE_FATA_DE_BUGETUL_DE_STAT">Creante fata de bugetul de stat</option>		
<option value="54" data-label="SUBVENTII">Subventii</option>		
<option value="55" data-label="CREANTE_FATA_DE_GRUP">Creante fata de grup</option>		
<option value="56" data-label="DEBITORI_DIVERSI">Debitori diversi</option>		
<option value="57" data-label="OPERATIUNI_IN_CURS_DE_CLARIFICARE_ACTIV">Operatiuni in curs de clarificare</option>		
<option value="58" data-label="DECONTARI_IN_CADRUL_UNITATII_ACTIV">Decontari in cadrul unitatii</option>		
<option value="59" data-label="DOBANZI_DE_PRIMIT">Dobanzi de primit</option>		
<option value="60" data-label="AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR">Ajustari pentru deprecierea creantelor</option>		
<option value="61" data-label="INVESTITII_PE_TERMEN_SCURT">Investitii pe termen scurt</option>		
<option value="62" data-label="DISPONIBIL_IN_CASERIE_SI_BANCA">Disponibil in caserie si banca</option>		
<option value="63" data-label="CONTURI_LA_BANCI">Conturi la banci</option>		
<option value="64" data-label="CASA">Casa</option>		
<option value="65" data-label="ACREDITIVE_ALTE_VALORI_VIRAMENTE_INTERNE">Acreditive, alte valori, viramente interne</option>		
<option value="66" data-label="AVANSURI_DE_TREZORERIE">Avansuri de trezorerie</option>		
<option value="67" data-label="ACTIVE_CIRCULANTE">Active circulante</option>		
<option value="68" data-label="CHELTUIELI_IN_AVANS">Cheltuieli in avans</option>		
<option value="69" data-label="TOTAL_ACTIV">Total activ</option>		
<option value="70" data-label="CIFRA_DE_AFACERI">Cifra de afaceri</option>		
<option value="71" data-label="VENITURI_DIN_VANZAREA_PRODUSELOR_FINITE">Venituri din vanzarea produselor finite</option>		
<option value="72" data-label="VENITURI_DIN_VANZAREA_SEMIFABRICATELOR_SI_PRODUSELOR_REZIDUALE">Venituri din vanzarea semifabricatelor si produselor reziduale</option>		
<option value="73" data-label="VENITURI_DIN_SERVICII_PRESTATE">Venituri din servicii prestate</option>		
<option value="74" data-label="VENITURI_DIN_STUDII_SI_CERCETARI">Venituri din studii si cercetari</option>		
<option value="75" data-label="VENITURI_DIN_REDEVENTE_LOCATII_DE_GESTIUNE_SI_CHIRII">Venituri din redevente, locatii de gestiune si chirii</option>		
<option value="76" data-label="VENITURI_DIN_VANZAREA_MARFURILOR">Venituri din vanzarea marfurilor</option>		
<option value="77" data-label="VENITURI_DIN_ACTIVITATI_DIVERSE">Venituri din activitati diverse</option>		
<option value="78" data-label="REDUCERI_COMERCIALE_ACORDATE">Reduceri comerciale acordate</option>		
<option value="79" data-label="VENITURI_DIN_SUBVENTII_DE_EXPLOATARE_AFERENTE_CIFREI_DE_AFACERI">Venituri din subventii de exploatare aferente cifrei de afaceri</option>		
<option value="80" data-label="CHELTUIELI_PENTRU_REALIZAREA_CIFREI_DE_AFACERI">Cheltuieli pentru realizarea cifrei de afaceri</option>		
<option value="81" data-label="CHELTUIELI_MATERIALE">Cheltuieli materiale</option>		
<option value="82" data-label="CHELTUIELI_CU_MATERIILE_PRIME">Cheltuieli cu materiile prime</option>		
<option value="83" data-label="CHELTUIELI_CU_MATERIALELE_CONSUMABILE">Cheltuieli cu materialele consumabile</option>		
<option value="84" data-label="CHELTUIELI_CU_OBIECTELE_DE_INVENTAR_MATERIALELE_NESTOCATE_SI_AMBALAJELE">Cheltuieli cu obiectele de inventar , materialele nestocate si ambalajele</option>		
<option value="85" data-label="CHELTUIELI_PRIVIND_ENERGIA_SI_APA">Cheltuieli privind energia si apa</option>		
<option value="86" data-label="CHELTUIELI_PRIVIND_ANIMALELE_SI_PASARILE">Cheltuieli privind animalele si pasarile</option>		
<option value="87" data-label="CHELTUIELI_PRIVIND_MARFURILE">Cheltuieli privind marfurile</option>		
<option value="88" data-label="REDUCERI_COMERCIALE_PRIMITE">Reduceri comerciale primite</option>		
<option value="89" data-label="CHELTUIELI_CU_SERVICII_PRESTATE_DE_TERTI">Cheltuieli cu servicii prestate de terti</option>		
<option value="90" data-label="CHELTUIELI_CU_INTRETINEREA_SI_REPARATIILE">Cheltuieli cu intretinerea si reparatiile</option>		
<option value="91" data-label="CHELTUIELI_CU_REDEVENTE_SI_CHIRII">Cheltuieli cu redevente si chirii</option>		
<option value="92" data-label="CHELTUIELI_CU_PRIMELE_DE_ASIGURARE">Cheltuieli cu primele de asigurare</option>		
<option value="93" data-label="CHELTUIELI_CU_STUDIILE_SI_CERCETARILE">Cheltuieli cu studiile si cercetarile</option>		
<option value="94" data-label="CHELTUIELI_CU_COLABORATORII">Cheltuieli cu colaboratorii</option>		
<option value="95" data-label="CHELTUIELI_PRIVIND_COMISIOANELE_SI_ONORARIILE">Cheltuieli privind comisioanele si onorariile</option>		
<option value="96" data-label="CHELTUIELI_DE_PROTOCOL_RECLAMA_SI_PUBLICITATE">Cheltuieli de protocol, reclama si publicitate</option>		
<option value="97" data-label="CHELTUIELI_CU_TRANSPORTUL_DE_BUNURI_SI_PERSONAL_DETASARI_TRASFERARI">Cheltuieli cu transportul de bunuri si personal, detasari, trasferari</option>		
<option value="98" data-label="CHELTUIELI_POSTALE_SI_TAXE_DE_TELECOMUNICATII">Cheltuieli postale si taxe de telecomunicatii</option>		
<option value="99" data-label="CHELTUIELI_CU_SERVICIILE_BANCARE">Cheltuieli cu serviciile bancare</option>		
<option value="100" data-label="ALTE_CHELTUIELI_CU_SERVICIILE_EXECUTATE_DE_TERTI">Alte cheltuieli cu serviciile executate de terti</option>		
<option value="101" data-label="CHELTUIELI_DE_PERSONAL">Cheltuieli de personal</option>		
<option value="102" data-label="PROFIT_AFERENT_ACTIVITATII_DE_BAZA">Profit aferent activitatii de baza</option>		
<option value="103" data-label="ALTE_VENITURI_DIN_EXPLOATARE">Alte venituri din exploatare</option>		
<option value="104" data-label="VENITURI_AFERENTE_COSTULUI_PRODUCTIEI_IN_CURS_DE_EXECUTIE">Venituri aferente costului productiei in curs de executie</option>		
<option value="105" data-label="VENITURI_DIN_PRODUCTIA_DE_IMOBILIZARI">Venituri din productia de imobilizari</option>		
<option value="106" data-label="SUBVENTII_PRIMITE_PENTRU_CHELTUIELI_DE_EXPLOATARE">Subventii primite pentru cheltuieli de exploatare</option>		
<option value="108" data-label="VENITURI_DIN_DESPAGUBIRI_AMENZI_SI_PENALITATI">Venituri din despagubiri, amenzi si penalitati</option>		
<option value="109" data-label="VENITURI_DIN_DONATII_PRIMITE">Venituri din donatii primite</option>		
<option value="110" data-label="VENITURI_DIN_VANZAREA_ACTIVELOR_SI_ALTE_OPERATII_DE_CAPITAL">Venituri din vanzarea activelor si alte operatii de capital</option>		
<option value="111" data-label="VENITURI_DIN_SUBVENTII_PENTRU_INVESTITII">Venituri din subventii pentru investitii</option>		
<option value="112" data-label="ALTE_VENITURI_OCAZIONALE_DIN_EXPLOATARE">Alte venituri ocazionale din exploatare</option>		
<option value="114" data-label="ALTE_CHELTUIELI_DE_EXPLOATARE">Alte cheltuieli de exploatare</option>		
<option value="115" data-label="CHELTUIELI_CU_ALTE_IMPOZITE_TAXE_SI_VARSAMINTE_ASIMILATE">Cheltuieli cu alte impozite, taxe si varsaminte asimilate</option>		
<option value="116" data-label="CHELTUIELI_CU_PROTECTIA_MEDIULUI_INCONJURATOR">Cheltuieli cu protectia mediului inconjurator</option>		
<option value="118" data-label="DESPAGUBIRI_AMENZI_SI_PENALITATI">Despagubiri, amenzi si penalitati</option>		
<option value="119" data-label="DONATII_ACORDATE">Donatii acordate</option>		
<option value="120" data-label="CHELTUIELI_PRIVIND_ACTIVELE_CEDATE_SI_ALTE_OPERATII_DE_CAPITAL">Cheltuieli privind activele cedate si alte operatii de capital</option>		
<option value="121" data-label="ALTE_CHELTUIELI_OCAZIONALE_DE_EXPLOATARE">Alte cheltuieli ocazionale de exploatare</option>		
<option value="122" data-label="CHELTUIELI_CU_AMORTIZAREA_AJUSTARI_DE_VALOARE_SI_PROVIZIOANELE">Cheltuieli cu amortizarea, ajustari de valoare si provizioanele </option>		
<option value="123" data-label="TOTAL_VENITURI_DIN_EXPLOATARE">Total venituri din exploatare</option>		
<option value="124" data-label="TOTAL_CHELTUIELI_DE_EXPLOATARE">Total cheltuieli de exploatare</option>		
<option value="125" data-label="PROFIT_DIN_EXPLOATARE">Profit din  exploatare</option>		
<option value="126" data-label="VENITURI_FINANCIARE">Venituri financiare</option>		
<option value="127" data-label="VENITURI_DIN_DOBANZI">Venituri din dobanzi</option>		
<option value="128" data-label="VENITURI_DIN_DIFERENTE_DE_CURS_VALUTAR">Venituri din diferente de curs valutar</option>		
<option value="129" data-label="VENITURI_DIN_SCONTURI_OBTINUTE">Venituri din sconturi obtinute</option>		
<option value="130" data-label="ALTE_VENITURI_FINANCIARE">Alte venituri financiare</option>		
<option value="131" data-label="VENITURI_EXTRAORDINARE">Venituri extraordinare</option>		
<option value="132" data-label="CHELTUIELI_FINANCIARE">Cheltuieli financiare</option>		
<option value="133" data-label="CHELTUIELI_PRIVIND_DOBANZILE">Cheltuieli privind dobanzile</option>		
<option value="134" data-label="CHELTUIELI_DIN_DIFERENTE_DE_CURS_VALUTAR">Cheltuieli din diferente de curs valutar </option>
<option value="135" data-label="CHELTUIELI_PRIVIND_SCONTURILE_ACORDATE">Cheltuieli privind sconturile acordate </option>		
<option value="136" data-label="ALTE_CHELTUIELI_FINANCIARE">Alte cheltuieli financiare</option>		
<option value="137" data-label="CHELTUIELI_EXTRAORDINARE">Cheltuieli extraordinare</option>		
<option value="138" data-label="PROFIT_DIN_ACTIVITATEA_FINANCIARA">Profit din activitatea financiara</option>		
<option value="139" data-label="VENITURI_TOTALE">Venituri totale</option>		
<option value="140" data-label="CHELTUIELI_TOTALE_INAINTE_IMPOZITARE">Cheltuieli totale inainte  de impozitare</option>		
<option value="141" data-label="PROFIT_BRUT">Profit brut</option>		
<option value="142" data-label="IMPOZIT_PE_PROFIT">Cheltuieli cu impozitul pe profit</option>		
<option value="143" data-label="PROFIT_NET">Profit net</option>		
<option value="145" data-label="VENITURI_IN_AVANS">Venituri in avans</option>		
<option value="146" data-label="DATORII_PE_TERMEN_SCURT">DATORII pe termen scurt (scadenta sub 1 an)</option>		
<option value="147" data-label="TOTAL_DATORII">Total datorii</option>		
<option value="148" data-label="ALTE_DATORII">Alte datorii</option>		
<option value="149" data-label="REPARTIZAREA_PROFITULUI">Repartizarea profitului</option>		
<option value="150" data-label="TOTAL_PASIV">Total pasiv</option>		
<option value="160" data-label="ALTE_CREANTE">Alte creante</option>		
<option value="161" data-label="PROFIT_DIN_ACTIVITATEA_EXTRAORDINARA">Profit din activitatea extraordinara</option>		
<option value="162" data-label="EBITDA">EBITDA</option>		
<option value="164" data-label="EBIT">EBIT</option>		
<option value="165" data-label="CHELTUIELI_TOTALE">Cheltuieli totale</option>	
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Evolutie</label>
						<div class="col-md-9">
							<div class="radio-list">
								<label class="radio-inline">
								<input type="radio" name="operation"  value="2" checked="">minim </label>
								<label class="radio-inline">
								<input type="radio" name="operation"  value="3" checked="">maxim </label>
							</div>
						</div>
					</div>					
					<div class="form-group">
						<label class="col-md-3 control-label">Valoare tinta</label>
						<div class="col-md-9">
							<input type="text" name="target_value" class="form-control input-inline input-medium" placeholder="Valoarea tinta">%
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label"></label>
						<div class="col-md-9">
							<p class="form-control-static">
								 din Venituri Totale
							</p>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn default" data-dismiss="modal">Inchide</button>
				<button type="button" class="btn blue" id="btn-form-submit">Salveaza</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
{else}
	{if $balantaCurenta!=null && $balantaPrecedenta==null}
	<div class="note note-info">
		<p class="block">Compania <b>{$companie->name}</b> nu are incarcata o balanta precedenta lunii selectate.</p>
		<p>
			 Pentru a putea accesa indicatorii financiari alegeti o alta luna sau incarcati balanta precedenta lunii selectate. <br/>
			 <a class="btn blue btn-xs" href="{'/'|url}balante_add?cid={$companie->id}">Adauga balanta</a>
		</p>
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
{/if}


{literal}
<script>
function showCard(formId) {
		
	type=$(formId).find('input[name="type"]').val();
	modalFormId=modalTypeSet(type);	
	loadCardData(formId, type, modalFormId);
}
function loadCardData(formId, type, modalFormId) {	
	
	$(modalFormId).find('[name="type"]').change(function (e) {
		//get the new type
		newModalFormId=modalTypeSet(this.value);
			
		//load data for the correct form
		loadCardData(formId,this.value,newModalFormId);
    });
	
	
	$(modalFormId).find('input[name="type"]').val(type);
	$(modalFormId).find('input[name="id"]').val($(formId).find('input[name="id"]').val());
	$(modalFormId).find('input[name="cid"]').val($(formId).find('input[name="company_id"]').val());
	$(modalFormId).find('input[name="bid"]').val($(formId).find('input[name="balanta_id"]').val());		
	$(modalFormId).find('input[name="item_label"]').val($(formId).find('input[name="item_label"]').val());		
	//selectez care indicator 	
	item=$(formId).find('input[name="item_id"]').val();
	$(modalFormId).find('[name="item"]').select2("val",item);
	$(modalFormId).find('[name="item"]').select2()
        .on("change", function(e) {
          $(modalFormId).find('input[name="item_label"]').val(
			$(modalFormId).find('[name="item"]').select2().find(":selected").data("label")
			);				  
        });
	//setez in hidden input labelul
	$(modalFormId).find('input[name="bid"]').val($(formId).find('input[name="balanta_id"]').val());		
	
	
	//selectez operatiunea
	op=$(formId).find('input[name="operation"]').val();
	$(modalFormId).find('input[name="operation"]').attr("checked",false);
	$(modalFormId).find('input[name="operation"]').parent().removeClass("checked");
	$(modalFormId).find('input[name="operation"][value="'+op+'"]').attr("checked",true);
	$(modalFormId).find('input[name="operation"][value="'+op+'"]').parent().addClass("checked");
		
	
	//selectez ce valoare
	val=$(formId).find('input[name="target_value"]').val();
	$(modalFormId).find('input[name="target_value"]').val(val);
	
	
	//sa submitez formul si sa salvez in baza de date
	$("#btn-form-submit").click(function(){ $(modalFormId).submit(); });
	
	//atentie ca lipseste labelul
	
	//dupa salvare se face refresh la dashboard
}
function modalTypeSet(type) {
	formId="";
	switch(type) {
		case '0':
			$("#form_type0").show();
			$("#form_type1").hide();
			$("#form_type2").hide();
			formId="#form_type0";
			break;
		case '1':
			$("#form_type0").hide();
			$("#form_type1").show();
			$("#form_type2").hide();
			formId="#form_type1";
			break;
		case '2':
			$("#form_type0").hide();
			$("#form_type1").hide();
			$("#form_type2").show();
			formId="#form_type2";
			break;
	
	}
	return formId;
}
var ObiectiveFinanciare = function() {

    return {
        //main function
        init: function() {
			
			moneyFormat();
				
            ObiectiveFinanciare.initKnobDials();
			
        },
		
		
		
		initKnobDials: function () {
            //knob does not support ie8 so skip it
            if (!jQuery().knob || Metronic.isIE8()) {
                return;
            }

            // general knob
            $(".knob").knob({
                'dynamicDraw': true,
                'thickness': 0.2,
                'tickColorizeValues': true,
                'skin': 'tron',
				'fgColor': '#2090A8',
				'width':'150',
				'height':'120',
				'readOnly':'true',
				'angleArc':240,
				'angleOffset':-120,
				'format' : function (value) {
					return value + '%';
				},
				'min':0,
				'max':100
            });  
        }
	}
}();


</script>

{/literal}
