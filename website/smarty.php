<?php

// --------------------------------------------------------------- SMARTY ---------------------------------------- //

// tymczasowo - zamknij linki do mysqli-a
if ($link->connected) {
    mysqli_close($link);
}

if (!isset($smarty)) {
    echo 'Oops! Something went wrong. Please try again later, we are working on this... <br/>Sorry for the inconvenience!';
    include_once 'defektoskop.php';
    errory_add('BRAK SMARTOW', 100, 'SmartyError');

    $TRESC = 'SMARTY ERROR: '.$_SERVER['REQUEST_URI'];
    $headers = 'From: GeoKrety <geokrety@gmail.com>'."\r\n";
    $headers .= 'Return-Path: <geokrety@gmail.com>'."\r\n";
    try {
        mail('geokrety@gmail.com', 'Smarty error!', $TRESC, $headers);
    } catch (Exception $e) {
    }
    exit;
}

if ($_SESSION['isLoggedIn'] && !$smarty->getTemplateVars('user')) {
    $userR = new \Geokrety\Repository\UserRepository(\GKDB::getLink());
    $user = $userR->getById($_SESSION['currentUser']);
    $smarty->assign('user', $user);
}

$smarty->error_reporting = E_ALL;

$smarty->assign('cdnUrl', CONFIG_CDN);
$smarty->assign('jsUrl', CONFIG_CDN_JS);
$smarty->assign('librariesUrl', CONFIG_CDN_LIBRARIES);
$smarty->assign('cssUrl', CONFIG_CDN_CSS);
$smarty->assign('imagesUrl', CONFIG_CDN_IMAGES);
$smarty->assign('avatarUrl', CONFIG_CDN_OBRAZKI);
$smarty->assign('avatarMinUrl', CONFIG_CDN_OBRAZKI_MALE);
$smarty->assign('bannerUrl', CONFIG_CDN_BANNERS);
$smarty->assign('iconsUrl', CONFIG_CDN_ICONS);
$smarty->assign('head', $HEAD);
$smarty->assign('body', $BODY);
$smarty->assign('title', $TYTUL);
$smarty->assign('content', $TRESC);
$smarty->assign('footer', $OGON);

$smarty->assign('lang', $_COOKIE['geokret1']);

$smarty->assign('template_login', $template_login);

$smarty->assign('alert_msgs', array_merge($alert_msgs, isset($_SESSION['alert_msgs']) ? $_SESSION['alert_msgs'] : []));
unset($_SESSION['alert_msgs']);

$smarty->display($template, $smarty_cache_filename);
exit();
