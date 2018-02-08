﻿<?php
/**
 * Classe d'accès aux données.
 * Utilise les services de la classe PDO
 * pour l'application GSB
 * Les attributs sont tous statiques,
 * les 4 premiers pour la connexion
 * $monPdo de type PDO
 * $monPdoGsb qui contiendra l'unique instance de la classe
 * @package default
 * @author Cheri Bibi
 * @version    1.0
 * @link       http://www.php.net/manual/fr/book.pdo.php
 */

class PdoGsb
{
    private static $serveur = 'mysql:host=localhost';
    private static $bdd = 'dbname=gsb_frais';
    private static $user = 'root';
    private static $mdp = 'root';
    private static $monPdo;
    private static $monPdoGsb = null;

    /**
     * Constructeur privé, crée l'instance de PDO qui sera sollicitée
     * pour toutes les méthodes de la classe
     */
    private function __construct()
    {
        PdoGsb::$monPdo = new PDO(PdoGsb::$serveur . ';' . PdoGsb::$bdd, PdoGsb::$user, PdoGsb::$mdp);
        PdoGsb::$monPdo->query("SET CHARACTER SET utf8");
    }

    /**
     * Fonction statique qui crée l'unique instance de la classe
     * Appel : $instancePdoGsb = PdoGsb::getPdoGsb();
     * @return l'unique objet de la classe PdoGsb
     */
    public static function getPdoGsb()
    {
        if (PdoGsb::$monPdoGsb == null) {
            PdoGsb::$monPdoGsb = new PdoGsb();
        }
        return PdoGsb::$monPdoGsb;
    }

    public function _destruct()
    {
        PdoGsb::$monPdo = null;
    }

    /**
     * Retourne les informations d'un visiteur
     * @param $login
     * @param $mdp
     * @return l'id, le nom et le prénom sous la forme d'un tableau associatif
     */
    public function getInfosVisiteur($login, $mdp)
    {
        $req = "select Visiteur.id as id, Visiteur.nom as nom, Visiteur.prenom as prenom from Visiteur 
		where Visiteur.login='$login' and Visiteur.mdp='$mdp'";
        $rs = PdoGsb::$monPdo->query($req);
        $ligne = $rs->fetch();
        return $ligne;
    }

    /**
     * Retourne sous forme d'un tableau associatif toutes les lignes de frais hors forfait
     * concernées par les deux arguments
     * La boucle foreach ne peut être utilisée ici car on procède
     * à une modification de la structure itérée - transformation du champ date-
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     * @return tous les champs des lignes de frais hors forfait sous la forme d'un tableau associatif
     */
    public function getLesFraisHorsForfait($idVisiteur, $mois)
    {
        $req = "select * from LigneFraisHorsForfait where LigneFraisHorsForfait.idVisiteur ='$idVisiteur' 
		and LigneFraisHorsForfait.mois = '$mois' ";
        $res = PdoGsb::$monPdo->query($req);
        $lesLignes = $res->fetchAll();
        $nbLignes = count($lesLignes);
        for ($i = 0; $i < $nbLignes; $i++) {
            $date = $lesLignes[$i]['date'];
            $lesLignes[$i]['date'] = dateAnglaisVersFrancais($date);
        }
        return $lesLignes;
    }

    /**
     * Retourne le nombre de justificatif d'un visiteur pour un mois donné
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     * @return le nombre entier de justificatifs
     */
    public function getNbjustificatifs($idVisiteur, $mois)
    {
        $req = "select FicheFrais.nbJustificatifs as nb from  FicheFrais where FicheFrais.idVisiteur ='$idVisiteur' and FicheFrais.mois = '$mois'";
        $res = PdoGsb::$monPdo->query($req);
        $laLigne = $res->fetch();
        return $laLigne['nb'];
    }

