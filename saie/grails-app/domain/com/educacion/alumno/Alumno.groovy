package com.educacion.alumno


import com.educacion.enums.TipoDocumentoEnum
import com.educacion.enums.SexoEnum
import com.educacion.geografico.Localidad
import com.educacion.enums.SituacionAcademicaEnum

class Alumno {
	//Datos Personales
	Long numeroDocumento
	TipoDocumentoEnum tipoDocumento
	String apellidoNombre
	java.sql.Date fechaNacimiento
	SexoEnum sexo
	
	//Datos Nacimiento
	Localidad localidadNac //de ahi obtengo pais, provincia y cod.Postal
	
	//Datos de Domicilio
	Localidad localidadDomicilio
	String barrioDomicilio
	String calleDomicilio
	String numeroDomicilio
	
	//Datos de Contacto
	String telefonoParticular
	String telefonoCelular
	String email
	String telefenoAlternativo
	
	//Datos Académicos
	String establecimientoProcedencia
	String titulo
	Integer anioEgreso
	SituacionAcademicaEnum situacionAcademicas	
	String legajo
	
	//Datos Laborales
	String lugarLaboral
	String telefonoLaboral
	String barrioLaboral
	String calleLaboral
	String numeroLaboral
	Localidad localidadLaboral//de ahi obtengo pais, provincia y cod.Postal
	
	//Datos tutor
	
	
	
	
	
    static constraints = {
    }
}
