<?php

class repositorioController extends Controller{
    
    private $_repo;
    
    public function __construct() {
        parent::__construct();
        $this->_repo = $this->loadModel('repositorio');
    }
    
    
    //getGridJson($db,$tabla,$campos,$gridfilters=null,$idx=null,$sord=null){
    public function paises(){
        $campos = array("id","descripcion");
        $tabla = "paises";
        $gridfilters = null;
        if($this->getTexto("_search")=="true")
            $gridfilters = $this->getTexto("altfilters");
        //getGridJson($db,$tabla,$campos,$rows=null,$page=null,$gridfilters=null,$idx=null,$sord=null)
        $json = $this->getGridJson($this->_repo, $tabla, $campos
                ,$this->getInt("rows"),$this->getInt("page")
                ,$gridfilters,$this->getTexto("sidx")
                ,$this->getTexto("sord"));
        echo $json;
    }
    
    public function paisesxx(){
      if($this->getTexto("_search")=="true"){
          
          $altfilters = $this->getTexto("altfilters");
          $altfilters =  html_entity_decode($altfilters);
          $altfilters = json_decode($altfilters);
          switch (json_last_error()) {
                case JSON_ERROR_NONE:
                    echo ' - No errors';
                break;
                case JSON_ERROR_DEPTH:
                    echo ' - Maximum stack depth exceeded';
                break;
                case JSON_ERROR_STATE_MISMATCH:
                    echo ' - Underflow or the modes mismatch';
                break;
                case JSON_ERROR_CTRL_CHAR:
                    echo ' - Unexpected control character found';
                break;
                case JSON_ERROR_SYNTAX:
                    echo ' - Syntax error, malformed JSON';
                break;
                case JSON_ERROR_UTF8:
                    echo ' - Malformed UTF-8 characters, possibly incorrectly encoded';
                break;
                default:
                    echo ' - Unknown error';
                break;
          }  
      }
          
      $filtros = array();
      foreach ($altfilters->{"rules"} as $r){
          array_push($filtros, $r->{"field"})  ;
      }
      print_r($filtros);
      exit;
      $campos = array("id","descripcion");  
      $busquedas = $this->_repo->getBusquedas("paises",$campos,null); 
      
      /*
       		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
		list.each{
			
			if (flagaddcomilla)
				result=result+','
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.nombre==null?"":it.nombre)+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'

       */
      $totalregistros = $this->_repo->getTotalRegistros('paises',null);
      $totalpaginas = $totalregistros / $this->getInt('rows');
      if($totalpaginas<1 && $totalpaginas>0)
          $totalpaginas = 1;
      if($totalregistros<1 && $totalpaginas>0)
          $totalregistros = 1;
      $json = '{"page":'.$this->getInt("page").',"total":"'.$totalpaginas.'","records":"'.$totalregistros.'","rows":[';
      $flagcoma = false;
      foreach($busquedas as $b){
          if($flagcoma)
              $json = $json.",";
          $json = $json.'{"id":"'.$b["id"].'","cell":["'.$b["id"].'","'.$b["descripcion"].'"]}'; 
          $flagcoma=true;   
      }
      $json = $json . ']}';
      echo $json;
    }
    
    public function getProvincias(){
        
    }
    
    public function getLocalidades(){
        
    }
    
    public function index(){
        
    }
    
    
}


?>
