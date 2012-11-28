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
            $this->_view->assign('titulocontenido','Registro de Aspirantes');
            $this->_view->setJs(array('wizard/bbq','wizard/jquery.form','wizard/jquery.form.wizard-min','wizard/jquery.validate'));
            
            
            $this->_view->assign('tipoDocList',$this->_aspirante->getTiposDocumentos());
            $this->_view->assign('datos',$_POST);
            $this->_view->renderizar('registrar');
        }
        
        public function saveregistrar(){
           $errores = array(); 
           if(!$this->getInt('numerodocumento')){
               array_push($errores,'El Número de Documento es obligatorio');
           }
           
           if (!$this->getTexto('apellido')){
               array_push($errores,'El Apellido es ingreso obligatorio');
               $flagerror=true;
           }
           
           if (!$this->getTexto('nombre')){
               array_push($errores,'El Nombre es ingreso obligatrio');
               $flagerror=true;
           }
           
           
           
           if($flagerror){
               $this->_view->assign('_error',$errores);
               $this->_view->assign('titulocontenido','Registro de Aspirantes');
               $this->_view->assign('titulo','Registro de Aspirantes');
               $this->_view->setJs(array('wizard/bbq','wizard/jquery.form','wizard/jquery.form.wizard-min','wizard/jquery.validate'));
               $this->_view->assign('tipoDocList',$this->_aspirante->getTiposDocumentos());
               $this->_view->assign('datos',$_POST);
               $this->_view->renderizar('registrar');
           }else{
               $this->_view->assign('titulocontenido','Registro Guardado');
               $this->_view->assign('titulo','Registro Guardado');
               $this->_view->renderizar('show');
           }
           
        }
        
        public function exitsnumerodocumento(){
            echo "true";
        }
    }

?>
