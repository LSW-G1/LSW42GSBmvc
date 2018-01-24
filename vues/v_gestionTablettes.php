
<div id="contenu">
	<h2>Gestion tablette</h2>

	<table>
		<tr>
			<th>Modification</th>
			<th>Suppression</th>
			<th>ID</th>
			<th>RAM</th>
			<th>OS</th>
			<th>Supprimable</th>
		</tr>
		<?php
			foreach ($tablettes as $tablette){ ?>
			<tr>
				<td><a href="index.php?uc=gererTablettes&action=changerTablette&id=<?= $tablette->id; ?>">Modifier</a></td>
                <td><a href="index.php?uc=gererTablettes&action=supprimerTablette&id=<?= $tablette->id; ?>">Supprimer</a></td>
				<td><?= $tablette->id; ?></td>
	            <td><?= $tablette->memoireVive; ?></td>
	            <td><?= $tablette->type; ?></td>
	            <?php 
	            foreach ($tablettesEnStock as $tabletteStock)
	            {
	            	// print_r($tablettesEnStock); die();
	            	if ($tabletteStock->id == $tablette->id) { ?>
	            		<td> X </td>
	            	<?php } ?>
	            <?php } ?>
			</tr>
		<?php } ?>
	</table>

	<a href="index.php?uc=gererTablettes&action=changerTablette">+ Ajout d'une nouvelle tablette</a>