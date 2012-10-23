<?php

    class alumnoModel extends Model{
        public function __construct() {
            parent::__construct();
        }
        
        public function getAlumnos()
        {
            $alumnos = $this->_db->query("select * from alumnos");
            return $alumnos->fetchall();
        }
        
        
    }

?>
