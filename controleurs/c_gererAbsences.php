<?php
include("vues/v_sommaire.php");
$action = $_REQUEST['action'];
$idVisiteur = $_SESSION['idVisiteur'];
$aaaamm = getMois(date("d/m/Y"));
$numAnnee = substr($aaaamm, 0, 4);
$numMois = substr($aaaamm, 4, 2);
$mois = $numMois;
switch ($action) 
{
	case 'saisirAbsences':
	{
		$lesAbsences = $pdo->getListeAbsences($idVisiteur, $mois);

		if (empty($lesAbsences))
        {
            $pdo->creerNouvellesLigneAbsence($idVisiteur, $mois);
            header("Refresh: 0");
        }

		include("vues/v_listeAbsences.php");
		break;
	}
    case 'validerMajAbsences':
        {
            $absences = $_REQUEST["absences"];
            $pdo->majLignesAbsences($idVisiteur, $mois, $absences);

            header("Location: index.php?uc=gererAbsences&action=saisirAbsences");
        }
}
?>