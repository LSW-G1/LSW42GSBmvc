<div id="contenu">
    <table>
        <tr>
            <th>ID</th>
            <th>RAM</th>
            <th>OS</th>
        </tr>
        <?php
        foreach ($tablettes as $tablette) { ?>
            <tr>
                <td><?= $tablette->id; ?></td>
                <td><?= $tablette->memoireVive; ?></td>
                <td><?= $tablette->type; ?></td>
            </tr>
        <?php } ?>
    </table>
