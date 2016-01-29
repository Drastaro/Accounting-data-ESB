<?php

	#fatal error message:
	define('MSG_FATAL_ERROR', 
		"Momentan serverul are o problema. Va rugam raportati aceasta eroare la webmaster si incercati mai tarziu.");

	# general upload messages:
	define('UPLOADMSG_NO_INPUT', "Nu exista un field input file in formul html.");
	define('UPLOADMSG_BAD_FORM', "Form html nu are atributele 'enctype' si/sau 'method' setate corect.");
	define('UPLOADMSG_NO_USER_FILE', "Trebuie selectat un fisier pentru upload.");
	define('UPLOADMSG_PARTIAL', "Fisierul a fost uploadat partial.");
	define('UPLOADMSG_ERROR', "Eroare necunoscuta la upload.");

	define('UPLOADMSG_TOO_LARGE', "Dimensiunea fisierului este prea mare. Limita maxima permisa este: [MAXSIZE] octeti.");
	define('UPLOADMSG_TOO_SMALL', "Dimensiunea fisierului este prea mica. Limita minima permisa este: [MINSIZE] octeti.");
	define('UPLOADMSG_FORBIDDEN_EXTENSION', "Extensia fisierului este interzisa.");
	define('UPLOADMSG_NOT_ALLOWED_EXTENSION', "Extensia fisierului nu este permisa.");

	define('UPLOADMSG_FILE_EXISTS', "Fisierul uploadat exista deja.");
	define('UPLOADMSG_CANNOT_OVERWRITE', "Fisierul exista si nu poate fi suprascris.");
	define('UPLOADMSG_SAVE_FAIL', "Fisierul nu poate fi salvat.");

	# general image upload messages:
	define('UPLOADMSG_IMG_INVALID', "Fisierul uploadat nu este o imagine valida.");
	define('UPLOADMSG_IMG_TOO_BIG', "Imaginea uploadata este prea mare. Este permis maxim [WIDTH]x[HEIGHT].");
	define('UPLOADMSG_IMG_TOO_SMALL', "Imaginea uploadata este prea mica. Este permis minimum [WIDTH]x[HEIGHT].");
