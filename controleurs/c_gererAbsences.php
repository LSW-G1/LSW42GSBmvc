<?php
include("vues/v_sommaire.php");
$action = $_REQUEST['action'];
$idVisiteur = $_SESSION['idVisiteur'];
$aaaamm = getMois(date("d/m/Y"));
$numAnnee = substr($aaaamm, 0, 4);
$numMois = substr($aaaamm, 4, 2);
$mois = $numMois;
switch ($action) {
    case 'saisirAbsences':
        {
            $lesAbsences = $pdo->getListeAbsences($idVisiteur, $mois);
            $nonAbsents = $pdo->getVisiteursNonAbsents($mois);

            // Evite la boucle de reload si le visiteur n'a pas visité ses saisis frais ce mois ci.
            if ($pdo->estPremierFraisMois($idVisiteur, $mois)) {
                $pdo->creeNouvellesLignesFrais($idVisiteur, $mois);
            }

            if (empty($lesAbsences)) {
                $pdo->creerNouvellesLigneAbsence($idVisiteur, $mois);
                header("Refresh: 0");
            }

            include("vues/v_listeAbsences.php");
            break;
        }
    case 'validerMajAbsences':
	{
		$valider = true;
		$absences = $_REQUEST["absences"];
		$absencesActuelles = $pdo->getListeAbsences($idVisiteur, $mois);

		foreach ($absences as $code => $nombre)
		{
			foreach ($absencesActuelles as $ligne)
			{
				if (($code == $ligne["codeMotif"]) && ($nombre < $ligne["nombre"]))
				{
					$valider = false;
				}
			}
		}

		if ($valider)
		{
			$pdo->majLignesAbsences($idVisiteur, $mois, $absences);
			header("Location: index.php?uc=gererAbsences&action=saisirAbsences");
		}
		else
		{
			ajouterErreur("Vous ne pouvez pas enlever vos absences.");
			include("vues/v_erreurs.php");
			header("Refresh:3 url=index.php?uc=gererAbsences&action=saisirAbsences");
		}
	}
}
?>
