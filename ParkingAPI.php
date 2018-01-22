<?php
/**
 * Created by PhpStorm.
 * User: antho
 * Date: 22/01/2018
 * Time: 16:41
 */

class ParkingAPI {
    private $bdd;

    public function __construct() {
        try {
            $this->bdd = new PDO('mysql:host=localhost;dbname=api_ios;charset=utf8', 'amacabr2', 'sub@bg10');
        } catch (Exception $e) {
            die('Erreur : ' . $e->getMessage());
        }
    }
}