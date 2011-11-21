package com.educacion.academico

import com.educacion.enums.EstadoMateriaEnum
import com.educacion.enums.TipoMateriaEnum

class Materia {
	String denominacion
	boolean promocional
	DuracionMateria duracion
	String descripcion
	EstadoMateriaEnum estado
	Nivel nivel
	TipoMateriaEnum tipo
	String codigo
	Materia pcr
	Materia pca
	Materia prr
	Materia pra
	
	static belongsTo =[nivel:Nivel]
	
    static constraints = {
    }
}

