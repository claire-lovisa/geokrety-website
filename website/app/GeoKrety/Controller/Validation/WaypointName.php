<?php

namespace GeoKrety\Controller\Validation;

use GeoKrety\Controller\Base;
use GeoKrety\Model\Waypoint;

class WaypointName extends Base {
    public function post($f3) {
        header('Content-Type: application/json; charset=utf-8');
        $query = $f3->get('POST.name');

        if (empty($query)) {
            http_response_code(400);
            die(json_encode(array('error' => _('Waypoint seems empty.'))));
        }

        if (strlen($query) < GK_CHECK_WAYPOINT_NAME_MIN_LENGTH || strlen($query) > GK_CHECK_WAYPOINT_NAME_MAX_LENGTH) {
            http_response_code(400);
            die(json_encode(array('error' => sprintf(_('Waypoint length is invalid. It should be between %d and %d characters long.'), GK_CHECK_WAYPOINT_NAME_MIN_LENGTH, GK_CHECK_WAYPOINT_NAME_MAX_LENGTH))));
        }

        $waypoint = new Waypoint();
        $options = array(
            'limit' => GK_CHECK_WAYPOINT_NAME_COUNT,
        );
        $waypoints = $waypoint->find(array('name LIKE CONCAT(\'%\',?,\'%\')', $query), $options);

        $response = array();
        foreach ($waypoints as $wpt) {
            $response[] = $wpt->asArray();
        }

        echo json_encode($response, JSON_UNESCAPED_UNICODE);
    }
}
