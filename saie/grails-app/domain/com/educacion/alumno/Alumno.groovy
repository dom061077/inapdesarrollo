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
	String telefonoAlternativo
	
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
	String apellidoNombreTutor
	String profesionTutor
	String parentescoTutor
	String telefonoTutor
	String calleTutor
	String numeroTutor
	String barrioTutor
	Localidad localidadTutor
	
	//Datos Garante
	String apellidoNombreGarante
	String profesionGarante
	String parentescoGarante
	String telefonoGarante
	String calleGarante
	String numeroGarante
	String barrioGarante
	Localidad localidadGarante
	
	
	//Otros
	SituacionAcademicaEnum estadoAcademico
	SituacionAdministrativa situacionAdministrativa
	
	
	
	
	
	
	
    static constraints = {
		
		//Datos Personales
		numeroDocumento(nullable:false,blank:false,unique:true)
		tipoDocumento(nullable:false,blank:false)
		apellidoNombre(nullable:false,blank:false)
		fechaNacimiento(nullable:false,blank:false)
		sexo(nullable:false,blank:false)
		
		//Datos Nacimiento
		localidadNac(nullable:true,blank:true)
		
		//Datos de Domicilio
		localidadDomicilio(nullable:true,blank:true)
		barrioDomicilio(nullable:true,blank:true)
		calleDomicilio(nullable:true,blank:true)
		numeroDomicilio(nullable:true,blank:true)
		
		//Datos de Contacto
		String telefonoParticular
		String telefonoCelular
		String email
		String telefonoAlternativo
		
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
		String apellidoNombreTutor
		String profesionTutor
		String parentescoTutor
		String telefonoTutor
		String calleTutor
		String numeroTutor
		String barrioTutor
		Localidad localidadTutor
		
		//Datos Garante
		String apellidoNombreGarante
		String profesionGarante
		String parentescoGarante
		String telefonoGarante
		String calleGarante
		String numeroGarante
		String barrioGarante
		Localidad localidadGarante
		
		
		//Otros
		SituacionAcademicaEnum estadoAcademico
		SituacionAdministrativa situacionAdministrativa
	
    }
}
