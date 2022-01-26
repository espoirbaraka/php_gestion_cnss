<?php
	include './includes/conn.php';

		$conn = $pdo->open();
                    $stmt = $conn->prepare("SELECT * FROM t_user");
                    $stmt->execute();
                    
                    $result=array();
                    while($fetchData=$stmt->fetch()){
                        $result[]=$fetchData;
                    }
                    echo json_encode($result);
            

		$pdo->close();
	


?>