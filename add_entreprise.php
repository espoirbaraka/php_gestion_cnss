<?php
	include './includes/conn.php';

		$nom = $_POST['nom'];
        $siege = $_POST['siege'];

		$conn = $pdo->open();
		if($nom!="" && $siege!="")
		{
			$stmt = $conn->prepare("CALL add_entreprise(:design, :siege)");
            $stmt->execute(['design'=>$nom, 'siege'=>$siege]);
		}
                    
                  
            

		$pdo->close();
	


?>