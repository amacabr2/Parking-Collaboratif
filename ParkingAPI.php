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

        return $prepare->fetch(PDO::FETCH_ASSOC);
    }

    public function postAdd(array $parking) {
        $prepare = $this->bdd->prepare("INSERT INTO parking (prix_horaire, surveille, souterrain, disponible, adresse) VALUES (:prix_horaire, :surveille, :souterrain, :disponible, :adresse)");
        $prepare->bindParam(':prix_horaire', $parking['prix_horaire']);
        $prepare->bindParam(':surveille', $parking['surveille']);
        $prepare->bindParam(':souterrain', $parking['souterrain']);
        $prepare->bindParam(':disponible', $parking['disponible']);
        $prepare->bindParam(':adresse', $parking['adresse']);

        return $prepare->execute();
    }
}

$parkingAPI = new ParkingAPI();

if (isset($_GET['todo'])) {
    $todo = htmlspecialchars($_GET['todo']);

    if ($todo == "ALL") {
        $players = $parkingAPI->getAll();
        echo json_encode($players);
    } else if ($todo == "SELECT") {
        if (isset($_GET['id'])) {
            $player = $parkingAPI->getSelect(htmlspecialchars($_GET['id']));
            echo json_encode($player);
        }
    }
}


if ($inputJson = file_get_contents('php://input')) {
    $input = json_decode($inputJson, true);

    if ($input['method'] == "POST") {
        $parking = [
            'prix_horaire' => (float)htmlspecialchars($input['data']['prix_horaire']),
            'surveille' => (int)htmlspecialchars($input['data']['surveille']),
            'souterrain' => (int)htmlspecialchars($input['data']['souterrain']),
            'disponible' => (int)htmlspecialchars($input['data']['disponible']),
            'adresse' => htmlspecialchars($input['data']['adresse'])
        ];

        echo $parkingAPI->postAdd($parking);
    }
}