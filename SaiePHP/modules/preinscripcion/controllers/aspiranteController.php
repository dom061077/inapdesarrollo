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
            $this->_view->setJs(array('wizard/bbq','wizard/jquery.form','wizard/jquery.form.wizard','wizard/jquery.validate','wizard/additional-methods'));
            
            
            $this->_view->assign('tipoDocList',$this->_aspirante->getTiposDocumentos());
            $this->_view->assign('datos',$_POST);
            $this->_view->renderizar('registrar');
        }
        
        public function saveregistrar(){
           $errores = array(); 
           if(!$this->getInt('numerodocumento')){
               //array_push($errores,array('numerodocumento'=>'El Número de Documento es obligatorio'));
               $errores['numerodocumento']='El Numero de Documento es obligatorio';
               $flagerror=true;
           }
           
           if (!$this->getTexto('apellido')){
               //array_push($errores,array('apellido'=>'El Apellido es ingreso obligatorio'));
               $errores['apellido']='El Apellido es ingreso obligatorio';
               $flagerror=true;
           }
           
           if (!$this->getTexto('nombre')){
               //array_push($errores,array('nombre'=>'El Nombre es ingreso obligatrio'));
               $errores['nombre']='El Nombre es ingreso obligatorio';
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
               //echo "<p>PARAMETROS APELLIDO: ".$_POST['apellido']."</p>";
               //print_r($_POST);
               $this->_aspirante->insertPreinscripcion($_POST);
               return;
               $this->_view->assign('titulocontenido','Registro Guardado');
               $this->_view->assign('titulo','Registro Guardado');
               echo "SALVANDO REGISTRO!!!!!!!";
              // $this->_view->renderizar('show');
           }
           
        }
        
        public function exitsnumerodocumento(){
            $cantiadreg=0;
            if($this->getInt('numerodocumento')){
                $cantidadreg=$this->_aspirante->verificarNumeroDocumento($this->getInt('numerodocumento'));
                if($cantidadreg>0){
                    echo "false";
                    return;
                }
                    
                
            }
            echo "true";
        }
    }

?>
