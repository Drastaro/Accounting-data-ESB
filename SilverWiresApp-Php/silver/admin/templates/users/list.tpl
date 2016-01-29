<div class="leftCPbox">
	<form action="" method="get">
	<input type="hidden" name="page" value="users">
	<input type="hidden" name="action" value="list">
	
	<h1><img src="{'/'|url}admin/img/icons/users.png" alt="">Users</h1>
	<div align="center">[<a href="?page=users&amp;action=add_edit">adăugare</a>]</div>
	<br />
	
	<label>ID:</label> <input type="text" name="id" value="{$id}">
	
	<label>Nume:</label> <input type="text" name="name" value="{$name}">
	
	<label>E-mail:</label> <input type="text" name="email" value="{$email}">
	
	<label>Phone:</label> <input type="text" name="phone" value="{$phone}">
	
	<label>Activ:&nbsp;&nbsp;
	<select name="active" size="1">
        <option value="">Toti</option>
		<option value="1"{if $active=='1'} selected{/if}>Da</option>
		<option value="0"{if $active=='0'} selected{/if}>Nu</option>
	</select>
	</label>
	
	<label>Ordonare:</label>
	<select name="orderby_what" size="1" style="width:70px;">
		<option value="id">ID</option>
		<option value="name"{if $orderby_what=='name'} selected{/if}>Nume</option>
		<option value="email"{if $orderby_what=='email'} selected{/if}>E-mail</option>
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
		[<a href="?page=users&amp;action=list">resetare formular</a>]
	</p>
	</form>
</div>

<div style="margin-left:151px;">

	<table class="fancytable actiontable" style="width:100%">
		<tr>
			<th width="10">ID</th>
			<th>Nume</th>
			<th>E-mail</th>
			<th>Telefon</th>
            <th>Status</th>
			<th width="70">Opțiuni</th>
		</tr>
		{foreach item=r from=$res}
		<tr {if $r->isActive==0}class="text-inactive"{/if}>
			<td align="right">{$r->id}</td>
			<td><strong><a href="?page=users&amp;action=add_edit&amp;id={$r->id}">{$r->getName()}</a></strong></td>
			<td>{if $r->isConfirmed}<a href="mailto:{$r->email}">{$r->email}</a>{else}{$r->email} <b class="hl2">- NECONFIRMAT</b>{/if}</td>
			<td>{$r->telephone}</td>
            <td>{if $r->isActive}Activ{else}Inactiv{/if}</td>
			<td>
				<div class="simple-combo">
					<a class="ctrl" href="#">&or;</a>
					<div>
						<a href="?page=users&amp;action=add_edit&amp;id={$r->id}">Editare</a>
							
						<a href="?page=users&amp;action=toggle&amp;id={$r->id}"
							onclick="return confirm('Doriți să {if $r->isActive}dezactivați{else}activați{/if} userul {$r->getName()}?')"
							>{if $r->isActive}Dezactivare{else}Activare{/if}</a>

                        <a href="?page=users&amp;action=delete&amp;id={$r->id}"
                           onclick="return confirm('Doriți să ștergeți definitiv userul {$r->getName()}?')"
                            >Ștergere</a>
					</div>
				</div>
			</td>
		</tr>
		{foreachelse}
		<tr>
			<td colspan="16" align="center">- nu a fost găsit nici un user -</td>
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
