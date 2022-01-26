<?php
	include './includes/conn.php';

		$username = $_POST['username'];
        $password = $_POST['password'];
        $id = $_POST['id'];

		$conn = $pdo->open();
                    $stmt = $conn->prepare("UPDATE t_user SET Username=:username, Password=:password WHERE CodeUser=:id");
                    $stmt->execute(['username'=>$username, 'password'=>$password, 'id'=>$id]);
                  
            

		$pdo->close();
	


?>