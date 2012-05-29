package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 
import org.springframework.transaction.TransactionStatus


class AulaController {

	
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
        def aulaInstance = new Aula()
        aulaInstance.properties = params
        return [aulaInstance: aulaInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		
		def carrerasJson
		
		
				  
		if(params.detalleaulaSerialized)
			carrerasJson = grails.converters.JSON.parse(params.detalleaulaSerialized)

        def aulaInstance = new Aula(params)
		def carreraInstanceSearch
		
		Aula.withTransaction{TransactionStatus status ->
			carrerasJson.each{
				carreraInstanceSearch = Carrera.load(it.idid.toLong())
				aulaInstance.addToDetalle(new DetalleAula(carrera:carreraInstanceSearch,descripcion:it.observacion))
				
			}
			if (aulaInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'aula.label', default: 'Aula'), aulaInstance.id])}"
				redirect(action: "show", id: aulaInstance.id)
			}
			else {
				status.setRollbackOnly()
				render(view: "create", model: [aulaInstance: aulaInstance,detalleaulaSerialized:params.detalleaulaSerialized])
			}
	
			
		}
		
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def aulaInstance = Aula.get(params.id)
        if (!aulaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
            redirect(action: "list")
        }
        else {
            [aulaInstance: aulaInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def aulaInstance = Aula.get(params.id)
        if (!aulaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
            redirect(action: "list")
        }
        else {
			def carrerasSerialized = "["
			def flagaddcomilla = false
			aulaInstance.detalle.each{
				if (flagaddcomilla)
					carrerasSerialized=carrerasSerialized+','
				carrerasSerialized=carrerasSerialized+ '{"id":'+it.id+',"idid":'+it.carrera.id+',"denominacion":"'+it.carrera.denominacion+'","observacion":"'+it.descripcion+'"}'
				flagaddcomilla=true
			}
			carrerasSerialized = carrerasSerialized + "]"				
            return [aulaInstance: aulaInstance,detalleaulaSerialized:carrerasSerialized]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
	
		def detalleJson	
		
		if(params.detalleaulaSerialized)
			detalleJson = grails.converters.JSON.parse(params.detalleaulaSerialized)


        def aulaInstance = Aula.get(params.aulaId)
		
        if (aulaInstance) {

			if (params.version) {
                def version = params.version.toLong()
                if (aulaInstance.version > version) {
                    
                    aulaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'aula.label', default: 'Aula')] as Object[], "Another user has updated this Aula while you were editing")
                    render(view: "edit", model: [aulaInstance: aulaInstance])
                    return
                }
            } 
			Aula.withTransaction{TransactionStatus status ->
				
				def listDetalleAula = DetalleAula.createCriteria().list(){
					aula{
						eq("id",aulaInstance.id)
					}
				}
				listDetalleAula.each{
					aulaInstance.removeFromDetalle(it)
					it.delete()
				}
					
				aulaInstance.properties = params
				
				def detalleaulajson
				if(params.detalleaulaSerialized){
					detalleaulajson = grails.converters.JSON.parse(params.detalleaulaSerialized)
					
					def carreraInstance
					
					detalleaulajson?.each{
						carreraInstance = Carrera.load(it.idid.toLong())
						log.debug "El ID de aula es " + carreraInstance.id 
						
						aulaInstance.addToDetalle(new DetalleAula(descripcion:it.observacion
							,carrera:carreraInstance))
					}
				}
								
	            if (!aulaInstance.hasErrors() && aulaInstance.save(flush: true)) {
	                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'aula.label', default: 'Aula'), aulaInstance.id])}"
	                redirect(action: "show", id: aulaInstance.id)
	            }
	            else {
	                render(view: "edit", model: [aulaInstance: aulaInstance])
	            }
			}
        }
        else {
			log.debug "El ID de aula es " + params.aulaId
			
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"
		
		def aulaInstance = Aula.get(params.aulaId)
        if (aulaInstance) {
            try {

					Aula.withTransaction{TransactionStatus status ->
					
					def listDetalleAula = DetalleAula.createCriteria().list(){
						aula{
							eq("id",aulaInstance.id)
						}
					}
					listDetalleAula.each{
						aulaInstance.removeFromDetalle(it)
						it.delete()
					}

							
					aulaInstance.delete(flush: true)
	                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
	                redirect(action: "list")
            	}
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
                redirect(action: "show", id: params.aulaId)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Aula,params,grailsApplication)
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.nombre==null?"":it.nombre)+'","'+(it.cupo==null?"":it.cupo)+'","'+it.estado.name+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def list = Aula.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					aula id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Aula,params,grailsApplication)
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

	def listcarreras = {
		log.info "INGRESANDO AL CLOSURE listcarreras"
		log.info "PARAMETROS: $params"
		def aulaInstance = Aula.get(params.id)
		def result
		def flagcomilla = false
		if(aulaInstance){
			result =  '{"page":1,"total":"'+1+'","records":"'+aulaInstance.detalle.size()+'","rows":['
			aulaInstance.detalle.each{
				if(flagcomilla)
					result = result + ',{"id":"'+it.id+'","cell":["'+it.id+'","'+it.carrera.denominacion+'","'+it.descripcion+'"]}'
				else
					result = result + '{"id":"'+it.id+'","cell":["'+it.id+'","'+it.carrera.denominacion+'","'+it.descripcion+'"]}'
					
				if(!flagcomilla)
					flagcomilla=true
			}
			result = result + "]}"
			render result
		}else{
			render "[]"
		}
	}
	
	def editcarreras = {
		render(contentType :"text/json"){
			array{
				
			}
		}
	}

	def listdetallecarreras = {
		log.info "INGRESANDO AL METODO listdetallecarreras"
		log.info "PARAMETROS: ${params}"
		
		def aulaInstance = Aula.get(params.aula_id)
		
		def list=  aulaInstance.detalle
		def totalregistros=list.size()
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
		list.each{
			
			if (flagaddcomilla)
				result=result+','
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.carrera.denominacion+'","'+it.descripcion+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result
	}
	
	def reporteaulas = {
		log.info "INGRESANDO AL CLOSURE aulasreporte"
		log.info "PARAMETROS: $params"
		params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/aula/"))
		params.put("_format","PDF")
		params.put("_name","reporteaulas")
		params.put("_file","aula/aulasreporte")
		//params.put("encoding","UTF-8")
		def listAulas = Aula.list()
		chain(controller:'jasper', action:'index', model:[data:listAulas], params:params)
	}

	
}
