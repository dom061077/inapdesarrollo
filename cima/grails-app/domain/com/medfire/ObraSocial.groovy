package com.medfire

class ObraSocial {
	static auditable = true
	
	String descripcion
	String razonSocial
	String domicilio
	String codigoPostal
	String telefono
	String contacto
	String cuit
	Boolean habilitada= new Boolean(true)
	Institucion institucion
	
	static hasMany = [pacientes:Paciente]

    static constraints = {
		telefono(blank:true,nullable:true,matches:'[0-9]')
		cuit(matches:'[0-9]{2}-[0-9]{8}-[0-9]')
		descripcion(nullable:false,blank:false)
		razonSocial(nullable:false,blank:false)
    }
	
	static mapping = {
		pacientes (cascade:'save-update')
	}
}
