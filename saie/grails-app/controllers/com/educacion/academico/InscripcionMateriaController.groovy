package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 
import grails.converters.JSON
import org.springframework.transaction.TransactionStatus
import com.educacion.academico.exceptions.InscripcionMateriaException



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

    def create = {
		log.info "INGRESANDO AL CLOSURE create"
		log.info "PARAMETROS: $params"
        def inscripcionMateriaInstance = new InscripcionMateria()
        inscripcionMateriaInstance.properties = params
        return [inscripcionMateriaInstance: inscripcionMateriaInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def inscripcionMateriaInstance = new InscripcionMateria(params)
        if (inscripcionMateriaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), inscripcionMateriaInstance.id])}"
            redirect(action: "show", id: inscripcionMateriaInstance.id)
        }
        else {
            render(view: "create", model: [inscripcionMateriaInstance: inscripcionMateriaInstance])
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
		
		def inscripcionMateriaInstance = InscripcionMateria.get(params.idInsc)
        if (!inscripcionMateriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
            redirect(action: "list")
        }
        else {
			inscripcionMateriaInstance.detalleMateria.each{
				if(flagcoma){
					materiasSerialized  = materiasSerialized +','+ '{"id":"'+it.id+'","idid":"'+it.id+'","denominacion":"'+it.materia.denominacion+'","estadovalue":"'+it.estado+'","estado":"'+it.estado.name+'","tipovalue":"'+it.tipo+'","tipo":"'+it.tipo.name+'","nota":"'+it.nota+'"}'
				}else{
					materiasSerialized = materiasSerialized + '{"id":"'+it.id+'","idid":"'+it.id+'","denominacion":"'+it.materia.denominacion+'","estadovalue":"'+it.estado+'","estado":"'+it.estado.name+'","tipovalue":"'+it.tipo+'","tipo":"'+it.tipo.name+'","nota":"'+it.nota+'"}'
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
		
        def inscripcionMateriaInstance = InscripcionMateria.get(params.idInsc)
																	   
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
