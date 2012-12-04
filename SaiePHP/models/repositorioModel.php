<?php


class repositorioModel extends Model{
    
    public function __construct() {
        parent::__construct();
    }
    
    /*
     * 
     * permite buscar en tabla:$tabla, en los campos: $campos 
     * por los filtros indicados: $filtro
     */
    
    public function getBusquedas($tabla,$campos,$filtro){
        $query = "select ";
        foreach($campos as $c){
            if($query!="select " )
               $query = $query . ", ";     
            $query = $query . $c;
        }
        
        $query = $query ." from " . $tabla;
        if($filtro){
            $params = array();
            $query = $query." where ";
            foreach($filtro as $f){
                 if(substr($query, -6)!="where ")   
                    $query = $query." and ";
                 $query = $query ." ".$f["campo"]." ".$f["filtro"]." :".$f["campo"];
                 $key = ":".$f["campo"];
                 $params = Utilidad::array_push_withkey($params, $key, $f["valor"]);

            }
            $sql = $this->_db->prepare($query,$params);
        }else {
            $sql = $this->_db->query($query);
        }
        return $sql->fetchAll();
    }
    
    /*
     * permite traer el total de registros de la tabla: $tabla 
     * y filtro: $filtro
     */
    
    public function getTotalRegistros($tabla,$filtro){
        $query = "select count(*) as cantidad from $tabla";
        if($filtro){
            $params = array();
            $query = $query." where ";
            foreach($filtro as $f){
                 if(substr($query, -6)!="where ")   
                    $query = $query." and ";
                 $query = $query ." ".$f["campo"]." ".$f["filtro"]." :".$f["campo"];
                 $key = ":".$f["campo"];
                 $params = Utilidad::array_push_withkey($params, $key, $f["valor"]);

            }
            $sql = $this->_db->prepare($query,$params);
        }else {
            $sql = $this->_db->query($query);
        }
        return $sql->fetchColumn();
    }
    
    public function getBusquedasGrid($tabla,$campos,$page=null,$rows=null,$gridfilters=null,$idx=null,$sord=null, $rows, $page){
        $query = "select ";
        foreach($campos as $c){
            if($query!="select ")
                $query=$query.", ";
            $query = $query.$c;
        }
        $query = $query." from ".$tabla;   
        if($gridfilters){

          $altfilters =  html_entity_decode($gridfilters);
          $altfilters = json_decode($altfilters);
          switch (json_last_error()) {
                case JSON_ERROR_NONE:
                    //echo ' - No errors';
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
          $flagand=false;
          if(count($altfilters->{"rules"})>0)
              $query=$query." where ";
          foreach ($altfilters->{"rules"} as $r){
            //array_push($filtros, $r->{"field"})  ;
            $valor=$r->{"data"};
            if($flagand)  
                $query = $query." and ";
            $operador = Utilidad::getOperator($r->{"op"});
            if($r->{"op"}==EQ && !$valor)
                $valor = 0;
            if($r->{"op"}==BEGINWITH)
                $valor="'%".$valor."%'";
            $query = $query.$r->{"field"}.$operador.$valor;  
            $flagand=true;
          }
          
        }
        if($idx && $sord){
            $query = $query." order by ".$idx;
            $query = $query." ".$sord;   
        }
        if($page && $rows){
            if($page=1)
                $iniciopag=0;
            else
                $iniciopag=$rows+$page-1;
            $query = $query." LIMIT ".$iniciopag.", ".$rows ;
        }
        //echo "query: ".$query." page: ".$page." rows: ".$rows;
        //exit;
        
        $sql = $this->_db->query($query);
        return $sql->fetchAll();
    }
    
    public function getTotalBusquedaGrid($tabla,$gridfilters){
        $query = "select count(*) as cantidad  from ".$tabla;   
        
        if($gridfilters){
          $altfilters =  html_entity_decode($gridfilters);
          $altfilters = json_decode($altfilters);
          switch (json_last_error()) {
                case JSON_ERROR_NONE:
                    //echo ' - No errors';
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
          $flagand=false;
          if(count($altfilters->{"rules"})>0)
              $query=$query." where ";
          foreach ($altfilters->{"rules"} as $r){
            //array_push($filtros, $r->{"field"})  ;
            $valor=$r->{"data"};
            if($flagand)  
                $query = $query." and ";
            $operador=Utilidad::getOperator($r->{"op"});
            if($r->{"op"}==EQ && !$valor)
                $valor = 0;
            if($r->{"op"}==BEGINWITH)
                $valor="'%".$valor."%'";
            $query = $query.$r->{"field"}.$operador.$valor;  
            $flagand=true;
          }
          
        }
        //echo $query;
        //exit;
        $sql = $this->_db->query($query);
        return $sql->fetchColumn();
        
    }
    
}

?>
