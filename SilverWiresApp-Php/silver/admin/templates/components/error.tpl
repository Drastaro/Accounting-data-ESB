{if $ERROR_TITLE}
	<h1><img src="/admin/img/icons/not_available.png" alt="">{$ERROR_TITLE}</h1>
{/if}

<div align="center" class="error">{$ERROR}</div>

{if $ERROR_FILE}{include file="$ERROR_FILE"}{/if}
