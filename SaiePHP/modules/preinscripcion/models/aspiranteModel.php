<?php

    class aspiranteModel extends Model {
        public function __construct() {
            parent::__construct();
        }
        
        public function getTiposDocumentos(){
            $tiposdoc = $this->_db->query("SELECT * FROM tiposdocumentoidentidad");
            return $tiposdoc->fetchAll();
        }
        
        public function insertPreinscripcion($params) {
            $this->_db->prepare(
                    "
                       INSERT INTO alumnos VALUES (null, :tipodocumento, :numerodocumento,
                       :apellido,:nombre,:sexo,:fechanacimiento,:paisnacimiento,:provincianacimiento,
                       :localidadnacimiento,:calledomicilio,:numerodomicilio,:barriodomicilio
                       ,:paisdomicilio,:provinciadomicilio,:localidaddomicilio,:telefonoparticular
                       ,:celularparticular,:email,:telefonoalternativo,:establecimiento
                       ,:titulo,:anioegreso, :situacionacademica,:legajo,:lugarlaboral
                       ,:telefonolaboral,:callelaboral,:numerolaboral,:barriolaboral,:paislaboral
                       ,:provincialaboral,:localidadlaboral,:apenomtutor,:profesion,:parentescotutor
                       ,:telefonotutor,:calletutor,:numerotutor,:barriotutor,:paistutor,:provinciatutor
                       ,:localidadtutor,:apenomgarante,:profesiongarante:parentescogarante,:telefonogarante
                       ,:callegarante,:numerogarante,:barriogarante,:paisgarante,:provincia,:localidadgarante
                       ,:sitacademica,:sitadministrativa
                       )
                    "
            )->execute(
                    array(
                       ':tipodocumento' => $params['tipoidocumento'], 
                       ':numerodocumento' => $params['numerodocumento'],
                       ':apellido' => $params['apellido'],
                       ':nombre' => $params['nombre'],
                       ':sexo' => $params['sexo'],
                       ':fechanacimiento' => $params['fechanacimiento'],
                       ':paisnacimiento' => $params['paisnacimiento'],
                       ':provincianacimiento' => $params['provincianacimiento'],
                       ':localidadnacimiento' => $params['localidadnacimiento'],
                       ':calledomicilio' => $params['calledomicilio'],
                       ':numerodomicilio' => $params['numerodomicilio'],
                       ':barriodomicilio' => $params['barriodomicilio'],
                       ':paisdomicilio' => $params['paisdomicilio'],
                       ':provinciadomicilio' => $params['provinciadomicilio'],
                       ':localidaddomicilio' => $params['localidaddomicilio'],
                       ':telefonoparticular' => $params['telefonoparticular'],
                       ':celularparticular' => $params['celularparticular'],
                       ':email' => $params['email'],
                       ':telefonoalternativo' => $params['telefonoalternativo'],
                       ':establecimiento' => $params['establecimiento'],
                       ':titulo' => $params['titulo'],
                       ':anioegreso' => $params['anioegreso'], 
                       ':situacionacademica' => $params['situacionacademica'],
                       ':legajo' => $params['legajo'],
                       ':lugarlaboral' => $params['lugarlaboral'],
                       ':telefonolaboral' => $params['telefonolaboral'],
                       ':callelaboral' => $params['callelaboral'],
                       ':numerolaboral' => $params['numerolaboral'],
                       ':barriolaboral' => $params['barriolaboral'],
                       ':paislaboral' => $params['paislaboral'],
                       ':provincialaboral' => $params['provincialaboral'],
                       ':localidadlaboral' => $params['localidadlaboral'],
                       ':apenomtutor' => $params['apenomtutor'],
                       ':profesion' => $params['profesion'],
                       ':parentescotutor' => $params['parentescotutor'],
                       ':telefonotutor' => $params['telefonotutor'],
                       ':calletutor' => $params['telefonotutor'],
                       ':numerotutor' => $params['numerotutor'],
                       ':barriotutor'=> $params['barriotutor'],
                       ':paistutor' => $params['paistutor'],
                       ':provinciatutor' => $params['provinciatutor'],
                       ':localidadtutor' => $params['localidadtutor'],
                       ':apenomgarante' => $params['apenomgarante'],
                       ':profesiongarante' => $params['profesiongarante'],
                       ':parentescogarante' => $params['parentescogarante'],
                       ':telefonogarante' => $params['telefonogarante'],
                       ':callegarante' => $params['callegarante'],
                       ':numerogarante' => $params['numerogarante'],
                       ':barriogarante' => $params['barriogarante'],
                       ':paisgarante' => $params['paisgarante'],
                       ':provincia' => $params['provincia'],
                       ':localidadgarante' =>  $params['localidadgarante'],
                       ':sitacademica' => $params['sitacademica'],
                       ':sitadministrativa' => $params['sitacademica']
                    ));
        }
    }

?>
