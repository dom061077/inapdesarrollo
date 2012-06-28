package com.educacion.academico


import com.educacion.util.GUtilDomainClass 
import org.springframework.transaction.TransactionStatus
import java.text.SimpleDateFormat 
import java.text.DateFormat 
import java.text.ParseException 



class DivisionController {

	
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
        def divisionInstance = new Division()
        divisionInstance.properties = params
        return [divisionInstance: divisionInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

		def divisionesJson
		def nivelInstance = Nivel.get(params.nivelid);
		
		if (nivelInstance) {
		
			if(params.divisionesSerialized)
				divisionesJson = grails.converters.JSON.parse(params.divisionesSerialized)
	
				
			Nivel.withTransaction{TransactionStatus status ->
				divisionesJson.each{
					nivelInstance.addToDivisiones(new Division(descripcion:it.descripcion,letra:it.letra,turno:it.turno,descripcionTurno:it.descriturno,cupoComision:it.cupo ) )
									
				}
				if (nivelInstance.save(flush: true)) {
					log.debug("Objeto salvado")
					flash.message = "${message(code: 'default.created.message', args: [message(code: 'division.label', default: 'Division'), nivelInstance.id])}"
					redirect(action: "show", params:[idnivel: nivelInstance.id])
				}
				else {
					log.debug("Error al salvar")
					status.setRollbackOnly()
					render(view: "create", model: [nivelInstance: nivelInstance, divisionesSerialized:params.divisionesSerialized])
				}
			}
		}else{
			flash.message = "Ingrese correctamente Carrera y Nivel por favor..."
			render(view: "create", model: [nivelInstance: nivelInstance])
			return
	
		}
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def nivelInstance = Nivel.get(params.idnivel)
        if (!nivelInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'division.label', default: 'Division'), params.idnivel])}"
            redirect(action: "list")
        }
        else {
            [nivelInstance: nivelInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def divisionInstance = Division.get(params.id)
        if (!divisionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'nivel.label', default: 'Nivel'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [divisionInstance: divisionInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def divisionInstance = Division.get(params.id)
        if (divisionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (divisionInstance.version > version) {
                    divisionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'division.label', default: 'Division')] as Object[], "Another user has updated this Division while you were editing")
                    render(view: "edit", model: [divisionInstance: divisionInstance])
                    return
                }
            }
            divisionInstance.properties = params
            if (!divisionInstance.hasErrors() && divisionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'division.label', default: 'Division'), divisionInstance.id])}"
                redirect(action: "showdivisiones", id: divisionInstance.id)
            }
            else {
                render(view: "edit", model: [divisionInstance: divisionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'division.label', default: 'Division'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def divisionInstance = Division.get(params.id)
        if (divisionInstance) {
            try {
                divisionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'division.label', default: 'Division'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'division.label', default: 'Division'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'division.label', default: 'Division'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		
		def gud=new GUtilDomainClass(Division,params,grailsApplication)
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.nivel.carrera.denominacion+'","'+it.nivel.descripcion+'","'+it.descripcion+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def list = Division.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					division id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Division,params,grailsApplication)
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


	def editdivisiones = {
		log.info "INGRESANDO AL CLOSURE editdivisiones"
		log.info "PARAMETROS: $params"
		render(contentType:"text/json"){
			array{
				
			}
		}
	}
	
	def listdivisiones = {
		log.info "INGRESANDO AL CLOSURE listdivisiones"
		log.info "PARAMETROS: $params"
		def nivelInstance = Nivel.get(params.id)
		def result
		def flagcomilla = false
		if(nivelInstance){
			result =  '{"page":1,"total":"'+1+'","records":"'+nivelInstance.divisiones.size()+'","rows":['
			nivelInstance.divisiones.each{
				if(flagcomilla)
					result = result + ',{"id":"'+it.id+'","cell":["'+it.descripcion+'","'+it.letra+'","'+it.turno+'","'+it.descripcionTurno+'","'+it.cupoComision+'"]}'
				else
					result = result + '{"id":"'+it.id+'","cell":["'+it.descripcion+'","'+it.letra+'","'+it.turno+'","'+it.descripcionTurno+'","'+it.cupoComision+'"]}'
					
				if(!flagcomilla)
					flagcomilla=true
			}
			result = result + "]}"
			render result
		}else{
			render "[]"
		}
	}
	
	def showdivisiones = {
		log.info "INGRESANDO AL CLOSURE showdivisiones"
		log.info "PARAMETROS: $params"
		def divisionInstance = Division.get(params.id)
			
		if (!divisionInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'division.label', default: 'Division'), params.id])}"
			redirect(action: "list")
		}
		else {
			[divisionInstance: divisionInstance]
		}
	}
	
	def reportedivision = {
        log.info "INGRESANDO AL CLOSURE reportedivision"
        log.info "PARAMETROS: $params"
        params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/divisiones/"))
        params.put("_format","PDF")
        params.put("_name","reportedivisiones")
        params.put("_file","divisiones/reportedivisiones")
        //params.put("encoding","UTF-8")
        def listDivisiones = Division.list()
        chain(controller:'jasper', action:'index', model:[data:listDivisiones], params:params)
    }
	
}
