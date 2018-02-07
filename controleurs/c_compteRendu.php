<?php
include("vues/v_sommaire.php");
$idVisiteur = $_SESSION['idVisiteur'];
$aaaamm = getMois(date("d/m/Y"));
$action = $_REQUEST['action'];

switch ($action) {
    case 'saisirCompteRendu':
    {
    	$clients = $pdo->getClient();
    	include('v_ajoutCompteRendu.php');
    	break;
    }
    case 'validerCompteRendu':
    {
    	$contenu = $_REQUEST['contenue'];
    	$note = $_REQUEST['note'];
    	$idClient = $_REQUEST['client'];
    	$pdo->($contenu, $note, $aaaamm, $idVisiteur, $idClient);
    	break;
    }
    case 'compteRendu':
    {
    	// client / nom / métier
    	if ($idVisiteur == 'dev') 
    	{
    		$data = $pdo->(); //liste de tous les comptes rendu
    	}
    	else
    	{
    		$data = $pdo->($idVisiteur); //liste des comptes rendu du visiteur
    	}
    	include('v_listeCompteRendu');
    	break;
    }
    	

// ajout compte rendu -> v_ajoutCompteRendu.php
// etat compte rendu -> voir ce qu'il y a dans -> v_etatCompteRendu.php
// liste des compte rendu -> v_compteRendu.php 
?>