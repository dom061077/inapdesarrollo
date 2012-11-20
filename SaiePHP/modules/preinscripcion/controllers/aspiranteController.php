<?php

    class aspiranteController extends Controller{
        private $_aspirante;
                
                
        public function __construct() {
            parent::__construct();
            $this->_aspirante = $this->loadModel('aspirante','preinscripcion');
        }
        
        public function index(){
            $this->_view->renderizar('index');
        }
        
        public function registrar(){
            $this->_view->assign('titulo','Registro de aspirantes');
            $this->_view->setJs(array('wizard/bbq','wizard/jquery.form','wizard/jquery.form.wizard-min','wizard/jquery.validate'));
            
            
            $this->_view->assign('tipoDocList',$this->_aspirante->getTiposDocumentos());
            $this->_view->assign('datos',$_POST);
            $this->_view->renderizar('registrar');
        }
        
        public function saveregistrar(){
           if ($this->getTexto('apellido'))
               echo 
           else
               $this->_view->rendedirzar('registrar');
        }
    }

?>
