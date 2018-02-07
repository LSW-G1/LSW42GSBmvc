<?php
include("vues/v_sommaire.php");
$idVisiteur = $_SESSION['idVisiteur'];
$date = getMois(date("Y-m-d"));
$action = $_REQUEST['action'];

switch ($action) {
    case 'saisirCompteRendu':
    {
    	$clients = $pdo->getClients();
    	include('vues/v_ajoutCompteRendu.php');
    	break;
    }
    case 'validerCompteRendu':
    {
    	$contenu = $_REQUEST['contenue'];
    	$note = $_REQUEST['note'];
    	$idClient = $_REQUEST['client'];
    	$pdo->addCompteRendu($idVisiteur, $contenu, $note, $date, $idClient);
    }
    case 'listeCompteRendu':
    {
    	// client / nom / métier
    	if ($idVisiteur == 'dev') 
    	{
    		$data = $pdo->getCompteRendu(); //liste de tous les comptes rendu
    	}
    	else
    	{
    		$data = $pdo->getCompteRendu($idVisiteur); //liste des comptes rendu du visiteur
    	}
    	include('vues/v_listeCompteRendu.php');
    	break;
    }
    case 'compteRendu':
    {
        $data = $pdo->getCompteRendu($idVisiteur, $numeroOrdre);
        include('vues/compteRendu.php');
        break;
    }	
}
// ajout compte rendu -> v_ajoutCompteRendu.php
// etat compte rendu -> voir ce qu'il y a dans -> v_etatCompteRendu.php
// liste des compte rendu -> v_compteRendu.php 
?>