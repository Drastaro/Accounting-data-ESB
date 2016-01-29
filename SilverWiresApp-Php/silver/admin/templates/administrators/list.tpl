<h1><img src="{'/'|url}admin/img/icons/administratori.png" alt="">Administratori</h1>

<table class="fancytable actiontable">
	<tr>
		<th>Nume</th>
		<th>E-mail</th>
		<th>Opțiuni</th>
	</tr>
	
	{foreach from=$administrators item=adm name=nr}
	<tr>
		<td>{$adm->name}</td>
		<td>{$adm->email}</td>
		<td>
			<a href="?page=administrators&amp;action=add_edit&amp;id={$adm->id}">Editare</a>
			 - 
			<a href="?page=administrators&amp;action=remove&amp;id={$adm->id}" 
				onclick="return confirm('Confirm ștergerea administratorului!');">Ștergere</a>
		</td>
	</tr>
	{/foreach}
</table>

<p align="center"><a class="button" href="?page=administrators&amp;action=add_edit">Adaugă</a></p>