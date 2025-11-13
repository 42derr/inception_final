<?php

define( 'DB_NAME',  XXX  );
define( 'DB_USER',  XXX  );
define( 'DB_PASSWORD',  XXX  );
define( 'DB_HOST',  XXX  );
define( 'DB_CHARSET',  XXX  );
define( 'DB_COLLATE', '' );

define('AUTH_KEY',         'GsexEH!X:k!G1G|B|8HTQ-wuH1t9)-9/p3+uk$-YE8[_UY+Dl|u`_Ua`qce1>HeQ');
define('SECURE_AUTH_KEY',  '4-4sbn g=4NI-bwtwl ~+MM+KsS5xD*>`l@^(^|@s2YRWqi 04QEZ*RA^E~.V?4/');
define('LOGGED_IN_KEY',    '}k@b}Crmi>^x>zqy#`f!_)$bsgsbz=mCFwdD+zwf*9[+1gqp{Q Xg4/G:L.q UmS');
define('NONCE_KEY',        '8xx54h?:)>29xWu8:p8^-H=@:fSNu/raR@{RZu$E+FVRl`,2JW@zxFtSu;oS;XL=');
define('AUTH_SALT',        '39lq:5;*kahe>V%}7OG|U>bj6e{t}u5pWYXxX|U>u3|&AQzh(VP1%R=_1 C>~r(X');
define('SECURE_AUTH_SALT', '!bKa|U?YEk!e;grm?=,hfJc66S95NP<IbC=M-L@$Z YsMzK]X;]Y`sHNB4Ss&1r>');
define('LOGGED_IN_SALT',   'VM WIzCIPM~C*c_n-*aTqy5]ej(>d&Efgwk}>-fYfT&])|:]mK)B>(qk>0 A{[~L');
define('NONCE_SALT',       'CeC}yjs7sR~vy6e;B6 l0R6I@z<Uv;`) QO*[y>QDUR6~7 {G4-~oT+^4KC:dB`E');

define('WP_REDIS_HOST', 'rediscache');
define('WP_REDIS_PORT', 6379);
define('WP_CACHE', true);

$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
