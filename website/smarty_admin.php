<?php

require_once '__sentry.php';

$smarty_cache_this_page = 0; // this page should be cached for n seconds
require_once 'smarty_start.php';

$userid = $longin_status['userid'];
if (!in_array($userid, $config['superusers'])) {
    header('Location: /');
}

$TYTUL = 'Erase smarty templates';

if (isset($_POST['formname'])) {
    if ($_POST['formname'] == 'clear_all_cache') {
        info(_('Clearing cache…'));
        $smarty->clear_all_cache();
        sleep(2);
        success(_('Cache cleared 👍'));
    }

    if ($_POST['formname'] == 'clear_compiled_tpl') {
        info(_('Clearing compiled templates…'));
        $smarty->clear_compiled_tpl();
        sleep(2);
        success(_('Cache cleared 👍'));
    }
}

$smarty->assign('content_template', 'admin/smarty.tpl');

// --------------------------------------------------------------- SMARTY ---------------------------------------- //

require_once 'smarty.php';
