<?php

	function smarty_modifier_url($string)
	{
		return Application::getMappedPath($string);
	}
