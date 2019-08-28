<?php

namespace GeoKrety\Controller;

use GeoKrety\Pagination;
use GeoKrety\Service\Smarty;
use GeoKrety\Model\Geokret;
use GeoKrety\Model\Move;

class GeokretDetails extends BaseGeokret {
    public function get($f3) {
        // Load move independently to use pagination
        $move = new Move();
        $filter = array('geokret = ?', $this->geokret->id);
        $option = array('order' => 'moved_on_datetime DESC');
        $subset = $move->paginate(Pagination::findCurrentPage() - 1, GK_PAGINATION_GEOKRET_MOVES, $filter, $option);
        Smarty::assign('moves', $subset);
        // Paginate
        $pages = new Pagination($subset['total'], $subset['limit']);
        Smarty::assign('pg', $pages);

        Smarty::render('pages/geokret_details.tpl');
    }
}
