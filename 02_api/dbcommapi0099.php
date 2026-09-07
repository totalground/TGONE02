<?php
/**
 * API REST Dinámica - PHP + MySQL
 * Métodos: GET, POST, PUT, DELETE
 * Conexión dinámica vía parámetros JSON


*creado con claude 
*crea un API REST con los metodos POST, GET, PUT, DELETE en php que se conecte a una base de datos en mysql, debe recibir como parametro en un json , direccion del servidor, base de datos, usuario de base de datos , pasword de usuario de base de datos, tabla y duplas de campo, valor

*Esto no se lo puse pero lo sugirio Visual Studio code 
*para realizar las operaciones CRUD, el json debe ser enviado en el cuerpo de la solicitud HTTP, y la API debe procesar ese json para generar un query dinamico que se ejecute en la base de datos, y retornar una respuesta en formato JSON con el resultado de la operacion realizada, incluyendo mensajes de error si los hay.

 */

header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Manejo de preflight CORS
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// ─────────────────────────────────────────────
// Funciones auxiliares
// ─────────────────────────────────────────────

function responder(int $codigo, string $estado, string $mensaje, $datos = null): void {
    http_response_code($codigo);
    $respuesta = [
        "estado"  => $estado,
        "codigo"  => $codigo,
        "mensaje" => $mensaje,
    ];
    if ($datos !== null) {
        $respuesta["datos"] = $datos;
    }
    echo json_encode($respuesta, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
    exit();
}

function obtenerCuerpo(): array {
    $cuerpo = file_get_contents("php://input");
    if (empty($cuerpo)) {
        responder(400, "error", "El cuerpo de la solicitud está vacío o no es JSON válido.");
    }
    $datos = json_decode($cuerpo, true);
    if (json_last_error() !== JSON_ERROR_NONE) {
        responder(400, "error", "JSON inválido: " . json_last_error_msg());
    }
    return $datos;
}

function validarConexion(array $datos): void {
    $requeridos = ["servidor", "base_de_datos", "usuario", "password", "tabla", "action", "token"];
    foreach ($requeridos as $campo) {
        if (empty($datos[$campo])) {
            responder(400, "error", "El campo '$campo' es obligatorio en el JSON.");
        }
    }
}

function crearConexion(array $datos): PDO {
    $dsn = "mysql:host={$datos['servidor']};dbname={$datos['base_de_datos']};charset=utf8mb4";
    try {
        $pdo = new PDO($dsn, $datos['usuario'], $datos['password'], [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_TIMEOUT            => 5,
        ]);
        return $pdo;
    } catch (PDOException $e) {
        responder(503, "error", "No se pudo conectar a la base de datos: " . $e->getMessage());
    }
}

function sanitizarNombre(string $nombre): string {
    // Solo letras, números y guiones bajos
    if (!preg_match('/^[a-zA-Z0-9_]+$/', $nombre)) {
        responder(400, "error", "Nombre inválido: '$nombre'. Solo se permiten letras, números y guiones bajos.");
    }
    return $nombre;
}


function callget():void {
    $datos = obtenerCuerpo();
    validarConexion($datos);

        $pdo   = crearConexion($datos);
        $tabla = sanitizarNombre($datos['tabla']);

         if (!empty($datos['displayfields']) && is_array($datos['displayfields']))  {
            $displayfields = [];
            $displayfields =   $datos['displayfields'] ; // Campos a mostrar, por defecto todos   

            $stringfields = implode(", ", array_map(function($campo) {
                return "`" . sanitizarNombre($campo) . "`";
            }, $displayfields));
         } else {
            $stringfields = "*"; // Mostrar todos los campos si no se especifica límite
         }


        $sql    = "SELECT $stringfields FROM `$tabla`";
        $params = [];

        // Filtros opcionales mediante "condiciones"
         if (!empty($datos['condiciones']) && is_array($datos['condiciones'])) {
        $where = [];
        foreach ($datos['condiciones'] as $campo => $valor) {
        $campo   = sanitizarNombre($campo);
        $where[] = "`$campo` = :where_$campo";
        $params[":where_$campo"] = $valor;
        }

        $sql .= "  WHERE " . implode(" AND ", $where) . " ";
         }
        /********************************************** */


        // Límite opcional
        if (!empty($datos['limite']) && is_numeric($datos['limite'])) {
            $sql .= " LIMIT " . intval($datos['limite']);
                // offset opcional
                if (!empty($datos['offset']) && is_numeric($datos['offset'])) {
                $sql .= " OFFSET " . intval($datos['offset']);
                }
        }

        try {
            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);
            $registros = $stmt->fetchAll();
            $total = count($registros);
            responder(200, "éxito ". $sql , "$total registro(s) encontrado(s).", $registros);
        } catch (PDOException $e) {
            responder(500, "error ". $sql, "Error al consultar: " . $e->getMessage());
        }
}


