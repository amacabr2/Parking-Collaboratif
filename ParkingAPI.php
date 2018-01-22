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
            $this->bdd = new PDO('mysql:host=localhost;dbname=parking_associatif;charset=utf8', 'amacabr2', 'sub@bg10');
        } catch (Exception $e) {
            die('Erreur : ' . $e->getMessage());
        }
    }

    public function getAll() {
        return $this->bdd->query("select * from parking", PDO::FETCH_ASSOC)->fetchAll();
    }

    public function getSelect($id) {
        $prepare = $this->bdd->prepare("select * from parking where id = :id");
        $prepare->bindParam(':id', $id);
        $prepare->execute();
        return $prepare->fetch();
    }
}

$parkingAPI = new ParkingAPI();

if (isset($_GET['todo'])) {
    $todo = htmlspecialchars($_GET['todo']);

    if ($todo == "ALL") {
        $players = $parkingAPI->getAll();
        var_dump($players);
    } else if ($todo == "SELECT") {
        if (isset($_GET['id'])) {
            $player = $parkingAPI->getSelect(htmlspecialchars($_GET['id']));
            var_dump($player);
        }
    }
}