package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 
import grails.converters.JSON
import org.springframework.transaction.TransactionStatus
import com.educacion.academico.exceptions.InscripcionMateriaException
import com.educacion.alumno.Alumno;
import com.educacion.enums.inscripcion.EstadoPreinscripcion;
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum


class InscripcionMateriaController {

	def inscripcionMateriaService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		log.info "INGRESANDO AL CLOSURE list"
		log.info "PARAMETROS: $params"
     }
	
	def listjsonmateriasadd = {
		log.info "INGRESANDO AL CLOSURE listjsonmateriasadd"
		log.info "PARAMETROS $params"
		//-----------------------en esta seccion se detecta las materias en las que se puede inscribir el alumno------------
		
		/*def materias = Materia.createCriteria().list{
			nivel{
				carrera{
					eq("id",params.carreraId.toLong())
				}
			}
		}*/
		
		def materias = Materia.executeQuery("""
				FROM Materia m 
				LEFT JOIN m.inscmatdetalle  inscd with inscd.estado = :estado
				LEFT JOIN inscd.inscripcionMateria insc  
				LEFT JOIN insc.alumno alu with alu.id = :alumnoId 
			""",[alumnoId:params.alumnoId.toLong(),estado:EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_AUSENTE])
		//, m.nivel.carrera.id= :carreraId
		//, isNull(insc.id)
		def materiasInscripcion=[]
		def flagRegInscripcion
		def flagAprobInscripcion
		def cantidadConsulta
		log.debug "MATERIAS DEVUELTAS: "+materias
		materias.each{ mat ->
			flagRegInscripcion = false
			flagAprobInscripcion = false
			mat.matregcursar.each{ matreg ->
				cantidadConsulta = InscripcionMateriaDetalle.createCriteria().get{
					materia{
						eq("id",matreg.id)
					}
					eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR)
					projections{
						rowCount()
					}
				}
				if(cantidadConsulta>0)
					flagRegInscripcion=true
					
			}
			if(mat.matregcursar.size()==0)
				flagRegInscripcion = true
			mat.mataprobcursar.each{ mataprob ->
				cantidadConsulta = InscripcionMateriaDetalle.createCriteria().get{
					materia{
						eq("id",mataprob.id)
					}
					eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA)
					projections{
						rowCount()
					}
				}
				if(cantidadConsulta>0)
					flagAprobInscripcion=true
			}
			if(mat.mataprobcursar.size()==0)
				flagAprobInscripcion = true
			if(flagRegInscripcion && flagAprobInscripcion)
				materiasInscripcion.add(mat)
		}
		
		//------------------------------------------------------------------------------------------------------------------
		def totalregistros=materiasInscripcion.size()
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		
		
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false

		materiasInscripcion.each{
			if (flagaddcomilla)
				result=result+','
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+it.denominacion+'","'+'NO'+'"]}'
			flagaddcomilla=true
		}
		result=result+']}'
		render result
	}

    def create = {
		log.info "INGRESANDO AL CLOSURE create"
		log.info "PARAMETROS: $params"
		
		def hqlstr = "FROM Preinscripcion pre WHERE pre.estado=:estado AND pre.id = "
		hqlstr = hqlstr + " (SELECT max(id) FROM Preinscripcion pre2 WHERE pre2.alumno.id = :alumno )"
		def preinscripciones = Preinscripcion.executeQuery(hqlstr,["alumno":params.id.toLong(),"estado":EstadoPreinscripcion.ESTADO_INSCRIPTO])

		if(preinscripciones){
		   def preinscripcionInstance = preinscripciones.get(0)
		   if(!preinscripcionInstance){
				flash.message = "${message(code:'com.educacion.academico.InscripcionMateria.preinscripcion.blank.error')}"
				render(view:"alumnosinscripcion",model:[])
				return
		   }else{
		       def inscripcionMateriaInstance = new InscripcionMateria(alumno:preinscripcionInstance.alumno
						,preinscripcion:preinscripcionInstance,anioLectivo:preinscripcionInstance.anioLectivo)
		        //inscripcionMateriaInstance.properties = params
		        return [inscripcionMateriaInstance: inscripcionMateriaInstance]
		   }
		}else{
			flash.message = "${message(code:'com.educacion.academico.InscripcionMateria.preinscripcion.blank.error')}"
			render(view:"alumnosinscripcion",model:[])
			return
		}
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		
		def hqlstr = "FROM Preinscripcion pre WHERE pre.estado=:estado AND pre.id = "
		hqlstr = hqlstr + " (SELECT max(id) FROM Preinscripcion pre2 WHERE pre2.alumno.id = :alumno )"
		def inscripcionMateriaInstance = new InscripcionMateria(params)
		def preinscripciones = Preinscripcion.executeQuery(hqlstr,["alumno":inscripcionMateriaInstance.alumno.id,"estado":EstadoPreinscripcion.ESTADO_INSCRIPTO])
		

		if(preinscripciones){
			
			try{
				inscripcionMateriaService.saveInscripcionMateria(inscripcionMateriaInstance,params)
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'inscripcionMateria.label', default: 'Inscripcion Materia'), inscripcionMateriaInstance.id])}"
				render(view:"show",model:[inscripcionMateriaInstance:inscripcionMateriaInstance])
				return
			}catch(InscripcionMateriaException e){
				log.debug "ERRORES: "+inscripcionMateriaInstance.errors.allErrors
				render (view:"create", model:[inscripcionMateriaInstance:e.inscripcionMateria,materiasSerialized:params.materiasSerialized])
				return
			}

		}else{
			flash.message = "${message(code:'com.educacion.academico.InscripcionMateria.preinscripcion.blank.error')}"
			render(view:"create",model:[inscripcionMateriaInstace:inscripcionMateriaInstance])
		}


    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
        if (!inscripcionMateriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
            redirect(action: "list")
        }
        else {
            [inscripcionMateriaInstance: inscripcionMateriaInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"
		def materiasSerialized="["
		def flagcoma=false
		
		def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
        if (!inscripcionMateriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
            redirect(action: "list")
        }
        else {
			inscripcionMateriaInstance.detalleMateria.each{
				if(flagcoma){
					materiasSerialized  = materiasSerialized +','+ '{"id":"'+it.id+'","idid":"'+it.materia.id+'","denominacion":"'+it.materia.denominacion+'","estadovalue":"'+it.estado+'","estado":"'+it.estado.name+'","tipovalue":"'+it.tipo+'","tipo":"'+it.tipo.name+'","nota":"'+it.nota+'"}'
				}else{
					materiasSerialized = materiasSerialized + '{"id":"'+it.id+'","idid":"'+it.materia.id+'","denominacion":"'+it.materia.denominacion+'","estadovalue":"'+it.estado+'","estado":"'+it.estado.name+'","tipovalue":"'+it.tipo+'","tipo":"'+it.tipo.name+'","nota":"'+it.nota+'"}'
					flagcoma=true
				}

			}
			materiasSerialized = materiasSerialized + "]"
            return [inscripcionMateriaInstance: inscripcionMateriaInstance,materiasSerialized:materiasSerialized]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
																	   
        if (inscripcionMateriaInstance) {
	            if (params.version) {
	                def version = params.version.toLong()
	                if (inscripcionMateriaInstance.version > version) {
	                    inscripcionMateriaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria')] as Object[], "Another user has updated this InscripcionMateria while you were editing")
	                    render(view: "edit", model: [inscripcionMateriaInstance: inscripcionMateriaInstance])
	                    return 
	                }
	            }
				try{
						inscripcionMateriaService.updateInscripcionMateria(inscripcionMateriaInstance,params)
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'inscripcionmateria.label', default: 'InscripcionMateria'), inscripcionMateriaInstance.id])}"
						render(view:"show",model:[inscripcionMateriaInstance:inscripcionMateriaInstance])
						return
				}catch(InscripcionMateriaException e){
					log.debug "ERRORES DE VALIDACION: "+e.inscripcionMateria.errors.allErrors
					render (view:"edit", model:[inscripcionMateriaInstance:e.inscripcionMateria,materiasSerialized:params.materiasSerialized])
					return
				}
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
        if (inscripcionMateriaInstance) {
            try {
                inscripcionMateriaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(InscripcionMateria,params,grailsApplication)
		def list=gud.listrefactor(false)
		def totalregistros=gud.listrefactor(true)
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		
		
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
		list.each{
			
			if (flagaddcomilla)
				result=result+','
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.alumno.apellidoNombre)+'","'+it.carrera.denominacion+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def list = InscripcionMateria.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					inscripcionmateria id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(InscripcionMateria,params,grailsApplication)
		list=gud.listrefactor(false)
		def totalregistros=gud.listrefactor(true)
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		
		 
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
		list.each{
			
			if (flagaddcomilla)
				result=result+','
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.nombre+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def alumnosinscripcion = {
		log.info "INGRESANDO AL CLOSURE alumnosinscripcion"
		log.info "PARAMETROS: $params"
		
	}
	
	def editjsonmaterias = {
		render ""
	}

	def listjsonmaterias = {
		log.info "INGRESANDO AL CLOSURE listjsonmaterias"
		log.info "PARAMETROS: $params"
		def result="[]"
		
		if(params.id){
			def inscripcionMateriaInstance = InscripcionMateria.load(params.id.toLong())
			if(inscripcionMateriaInstance){
				def list=inscripcionMateriaInstance.detalleMateria
				def totalregistros=list.size()
				
				def totalpaginas=1
				
				result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
				def flagaddcomilla=false
				list.each{
					
					if (flagaddcomilla)
						result=result+','
						
					
					result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+(it.materia.denominacion)+'","'+it.estado.name+'","'+it.tipo.name+'","'+it.nota+'"]}'
					 
					flagaddcomilla=true
				}
				result=result+']}'
			}else{
				result="[]"
			}
		}
		render result

		
	}

	
}