function callpost():void {
    $datos = obtenerCuerpo();
    validarConexion($datos);

    if (empty($datos['campos']) || !is_array($datos['campos'])) {
        responder(400, "error", "El campo 'campos' es obligatorio con los valores a insertar.");
    }

    $pdo    = crearConexion($datos);
    $tabla  = sanitizarNombre($datos['tabla']);
    $campos = [];
    $placeholders = [];
    $params = [];

    foreach ($datos['campos'] as $campo => $valor) {
        $campo   = sanitizarNombre($campo);
        $campos[] = "`$campo`";
        $placeholders[] = ":$campo";
        $params[":$campo"] = $valor;
    }

    $sql = "INSERT INTO `$tabla` (" . implode(", ", $campos) . ") VALUES (" . implode(", ", $placeholders) . ")";

    try {
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        responder(201, "éxito", "Registro insertado correctamente.", ["id_insertado" => $pdo->lastInsertId()]);
    } catch (PDOException $e) {
        responder(500, "error", "Error al insertar: " . $e->getMessage());
    }
}

function callput():void {
    $datos = obtenerCuerpo();
    validarConexion($datos);

    if (empty($datos['campos']) || !is_array($datos['campos'])) {
        responder(400, "error", "El campo 'campos' es obligatorio con los valores a actualizar.");
    }
    if (empty($datos['condiciones']) || !is_array($datos['condiciones'])) {
        responder(400, "error", "El campo 'condiciones' es obligatorio para identificar el/los registro(s) a actualizar.");
    }

    $pdo    = crearConexion($datos);
    $tabla  = sanitizarNombre($datos['tabla']);
    $params = [];

    $set = [];
    foreach ($datos['campos'] as $campo => $valor) {
        $campo   = sanitizarNombre($campo);
        $set[]   = "`$campo` = :set_$campo";
        $params[":set_$campo"] = $valor;
    }

    $where = [];
    foreach ($datos['condiciones'] as $campo => $valor) {
        $campo   = sanitizarNombre($campo);
        $where[] = "`$campo` = :where_$campo";
        $params[":where_$campo"] = $valor;
    }

    $sql = "UPDATE `$tabla` SET " . implode(", ", $set) . " WHERE " . implode(" AND ", $where) . " " ;

    try {
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        responder(200, "éxito", "Registro(s) actualizado(s).", ["filas_afectadas" => $stmt->rowCount()]);
    } catch (PDOException $e) {
        responder(500, "error", "Error al actualizar: " . $e->getMessage());
    }
}

function calldelete():void {
    $datos = obtenerCuerpo();
    validarConexion($datos);

    if (empty($datos['condiciones']) || !is_array($datos['condiciones'])) {
        responder(400, "error", "El campo 'condiciones' es obligatorio para identificar el/los registro(s) a eliminar.");
    }

    $pdo    = crearConexion($datos);
    $tabla  = sanitizarNombre($datos['tabla']);
    $params = [];

    $where = [];
    foreach ($datos['condiciones'] as $campo => $valor) {
        $campo   = sanitizarNombre($campo);
        $where[] = "`$campo` = :where_$campo";
        $params[":where_$campo"] = $valor;
    }

    $sql = "DELETE FROM `$tabla` WHERE " . implode(" AND ", $where) . " ";

    try {
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        responder(200, "éxito", "$afectados registro(s) eliminado(s).", ["filas_afectadas" => $stmt->rowCount()]);
    } catch (PDOException $e) {
        responder(500, "error", "Error al eliminar: " . $e->getMessage());
    }
}

