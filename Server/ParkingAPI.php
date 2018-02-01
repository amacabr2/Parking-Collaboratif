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

    public function add(array $parking) {
        $prepare = $this->bdd->prepare("INSERT INTO parking (prix_horaire, surveille, souterrain, disponible, adresse) VALUES (:prix_horaire, :surveille, :souterrain, :disponible, :adresse)");

        $prepare->bindParam(':prix_horaire', $parking['prix_horaire']);
        $prepare->bindParam(':surveille', $parking['surveille']);
        $prepare->bindParam(':souterrain', $parking['souterrain']);
        $prepare->bindParam(':disponible', $parking['disponible']);
        $prepare->bindParam(':adresse', $parking['adresse']);

        return $prepare->execute();
    }

    public function update(array $parking) {
        $prepare = $this->bdd->prepare("
            UPDATE parking SET
                prix_horaire = :prix_horaire,
                surveille = :surveille,
                souterrain = :souterrain,
                disponible = :disponible,
                adresse = :adresse 
            WHERE id = :id     
        ");

        $prepare->bindParam(':prix_horaire', $parking['prix_horaire']);
        $prepare->bindParam(':surveille', $parking['surveille']);
        $prepare->bindParam(':souterrain', $parking['souterrain']);
        $prepare->bindParam(':disponible', $parking['disponible']);
        $prepare->bindParam(':adresse', $parking['adresse']);
        $prepare->bindParam(':id', $parking['id']);

        return $prepare->execute();
    }

    public function delete(int $id) {
        $prepare = $this->bdd->prepare("DELETE FROM parking WHERE id = :id");

        $prepare->bindParam(':id', $id);

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


if (isset($_POST['method'])) {
   $method = htmlspecialchars($_POST['method'])

    if ($method == "POST") {
        if (isset($_POST['prix_horaire']) && isset($_POST['surveille']) && isset($_POST['souterrain']) && isset($_POST['disponible']) && isset($_POST['adresse']) {
            $parking = [
                'prix_horaire' => (float)htmlspecialchars($_POST['prix_horaire']),
                'surveille' => (int)htmlspecialchars($_POST['surveille']),
                'souterrain' => (int)htmlspecialchars($_POST['souterrain']),
                'disponible' => (int)htmlspecialchars($_POST['disponible']),
                'adresse' => htmlspecialchars($_POST['adresse'])
            ];

            echo $parkingAPI->add($parking);
        }

        
    }

    if ($method == "UPDATE") {
        if (isset($_POST['prix_horaire']) && isset($_POST['surveille']) && isset($_POST['souterrain']) && isset($_POST['disponible']) && isset($_POST['adresse'] && isset($_POST['id'])) {
            $parking = [
            'prix_horaire' => (float)htmlspecialchars($_POST['prix_horaire']),
            'surveille' => (int)htmlspecialchars($_POST['surveille']),
            'souterrain' => (int)htmlspecialchars($_POST['souterrain']),
            'disponible' => (int)htmlspecialchars($_POST['disponible']),
            'adresse' => htmlspecialchars($_POST['adresse']),
            'id' => (int)htmlspecialchars($_POST['id']))
            ];

            echo $parkingAPI->update($parking);
        }
    }

    if ($input['method'] == "DELETE") {
        $id = (int)htmlspecialchars($_POST['id']));

        echo $parkingAPI->delete($id);
    }
}