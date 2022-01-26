<?php
	include './includes/conn.php';

	
		$nom = $_POST['nom'];
        $postnom = $_POST['postnom'];
        $prenom = $_POST['prenom'];
        $lieunaiss = $_POST['lieunaiss'];
        $salaire = $_POST['salaire'];
        $nomconjoint = $_POST['nomconjoint'];
        $postnomconjoint = $_POST['postnomconjoint'];
        $code = $_POST['code'];
             

		$conn = $pdo->open();
                    // $stmt = $conn->prepare("INSERT INTO t_membre(NomMembre, PostnomMembre, PrenomMembre, LieuNaissance, SalaireMembre, NomConjoint, PostnomConjoint, CodeEntreprise) VALUES(:nom, :postnom, :prenom, :lieu, :salaire, :nomconjoint, :postnomconjoint, :code)");
                    $stmt = $conn->prepare("CALL add_membre(:nom,:postnom,:prenom,:salaire,:lieu,:nomconjoint,:postnomconjoint,:code)");
                    $stmt->execute(['nom'=>$nom, 'postnom'=>$postnom, 'prenom'=>$prenom, 'salaire'=>$salaire, 'lieu'=>$lieunaiss, 'nomconjoint'=>$nomconjoint, 'postnomconjoint'=>$postnomconjoint, 'code'=>$code]);
                  
            

		$pdo->close();
	


?>