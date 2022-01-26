<?php
	include './includes/conn.php';

		$conn = $pdo->open();
                    $stmt = $conn->prepare("SELECT * FROM t_membre INNER JOIN t_entreprise ON t_membre.CodeEntreprise=t_entreprise.CodeEntreprise");
                    $stmt->execute();
                    
                    $result=array();
                    while($fetchData=$stmt->fetch()){
                        $result[]=$fetchData;
                    }
                    echo json_encode($result);
            

		$pdo->close();
	


?>