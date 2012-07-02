package com.educacion.academico

import com.educacion.enums.ModalidadFormacionEnum

class Carrera {

	String denominacion
	Integer duracion
	ModalidadFormacionEnum modalidadFormacion
	String titulo
	String validezTitulo
	String perfilEgresado
	String campoOcupacional
	
	static hasMany= [requisitos:Requisito,niveles:Nivel,anios:AnioLectivo, documentos:DocumentoCarrera, preinscripciones:Inscripcion]
	
    static constraints = {
		denominacion(nullable:false,blank:false,size:1..100)
		campoOcupacional(nullable:false,blank:false,size:1..250)
		/*anios validator: {val,obj->
			val.each{
                it.validate()
            }
		}*/
        niveles validator:  {val, obj ->
            def cantEsprimernivel=0
            val.each{
                it.validate()
                if(it.esprimernivel)
                    cantEsprimernivel+=1
            }

            if(cantEsprimernivel>1)
                return["esprimernivel.unique.error"]
            return true
        }
    }
	
	static mapping = {
		niveles lazy: false, sort: "id",order: "desc"
	}
}