// ─────────────────────────────────────────────
// Enrutador principal
// ─────────────────────────────────────────────

$metodo = $_SERVER['REQUEST_METHOD'];
switch ($metodo) {

    // ═══════════════════════════════════════════
    // GET - Leer registros
    // Parámetros JSON: servidor, base_de_datos, usuario, password, tabla
    // Opcional: condiciones { "campo": "valor", ... }
    // ═══════════════════════════════════════════
    case 'GET':
        callget();
        break;
    // ═══════════════════════════════════════════
    // POST - Insertar registro
    // Parámetros JSON: servidor, base_de_datos, usuario, password, tabla
    // Obligatorio: campos { "campo1": "valor1", "campo2": "valor2", ... }
    // ═══════════════════════════════════════════
    case 'POST':
        $datos = obtenerCuerpo();

        $action = $datos['action'];
        $token=$datos['token'];

        switch     ($action) {
            case 'get':
                callget();
                break;
            case 'post':
                callpost();
                break;
            case 'put':
                callput();
                break;
            case 'delete':
                calldelete();
                break;
            default:
                responder(400, "error", "Acción '$action' no soportada. Use 'get','post', 'put' o 'delete'.");
        }

    // ═══════════════════════════════════════════
    // PUT - Actualizar registro(s)
    // Parámetros JSON: servidor, base_de_datos, usuario, password, tabla
    // Obligatorio: campos { "campo1": "nuevo_valor", ... }
    // Obligatorio: condiciones { "id": 1, ... }  (al menos una condición)
    // ═══════════════════════════════════════════
    case 'PUT':
        callput();
        break;


    // ═══════════════════════════════════════════
    // DELETE - Eliminar registro(s)
    // Parámetros JSON: servidor, base_de_datos, usuario, password, tabla
    // Obligatorio: condiciones { "id": 1, ... }  (al menos una condición)
    // ═══════════════════════════════════════════
    case 'DELETE':
        calldelete();
        break;


    // ═══════════════════════════════════════════
    // Método no soportado
    // ═══════════════════════════════════════════
    default:
        responder(405, "error", "Método HTTP '$metodo' no soportado. Use GET, POST, PUT o DELETE.");
}


/*
Ejemplo de JSON para probar la API (GET) con POSTMAN o similar:

{
  "servidor": "localhost",
  "base_de_datos": "tgv_dev",
  "usuario": "",
  "password": "",
  "tabla": "usuario",
  "condiciones": { "id":3 },
        "limite": 10,
        "offset": 5
}
  */
/*
Ejemplo de la respuesta de la API (GET) con POSTMAN o similar:
{
    "estado": "éxito",
    "codigo": 200,
    "mensaje": "1 registro(s) encontrado(s).",
    "datos": [
        {
            "id": 3,
            "usuario": "Juan Rulfo",
            "password": "juanRulfo@example.com",
            "Status": "6",
            "nivel": "6",
            "boleano": 1,
            "numerico": 3,
            "fecha": "2000-01-15",
            "doble": 8
        }
    ]
}

*/

/*
Ejemplo de JSON para probar la API (POST) El original con POSTMAN o similar:
{
  "servidor": "localhost",
  "base_de_datos": "tgv_dev",
  "usuario": "",
  "password": "",
  "tabla": "usuario",

  "campos": { 
    "usuario": "Laura", 
    "password": "laura@example.com"
    }
}

*/

/*
Ejemplo de la respuesta de la API (POST) con POSTMAN o similar:

{
    "estado": "éxito",
    "codigo": 201,
    "mensaje": "Registro insertado correctamente.",
    "datos": {
        "id_insertado": "29"
    }
}

*/


/*
Ejemplo de JSON para probar la API (POST) con action post con POSTMAN o similar:

{
  "servidor": "localhost",
  "base_de_datos": "tgv_dev",
  "action": "post",
  "token":"Tg#10982278ia123",
  "usuario": "root",
  "password": "root",
  "tabla": "usuario",

  "campos": { 
    "usuario": "Laura", 
    "password": "laura@example.com"
    }
    
}
    /********************* respuesta de la API (POST) con action post con POSTMAN o similar:

    {
  "servidor": "localhost",
  "base_de_datos": "tgv_dev",
  "usuario": "",
  "password": "",
  "tabla": "usuario",
  "condiciones": { "id":3 },
  "campos": { 
    "usuario": "Laura", 
    "password": "laura@example.com"
    }
} 
*/




