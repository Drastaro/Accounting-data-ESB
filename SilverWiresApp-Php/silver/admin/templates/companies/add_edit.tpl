<h1><img src="{'/'|url}admin/img/icons/users.png" alt="">{if !$res->id}Adăugare companie{else}Editare: {$res->name}{/if}</h1>

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
					<td><input type="text" value="{$res->name|escape}" name="name" size="50" /></td>
				</tr>
                <tr>
                    <td>User:</td>
                    <td>
                        <select name="user_id">
                            <option>- select user -</option>
                            {foreach item=r from=$users}
                                <option value="{$r->id}" {if $res->user_id==$r->id}selected{/if}>{$r->getName()}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
			</table>
		</td>
	</tr>
</table>

<p align="center">
	<input type="submit" value="Salvează" class="button">
	<a class="button" href="?page=companies&amp;action=list">Renunță</a>
</p>
</form>