    /**
     * Retourne sous forme d'un tableau associatif toutes les lignes de frais au forfait
     * concernées par les deux arguments
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     * @return l'id, le libelle et la quantité sous la forme d'un tableau associatif
     */
    public function getLesFraisForfait($idVisiteur, $mois)
    {
        $req = "select FraisForfait.id as idfrais, FraisForfait.libelle as libelle, 
		LigneFraisForfait.quantite as quantite from LigneFraisForfait inner join FraisForfait 
		on FraisForfait.id = LigneFraisForfait.idFraisForfait
		where LigneFraisForfait.idVisiteur ='$idVisiteur' and LigneFraisForfait.mois='$mois' 
		order by LigneFraisForfait.idFraisForfait";
        $res = PdoGsb::$monPdo->query($req);
        $lesLignes = $res->fetchAll();
        return $lesLignes;
    }

    /**
     * Met à jour la table ligneFraisForfait
     * Met à jour la table ligneFraisForfait pour un visiteur et
     * un mois donné en enregistrant les nouveaux montants
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     * @param $lesFrais tableau associatif de clé idFrais et de valeur la quantité pour ce frais
     * @return un tableau associatif
     */
    public function majFraisForfait($idVisiteur, $mois, $lesFrais)
    {
        $lesCles = array_keys($lesFrais);
        foreach ($lesCles as $unIdFrais) {
            $qte = $lesFrais[$unIdFrais];
            $req = "update LigneFraisForfait set LigneFraisForfait.quantite = $qte
			where LigneFraisForfait.idVisiteur = '$idVisiteur' and LigneFraisForfait.mois = '$mois'
			and LigneFraisForfait.idFraisForfait = '$unIdFrais'";
            PdoGsb::$monPdo->exec($req);
        }

    }

