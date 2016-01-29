{if $ERROR_TITLE}
	<h2>{$ERROR_TITLE}</h2>
{/if}

<p class="error">{$ERROR}</p>

{if $ERROR_FILE}{include file="$ERROR_FILE"}{/if}
