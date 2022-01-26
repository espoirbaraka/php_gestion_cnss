<?php
	include './includes/conn.php';

	
		$membre = $_POST['membre'];
        $montant = $_POST['montant'];
        
             

		$conn = $pdo->open();
        
            $stmt = $conn->prepare("CALL cotiser_montant(:montant,:membre)");
            $stmt->execute(['montant'=>$montant, 'membre'=>$membre]);
                  
            

		$pdo->close();
	


?>