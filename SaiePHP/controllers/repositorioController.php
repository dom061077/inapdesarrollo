<?php

class repositorioController extends Controller{
    
    private $_repo;
    
    public function __construct() {
        parent::__construct();
        $this->_repo = $this->loadModel('repositorio');
    }
    
    public function paises(){
      $campos = array("id","descripcion");  
      if($this->getTexto("_search")=="true"){
          
          $altfilters = $this->getTexto("altfilters");
          //echo $altfilters;
          $altfilters = json_encode($altfilters);
          //$altfilters = json_decode($altfilters);
          print_r ($altfilters->groupOp);
          
      }
          
      exit;
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
