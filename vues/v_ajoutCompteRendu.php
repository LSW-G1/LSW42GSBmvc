<!-- Formulaire des comptes rendu accessibles -->
<div id="contenu">
    <form method="POST" action="index.php?uc=compteRendu&action=<?php 
    if(isset($data['contenu']))
    {
        echo("validerModification&idVisiteur=".$_SESSION['idVisiteur']."&numeroOrdre=".$data['numeroOrdre']);
    }
    else
    {
        echo('validerCompteRendu');
    }?>">

        <fieldset>
            <legend>Client</legend>
            <select name="client" required style="width: 100%;">
                <?php foreach($clients as $client): ?>
                    <option value="<?= $client["idClient"]; ?>"><?= $client["nom"]; ?></option>
                <?php endforeach; ?>
            </select>
        </fieldset>

        <fieldset>
            <legend>Compte Rendu</legend>
            <textarea name="contenue" cols="30" rows="10" required style="width: 100%;"><?php
                if (isset($data['contenu'])) 
                {
                    echo ($data['contenu']);
                }?>
            </textarea>
        </fieldset>

        <fieldset>
            <legend>Note</legend>
            <select name="note" style="width: 100%;>
                <?php for ($i = 0; $i <= 5; $i++):?>
                <option value="<?=$i;?>">
                    <?= $i; ?>
                </option>
                <?php endfor; ?>
            </select>
        </fieldset>

        <br>
        <button type="submit" style="width: 100%;"> Envoyer ! </button>
    </form>