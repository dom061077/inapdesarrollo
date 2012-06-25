package com.educacion.academico

import com.educacion.enums.EstadoMateriaEnum
import com.educacion.enums.TipoMateriaEnum

class Materia {
	String denominacion
	boolean promocional
	boolean troncal = false
	Integer duracion
	String descripcion
	EstadoMateriaEnum estado
	Nivel nivel
	TipoMateriaEnum tipo
	String codigo
	
	static belongsTo =[nivel:Nivel]
	
	static hasMany = [matregcursar:Materia,mataprobcursar:Materia,matregrendir:Materia,mataprobrendir:Materia,inscmatdetalle:InscripcionMateriaDetalle]
	
    static constraints = {
		denominacion(nullable:false,blank:false)
		codigo(nullable:false,blank:false)
    }
	
	static mapping = {
		matregcursar lazy:false
		mataprobcursar lazy:false
		matregrendir lazy:false
		mataprobrendir lazy:false
	}
	
}

