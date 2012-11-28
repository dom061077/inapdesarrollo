<?php


class repositorioModel extends Model{
    
    public function __construct() {
        parent::__construct();
    }
    
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
        return $sql->fetchall();
    }
    
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
        
    }
}

?>
