<?php
	include './includes/conn.php';

		$conn = $pdo->open();
                    $code=$_POST['id'];
                    $stmt = $conn->prepare("DELETE FROM t_membre WHERE CodeMembre=:code");
                    $stmt->execute(array('code'=>$code));
                    
            

		$pdo->close();
	


?>