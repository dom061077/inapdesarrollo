package com.educacion.academico

import com.educacion.enums.TipoDocumentoEnum
import com.educacion.enums.SexoEnum
import com.educacion.geografico.Provincia
import com.educacion.geografico.Localidad
import java.sql.Date

class Docente {
    TipoDocumentoEnum tipoDocumento
    Long numeroDocumento
    String apellido
    String nombre
    Date fechaNacimiento
    SexoEnum sexo
    Provincia provinciaNacimiento

    Localidad localidadDomicilio
    String calleDomicilio
    String numeroDomicilio
    String barrioDomicilio
    String codigoPostalDomicilio

    String telefonoParticular
    String telefonoCelular
    String email
    String telefonoMensaje

    static constraints = {
        apellido nullable: false,blank: false
        nombre nullable: false, blank: false
        localidadDomicilio nullable: true, blank:true
        provinciaNacimiento( nullable: true,blank:true)
        fechaNacimiento(nullable: true,blank:true)

    }
}
