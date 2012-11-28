<?php

class repositorioController extends Controller{
    
    private $_repo;
    
    public function __construct() {
        parent::__construct();
        $this->_repo = $this->loadModel('repòsitorio');
    }
    
    public function getPaises(){
      $campos = array("descripcion");  
      //$filtro = array(array("campo"=>"descripcion","filtro"=>"like","valor"=>));
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
      $totalregistros = 
      $json = '{"page":'.$this->getInt("page").',"total":"';
      foreach($busquedas as $b){
          
      }
      
    }
    
    public function getProvincias(){
        
    }
    
    public function getLocalidades(){
        
    }
    
    public function index(){
        
    }
    
    
}


?>
