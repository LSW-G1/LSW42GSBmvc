<div id="contenu">
	<form action="index.php?uc=gererTablettes&action=ValiderChangement" method="post">
	    <div class="corpsForm">

	        <fieldset>
	            <legend>Nouvelle tablette
	            </legend>
	            <input type="text" id="txtDateHF" name="id" hidden="true" size="10" maxlength="10" value=""/>
	            <p>
	                <label for="txtLibelleHF">Nom</label>
	                <input type="text" id="txtLibelleHF" name="libelle" size="70" maxlength="256" value=""/>
	            </p>
	            <p>
	                <label for="txtMontantHFOS">Type</label>
	                <input type="text" id="txtMontantHF" name="type" size="10" maxlength="10" value=""/>
	            </p>
	            <p>
	                <label for="txtMontantHFOS">Marque</label>
	                <input type="text" id="txtMontantHF" name="marque" size="10" maxlength="10" value=""/>
	            </p>
	            <p>
	                <label for="txtMontantHFOS">MemoireVive</label>
	                <input type="text" id="txtMontantHF" name="ram" size="10" maxlength="10" value=""/>
	            </p>
	            <p>
	                <label for="txtMontantHFOS">MemoireDisque</label>
	                <input type="text" id="txtMontantHF" name="disque" size="10" maxlength="10" value=""/>
	            </p>
	            <p>
	                <label for="txtMontantHFOS">Prix</label>
	                <input type="text" id="txtMontantHF" name="prix" size="10" maxlength="10" value=""/>
	            </p>
	        </fieldset>
	    </div>
	    <div class="piedForm">
	        <p>
	            <input id="ajouter" type="submit" value="Ajouter" size="20"/>
	            <input id="effacer" type="reset" value="Effacer" size="20"/>
	        </p>
	    </div>

	</form>