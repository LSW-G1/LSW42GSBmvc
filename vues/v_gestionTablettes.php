<div id="contenu">
	<h2>Gestion tablette</h2>

	<table>
		<tr>
			<th>Modification</th>
			<th>Suppression</th>
			<th>ID</th>
			<th>RAM</th>
			<th>OS</th>
		</tr>
		<?php
			foreach ($tablettes as $tablette){ ?>
			<tr>
				<td></td>
				<td></td>
				<td><?= $tablette->id; ?></td>
	            <td><?= $tablette->memoireVive; ?></td>
	            <td><?= $tablette->type; ?></td>
			</tr>
		<?php } ?>
	</table>

	<a href="vues/v_changerTablette.php">+ Ajout d'une nouvelle tablette</a>