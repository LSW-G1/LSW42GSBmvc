<div id="contenu">
    <h2>Renseigner mes absences du mois <?php echo $numMois . "-" . $numAnnee ?></h2>

    <form method="POST" action="index.php?uc=gererAbsences&action=validerMajAbsences">
        <div class="corpsForm">

            <fieldset>
                <legend>Abences
                </legend>
                <?php
                foreach ($lesAbsences as $uneAbsence) {
                    $codeMotif = $uneAbsence['codeMotif'];
                    $libelle = $uneAbsence['libelle'];
                    $quantite = $uneAbsence['nombre'];
                    ?>
                    <p>
                        <label for="absences"><?php echo $libelle ?></label>
                        <input type="text" id="absence" name="absence[<?php echo $idFrais ?>]" size="10" maxlength="5"
                               value="<?php echo $quantite ?>">
                    </p>

                    <?php
                }
                ?>


            </fieldset>
        </div>
        <div class="piedForm">
            <p>
                <input id="ok" type="submit" value="Valider" size="20"/>
                <input id="annuler" type="reset" value="Effacer" size="20"/>
            </p>
        </div>

    </form>
