package com.medfire

//http://fbflex.wordpress.com/2011/10/24/six-ways-to-become-a-better-grails-programmer/

import com.medfire.enums.EstadoEvent;
import com.medfire.util.FilterUtils
import java.util.Calendar;
import java.util.Date
import java.util.GregorianCalendar
import grails.converters.JSON
import com.medfire.security.Person

class EventController {
	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }
 
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [eventInstanceList: Event.list(params), eventInstanceTotal: Event.count()]
    }

    def create = {
		log.info "INGRESANDO AL METODO create DEL CONTROLLER EventController"
		log.info "PARAMETROS $params" 
		//def eventInstance = new Event()
        //eventInstance.properties = params
		
		
		def usuario = Person.load( springSecurityService.getCurrentUser()?.id)
		def profList = Profesional.createCriteria().list{
			and{
				eq("activo",true)
				institucion{
					eq("id",usuario.institucion.id)
				}
			}
			order("nombre","asc")
		}
		def profsel
		if(params.profesionalId) 
			profsel=profList.find{it.id==params.profesionalId.toLong()}
		else{
			if(profList?.size()>0)
				profsel=profList.get(0)
			else
				flash.message=g.message(code:"com.medfire.Event.sin.profesionales",args:[usuario.institucion.nombre])		 
		}
		log.debug "cantidad de profesionales que atiende: "+profList.size()
        return [profesionales:profList,profesionalId:params.profesionalId,profsel:profsel,intervalo:30]
    }

    def save = {
        def eventInstance = new Event(params)
        if (eventInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])}"
            redirect(action: "show", id: eventInstance.id)
        }
        else {
            render(view: "create", model: [eventInstance: eventInstance])
        }
    }

    def show = {
        def eventInstance = Event.get(params.id)
        if (!eventInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            redirect(action: "list")
        }
        else {
            [eventInstance: eventInstance]
        }
    }

    def edit = {
        def eventInstance = Event.get(params.id)
        if (!eventInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [eventInstance: eventInstance]
        }
    }

    def update = {
        def eventInstance = Event.get(params.id)
        if (eventInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventInstance.version > version) {
                    
                    eventInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'event.label', default: 'Event')] as Object[], "Another user has updated this Event while you were editing")
                    render(view: "edit", model: [eventInstance: eventInstance])
                    return
                }
            }
            eventInstance.properties = params
            if (!eventInstance.hasErrors() && eventInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])}"
                redirect(action: "show", id: eventInstance.id)
            }
            else {
                render(view: "edit", model: [eventInstance: eventInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def eventInstance = Event.get(params.id)
        if (eventInstance) {
            try {
                eventInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
                redirect(action: "list")
                
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
                redirect(action: "show", id: params.id)
                
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            redirect(action: "list")
             
        }
    }

	def operation = {
		//log.info "INGRESANDO AL METODO operation DEL CONTROLLER EventController"
		//log.info "PARAMETROS $params"
		if(params.cmd.equals("read")){
			return read(params)		
		}
		
		if(params.cmd.equals("save")){
			return savejson(params)		
		}
		
		if(params.cmd.equals("update")){
			return updateeventjson(params)		
		}
		
		if(params.cmd.equals("updatePos")){
			return updateeventposjson(params)
		}
		
		if(params.cmd.equals("delete")){
			return deleteevent(params)
		}
		
		if(params.cmd.equals("list")){
			return listatencionjson(params)
		}
		
		
	}
	    
	
	
    private def read(def params){
		//log.info "INGRESANDO AL METODO PRIVADO read"
		def eventos = Event.createCriteria().list(){
			and{
				profesional{
					eq('id',new Long(params.profesionalId?:0))
				}
				ge("start",Integer.parseInt(params.start) )
				le("end",Integer.parseInt(params.end))
			}
			
		}
		def backgroundColor=grailsApplication.config.event.COLOR_PENDIENTE
		def borderColor = ""
		def textColor = ""
		render(contentType:"text/json"){
			array{
				for(e in eventos){
					
					if(e.estado==EstadoEvent.EVENT_PENDIENTE)
						backgroundColor=grailsApplication.config.event.COLOR_PENDIENTE
					if(e.estado==EstadoEvent.EVENT_ATENDIDO)
						backgroundColor=grailsApplication.config.event.COLOR_ATENDIDO
					if(e.estado==EstadoEvent.EVENT_AUSENTE)
						backgroundColor=grailsApplication.config.event.COLOR_AUSENTE
					if(e.estado==EstadoEvent.EVENT_ANULADO)
						backgroundColor=grailsApplication.config.event.COLOR_ANULADO
					if(e.estado==EstadoEvent.EVENT_ENSALA)	
						backgroundColor=grailsApplication.config.event.COLOR_ENSALA
					
					if(e.sobreTurno){
						borderColor=grailsApplication.config.event.COLOR_SOBRETURNO
						textColor=grailsApplication.config.event.COLOR_SOBRETURNO	
					}else{
						borderColor=""
						textColor=""
					}
						

					evento id: e.id,pacienteId:e.paciente?.id,estado:e.estado, title:e.titulo,start:e.start,sobreTurno:e.sobreTurno, end:e.end, allDay:false,version:e.version,es,borderColor:borderColor,textColor:textColor,backgroundColor:backgroundColor,fechaStart: g.formatDate(date:e.fechaStart,format:"dd/MM/yyyy hh:mm"),fechaEnd:g.formatDate(date:e.fechaEnd,format:"dd/MM/yyyy hh:mm")
				}
			}
		}
	}

    private def savejson(def params) {
		log.info "INGRESANDO AL METODO PRIVADO savejson "
		log.info "PARAMETROS $params"
        def eventInstance = new Event()
        
		Calendar currentCal = Calendar.getInstance()
		Calendar cal = Calendar.getInstance()
		currentCal.set(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH),cal.get(Calendar.DATE))
		
        GregorianCalendar gc = new GregorianCalendar(
        		Integer.parseInt(params.startyear)
        		,Integer.parseInt(params.startmonth)
        		,Integer.parseInt(params.startday)
        								 
        		,Integer.parseInt(params.starthours)
        		,Integer.parseInt(params.startminutes)
        	)
		if(gc.before(currentCal)){
			render "Fecha de turno anterior al dia de hoy"
			return
		}
		
        eventInstance.fechaStart = new java.sql.Date(gc.getTime().getTime())
        
        gc.set(Integer.parseInt(params.endyear)
        		,Integer.parseInt(params.endmonth)
        		,Integer.parseInt(params.endday)
        		,Integer.parseInt(params.endhours)
        		,Integer.parseInt(params.endminutes)
        		)
        
		
		
        eventInstance.fechaEnd = new java.sql.Date(gc.getTime().getTime())
		eventInstance.start = new Integer(params.start)
		eventInstance.end = new Integer(params.end)
		eventInstance.allDay = false
		eventInstance.titulo = params.title
		eventInstance.sobreTurno = params.essobreturno.toBoolean()
		
		
		if(!params.pacienteId.trim().equals(""))
			eventInstance.paciente = Paciente.load(new Long(params.pacienteId))
			
		if(params.profesionalId)	
			eventInstance.profesional = Profesional.load(new Long(params.profesionalId))
			
		def sobreturno = esSobreturno(eventInstance)
			
		eventInstance.user = springSecurityService.getCurrentUser()
        if (eventInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])}"
            if(sobreturno)
				render "El turno se guardó correctamente pero es un SOBRETURNO"
			else
            	render eventInstance.id
        }
        else {
			log.debug "ERRORES: "+eventInstance.errors.allErrors
            render "Error al tratar de guardar el turno"
        }
    }
	
	
	//-----------------validacion sobreturnos-----------
	private boolean esSobreturno(def eventInstance){
		log.debug "INGRESANDO AL METODO PRIVADO esSobreturno"
		def listsobreturno = Event.createCriteria().list(){
			and{
				or{
					//caso 1
					and{
						eq("start",eventInstance.start)
						eq("end",eventInstance.end)
					}
					
					//caso 2
					and{
						gt("start",eventInstance.start)
						gt("end",eventInstance.end)
						lt("start",eventInstance.end)
					}
					
					//caso 3
					and{
						lt("start",eventInstance.start)
						lt("end",eventInstance.end)
						gt("end",eventInstance.start)
						
					}
					
					//caso 4
					and{
						eq("start",eventInstance.start)
						lt("end",eventInstance.end)
					}
					
					//caso 5
					and{
						gt("start",eventInstance.start)
						lt("end",eventInstance.end)
					}
					
				}
				profesional{
					eq("id",eventInstance.profesional.id)
				}
			}	
		}
		
		if(listsobreturno.size()>1){
			log.debug "ES UN SOBRETURNO"
			return true
		}else{
			log.debug "NO ES UN SOBRETURNO"
			return false
		}
	}
	
	//--------------------------------------------------

	
    
    private def deleteevent(def params){
    	log.info "INGRESANDO AL METODO PRIVADO deleteevent"
    	log.info "PARAMETROS $params"
		def hoy = new Date()
		def gc = new GregorianCalendar()
		gc.setTime(hoy)
		def gcHoy = new GregorianCalendar(gc.get(Calendar.YEAR),gc.get(Calendar.MONTH),gc.get(Calendar.DATE))

		
        def eventInstance = Event.get(params.id)
        if (eventInstance) {
            try {
				if(!eventInstance.estado.equals(EstadoEvent.EVENT_PENDIENTE && !eventInstance.estado.equals(EstadoEvent.EVENT_ENSALA)) 
					|| eventInstance.fechaStart.compareTo(gcHoy.getTime())<0 ){
					render(contentType:"text/json"){
						result success:false,title:"Error, solo se pueden modificar los turnos pendientes y que no sean anteriores al día de hoy"
					}
					return
				}
				
                eventInstance.delete(flush: true)
                //flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
                //redirect(action: "list")
                render (contentType:"text/json"){
					result success:true
				}
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                //flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
                //redirect(action: "show", id: params.id)
                render "${message(code: 'default.not.deleted.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            }
        }
        else {
            //flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            //redirect(action: "list")
            render "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}" 
        }
    }
    
    private def updateeventjson(def params){
    	log.info "INGRESANDO AL METODO PRIVADO updateeventjson"
    	log.info "PARAMETROS $params"
    	
		def hoy = new Date()
		def gc = new GregorianCalendar()
		gc.setTime(hoy)
		def gcHoy = new GregorianCalendar(gc.get(Calendar.YEAR),gc.get(Calendar.MONTH),gc.get(Calendar.DATE))
		
        def eventInstance = Event.get(params.id)
		
        if (eventInstance) {
			if(!eventInstance.estado.equals(EstadoEvent.EVENT_PENDIENTE) 
				 || eventInstance.fechaStart.compareTo(gcHoy.getTime())<0 ){
				render(contentType:"text/json"){
					result success:false,title:"Error, solo se pueden modificar los turnos pendientes y que no sean anteriores al d�a de hoy"
				}
				return
			}
			
            if (params.version) {
                def version = params.version.toLong()
                if (eventInstance.version > version) {
					
                    //eventInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'event.label', default: 'Event')] as Object[], "Another user has updated this Event while you were editing")
                    //render(view: "edit", model: [eventInstance: eventInstance])
                    //return
                    render (contentType:"text/json"){
						result success:false,title:"Error, el turno está siendo modificado por otro usuario"
					}
					return
                }
            }
			if(params.paciente.id)
            	eventInstance.paciente=Paciente.load(params.paciente.id)
			else
				eventInstance.paciente=null	
			eventInstance.properties=params
			
			
            if (!eventInstance.hasErrors() && eventInstance.save(flush: true)) {
                //flash.message = "${message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])}"
                //redirect(action: "show", id: eventInstance.id)
                render (contentType:"text/json"){
					result success:true,title:eventInstance.paciente?.apellido+"-"+eventInstance.paciente?.nombre
				}
            }
            else {
                //render(view: "edit", model: [eventInstance: eventInstance])
				log.debug "ERROR DE VALIDACION: "+eventInstance.errors.allErrors
                render (contentType:"text/json"){
                	result success:false,title:"Error, datos incompletos"
                }
                //render "Error, no se modifcó el turno"
            }
        }
        else {
            //flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            //redirect(action: "list")
            //render "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            render(contentType:"text/json"){
            	result success:false,title:"${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            }
        }
    }
    

	private def updateeventposjson(def params){
		log.info "INGRESANDO AL METODO PRIVADO updateeventposjson"
		log.info "PARAMETROS $params"
		
		def eventInstance = Event.get(params.id)
		Calendar currentCal = Calendar.getInstance()
		Calendar cal = Calendar.getInstance()
		currentCal.set(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH),cal.get(Calendar.DATE))
		
		
		if (eventInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (eventInstance.version > version) {
					
					//eventInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'event.label', default: 'Event')] as Object[], "Another user has updated this Event while you were editing")
					//render(view: "edit", model: [eventInstance: eventInstance])
					//return
					log.info "EL EVENTO O TURNO ESTA SIENDO MODIFICADO POR OTRO USUARIO"
					render (contentType:"text/json"){
						result success:false,title:"Error, el turno está siendo modificado por otro usuario"
					}
					return
				}
			}
			
			if (!eventInstance.estado.equals(EstadoEvent.EVENT_PENDIENTE && !eventInstance.estado.equals(EstadoEvent.EVENT_ENSALA)) 
					|| eventInstance.fechaStart.compareTo(currentCal.getTime())<0){
				render(contentType:"text/json"){
					result success:false,title:"Error, para mover un turno el mismo debe estar pendiente y que no sean anteriores al día de hoy"
				}
				return
				
			}
	        GregorianCalendar gc = new GregorianCalendar(
	        		Integer.parseInt(params.startyear)
	        		,Integer.parseInt(params.startmonth)
	        		,Integer.parseInt(params.startday)
	        								 
	        		,Integer.parseInt(params.starthours)
	        		,Integer.parseInt(params.startminutes)
	        	)
	        	
			if(gc.before(currentCal)){
				
				render(contentType:"text/json"){
					result success:false,title:"Fecha de turno anterior al dia de hoy"
				}
				log.debug "FECHA DE TURNO ANTERIOR AL DIA DE HOY"
				return
			}		

			eventInstance.start=new Integer(params.start)
			eventInstance.end=new Integer(params.end)

		        	
	        eventInstance.fechaStart = new java.sql.Date(gc.getTime().getTime())
	        log.debug "SUPERADA VALIDACION DE FECHAS"
	        gc.set(Integer.parseInt(params.endyear)
	        		,Integer.parseInt(params.endmonth)
	        		,Integer.parseInt(params.endday)
	        		,Integer.parseInt(params.endhours)
	        		,Integer.parseInt(params.endminutes)
	        		)
	        
	        eventInstance.fechaEnd = new java.sql.Date(gc.getTime().getTime())

			def sobreturno = esSobreturno(eventInstance)	
			
			if (!eventInstance.hasErrors() && eventInstance.save(flush: true)) {
				//flash.message = "${message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])}"
				//redirect(action: "show", id: eventInstance.id)
				log.info "EL EVENTO O TURNO SE GUARDO CORRECTAMENTE"
				def titulo = ""
				if(sobreturno){
					render (contentType:"text/json"){
						result success:false,title:"El turno se guardó correctamente pero es SOBRETURNO"
					}
				}else{
					render (contentType:"text/json"){
						result success:true,title:eventInstance.titulo
					}
				}
			}
			else {
				//render(view: "edit", model: [eventInstance: eventInstance])
				log.info "ERRORES DE VALIDACION EN EVENTO O TURNO: "+eventInstance.errors.allErrors
				def msgerror=''
				eventInstance.errors.allErrors.each{
					if(msgerror.indexOf(g.message(error:it))==-1)
						msgerror+=g.message(error:it)
				}
				render (contentType:"text/json"){
					result success:false,title:"$msgerror"
				}
			}
		}
		else {
			//flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
			//redirect(action: "list")
			//render "${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
			render(contentType:"text/json"){
				result success:false,title:"${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
			}
		}
	}

	def listjson={
		log.info "INGRESANDO AL CLOSURE listjson DEL CONTROLLER EventController"
		log.debug "PARAMETROS $params"
		def pagingConfig = []
		if(params.rows){
			pagingConfig = [
				max: Integer.parseInt(params.rows),
				offset:	Integer.parseInt(params.page-1)
			]
		}
		def list = User.createCriteria().list(pagingConfig){
			and{
				eq("enabled",true)
				eq("esProfesional",true)
				secretaria{
					eq("id",true)
				}
			}	
		}
		
	}
	
	private def listatencionjson(def params) {
		log.info "INGRESANDO AL METODO PRIVADO listatencionjson DEL CONTROLLER EventController"
		log.debug "PARAMETROS $params"	
		
		def pagingConfig = []
	
		
		if(params.rows){
			pagingConfig = [
				max: Integer.parseInt(params.rows),
				offset:	Integer.parseInt("1")-1
			]
		}
		def list = Event.createCriteria().list(){
			
			profesional{
				eq('id',new Long(params.profesionalId))
			}
		}
		
		
		
		
    	log.debug "TOTAL DE LIST: "+list.size()
    	def totalregistros=list.size()
    	def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
    	
    	def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
    	
    	
    	def flagaddcomilla=false
    	list.each{
    		if (flagaddcomilla)
    			result=result+','
    		result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+ (it.paciente?it.paciente?.apellido+'-'+it.paciente?.nombre:it.titulo)+'","'+it.estado+'","'+it.estado.name+'","'+it.version+'","'+g.formatDate(format:"dd/MM/yyyy hh:mm",date:it.fechaStart)+'","'+g.formatDate(format:"dd/MM/yyyy hh:mm",date:it.fechaEnd)+'"]}'
    		flagaddcomilla=true
    	}
    	
    	result=result+']}'
    	render result
    	
    	
    	/*render(contentType:"text/json"){
			if(list.size()>0)
    			success = true
			else
				success = false	
    		results = array{
    			list.each{
    				result(id:it.id,estado:'hola',paciente:it.paciente.apellido+"-"+it.paciente.nombre)
    				
    			}
    		}
    	}*/
	}
	
	def atenciondeldia= {
		Calendar cal= Calendar.getInstance()
		
		if(params.fechaFiltro && params.fechaFiltro.toLowerCase()!='null'){
			cal.set(Calendar.DATE,params.fechaFiltro.substring(0,2).toInteger())
			cal.set(Calendar.MONTH,params.fechaFiltro.substring(3,5).toInteger()-1)
			cal.set(Calendar.YEAR,params.fechaFiltro.substring(6,10).toInteger())
		}
		
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);

		def dateStart = cal.getTime();
		cal.set(Calendar.HOUR_OF_DAY, 24);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		def dateEnd = cal.getTime()
		def user = Person.load(springSecurityService.getCurrentUser().id)
		def filtersJson 
		def oper
		
		
		//log.debug "PROFESIONAL ASIGNADO ID: "+user?.profesionalAsignado?.id
		//def list = new GUtilDomainClass(Event,params,grailsApplication).listrefactor()
		def criteria = Event.createCriteria()
		def closure = {
			criteria.and(){
				criteria.profesional(){
					criteria.eq('id',user.profesionalAsignado?.id)
				}
				criteria.between('fechaStart',dateStart,dateEnd)
				if(Boolean.parseBoolean(params._search)){
					if(params.filters){
						filtersJson = JSON.parse(params.filters)
						criteria."${filtersJson.groupOp.toLowerCase()}"(){
							filtersJson?.rules?.each{
								oper = FilterUtils.operationSearch(it.op)
								criteria."${oper}"(it.field,"%"+it.data+"%")
							}
						}
					}
				}
			}
			//log.debug("APLICANDO EL ORDENAMIENTO")
			order("fechaStart","asc")
		}
		
		def criteriaCount = Event.createCriteria()
		def closureCount = {
			criteriaCount.and(){
				criteriaCount.profesional(){
					criteriaCount.eq('id',user.profesionalAsignado?.id)
				}
				criteriaCount.between('fechaStart',dateStart,dateEnd)
				if(Boolean.parseBoolean(params._search)){
					if(params.filters){
						filtersJson = JSON.parse(params.filters)
						criteriaCount."${filtersJson.groupOp.toLowerCase()}"(){
							filtersJson?.rules?.each{
								oper = FilterUtils.operationSearch(it.op)
								criteriaCount."${oper}"(it.field,"%"+it.data+"%")
							}
						}
					}
				}
			}
			criteriaCount.projections{
				rowCount()
			}
		}
		
		def list = criteria.list(closure)

		
		//log.debug "TOTAL DE LIST: "+list.size()
		def totalregistros=criteriaCount.get(closureCount)
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		
		
		def flagaddcomilla=false
		def backgroundColor
		
		list.each{
			
			if(it.estado==EstadoEvent.EVENT_PENDIENTE)
				backgroundColor=grailsApplication.config.event.COLOR_PENDIENTE
			if(it.estado==EstadoEvent.EVENT_ENSALA)
				backgroundColor=grailsApplication.config.event.COLOR_ENSALA

			if(it.estado==EstadoEvent.EVENT_ATENDIDO)
				backgroundColor=grailsApplication.config.event.COLOR_ATENDIDO
			if(it.estado==EstadoEvent.EVENT_AUSENTE)
				backgroundColor=grailsApplication.config.event.COLOR_AUSENTE
			if(it.estado==EstadoEvent.EVENT_ANULADO)
				backgroundColor=grailsApplication.config.event.COLOR_ANULADO
				
			if (flagaddcomilla)
				result=result+','
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+ (it.paciente?it.paciente?.apellido+'-'+it.paciente?.nombre:it.titulo)+'","'+it.estado+'","'+it.estado.name+'","'+it.version+'","'+g.formatDate(format:"HH:mm",date:it.fechaStart)+'","'+g.formatDate(format:"dd/MM/yyyy HH:mm",date:it.fechaStart)+'","'+g.formatDate(format:"HH:mm",date:it.fechaEnd)+'","'+g.formatDate(format:"dd/MM/yyyy HH:mm",date:it.fechaEnd)+'","'+backgroundColor+'","'+(it.paciente?it.paciente.id:0)+'"]}'
			flagaddcomilla=true
		}
		
		result=result+']}'
		render result

	}
	
	def updateestado = {
		log.info "INGRESANDO AL CLOSURE updateestado DEL CONTROLLER EventController"
		log.info "PARAMETROS: ${params}"
		def eventInstance = Event.get(params.id.toLong())
        if (eventInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (eventInstance.version > version) {
					
                    render (contentType:"text/json"){
						result success:false,title:"Error, el turno está siendo modificado por otro usuario"
					}
					return
                }
            }
			if(eventInstance.consulta){
				render(contentType:"text/json"){
					result success:false,title:"Error, el turno ya fue atendido o tiene visitas vinculadas"
				}
				return
			}
			
			if(!eventInstance.estado.equals(EstadoEvent.EVENT_PENDIENTE) && !eventInstance.estado.equals(EstadoEvent.EVENT_ENSALA)){
				render(contentType:"text/json"){
					result success:false,title:"Error, solo puede cambiar el estado a los turnos pendientes"
				}
				return
			}
			
			if(eventInstance.paciente==null){
				render(contentType:"text/json"){
					result success:false,title:"Error, solo puede cambiar el esado a los turnos que esten vinculados con el paciente correspondiente"
				}
				return
			}
			
			
			eventInstance.properties=params
            if (!eventInstance.hasErrors() && eventInstance.save(flush: true)) {
                render (contentType:"text/json"){
					result success:true,title:eventInstance.titulo
				}
            }
            else {
                render (contentType:"text/json"){
                	result success:false,title:"Error, datos incompletos"
                }
            }
        }
        else {
            render(contentType:"text/json"){
            	result success:false,title:"${message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])}"
            }
        }

	}
	 
	def editpaciente = {
		log.info "INGRESANDO AL CLOSURE editpaciente DEL CONTROLLER EventController"
		log.info "PARAMETROS: ${params}"
		def eventInstance = Event.load(new Long(params.id))
		if (eventInstance.paciente)
			redirect(controller:"historiaClinica",action: "create", params:[pacienteId: eventInstance.paciente.id,eventId: eventInstance.id])
		else{
			log.debug "ID DEL EVENTO A ASOCIAR CON EL PACIENTE QUE SE CREARA: "+eventInstance.id
			log.debug "VERSION DEL EVENTO A ASOCIAR CON EL PACIENTE QUE SE CREARA: "+eventInstance.version
			redirect(controller:"paciente",action: "create",params:[eventId:eventInstance.id])
		}	
	}    
}
