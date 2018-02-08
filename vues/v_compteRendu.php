<!-- Compte rendu spécifique -->
<div id="contenu">
    <h2><?= "Compte Rendu: " . $data["nomVisiteur"] . " " . $data["prenomVisiteur"] . " pour " . $data['nomClient'] . " " . $data['prenomClient'] . " - " . $data['note'] . "/5 "; ?></h2>
    <p><?= $data["contenu"]; ?></p>

    <a href="index.php?uc=compteRendu&action=listeCompteRendu"><button>Retour</button></a>
    <a href="index.php?uc=compteRendu&action=modifier&idVisiteur=<?= $_SESSION['idVisiteur']; ?>&numeroOrdre=<?= $data['numeroOrdre']; ?>"><button>Modifier</button></a>
    <a href="index.php?uc=compteRendu&action=supprimer&idVisiteur=<?= $_SESSION['idVisiteur']; ?>&numeroOrdre=<?= $data['numeroOrdre']; ?>"><button>Supprimer</button></a>