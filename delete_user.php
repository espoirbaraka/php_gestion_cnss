<?php
	include './includes/conn.php';

		$conn = $pdo->open();
                    $code=$_POST['id'];
                    $stmt = $conn->prepare("DELETE FROM t_user WHERE CodeUser=:code");
                    $stmt->execute(array('code'=>$code));
                    
            

		$pdo->close();
	


?>