    /**
     * met à jour le nombre de justificatifs de la table ficheFrais
     * pour le mois et le visiteur concerné
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     */
    public function majNbJustificatifs($idVisiteur, $mois, $nbJustificatifs)
    {
        $req = "update FicheFrais set nbJustificatifs = $nbJustificatifs 
		where FicheFrais.idVisiteur = '$idVisiteur' and FicheFrais.mois = '$mois'";
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * Teste si un visiteur possède une fiche de frais pour le mois passé en argument
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     * @return vrai ou faux
     */
    public function estPremierFraisMois($idVisiteur, $mois)
    {
        $ok = false;
        $req = "select count(*) as nblignesfrais from FicheFrais 
		where FicheFrais.mois = '$mois' and FicheFrais.idVisiteur = '$idVisiteur'";
        $res = PdoGsb::$monPdo->query($req);
        $laLigne = $res->fetch();
        if ($laLigne['nblignesfrais'] == 0) {
            $ok = true;
        }
        return $ok;
    }

    /**
     * Crée une nouvelle fiche de frais et les lignes de frais au forfait pour un visiteur et un mois donnés
     * récupère le dernier mois en cours de traitement, met à 'CL' son champs idEtat, crée une nouvelle fiche de frais
     * avec un idEtat à 'CR' et crée les lignes de frais forfait de quantités nulles
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     */
    public function creeNouvellesLignesFrais($idVisiteur, $mois)
    {
        $dernierMois = $this->dernierMoisSaisi($idVisiteur);
        $laDerniereFiche = $this->getLesInfosFicheFrais($idVisiteur, $dernierMois);
        if ($laDerniereFiche['idEtat'] == 'CR') {
            $this->majEtatFicheFrais($idVisiteur, $dernierMois, 'CL');

        }
        $req = "insert into FicheFrais(idVisiteur,mois,nbJustificatifs,montantValide,dateModif,idEtat) 
		values('$idVisiteur','$mois',0,0,now(),'CR')";
        PdoGsb::$monPdo->exec($req);
        $lesIdFrais = $this->getLesIdFrais();
        foreach ($lesIdFrais as $uneLigneIdFrais) {
            $unIdFrais = $uneLigneIdFrais['idfrais'];
            $req = "insert into LigneFraisForfait(idVisiteur,mois,idFraisForfait,quantite) 
			values('$idVisiteur','$mois','$unIdFrais',0)";
            PdoGsb::$monPdo->exec($req);
        }
    }

    /**
     * Retourne le dernier mois en cours d'un visiteur
     * @param $idVisiteur
     * @return le mois sous la forme aaaamm
     */
    public function dernierMoisSaisi($idVisiteur)
    {
        $req = "select max(mois) as dernierMois from FicheFrais where FicheFrais.idVisiteur = '$idVisiteur'";
        $res = PdoGsb::$monPdo->query($req);
        $laLigne = $res->fetch();
        $dernierMois = $laLigne['dernierMois'];
        return $dernierMois;
    }

    /**
     * Retourne les informations d'une fiche de frais d'un visiteur pour un mois donné
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     * @return un tableau avec des champs de jointure entre une fiche de frais et la ligne d'état
     */
    public function getLesInfosFicheFrais($idVisiteur, $mois)
    {
        $req = "select FicheFrais.idEtat as idEtat, FicheFrais.dateModif as dateModif, FicheFrais.nbJustificatifs as nbJustificatifs, 
			FicheFrais.montantValide as montantValide, Etat.libelle as libEtat from  FicheFrais inner join Etat on FicheFrais.idEtat = Etat.id 
			where FicheFrais.idVisiteur ='$idVisiteur' and FicheFrais.mois = '$mois'";
        $res = PdoGsb::$monPdo->query($req);
        $laLigne = $res->fetch();
        return $laLigne;
    }

    /**
     * Modifie l'état et la date de modification d'une fiche de frais
     * Modifie le champ idEtat et met la date de modif à aujourd'hui
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     */

    public function majEtatFicheFrais($idVisiteur, $mois, $etat)
    {
        $req = "update FicheFrais set idEtat = '$etat', dateModif = now() 
		where FicheFrais.idVisiteur ='$idVisiteur' and FicheFrais.mois = '$mois'";
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * Retourne tous les id de la table FraisForfait
     * @return un tableau associatif
     */
    public function getLesIdFrais()
    {
        $req = "SELECT FraisForfait.id AS idfrais FROM FraisForfait ORDER BY FraisForfait.id";
        $res = PdoGsb::$monPdo->query($req);
        $lesLignes = $res->fetchAll();
        return $lesLignes;
    }

    /**
     * Crée un nouveau frais hors forfait pour un visiteur un mois donné
     * à partir des informations fournies en paramètre
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     * @param $libelle : le libelle du frais
     * @param $date : la date du frais au format français jj//mm/aaaa
     * @param $montant : le montant
     */
    public function creeNouveauFraisHorsForfait($idVisiteur, $mois, $libelle, $date, $montant)
    {
        $dateFr = dateFrancaisVersAnglais($date);
        $req = "insert into LigneFraisHorsForfait 
		values('','$idVisiteur','$mois','$libelle','$dateFr','$montant')";
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * Supprime le frais hors forfait dont l'id est passé en argument
     * @param $idFrais
     */
    public function supprimerFraisHorsForfait($idFrais)
    {
        $req = "delete from LigneFraisHorsForfait where LigneFraisHorsForfait.id =$idFrais ";
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * Retourne les mois pour lesquel un visiteur a une fiche de frais
     * @param $idVisiteur
     * @return un tableau associatif de clé un mois -aaaamm- et de valeurs l'année et le mois correspondant
     */
    public function getLesMoisDisponibles($idVisiteur)
    {
        $req = "select FicheFrais.mois as mois from  FicheFrais where FicheFrais.idVisiteur ='$idVisiteur' 
		order by FicheFrais.mois desc ";
        $res = PdoGsb::$monPdo->query($req);
        $lesMois = array();
        $laLigne = $res->fetch();
        while ($laLigne != null) {
            $mois = $laLigne['mois'];
            $numAnnee = substr($mois, 0, 4);
            $numMois = substr($mois, 4, 2);
            $lesMois["$mois"] = array(
                "mois" => "$mois",
                "numAnnee" => "$numAnnee",
                "numMois" => "$numMois"
            );
            $laLigne = $res->fetch();
        }
        return $lesMois;
    }

    /**
     * Retourne tous les clients de la base de données
     * @return un tableau contenant tous les clients
     */
    public function getClients()
    {
        $req = "SELECT * FROM Client";
        $res = PdoGsb::$monPdo->query($req);

        return $res;
    }

    public function getListeCompteRendu($idVisiteur = null)
    {
        $req = "SELECT Client.nom AS nomClient, Client.prenom AS prenomClient, CompteRendu.note AS note, Visiteur.nom AS nomVisiteur, Visiteur.prenom AS prenomVisiteur, CompteRendu.dateVisite, CompteRendu.numeroOrdre FROM Client, CompteRendu, Visiteur WHERE Client.idClient = CompteRendu.idClient AND Visiteur.id = CompteRendu.idVisiteur";
        if (isset($idVisiteur))
        {
            $req .= " AND CompteRendu.idVisiteur = '$idVisiteur'";
        }
        
        $res = PdoGsb::$monPdo->query($req);
        return $res;
    }

    public function getCompteRendu($idVisiteur, $numeroOrdre)
    {
        $req = "SELECT CompteRendu.numeroOrdre AS numeroOrdre, TypeClient.libelle AS metier, Client.nom AS nomClient, Client.prenom AS prenomClient, CompteRendu.contenu AS contenu, CompteRendu.note AS note, Visiteur.nom AS nomVisiteur, Visiteur.prenom AS prenomVisiteur FROM Client, CompteRendu, TypeClient, Visiteur WHERE TypeClient.idTypeClient = Client.idTypeClient AND Client.idClient = CompteRendu.idClient AND CompteRendu.idVisiteur = '$idVisiteur' AND CompteRendu.numeroOrdre = '$numeroOrdre';";
        $res = PdoGsb::$monPdo->query($req);
        $data = $res->fetch();

        return $data;
    }

    public function addCompteRendu($idVisiteur, $contenu, $note, $date, $idClient)
    {
        $req = "SELECT MAX(numeroOrdre) AS ordreActuel FROM CompteRendu WHERE idVisiteur = '$idVisiteur'";
        $res = PdoGsb::$monPdo->query($req);

        $ordreActuel = $res->fetch();
        $ordreActuel = intval($ordreActuel[0]) + 1;

        $req = "INSERT INTO CompteRendu VALUES (:ordreActuel, :idVisiteur, :contenu, :note, :date, :idClient)";
        
        $reqPrep = PdoGsb::$monPdo->prepare($req);
        $reqPrep->execute(array(":ordreActuel" => $ordreActuel, ":idVisiteur" => $idVisiteur, ":contenu" => $contenu, ":note" => $note, ":date" => $date, ":idClient" => $idClient));
    }

    public function updateCompteRendu($idVisiteur, $numeroOrdre, $contenu, $note, $idClient)
    {
        $req = "UPDATE CompteRendu SET contenu = (:contenu), note = (:note), idClient = (:idClient) 
            WHERE idVisiteur='$idVisiteur' AND numeroOrdre = '$numeroOrdre' ";
        $res = PdoGsb::$monPdo->prepare($req);
        $res->execute(array(":contenu" => $contenu, ":note" => $note, ":idClient" => $idClient));
    }

    public function deleteCompteRendu($idVisiteur, $numeroOrdre)
    {
        $req = "DELETE FROM CompteRendu WHERE idVisiteur = (:idVisiteur) AND numeroOrdre = (:numeroOrdre)";
        $res = PdoGsb::$monPdo->prepare($req);
        $res->execute(array(":idVisiteur" => $idVisiteur, ":numeroOrdre" => $numeroOrdre));
    }
}

?>
