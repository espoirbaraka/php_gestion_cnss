<?php
	include './includes/conn.php';

		$username = $_POST['username'];
        $password = $_POST['password'];

		$conn = $pdo->open();
		if($username!="" && $password!="")
		{
			$stmt = $conn->prepare("INSERT INTO t_user(Username, Password) VALUES(:username, :password)");
            $stmt->execute(['username'=>$username, 'password'=>$password]);
		}
                    
                  
            

		$pdo->close();
	


?>