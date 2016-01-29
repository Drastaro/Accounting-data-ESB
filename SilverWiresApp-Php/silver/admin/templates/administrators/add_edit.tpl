<h1><img src="{'/'|url}admin/img/icons/administratori.png" alt="">{if $adm->id}Editare{else}Adăugare{/if} administrator</h1>

<form method="post" action="">
<table class="fancytable">
	<tr>
		<th>Autentificare</th>
	</tr>
	<tr>
		<td>
			<table>
				<tr>
					<td>Nume:</td>
					<td><input type="text" value="{$adm->name}" name="name" size="50" /></td>
				</tr>
				<tr>
					<td>E-mail:</td>
					<td><input type="text" value="{$adm->email}" name="email" size="50" /></td>
				</tr>
				<tr>
					<td>Parola nouă:</td>
					<td><input type="password" value="" name="password" size="25" autocomplete="off" /></td>
				</tr>
				<tr>
					<td>Confirmare parolă:</td>
					<td><input type="password" value="" name="password2" size="25" autocomplete="off" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<th colspan="2">Access</th>
	</tr>
	<tr>
		<td colspan="2" style="line-height:25px;">
		{foreach from=$accessData item=ad key=k}
			<input type="checkbox" name="access[]" value="{$k}" id="acc{$k}" {if ($adm->hasAccess($k))} checked="checked" {/if}>
			<label for="acc{$k}">{$ad}</label>
			<br>
		{/foreach}
		</td>
	</tr>
</table>
<p align="center">
	<input type="submit" value=" Save " class="button" />
	<a href="?page=administrators&amp;action=list" class="button">Cancel</a>
</p>
</form>