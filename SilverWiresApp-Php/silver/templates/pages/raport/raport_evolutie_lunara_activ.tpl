<div class="portlet light">
	<div class="portlet-title">
		<div class="caption">
			<i class="icon-shuffle font-blue-steel"></i>
			<span class="caption-subject font-blue-steel bold uppercase">Activul patrimonial</span>
			
		</div>
		
	</div>
	<div class="portlet-body">
		<div id="evolutie_graph_active"></div>
		<div id="active_choices"><br/><strong>Filtrare grafic:</strong></div>
		<div style="width:100%;overflow-x:auto;">
		<table class="table table-striped table-hover table-bordered" style="text-align:right" id="table_activ" >
		<thead>
		<tr >
			<th colspan=2 width=40%>
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
			<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['ACTIVE_CIRCULANTE']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['ACTIVE_CIRCULANTE']->value()}</span></td>
			<td>{$rap['ACTIVE_CIRCULANTE']->valuePercent()}%</td>
			{/foreach}
		</tr>
		<tr>
			<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
			<td style="text-align:left;">{$TXT['DISPONIBIL_IN_CASERIE_SI_BANCA']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['DISPONIBIL_IN_CASERIE_SI_BANCA']->value()}</span></td>
			<td>{$rap['DISPONIBIL_IN_CASERIE_SI_BANCA']->valuePercent()}%</td>
			{/foreach}
		</tr>
		{$disponibilCaserie =['CONTURI_LA_BANCI',
						'CASA',
						'ACREDITIVE_ALTE_VALORI_VIRAMENTE_INTERNE',
						'AVANSURI_DE_TREZORERIE']}
		
		{foreach from=$disponibilCaserie item=i}
			<tr class="isChildRow hide">
				<td style="text-align:center;"></td>
				<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap[$i]->value()}</span></td>
				<td>{$rap[$i]->valuePercent()}%</td>
				{/foreach}
			</tr>
		{/foreach}
		<!-- investitii termen scurt -->
		<tr>
			<td style="width: 10px; text-align:center;"></td>
			<td style="text-align:left;">{$TXT['INVESTITII_PE_TERMEN_SCURT']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['INVESTITII_PE_TERMEN_SCURT']->value()}</span></td>
			<td>{$rap['INVESTITII_PE_TERMEN_SCURT']->valuePercent()}%</td>
			{/foreach}
		</tr>				
		<!-- end investitii termen scurt -->
		<!-- Creante -->
		<tr>
			<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
			<td style="text-align:left;">{$TXT['CREANTE']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['CREANTE']->value()}</span></td>
			<td>{$rap['CREANTE']->valuePercent()}%</td>
			{/foreach}
		</tr>
		{$creante =['CLIENTI',
						'FURNIZORI_DEBITORI',
						'CREANTE_FATA_DE_PERSONALUL_ANGAJAT',
						'CREANTE_FATA_DE_BUGETUL_DE_STAT',
						'SUBVENTII',
						'CREANTE_FATA_DE_GRUP']}
		
		
		{foreach from=$creante item=i}
			<tr class="isChildRow hide">
				<td style="text-align:center;"></td>
				<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap[$i]->value()}</span></td>
				<td>{$rap[$i]->valuePercent()}%</td>
				{/foreach}
			</tr>
		{/foreach}
		<tr class="isChildRow hide">
				<td style="text-align:center;"></td>
				<td style="text-align:left;padding-left:9px;" class="sub-details-control"><i class="fa fa-plus-square-o fa-lg"  style="padding-right:9px;"></i>{$TXT['ALTE_CREANTE']}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap['ALTE_CREANTE']->value()}</span></td>
				<td>{$rap['ALTE_CREANTE']->valuePercent()}%</td>
				{/foreach}
		</tr>
		{$alteCreante =['DEBITORI_DIVERSI',
						'OPERATIUNI_IN_CURS_DE_CLARIFICARE_ACTIV',
						'DECONTARI_IN_CADRUL_UNITATII_ACTIV',
						'DOBANZI_DE_PRIMIT']}
		{foreach from=$alteCreante item=i}
			
			<tr class="isSubChildRow hide">
				<td style="text-align:center;"></td>
				<td style="text-align:left;padding-left:60px;">{$TXT[$i]}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap[$i]->value()}</span></td>
				<td>{$rap[$i]->valuePercent()}%</td>
				{/foreach}
			</tr>
		{/foreach}
		
		
		<tr class="isChildRow hide">
			<td style="text-align:center;"></td>
			<td style="text-align:left;padding-left:30px;">{$TXT['AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR']->value()}</span></td>
			<td>{$rap['AJUSTARI_PENTRU_DEPRECIEREA_CREANTELOR']->valuePercent()}%</td>
			{/foreach}
		</tr>
		<!-- END creante -->
		<!-- Stocuri -->
		<tr>
			<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
			<td style="text-align:left;">{$TXT['STOCURI']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['STOCURI']->value()}</span></td>
			<td>{$rap['STOCURI']->valuePercent()}%</td>
			{/foreach}
		</tr>
		{$stocuri =['STOCURI_DE_MATERII_PRIME_SI_MATERIALE',
					'STOCURI_IN_CURS_DE_APROVIZIONARE',
					'PRODUCTIA_IN_CURS_DE_EXECUTIE',
					'PRODUSE',
					'STOCURI_AFLATE_LA_TERTI',
					'ANIMALE_SI_PASARI',
					'MARFURI',
					'AMBALAJE',
					'AJUSTARI_PENTRU_DEPREC_STOCURILOR']}
		{foreach from=$stocuri item=i}
			<tr class="isChildRow hide">
				<td style="text-align:center;"></td>
				<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap[$i]->value()}</span></td>
				<td>{$rap[$i]->valuePercent()}%</td>
				{/foreach}
			</tr>
		{/foreach}
		<!-- END stocuri -->
		<tr>
			<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['CHELTUIELI_IN_AVANS']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['CHELTUIELI_IN_AVANS']->value()}</span></td>
			<td>{$rap['CHELTUIELI_IN_AVANS']->valuePercent()}%</td>
			{/foreach}
		</tr>
		<tr>
			<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['ACTIVE_IMOBILIZATE']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['ACTIVE_IMOBILIZATE']->value()}</span></td>
			<td>{$rap['ACTIVE_IMOBILIZATE']->valuePercent()}%</td>
			{/foreach}
		</tr>
		<!-- Imobilizari necorporale  -->
		<tr>
			<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
			<td style="text-align:left;">{$TXT['IMOBILIZARI_NECORPORALE']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['IMOBILIZARI_NECORPORALE']->value()}</span></td>
			<td>{$rap['IMOBILIZARI_NECORPORALE']->valuePercent()}%</td>
			{/foreach}
		</tr>
		{$imobilizariNecorporale =['IMOBILIZARI_NECOROPRALE_VALOARE_DE_INTRARE',
									'AMORTIZARE_SI_AJUSTARI_IMOBILIZARI_NECORPORALE']}
		{foreach from=$imobilizariNecorporale item=i}
			<tr class="isChildRow hide">
				<td style="text-align:center;"></td>
				<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap[$i]->value()}</span></td>
				<td>{$rap[$i]->valuePercent()}%</td>
				{/foreach}
			</tr>
		{/foreach}
		<!-- END Imobilizari necorporale  -->
		<!-- Imobilizari corporale  -->
		<tr>
			<td style="width: 10px; text-align:center;" class="details-control"><i class="fa fa-plus-square-o fa-lg"></i></td>
			<td style="text-align:left;">{$TXT['IMOBILIZARI_CORPORALE']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['IMOBILIZARI_CORPORALE']->value()}</span></td>
			<td>{$rap['IMOBILIZARI_CORPORALE']->valuePercent()}%</td>
			{/foreach}
		</tr>
		{$imobilizariCorporale =['TERENURI_SI_AMENAJARI_LA_TERENURI',
								'CONSTRUCTII',
								'INSTALATII_TEHNICE_MIJ_TRANS',
								'MOBILIER_BIROTICA_ECHIP_PROTECTIE',
								'IMOBILIZARI_IN_CURS_DE_APROVIZIONARE_AVANSURI_ACORDATE',
								'AMORTIZARI_PRIVIND_IMOBILIZARILE_CORPORALE']}
		{foreach from=$imobilizariCorporale item=i}
			<tr class="isChildRow hide">
				<td style="text-align:center;"></td>
				<td style="text-align:left;padding-left:30px;">{$TXT[$i]}</td>
				{foreach from=$rapoarteBalante item=rap}
				<td><span class="money">{$rap[$i]->value()}</span></td>
				<td>{$rap[$i]->valuePercent()}%</td>
				{/foreach}
			</tr>
		{/foreach}
		<!-- END Imobilizari corporale  -->
		<!-- Imobilizari financiare  -->
		<tr>
			<td style="width: 10px; text-align:center;" ></td>
			<td style="text-align:left;">{$TXT['IMOBILIZARI_FINANCIARE']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['IMOBILIZARI_FINANCIARE']->value()}</span></td>
			<td>{$rap['IMOBILIZARI_FINANCIARE']->valuePercent()}%</td>
			{/foreach}
		</tr>
		<!-- END Imobilizari necorporale  -->
		<tr>
			<td style="text-align:left;" colspan=2 class="bold uppercase">{$TXT['TOTAL_ACTIV']}</td>
			{foreach from=$rapoarteBalante item=rap}
			<td><span class="money">{$rap['TOTAL_ACTIV']->value()}</span></td>
			<td>{$rap['TOTAL_ACTIV']->valuePercent()}%</td>
			{/foreach}
		</tr>
		
		</tbody>
	</table>
	</div>
	</div>
</div>