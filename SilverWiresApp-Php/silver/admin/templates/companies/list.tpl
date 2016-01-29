<div class="leftCPbox">
	<form action="" method="get">
	<input type="hidden" name="page" value="companies">
	<input type="hidden" name="action" value="list">
	
	<h1><img src="{'/'|url}admin/img/icons/companies.png" alt="">Companies</h1>
	<div align="center">[<a href="?page=companies&amp;action=add_edit">adăugare</a>]</div>
	<br />
	
	<label>ID:</label> <input type="text" name="id" value="{$id}">

    <label>User ID:</label> <input type="text" name="user_id" value="{$user_id}">
	
	<label>Nume:</label> <input type="text" name="name" value="{$name}">
	
	<label>Ordonare:</label>
	<select name="orderby_what" size="1" style="width:70px;">
		<option value="id">ID</option>
		<option value="name"{if $orderby_what=='name'} selected{/if}>Nume</option>
	</select>
	<select name="orderby_how" size="1" style="width:53px;">
		<option value="ASC">ASC</option>
		<option value="DESC"{if $orderby_how=='DESC'} selected{/if}>DES</option>
	</select>
	
	<label>Rezultate/pag: <input type="text" name="rezultate" value="{$rezultate}" style="width:30px;"></label>
	
	<p align="center"><input type="submit" value="Caută" class="button"></p>
	
	<p align="center">
		<strong>Nr. rezultate: {$total}</strong>
		<br />
		[<a href="?page=companies&amp;action=list">resetare formular</a>]
	</p>
	</form>
</div>

<div style="margin-left:151px;">

	<table class="fancytable actiontable" style="width:100%">
		<tr>
			<th width="10">ID</th>
			<th>Nume</th>
            <th>User</th>
			<th width="70">Opțiuni</th>
		</tr>
		{foreach item=r from=$res}
		<tr>
			<td align="right">{$r->id}</td>
			<td><strong><a href="?page=companies&amp;action=add_edit&amp;id={$r->id}">{$r->name}</a></strong></td>
            <td><strong><a href="?page=users&amp;action=add_edit&amp;id={$r->user_id}">{$r->user_name}</a></strong></td>
			<td>
				<div class="simple-combo">
					<a class="ctrl" href="#">&or;</a>
					<div>
						<a href="?page=companies&amp;action=add_edit&amp;id={$r->id}">Editare</a>
							
                        <a href="?page=companies&amp;action=delete&amp;id={$r->id}"
                           onclick="return confirm('Doriți să ștergeți definitiv compania {$r->name}?')"
                            >Ștergere</a>
					</div>
				</div>
			</td>
		</tr>
		{foreachelse}
		<tr>
			<td colspan="16" align="center">- nu a fost găsit nici o companie -</td>
		</tr>
		{/foreach}
	</table>
	<div class="pageslinks" align="center">
		{$paginator}
	</div>
	
</div>

{literal}
<script type="text/javascript">
<!--
	$('.simple-combo .ctrl').click(function(){
		if ($(this).parent().find('div').css('position') == 'static') {
			$('.simple-combo div').css({position:'static'});
			$(this).parent().find('div').css({position:'absolute'});
		} else {
			$('.simple-combo div').css({position:'static'});
		}
		return false;
	});

	$('.combobox').combobox();
//-->
</script>
{/literal}
