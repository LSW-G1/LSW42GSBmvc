<!-- Tableau des comptes rendus -->
<div id="contenu">
    <a href="index.php?uc=compteRendu&action=saisirCompteRendu"><button style="width: 100%;">Ajouter un compte rendu</button></a>
    <table style="width:100%">
        <tr>
            <th>Nom Visiteur</th>
            <th>Prénom Visiteur</th>
            <th>Nom Client</th>
            <th>Prénom Client</th>
            <th>Date Visite</th>
            <th>Note</th>
            <th>Lire</th>
        </tr>
        <?php foreach ($data as $client): ?>
        <tr>
            <td><?= $client["nomVisiteur"]; ?></td>
            <td><?= $client["prenomVisiteur"]; ?></td>
            <td><?= $client["nomClient"]; ?></td>
            <td><?= $client["prenomClient"]; ?></td>
            <td><?= $client["dateVisite"]; ?></td>
            <td><?= $client["note"]; ?></td>
            <td><a href="#">Lire le compte rendu</a></td>
        </tr>
        <?php endforeach; ?>
    </table>

