<?php

/*
 * -------------------------------------
 * www.dlancedu.com | Jaisiel Delance
 * framework mvc basico
 * Controller.php
 * -------------------------------------
 */


abstract class Controller
{
    protected $_view;
    protected $_acl;
    protected $_request;
    
    public function __construct() {
        $this->_acl = new ACL();
        $this->_request = new Request();
        $this->_view = new View($this->_request, $this->_acl);
    }
    
    abstract public function index();
    
    protected function loadModel($modelo, $modulo = false)
    {
        $modelo = $modelo . 'Model';
        $rutaModelo = ROOT . 'models' . DS . $modelo . '.php';
        
        if(!$modulo){
            $modulo = $this->_request->getModulo();
        }
        
        if($modulo){
           if($modulo != 'default'){
               $rutaModelo = ROOT . 'modules' . DS . $modulo . DS . 'models' . DS . $modelo . '.php';
           } 
        }
        
        if(is_readable($rutaModelo)){
            require_once $rutaModelo;
            $modelo = new $modelo;
            return $modelo;
        }
        else {
            throw new Exception('Error de modelo');
        }
    }
    
    protected function getLibrary($libreria)
    {
        $rutaLibreria = ROOT . 'libs' . DS . $libreria . '.php';
        
        if(is_readable($rutaLibreria)){
            require_once $rutaLibreria;
        }
        else{
            throw new Exception('Error de libreria');
        }
    }
    
    protected function getTexto($clave)
    {
        if(isset($_POST[$clave]) && !empty($_POST[$clave])){
            $_POST[$clave] = htmlspecialchars($_POST[$clave], ENT_QUOTES);
            return $_POST[$clave];
        }
        
        return '';
    }
    
    protected function getInt($clave)
    {
        if(isset($_POST[$clave]) && !empty($_POST[$clave])){
            $_POST[$clave] = filter_input(INPUT_POST, $clave, FILTER_VALIDATE_INT);
            return $_POST[$clave];
        }
        
        return 0;
    }
    
    /*modificaciones DOM*/
    protected function getBoolean($clave){
        if(isset($_POST[$clave]) && !empty($_POST[$clave])){
            $_POST[$clave] = filter_input(INPUT_POST, $clave, FILTER_VALIDATE_BOOLEAN);
            return $_POST[$clave];
        }
        
        return 0;

    }
    
    protected function redireccionar($ruta = false)
    {
        if($ruta){
            header('location:' . BASE_URL . $ruta);
            exit;
        }
        else{
            header('location:' . BASE_URL);
            exit;
        }
    }

    protected function filtrarInt($int)
    {
        $int = (int) $int;
        
        if(is_int($int)){
            return $int;
        }
        else{
            return 0;
        }
    }
    
    protected function getPostParam($clave)
    {
        if(isset($_POST[$clave])){
            return $_POST[$clave];
        }
    }
    
    protected function getSql($clave)
    {
        if(isset($_POST[$clave]) && !empty($_POST[$clave])){
            $_POST[$clave] = strip_tags($_POST[$clave]);
            
            if(!get_magic_quotes_gpc()){
                $_POST[$clave] = mysql_escape_string($_POST[$clave]);
            }
            
            return trim($_POST[$clave]);
        }
    }
    
    protected function getAlphaNum($clave)
    {
        if(isset($_POST[$clave]) && !empty($_POST[$clave])){
            $_POST[$clave] = (string) preg_replace('/[^A-Z0-9_]/i', '', $_POST[$clave]);
            return trim($_POST[$clave]);
        }
        
    }
    
    public function validarEmail($email)
    {
        if(!filter_var($email, FILTER_VALIDATE_EMAIL)){
            return false;
        }
        
        return true;
    }
    
	protected function formatPermiso($clave)
    {
        if(isset($_POST[$clave]) && !empty($_POST[$clave])){
            $_POST[$clave] = (string) preg_replace('/[^A-Z_]/i', '', $_POST[$clave]);
            return trim($_POST[$clave]);
        }
        
    }
    
    protected function getGridJson($db,$tabla,$campos,$rows=null,$page=null,$gridfilters=null,$idx=null,$sord=null){
//($tabla,$campos,$page=null,$rows=null,$gridfilters=null,$idx=null,$sord=null, $rows, $page){        
        $registros = $db->getBusquedasGrid($tabla,$campos,$page,$rows,$gridfilters,$idx,$sord,$rows,$page);
        $json="";
        $totalregistros = $db->getTotalBusquedaGrid('paises',$gridfilters);
        $totalpaginas = $totalregistros / $this->getInt('rows');
        if($totalpaginas<1 && $totalpaginas>0)
            $totalpaginas = 1;
        if($totalregistros<1 && $totalpaginas>0)
            $totalregistros = 1;
        $json = '{"page":'.$this->getInt("page").',"total":"'.$totalpaginas.'","records":"'.$totalregistros.'","rows":[';
        $flagcoma = false;
        foreach($registros as $r){
            if($flagcoma)
                $json = $json.",";
            $json = $json.'{"id":"'.$r[$campos[0]].'","cell":[';
            $flagcomacampos=false;
            foreach($campos as $c){
                $keycampo = $c;
                if($flagcomacampos)
                    $json=$json.',"';
                else                     
                    $json=$json.'"';
                $json=$json.$r[$c].'"'; 
                $flagcomacampos=true;
            }
            $json=$json.']}'; 
            $flagcoma=true;   
        }
        $json = $json . ']}';
        return $json;
    }
}

?>
