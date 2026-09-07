<?php
// At the top of your API file
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Check request method
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    //Se lee el json que esta en body del answer del  post

    $data =  file_get_contents("php://input");
    $data2 =  json_decode($data );

        $rssi = $data2->uplink_message->rx_metadata[0]->rssi;
                $dispositivo = (string)$data2->end_device_ids->dev_eui;
        echo " <-------> dispositivos ";
        echo $dispositivo; // $data2->uplink_message->rx_metadata[0]->rssi;


        $campos = "rssi , ";
        $valores = " $rssi  " . " ,";
        $registro_duplicado = " ON DUPLICATE KEY UPDATE ";
        // Separador de campos  prefijo, la primera vez vacio
        $separador = "";
        //echo $data2->end_device_ids->dev_addr;
        //echo $data2->uplink_message->decoded_payload->Unidad;
        

        
        echo " RSSI <-------> ";
                    // Para hacer mas legible el query que ya es muy largo
            $dev_eui = gettype($data2->end_device_ids);
            echo $dev_eui ;

        foreach ($data2->uplink_message->decoded_payload   as $clave => $valor) {

        if ( $clave ==="Final"  && $valor === "end"  ) {
                    //$mysqli->query("CALL p(1)");
                    //->decoded_payload->idtrack
                    $query = "CALL TOV452_END( " . $data2->uplink_message->decoded_payload->idTrack . "  )";
                    echo $clave . "Esto es el fin de la transmision " . $valor . " " . $query;
                    break; // Sale del foreach cuando encuentra FINAL.END y va a grabar 
        }
        else{
        echo $clave . ": " . $valor . "<br>";
        //  poner al final un campo para evitar quitar la coma
        $campos = $campos . $separador . $clave ;
        $valores = $valores . $separador . $valor  ;
        $registro_duplicado = $registro_duplicado . $separador . $clave . " = values(" . $clave . " ) ";
        // a partir de la segunda iteracion va con coma 
        $separador = ",";
        }
            echo $valores ;
            echo $campos;
            echo $campos . "---------->>>>>>>>>>" . $valores;
            echo 'Process the data';


            
           
            //$query = "insert TOV452 (TOV452_ID," . $campos ."track)  values (5," . $valores ."     '".$data."') " . $registro_duplicado. "  ;";
             //$query = "insert TOV452 (TOV452_ID," . $campos .", track)  values ( '" . $dispositivo . "' ," . $valores ."   ,  'data' ) " . $registro_duplicado. "  ;";

            $query = "insert TOV452 (TOV452_ID," . $campos .", fecha )  values ( '" . $dispositivo . "' ," . $valores ."   ,  now() ) " . $registro_duplicado. "  ;";

            //echo "Debug  message el query -> " . $query . "<-----";
             echo "idTrack ->>>>>>" . $data2->uplink_message->decoded_payload->idTrack;
            echo "dev_eui ->>>>>>" . $data2->end_device_ids->dev_eui;
        }

//$query = "insert package values (null,5,1,'".$data."');";

/****************************** */
//Desactiva grabacion 
//exit();
/****************************** */

//grabando lo que llego
try{
//TODO Variables  planchadas para acceder a la base de datos
 $con= new PDO('mysql:host=localhost;dbname=TGV_Dev', "root", "root");
 $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
 $result = $con->query($query); 
 $row = $result->fetch(PDO::FETCH_ASSOC);
  } catch(PDOException $e) {
 echo 'ERROR: ' . $e->getMessage();
 } // end try

} 
elseif ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // Your GET logic here
    echo json_encode(["message" => "GET request received"]);
} 
else {
    // Method not allowed
    http_response_code(405);
    echo json_encode(["message" => "Method not allowed"]);
}
?>
