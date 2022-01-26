<?php
	include './includes/conn.php';

	
		$username = $_POST['username'];
        $password = $_POST['password'];
        // $username = 'Espoir';
        // $password = 'admin';

		$conn = $pdo->open();
		
			$stmt = $conn->prepare("SELECT * FROM t_user WHERE Username = ? AND Password = ?");
            $stmt->execute(array($username,$password));
			$nbre = $stmt->rowCount();
			
			if($nbre == 1){
				echo json_encode("Success");
			}
			else{
				echo json_encode("Error");
			}
                  
            

		$pdo->close();
	


?>