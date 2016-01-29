<?php

	#fatal error message:
	define('MSG_FATAL_ERROR', "The server made a boom. Please report this error to the webmaster and try later.");

	# general upload messages:
	define('UPLOADMSG_NO_INPUT', "No input file in html form.");
	define('UPLOADMSG_BAD_FORM', "The html form has an incorrect enctype and/or method.");
	define('UPLOADMSG_NO_USER_FILE', "You haven't selected any file to upload.");
	define('UPLOADMSG_PARTIAL', "The file was only partially uploaded.");
	define('UPLOADMSG_ERROR', "Unknown upload error.");

	define('UPLOADMSG_TOO_LARGE', "File size too large. The maximum permitted size is: [MAXSIZE] bytes.");
	define('UPLOADMSG_TOO_SMALL', "File size too small. The maximum permitted size is: [MINSIZE] bytes.");
	define('UPLOADMSG_FORBIDDEN_EXTENSION', "File extension is forbidden.");
	define('UPLOADMSG_NOT_ALLOWED_EXTENSION', "File extension not allowed.");

	define('UPLOADMSG_FILE_EXISTS', "The destination file already exists.");
	define('UPLOADMSG_CANNOT_OVERWRITE', "The destination file already exists and could not be overwritten.");
	define('UPLOADMSG_SAVE_FAIL', "Impossible to save the file.");

	# general image upload messages:
	define('UPLOADMSG_IMG_INVALID', "The uploaded file is not a valid image.");
	define('UPLOADMSG_IMG_TOO_BIG', "The uploaded image is too big. Maximum size is [WIDTH]x[HEIGHT].");
	define('UPLOADMSG_IMG_TOO_SMALL', "The uploaded image is too small. Minimum size is [WIDTH]x[HEIGHT].");

