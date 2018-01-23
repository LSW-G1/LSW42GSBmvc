<!-- Division pour le sommaire -->
<div id="menuGauche">
    <div id="infosUtil">

        <h2>

        </h2>

    </div>
    <ul id="menuList">
        <li>
            Visiteur :<br>
            <?php echo $_SESSION['prenom'] . "  " . $_SESSION['nom'] ?>
        </li>
        <li class="smenu">
            <a href="index.php?uc=gererFrais&action=saisirFrais" title="Saisie fiche de frais ">Saisie fiche de
                frais</a>
        </li>
        <li class="smenu">
            <a href="index.php?uc=etatFrais&action=selectionnerMois" title="Consultation de mes fiches de frais">Mes
                fiches de frais</a>
        </li>
        <li class="smenu">
            <a href="index.php?uc=gererTablettes&action=voirTablette" title="Votre tablette">Votre tablette</a>
        </li>
        <?php if ($_SESSION["idVisiteur"] == "daf") { ?>
            <li class="smenu">
                <a href="index.php?uc=gererTablettes&action=voirTablettesEnStock" title="Tablettes en Stock">Tablettes en stock</a>
            </li>
            <li class="smenu">
                <a href="index.php?uc=gererTablettes&action=gererTablettes" title="Gestion Tablettes">Gestion Tablettes</a>
            </li>
        <?php } ?>
        <li class="smenu">
            <a href="index.php?uc=connexion&action=deconnexion" title="Se déconnecter">Déconnexion</a>
        </li>
    </ul>

</div>
    