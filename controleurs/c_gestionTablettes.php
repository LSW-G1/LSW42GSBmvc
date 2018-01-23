<?php
include("vues/v_sommaire.php");
$action = $_REQUEST['action'];
$idVisiteur = $_SESSION['idVisiteur'];
switch ($action) {
    case 'voirTablette':
        {
            $tablette = $pdo->getLaTablette($idVisiteur);
            include("vues/v_tablette.php");
            break;
        }
    case 'voirTablettesEnStock':
        {
            if ($_SESSION['idVisiteur'] == "daf") {
                $tablettes = $pdo->getTablettesEnStock();
                include("vues/v_tablettesEnStock.php");
            } else {
                header('Location: index.php?uc=etatFrais&action=voirTablette');
            }
            break;
        }
}
?>