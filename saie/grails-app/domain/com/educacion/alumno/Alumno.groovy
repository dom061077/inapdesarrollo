package com.educacion.alumno


import com.educacion.enums.TipoDocumentoEnum
import com.educacion.enums.SexoEnum
import com.educacion.geografico.Localidad
import com.educacion.enums.SituacionAcademicaEnum
import pl.burningice.plugins.image.ast.FileImageContainer


@FileImageContainer(field = 'photo')
class Alumno {
	//Datos Personales
	Long numeroDocumento
	TipoDocumentoEnum tipoDocumento
	String apellido
	String nombre
	java.sql.Date fechaNacimiento
	SexoEnum sexo
	
	java.util.Date fechaAlta = new java.util.Date()
	
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
		apellido(nullable:false,blank:false)
		nombre(nullable:false,blank:false)
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
		telefonoParticular(nullable:true,blank:true)
		telefonoCelular(nullable:true,blank:true)
		email(nullable:true,blank:true)
		telefonoAlternativo(nullable:true,blank:true)
		
		//Datos Académicos
		establecimientoProcedencia(nullable:true,blank:true)
		titulo(nullable:true,blank:true)
		anioEgreso(nullable:true,blank:true)
		situacionAcademicas(nullable:true,blank:true)
		legajo(nullable:true,blank:true)
		
		//Datos Laborales
		lugarLaboral(nullable:true,blank:true)
		telefonoLaboral(nullable:true,blank:true)
		barrioLaboral(nullable:true,blank:true)
		calleLaboral(nullable:true,blank:true)
		numeroLaboral(nullable:true,blank:true)
		localidadLaboral(nullable:true,blank:true)//de ahi obtengo pais, provincia y cod.Postal
		
		//Datos tutor
		apellidoNombreTutor(nullable:true,blank:true)
		profesionTutor(nullable:true,blank:true)
		parentescoTutor(nullable:true,blank:true)
		telefonoTutor(nullable:true,blank:true)
		calleTutor(nullable:true,blank:true)
		numeroTutor(nullable:true,blank:true)
		barrioTutor(nullable:true,blank:true)
		localidadTutor(nullable:true,blank:true)
		
		//Datos Garante
		apellidoNombreGarante(nullable:true,blank:true)
		profesionGarante(nullable:true,blank:true)
		parentescoGarante(nullable:true,blank:true)
		telefonoGarante(nullable:true,blank:true)
		calleGarante(nullable:true,blank:true)
		numeroGarante(nullable:true,blank:true)
		barrioGarante(nullable:true,blank:true)
		localidadGarante(nullable:true,blank:true)
		
		
		//Otros
		estadoAcademico(nullable:true,blank:true)
		situacionAdministrativa(nullable:true,blank:true)
	
    }
}
