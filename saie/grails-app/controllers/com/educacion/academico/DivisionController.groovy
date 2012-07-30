package com.educacion.academico


import com.educacion.util.GUtilDomainClass 
import org.springframework.transaction.TransactionStatus
import java.text.SimpleDateFormat 
import java.text.DateFormat 
import java.text.ParseException 
import com.educacion.academico.util.AcademicoUtil
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum
import com.educacion.enums.inscripcion.EstadoInscripcionMatriculaEnum


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
	
			def aulaInstance	
			Nivel.withTransaction{TransactionStatus status ->
                divisionesJson.each{
                    aulaInstance = Aula.get(it.aulaid)
                    nivelInstance.addToDivisiones(new Division(descripcion:it.descripcion,letra:it.letra,turno:it.turno,descripcionTurno:it.descriturno,cupoComision:it.cupo,aula:aulaInstance))
									
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.nivel.carrera.denominacion+'","'+it.nivel.descripcion+'","'+it.descripcion+'","'+it.aula.nombre+'"]}'
			 
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


    def editdivision = {
        log.info "INGRESANDO AL CLOSURE editdivision"
        log.info "PARAMETROS: $params"

        render "[]"
    }


	def editdivisiones = {
		log.info "INGRESANDO AL CLOSURE editdivisiones"
		log.info "PARAMETROS: $params"
        def divisionInstance = Division.get(params.divisiones.toLong())

        if (divisionInstance){
            def inscdetalleList = InscripcionMateriaDetalle.createCriteria().list{
                inscripcionMateria{
                    inscripcionMatricula{
                        eq("id",params.id.toLong())
                    }

                }
            }
            InscripcionMateriaDetalle.withTransaction {TransactionStatus status ->
                //InscripcionMateriaDetalle.executeUpdate("update InscripcionMateriaDetalle  set division.id =? where inscripcionMateria.inscripcionMatricula.id=?",[divisionInstance.id,params.id.toLong()])
                inscdetalleList.each {
                    it.division = divisionInstance
                    it.save()
                }

            }
        }
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
					result = result + ',{"id":"'+it.id+'","cell":["'+it.descripcion+'","'+it.letra+'","'+it.turno+'","'+it.descripcionTurno+'","'+it.cupoComision+'","'+it.aula.nombre+'"]}'
				else
					result = result + '{"id":"'+it.id+'","cell":["'+it.descripcion+'","'+it.letra+'","'+it.turno+'","'+it.descripcionTurno+'","'+it.cupoComision+'","'+it.aula.nombre+'"]}'
					
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

        params.put("nombreinstitucion", g.message(code:"caratula.institucion.nombre"))
        params.put("direccioninstitucion", g.message(code:"caratula.institucion.direccion"))
        params.put("telefonoinstitucion", g.message(code:"caratula.institucion.telefono"))

        params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/divisiones/"))
        params.put("_format","PDF")
        params.put("_name","reportedivisiones")
        params.put("_file","divisiones/reportedivisiones")
        def listDivisiones = Division.list()

        listDivisiones.each {
            it.nivel.carrera.denominacion
        }

        chain(controller:'jasper', action:'index', model:[data:listDivisiones], params:params)
    }


    def asignaula = {
        log.info "INGRESANDO AL CLOSURE asignaula"
        log.info "PARAMETROS: $params"


    }


    def listalumnos = {
        log.info "INGRESANDO AL CLOSURE listalumnos"
        log.info "PARAMETROS: $params"
        def filtersjson

        if (params._search.toBoolean()){
            filtersjson = grails.converters.JSON.parse(params.filters)
        }
        
        
        if (params.carreraid && params.carreraid != ""){
            def anioLectivoInstance = AcademicoUtil.getAnioLectivoCarrera(params.carreraid.toLong())

            def list =  InscripcionMatricula.createCriteria().list {
                anioLectivo{
                    eq("id",anioLectivoInstance.id)
                }
                carrera{
                    eq("id",params.carreraid.toLong())
                }
                // TODO: Preguntar si filtramos por otro estado además de "Condirmado" en la inscripción de la Matrícula
                or{
                    eq("estado",EstadoInscripcionMatriculaEnum.ESTADOINSMAT_CONFIRMADA)
                    eq("estado",EstadoInscripcionMatriculaEnum.ESTADOINSMAT_PAGADA)
                }
                alumno{
                    and{
                        filtersjson?.rules?.each{
                           if(it.field.toUpperCase().equals("NUMERODOCUMENTO"))
                               try
                                   {eq(it.field,it.data.toLong())}
                               catch(Exception e){

                                }
                           else
                               ilike(it.field,"%"+it.data+"%")

                        }
                    }
                }

            }

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

                result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.alumno.apellido==null?"":it.alumno.apellido)+'","'+(it.alumno.nombre==null?"":it.alumno.nombre)+'","'+(it.alumno.tipoDocumento.name==null?"":it.alumno.tipoDocumento.name)+'","'+(it.alumno.numeroDocumento==null?"":it.alumno.numeroDocumento)+'","'+(it.alumno.fechaNacimiento==null?"":g.formatDate(format:'dd/MM/yyyy',date:it.alumno.fechaNacimiento))+'",""]}'

                flagaddcomilla=true
            }
            result=result+']}'
            render result
        }else{
            render "[]"
        }

    }


    def listamateriainscripcion = {
        log.info "INGRESANDO AL CLOSURE listamateriainscripcion"
        log.info "PARAMETROS: $params"

        def list =  InscripcionMateriaDetalle.createCriteria().list {
            inscripcionMateria{
               eq("estado",EstadoInscripcionMateriaEnum.ESTADOINSMAT_ACTIVA)
                inscripcionMatricula {
                    eq("id",params.id.toLong())
                }
            }
            materia{
                nivel{
                    eq("id",params.nivelid.toLong())
                }
            }
            
        }

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

            result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.materia.denominacion+'","'+(it.division?.descripcion==null?"":it.division?.descripcion)+'"]}'

            flagaddcomilla=true
        }
        result=result+']}'
        render result


    }


    def listdivisionjson = {
        log.info "INGRESANDO AL CLOSURE listdivisionjson"
        log.info "PARAMETROS: $params"

        def list = Division.createCriteria().list {
            nivel {
                eq("id", params.nivelID.toLong())
            }    
            
        } 
        
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

            result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.descripcion+'","'+it.letra+'","'+it.cupoComision+'","'+it.turno+'","'+it.aula.nombre+'"]}'

            flagaddcomilla=true
        }
        log.debug "RESULT RENDERED "+result
        result=result+']}'
        render result

    }


    def editdivmateria = {
        log.info "INGRESANDO AL CLOSURE editdivmateria"
        log.info "PARAMETROS: $params"

        def divisionInstance = Division.get(params.divisiones.toLong())

        if (divisionInstance){
            def inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.get(params.id.toLong())
            inscripcionMateriaDetalleInstance.division = divisionInstance
            inscripcionMateriaDetalleInstance.save()
        }
        render(contentType:"text/json"){
            array{

            }
        }
    }



}
