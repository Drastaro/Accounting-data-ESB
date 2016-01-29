<h1><img src="{'/'|url}admin/img/icons/users.png" alt="">{if !$res->id}Adăugare user{else}Editare: {$res->getName()}{/if}</h1>

<form action="" method="post">
{if $res->id}<input type="hidden" name="id" value="{$res->id}">{/if}
<table class="fancytable">
	<tr>
		<th colspan="2">Detalii</th>
	</tr>
	<tr>
		<td>
			<table>
				<tr>
					<td>Nume:</td>
					<td><input type="text" value="{$res->last_name|escape}" name="last_name" size="50" /></td>
				</tr>
				<tr>
					<td>Prenume:</td>
					<td><input type="text" value="{$res->first_name|escape}" name="first_name" size="50" /></td>
				</tr>
				<tr>
					<td>E-mail:</td>
					<td><input type="text" value="{$res->email|escape}" name="email" size="50" /></td>
				</tr>
				<tr>
					<td>Telefon:</td>
					<td><input type="text" value="{$res->telephone|escape}" name="telephone" size="50" /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<p align="center">
	<input type="submit" value="Salvează" class="button">
	<a class="button" href="?page=users&amp;action=list">Renunță</a>
</p>
</form>
