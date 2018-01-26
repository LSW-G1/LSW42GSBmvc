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
                header('Location: index.php?uc=gererTablettes&action=voirTablette');
            }
            break;
        }
    case 'gererTablettes':
        {
            if ($_SESSION['idVisiteur'] == "daf") {
                $tablettes = $pdo->getTablettes();
                $tablettesEnStock = $pdo->getTablettesEnStock();
                include("vues/v_gestionTablettes.php");
            } else {
                header('Location: index.php?uc=gererTablettes&action=voirTablette');
            }
            break;
        }
    case 'changerTablette':
        {
            if ($_SESSION['idVisiteur'] == "daf") {
                if (!empty($_GET["id"])) {
                    $tablette = $pdo->getTabletteFromID($_GET["id"]);
                }
                include("vues/v_changerTablette.php");
            } else {
                header('Location: index.php?uc=gererTablettes&action=voirTablette');
            }
            break;
        }
    case 'validerChangement':
        {
            if ($_SESSION['idVisiteur'] == "daf") {
                if (!empty($_POST["id"])) {
                    $pdo->changeTablette($_POST);
                } else {
                    $pdo->addTablette($_POST);
                }
                header("Location: index.php?uc=gererTablettes&action=gererTablettes");
            } else {
                header("Location: index.php?uc=gererTablettes&action=voirTablette");
            }
            break;
        }
    case 'supprimerTablette':
        {
            if ($_SESSION['idVisiteur'] == "daf") {
                if (!empty($_GET["id"])) {
                    $result = $pdo->deleteTablette($_GET["id"]);
                    if (!$result) {
                        ajouterErreur("Cette tablette est affectée à un visiteur. Vous ne pouvez pas la supprimer.");
                        include("vues/v_erreurs.php");
                        break;
                    }
                }
            }
            header("Location: index.php?uc=gererTablettes&action=gererTablettes");
            break;
        }
}
?>