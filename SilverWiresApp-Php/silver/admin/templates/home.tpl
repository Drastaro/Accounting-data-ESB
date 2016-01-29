{if $ADMIN->hasAccessToPage('companies') || $ADMIN->hasAccessToPage('users') || $ADMIN->hasAccessToPage('administrators')}
<table align="center" cellspacing="1" cellpadding="3" width="600" class="fancytable dashboard">
  <tr>
    <th>Secțiuni</th>
  </tr>
  <tr>
    <td><table cellspacing="5" width="100%" align="left">
        <tr>
        {if $ADMIN->hasAccessToPage('companies')}
          <td valign="top" width="17%"><div align="center"><a href="?page=companies&amp;action=list"><img src="{'/'|url}admin/img/icons/companies.png" border="0" alt=""><br>
              Companii
          </a></div></td>
        {/if}
        {if $ADMIN->hasAccessToPage('users')}
          <td valign="top" width="17%"><div align="center"><a href="?page=users&amp;action=list"><img src="{'/'|url}admin/img/icons/users.png" border="0" alt=""><br>
              Clienți
          </a></div></td>
        {/if}
        {if $ADMIN->hasAccessToPage('administrators')}
          <td valign="top" width="17%"><div align="center"><a href="?page=administrators&amp;action=list"><img src="{'/'|url}admin/img/icons/administratori.png" border="0" alt=""><br>
              Administratori
          </a></div></td>
        {/if}
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
<br>
{/if}
