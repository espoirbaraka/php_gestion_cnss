<?php
	include './includes/conn.php';

		$conn = $pdo->open();
                    $stmt = $conn->prepare("SELECT * FROM t_contribution INNER JOIN t_membre ON t_contribution.CodeMembre=t_membre.CodeMembre ORDER BY CodeContribution DESC");
                    $stmt->execute();
                    
                    $result=array();
                    while($fetchData=$stmt->fetch()){
                        $result[]=$fetchData;
                    }
                    echo json_encode($result);
            

		$pdo->close();
	


?>