/*

Ejemplo de JSON para probar la API post con action (put) con POSTMAN o similar:
{
  "servidor": "localhost",
  "base_de_datos": "tgv_dev",
  "usuario": "",
  "password": "",
    "action": "post",
  "token":"Tg#10982278ia123",
  "tabla": "usuario",
  "condiciones": { "id":3 },
  "campos": { 
    "usuario": "Laura", 
    "password": "laura@example.com"
    }
}
*/

/* ejemplo de la respuesta de la API (POST) con action (delete) con POSTMAN o similar:

{
  "servidor": "localhost",
  "base_de_datos": "tgv_dev",
  "action": "delete",
  "token":"Tg#10982278ia123",
  "usuario": "root",
  "password": "root",
  "tabla": "usuario",
     "condiciones": { "id":8 },


}


*/


/* Ejemplo de la respuesta de la API (PUT) con POSTMAN o similar:

{
    "estado": "éxito",
    "codigo": 200,
    "mensaje": "1 registro(s) actualizado(s).",
    "datos": {
        "filas_afectadas": 1
    }
}

*/

/* Ejemplo de JSON para probar la API (DELETE) con POSTMAN o similar:
{
"servidor": "localhost",
  "base_de_datos": "tgv_dev",
  "usuario": "",
  "password": "",
  "tabla": "usuario",
  "condiciones": { "id": 3 }
}

*/

/* Ejemplo de la respuesta de la API (DELETE) con POSTMAN o similar:


{
    "estado": "éxito",
    "codigo": 200,
    "mensaje": "1 registro(s) eliminado(s).",
    "datos": {
        "filas_afectadas": 1
    }
}


{
  "servidor": "localhost",
  "base_de_datos": "tgv_dev",
  "usuario": "root",
  "password": "root",
    "action": "get",
  "token":"Tg#10982278ia123",

  "tabla": "prueba",


  "condiciones": {"nombre":"11","descripcion": "6","id":2},

  "limite": 1,
  "offset": 0,

  "displayfields":["id","Nombre","descripcion"],

  "campos": { 
    
    "Nombre": "12",
    "Descripcion": "6",
    "Status": "6",
    "nivel": "6",
    "boleano": 1,
    "numerico": 3,
    "doble": 8,
    "fecha": "2012-12-12",
    "hora": "15:15:15",
    "fecha_hora": "2012-12-12 15:15:15"


    }
}

{
  "servidor": "localhost",
  "base_de_datos": "tgv_dev",
  "usuario": "root",
  "password": "root",
    "action": "get",
  "token":"Tg#10982278ia123",

  "tabla": "prueba",


  "condiciones": {"nombre":"11","descripcion": "6","id":2},

  "limite": 1,
  "offset": 0,

  "displayfields":["id","Nombre","descripcion"],

  "campos": { 
    
    "Nombre": "12",
    "Descripcion": "6",
    "Status": "6",
    "nivel": "6",
    "boleano": 1,
    "numerico": 3,
    "doble": 8,
    "fecha": "2012-12-12",
    "hora": "15:15:15",
    "fecha_hora": "2012-12-12 15:15:15"


    }
}


{
  "servidor": "localhost",
  "base_de_datos": "tgv_dev",
  "usuario": "root",
  "password": "root",
    "action": "get",
  "token":"Tg#10982278ia123",

  "tabla": "prueba",


  "condiciones": {"nombre":"11","descripcion": "6","id":2},

  "limite": 1,
  "offset": 0,

  "displayfields":["id","Nombre","descripcion"],

  "campos": { 
    
    "Nombre": "21",
    "Descripcion": "21",
    "Status": "6",
    "nivel": "6",
    "boleano": 1,
    "numerico": 3,
    "doble": 8,
    "fecha": "2012-12-12",
    "hora": "15:15:15",
    "fecha_hora": "2012-12-12 15:15:15"


    }
}


*/