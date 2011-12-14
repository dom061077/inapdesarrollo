package com.educacion.academico


import com.educacion.util.GUtilDomainClass
import java.text.SimpleDateFormat 
import java.text.DateFormat 
import java.text.ParseException
import org.springframework.transaction.TransactionStatus
import com.educacion.enums.EstadoRequisitoEnum

import com.educacion.annotations.SecuredRequest;
import com.educacion.util.SecuredClosureAnnotationsHelper;


class RequisitoController {
	def sessionRegistry
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }
	
	@SecuredRequest
    def list = {
		log.info "INGRESANDO AL CLOSURE list"
		log.info "PARAMETROS: $params"
     }

	@SecuredRequest
    def create = {
		log.info "INGRESANDO AL CLOSURE create"
		log.info "PARAMETROS: $params"
		if(ClaseRequisito.count()==0){
			flash.message = "Debe cargar las Clases de Requisitos para poder cargar Requisitos"
			redirect(controller:"requisito",action:"list")
			return
		}
        def requisitoInstance = new Requisito()
        requisitoInstance.properties = params
        return [requisitoInstance: requisitoInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		def subRequisitosJson 
		if(params.subRequisitosSerialized)
			subRequisitosJson = grails.converters.JSON.parse(params.subRequisitosSerialized)

        def requisitoInstance = new Requisito(params)
		Requisito.withTransaction{TransactionStatus status ->
			def subRequisitoInstance
			log.debug "CANTIDAD DE SUBREQUISITOS: ${subRequisitosJson.size()}"
			subRequisitosJson.each{
				subRequisitoInstance = new SubRequisito(descripcion:it.descripcion,estado:EstadoRequisitoEnum."${it.estadoValue}")
				requisitoInstance.addToSubRequisitos(subRequisitoInstance)
			}
	        if (requisitoInstance.save(flush: true)) {
	            flash.message = "${message(code: 'default.created.message', args: [message(code: 'requisito.label', default: 'Requisito'), requisitoInstance.id])}"
	            redirect(controller:"requisito",action: "show", id: requisitoInstance.id)
	        }
	        else {
				status.setRollbackOnly()
	            render(view: "create", model: [requisitoInstance: requisitoInstance,subRequisitosSerialized:params.subRequisitosSerialized])
	        }
		}
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def requisitoInstance = Requisito.get(params.id)
        if (!requisitoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
            redirect(action: "list")
        }
        else {
            [requisitoInstance: requisitoInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def requisitoInstance = Requisito.get(params.id)
		def subRequisitosSerialized="["
		def flagcoma=false
		
        if (!requisitoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
            redirect(action: "list")
        }
        else {
			requisitoInstance.subRequisitos.each{
				if(flagcoma){
					subRequisitosSerialized = subRequisitosSerialized+','+ '{"id":'+it.id+',"idid":'+it.id+',"estadoValue":"'+it.estado+'","estado":"'+it.estado.name+'","descripcion":"'+it.descripcion+'"}'
				}else{
					subRequisitosSerialized = subRequisitosSerialized+ '{"id":'+it.id+',"idid":'+it.id+',"estadoValue":"'+it.estado+'","estado":"'+it.estado.name+'","descripcion":"'+it.descripcion+'"}'
					flagcoma=true
				}
			}
			subRequisitosSerialized = subRequisitosSerialized+"]"
            return [requisitoInstance: requisitoInstance,subRequisitosSerialized:subRequisitosSerialized]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		def subRequisitosJson
		def subRequisitosSerialized=params.subRequisitosSerialized
		def flagcoma=false
		
		if(params.subRequisitosSerialized)
			subRequisitosJson = grails.converters.JSON.parse(params.subRequisitosSerialized)

			//[{"id":"2","codigo":"OORR-6","descripcion":"requisito 6"},{"id":"1","codigo":"OORR-3","descripcion":"REQUISITO 3"}]
        def requisitoInstance = Requisito.get(params.requisitoId)
        if (requisitoInstance) {
			if(!subRequisitosSerialized){
				subRequisitosSerialized="["
				requisitoInstance.subRequisitos.each{
					if(flagcoma){
						subRequisitosSerialized = subRequisitosSerialized+','+ '{"id":'+it.id+',"idid":"'+it.id+'","descripcion":"'+it.descripcion+'"}'
					}else{
						subRequisitosSerialized = subRequisitosSerialized+ '{"id":'+it.id+',"idid":"'+it.id+'","descripcion":"'+it.descripcion+'"}'
						flagcoma=true
					}
				}
				subRequisitosSerialized=subRequisitosSerialized+"]"
			}
			
			Requisito.withTransaction{TransactionStatus status ->
	            if (params.version) {
	                def version = params.version.toLong()
	                if (requisitoInstance.version > version) {
						status.setRollbackOnly()
	                    requisitoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'requisito.label', default: 'Requisito')] as Object[], "Another user has updated this Requisito while you were editing")
	                    render(view: "edit", model: [requisitoInstance: requisitoInstance,subRequisitosSerialized:subRequisitosSerialized])
	                    return
	                }
	            }
				def arraySubrequisitos = []
				requisitoInstance.subRequisitos.each{
					arraySubrequisitos.add(it.id)
				}
				def subRequisitoInstance
				arraySubrequisitos.each { 
					try{
						subRequisitoInstance = SubRequisito.load(it)
						requisitoInstance.removeFromSubRequisitos(subRequisitoInstance)
						subRequisitoInstance.delete()
					}catch(org.hibernate.ObjectNotFoundException e){
						
					}	
				}
				
				
				subRequisitosJson.each{
					requisitoInstance.addToSubRequisitos(new SubRequisito(descripcion:it.descripcion,estado:EstadoRequisitoEnum."${it.estadoValue}"))
				}
				if(params.claseRequisitoId)
					requisitoInstance.claseRequisito = ClaseRequisito.load(params.claseRequisitoId.toLong())	
				else
					requisitoInstance.claseRequisito = null
					
	            requisitoInstance.properties = params
	            if (!requisitoInstance.hasErrors() && requisitoInstance.save(flush: true)) {
	                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'requisito.label', default: 'Requisito'), requisitoInstance.id])}"
	                redirect(controller:"requisito",action: "show", id: requisitoInstance.id)
	            }
	            else {
					status.setRollbackOnly()
	                render(view: "edit", model: [requisitoInstance: requisitoInstance,subRequisitosSerialized:subRequisitosSerialized])
	            }
			}
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def requisitoInstance = Requisito.get(params.id)
        if (requisitoInstance) {
            try {
                requisitoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
                redirect(controller:"requisito",action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Requisito,params,grailsApplication)
		def list=gud.listrefactor(false)
		def totalregistros=gud.listrefactor(true)
		def cnt = 0
		
		log.debug "CANTIDAD DE PRINCIPALS: "+sessionRegistry.getAllPrincipals().size()
		sessionRegistry.getAllPrincipals().each{
			cnt += sessionRegistry.getAllSessions(it, false).size()
			log.debug "Principal: "+it
		}
		//---------para testear los closures de un controller
		/*grailsApplication.controllerClasses.each{
			log.debug "CLOSURE: "+it.fullName
			it.URIs.each{
				log.debug "				URIs: "+it
			}
		}*/
		
		SecuredClosureAnnotationsHelper.listRequestmap(grailsApplication,log)?.each{
			log.debug "OBJETO DEVUELTO PARA LOS SECURED REQUEST"
		}
		
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		
		
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
		list.each{
			
			if (flagaddcomilla)
				result=result+','
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.descripcion==null?"":it.descripcion)+'","'+(it.estado?.name==null?"":it.estado?.name)+'","'+(it.claseRequisito?.descripcion==null?"":it.claseRequisito?.descripcion)+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def list = Requisito.createCriteria().list(){
				like('descripcion','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					requisito id:obj.id,label:obj.descripcion,value:obj.descripcion
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Requisito,params,grailsApplication)
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
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.descripcion+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}

	def editsubrequisitos = {
		log.info "INGRESANDO AL CLOSURE editsubrequisitos"
		log.info "PARAMETROS: $params"
		render(contentType:"text/json"){
			array{
				
			}
		}
	}

	def listsubrequisitos = {
		log.info "INGRESANDO AL CLOSURE listsubrequisitos"
		log.info "PARAMETROS: $params"
		def requisitoInstance
		
		def result
		def flagaddcomilla
		def totalpaginas
		def totalregistros

		if(params.id){
			requisitoInstance = Requisito.load(params.id.toLong())
			 result='{"page":1,"total":"'+1+'","records":"'+requisitoInstance.subRequisitos.size()+'","rows":['
			 flagaddcomilla=false
			 requisitoInstance.subRequisitos.each{
				 
				 if (flagaddcomilla)
					 result=result+','
				 
				 result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.descripcion+'","'+it.estado.name+'"]}'
				  
				 flagaddcomilla=true
			 }
	 
			 result=result+']}'
			 render result
	 	}else{
		 	render '{page:0,"total":"0","records":0,"rows":[]}'
		 }

	}
	
}
