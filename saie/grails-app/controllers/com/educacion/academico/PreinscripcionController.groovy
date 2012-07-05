package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 

import org.springframework.transaction.TransactionStatus

import com.educacion.enums.inscripcion.EstadoPreinscripcion
import com.educacion.enums.inscripcion.EstadoDetalleInscripcionRequisito
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum;
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum
import com.educacion.alumno.Alumno
import com.educacion.enums.inscripcion.EstadoInscripcionMatriculaEnum
import com.mysql.jdbc.log.Log;
import com.educacion.enums.inscripcion.OrigenInscripcionMateriaEnum
import com.educacion.academico.util.AcademicoUtil



class PreinscripcionController {

    def imageUploadService
    //TODO impementar en anulacion o eliminacion de preinscripcion la anulacion de inscripcionmatricula e inscripcionmateria
    //TODO reordenar y modificar el estado de todas las preinscripcions teniendo en cuenta los cupos
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
        def preinscripcionInstance = new Preinscripcion()
		def niveles
		//def carreras = Carrera.listOrderByDenominacion()
		//niveles = carreras?.get(0)?.niveles
		def carreraInstance = Carrera.get(params.id)
		def anioLectivoInstance = AcademicoUtil.getAnioLectivoCarrera(carreraInstance.id)
		/*def sortedList= carreraInstance.anios.sort{it.anioLectivo}.reverse()
		if(sortedList.size()>0){
			def cupo= sortedList.get(0).cupo
			def cupoSuplementes = sortedList.get(0).cupoSuplentes
			anioLectivoInstance = sortedList.get(0)
		}*/

		if(!anioLectivoInstance){
			flash.message = g.message(code:"com.educacion.academico.Carrera.flash.message.aniolectivo",args:[carreraInstance?.denominacion])
			redirect(action:"carrerasdisponibles")
			return
		}
		
		if(params.alumnoId){
			log.debug "SE ENCONTRO EL ALUMNOID: "+params.alumnoId
			preinscripcionInstance.alumno = Alumno.get(params.alumnoId)
		}
        preinscripcionInstance.properties = params
		preinscripcionInstance.carrera = carreraInstance
        def materiasSerialized

        def listmaterias = Materia.createCriteria().list(){
            and{
                nivel{
                    carrera{
                        eq("id",preinscripcionInstance.carrera.id)
                    }
                    //matregcursar:Materia,mataprobcursar:Materia,matregrendir:Materia,mataprobrendir:Materia
                }
                isEmpty("matregcursar")
                isEmpty("mataprobcursar")
                isEmpty("matregrendir")
                isEmpty("mataprobrendir")
            }
        }
        def flagcomilla = false
        materiasSerialized = "["
        listmaterias.each{
            if(flagcomilla)
                materiasSerialized = materiasSerialized + ","
            materiasSerialized = materiasSerialized + '{"id":'+it.id+',"idid":'+it.id+',"denominacion":"'+it.denominacion+'","seleccion":"Yes"}'
            flagcomilla = true
        }
        materiasSerialized += "]"


        return [preinscripcionInstance: preinscripcionInstance,materiasSerialized: materiasSerialized]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
        def inscripcionMatriculaInstance
        def materiasJson

        if(params.materiasSerialized)
            materiasJson = grails.converters.JSON.parse(params.materiasSerialized)


        def preinscripcionInstance = new Preinscripcion(params)
        def alumnoInstance = Alumno.get(params.alumnoId)
        if (!alumnoInstance)
                alumnoInstance = new Alumno(params)
        
		
		if(preinscripcionInstance.carrera){
			/*def sortedList= preinscripcionInstance.carrera.anios.sort{it.anioLectivo}.reverse()

			if(sortedList.size()>0){
				def cupo= sortedList.get(0).cupo
				def cupoSuplementes = sortedList.get(0).cupoSuplentes
				preinscripcionInstance.anioLectivo = sortedList.get(0)
			}*/
			preinscripcionInstance.anioLectivo = AcademicoUtil.getAnioLectivoCarrera(preinscripcionInstance.carrera.id)
			
		}
		if(!preinscripcionInstance.anioLectivo){
			flash.message = g.message(code:"com.educacion.academico.Carrera.flash.message.aniolectivo",args:[preinscripcionInstance?.carrera?.denominacion])
			render(view: "create", model: [preinscripcionInstance: preinscripcionInstance])
			return
		}
		
		//if(carreraInstance.)
		def hqlstr = "SELECT c.id,c.denominacion,c.duracion,c.titulo,c.validezTitulo,(SELECT max(a.anioLectivo) ";
		hqlstr = hqlstr +" FROM AnioLectivo a WHERE a.carrera.id=c.id)";
		hqlstr = hqlstr 	+",(SELECT acup.cupo FROM AnioLectivo acup";
		hqlstr = hqlstr		+" WHERE acup.anioLectivo=(SELECT MAX(anioLectivo) FROM AnioLectivo suba WHERE suba.carrera.id=c.id GROUP BY suba.carrera.id)";
		hqlstr = hqlstr		+" AND acup.carrera.id=c.id";
		hqlstr = hqlstr		+")";
		hqlstr = hqlstr	+",(SELECT acup.cupoSuplentes FROM AnioLectivo acup";
		hqlstr = hqlstr	+" WHERE acup.anioLectivo=(SELECT MAX(anioLectivo) FROM AnioLectivo suba WHERE suba.carrera.id=c.id GROUP BY suba.carrera.id)";
		hqlstr = hqlstr	+" AND acup.carrera.id=c.id";
		hqlstr = hqlstr	+")";
		hqlstr = hqlstr	+"  ,(SELECT";
		hqlstr = hqlstr	+"	COUNT(pre.id) FROM Preinscripcion pre WHERE pre.carrera.id=c.id AND pre.estado<>:estado AND pre.anioLectivo.anioLectivo=";
		hqlstr = hqlstr	+"(SELECT MAX(anioLectivo) FROM AnioLectivo a WHERE a.carrera.id=c.id)";
		hqlstr = hqlstr	+"  )";
		hqlstr = hqlstr	+" FROM Carrera c WHERE c.id=:carrera";
		def list =  Carrera.executeQuery(hqlstr,["carrera":preinscripcionInstance.carrera?.id,"estado":EstadoPreinscripcion.ESTADO_PREINSCIRPTOANULADO])
		def datosCarrera = list?.get(0)
		def cupodisponible=0
		def cupo = 0
		def cuposuplentes = 0
		def inscriptos = 0
		
		//el indice 6 es el cupo, el 7 cupo suplente, el 8 la cantidad de preinscripciones
		if((!datosCarrera[6]) || (datosCarrera[6]==0)){
			flash.message = "No hay un cupo cargado para el a�o lectivo ${preinscripcionInstance.anioLectivo.anioLectivo}"
			render(view: "create", model: [preinscripcionInstance: preinscripcionInstance])
			return
		}
		cupo = preinscripcionInstance.anioLectivo.cupo
		if(datosCarrera[7])  
			cuposuplentes = datosCarrera[7]
		if(datosCarrera[8])
			inscriptos = datosCarrera[8]
			
		if((cupo+cuposuplentes)<(inscriptos+1)){
			flash.message="No hay un cupo para esta inscripción"
			render(view:"create",model:[preinscripcionInstance:preinscripcionInstance])
			return
		}		
		cupodisponible = datosCarrera[6] - datosCarrera[8] - 1

        def flagprimernivel=false
        preinscripcionInstance.carrera.niveles.each {
            if(it.esprimernivel){
                flagprimernivel = true
                return
            }
        }


		if(cupodisponible<0){
            if (flagprimernivel)
                preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_ASPIRANTESUPLENTE
            else
			    preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_PREINSCRIPTOSUPLENTE
        }else{
            if (flagprimernivel)
                preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_ASPIRANTE
            else
			    preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_ASPIRANTESUPLENTE
        }
																 

		Preinscripcion.withTransaction{TransactionStatus status ->
			def inscripcionDetalleInstance = new InscripcionDetalleRequisito()
			
			preinscripcionInstance.carrera?.requisitos?.each{
				inscripcionDetalleInstance = new InscripcionDetalleRequisito()
				inscripcionDetalleInstance.requisito = it
				inscripcionDetalleInstance.estado = EstadoDetalleInscripcionRequisito.ESTADOINSREQ_INSATISFECHO
				preinscripcionInstance.addToDetalle(inscripcionDetalleInstance)
			}

            def inscripcionMateriaInstance


            inscripcionMatriculaInstance = new InscripcionMatricula(alumno:preinscripcionInstance.alumno
                    ,anioLectivo:preinscripcionInstance.anioLectivo
                    ,carrera:preinscripcionInstance.carrera
                    ,estado:EstadoInscripcionMatriculaEnum.ESTADOINSMAT_GENERADA)


            //preinscripcionInstance.inscripcionMatricula = inscripcionMatriculaInstance

            if(!alumnoInstance.hasErrors() && alumnoInstance.save()){
                if(alumnoInstance.photo && !alumnoInstance.photo?.isEmpty())
                    imageUploadService.save(alumnoInstance)

                preinscripcionInstance.alumno = alumnoInstance
                inscripcionMatriculaInstance.alumno = alumnoInstance
                inscripcionMatriculaInstance.anioLectivo = preinscripcionInstance.anioLectivo
                inscripcionMatriculaInstance.carrera = preinscripcionInstance.carrera


                if(materiasJson){
                    def materiaInstance
                    def cantselect = 0
                    inscripcionMateriaInstance = new InscripcionMateria(alumno:alumnoInstance
                            ,carrera:preinscripcionInstance.carrera,anioLectivo:preinscripcionInstance.anioLectivo
                            ,origen:OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA)
                    materiasJson.each{
                        log.debug "SELECCION: "+it.seleccion
                        if(it.seleccion.toUpperCase().equals("YES")){
                            materiaInstance = Materia.load(it.idid)
                            inscripcionMateriaInstance.addToDetalleMateria(new InscripcionMateriaDetalle(materia:materiaInstance
                                    ,tipo:TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR))
                            inscripcionMatriculaInstance.addToInscripcionesmaterias(inscripcionMateriaInstance)
                            cantselect++
                        }
                    }
                    if(cantselect==0){
                        status.setRollbackOnly()
                        preinscripcionInstance.errors.rejectValue("inscripcionMatricula","com.educacion.academico.InscripcionMateria.materias.blank.error")
                        render(view: "create", model: [preinscripcionInstance: preinscripcionInstance,materiasSerialized:params.materiasSerialized])
                        return

                    }
                }


                if (!inscripcionMatriculaInstance.hasErrors() && inscripcionMatriculaInstance.save()){
                    preinscripcionInstance.inscripcionMatricula = inscripcionMatriculaInstance
                    if (!preinscripcionInstance.hasErrors() && preinscripcionInstance.save()) {
                        flash.message = "${message(code: 'default.created.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), preinscripcionInstance.id])}"
                        redirect(action: "show", id: preinscripcionInstance.id)
                    }else{
                        status.setRollbackOnly()
                        render(view: "create", model: [preinscripcionInstance: preinscripcionInstance,alumnoInstance:alumnoInstance,materiasSerialized:params.materiasSerialized])
                    }
                }else{
                    log.debug "ERROR: "
                    status.setRollbackOnly()
                    render(view: "create", model: [inscripcionMatriculaInstance:inscripcionMatriculaInstance,preinscripcionInstance: preinscripcionInstance,alumnoInstance:alumnoInstance,materiasSerialized:params.materiasSerialized])

                }
            }else {
				status.setRollbackOnly()
				render(view: "create", model: [preinscripcionInstance: preinscripcionInstance,alumnoInstance:alumnoInstance,materiasSerialized:params.materiasSerialized])
			}
		}
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def preinscripcionInstance = Preinscripcion.get(params.id)
        if (!preinscripcionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
            redirect(action: "list")
        }
        else {
            [preinscripcionInstance: preinscripcionInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def preinscripcionInstance = Preinscripcion.get(params.id)
        if (!preinscripcionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
            redirect(action: "list")
        }
        else {

            def flagcomilla = false
            def flagseleccionado
            def idinscmatdetalle
            def materiasSerialized = "["

            def materiasCursar = Materia.createCriteria().list(){
                and{
                    nivel{
                        carrera{
                            eq("id",preinscripcionInstance.carrera.id)
                        }
                        //matregcursar:Materia,mataprobcursar:Materia,matregrendir:Materia,mataprobrendir:Materia
                    }
                    isEmpty("matregcursar")
                    isEmpty("mataprobcursar")
                    isEmpty("matregrendir")
                    isEmpty("mataprobrendir")
                }
            }

            materiasCursar.each{ matcursar->
                if(flagcomilla)
                    materiasSerialized = materiasSerialized + ","
                flagseleccionado="No"
                idinscmatdetalle = 0
                preinscripcionInstance.inscripcionMatricula.inscripcionesmaterias.each{inscmateria ->
                    if (inscmateria.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA){
                        inscmateria.detalleMateria.each{detinsc->
                            if(detinsc.materia.id==matcursar.id){
                                flagseleccionado="Yes"
                                idinscmatdetalle = detinsc.id
                                return
                            }
                        }
                        return
                    }
                }
                materiasSerialized = materiasSerialized + '{"id":'+matcursar.id+',"idid":'+idinscmatdetalle+',"idmateria":'+matcursar.id+',"denominacion":"'+matcursar.denominacion+'","seleccion":"'+flagseleccionado+'"}'
                flagcomilla = true
            }
            materiasSerialized += "]"


            return [preinscripcionInstance: preinscripcionInstance, materiasSerialized: materiasSerialized]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"

        def preinscripcionInstance = Preinscripcion.get(params.id)
        if (preinscripcionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (preinscripcionInstance.version > version) {
                    
                    preinscripcionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'preinscripcion.label', default: 'Preinscripcion')] as Object[], "Another user has updated this Preinscripcion while you were editing")
                    render(view: "edit", model: [preinscripcionInstance: preinscripcionInstance])
                    return
                }
            }
            preinscripcionInstance.properties = params
            if (!preinscripcionInstance.hasErrors() && preinscripcionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), preinscripcionInstance.id])}"
                redirect(action: "show", id: preinscripcionInstance.id)
            }
            else {
                render(view: "edit", model: [preinscripcionInstance: preinscripcionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def preinscripcionInstance = Preinscripcion.get(params.id)
        if (preinscripcionInstance) {
            Preinscripcion.withTransaction {TransactionStatus status ->
                try {
                    preinscripcionInstance.inscripcionMatricula.delete()
                    preinscripcionInstance.delete(flush: true)
                    flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
                    redirect(action: "list")
                }
                catch (org.springframework.dao.DataIntegrityViolationException e) {
                    flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
                    status.rollbackOnly()
                    redirect(action: "show", id: params.id)
                }
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		if(params.estado){
			params.altfilters ="{'groupOp':'AND','rules':[{'field':'estado','op':'eq','data':'"+EstadoPreinscripcion."${params.estado}"+"'}]}"
				
		}
		
		def gud=new GUtilDomainClass(Preinscripcion,params,grailsApplication)
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.alumno.apellido==null?"":it.alumno.apellido)+'","'+(it.alumno.nombre==null?"":it.alumno.nombre)+'","'+(it.carrera.denominacion==null?"":it.carrera.denominacion)+'","'+g.formatDate(date:it.fechaAlta,format:"dd/MM/yyyy")+'","'+(it.anioLectivo.anioLectivo==null?"":it.anioLectivo.anioLectivo)+'","'+it.estado?.name+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def list = Preinscripcion.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					preinscripcion id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Preinscripcion,params,grailsApplication)
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

	
	def carrerasdisponibles = {
		log.info "INGRESANDO AL CLOSURE carrerasdisponibles"
		log.info "PARAMETROS: $params"
		
	}


	
	def inscribir = {
		log.info "INGRESANDO AL CLOSURE inscribir"
		log.info "PARAMETROS $params"
		def preinscripcionInstance = Preinscripcion.get(params.id)

        def materiasCursar = AcademicoUtil.getMateriasCursarDisponibles(preinscripcionInstance?.carrera?.id,preinscripcionInstance?.alumno?.id)

        def flagcomilla = false
        def flagseleccionado
        def idinscmatdetalle
        def materiasSerialized = "["


        materiasCursar.each{ matcursar->
            if(flagcomilla)
                materiasSerialized = materiasSerialized + ","
            flagseleccionado="No"
            idinscmatdetalle = 0
            preinscripcionInstance.inscripcionMatricula.inscripcionesmaterias.each{inscmateria ->
                if (inscmateria.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA){
                    inscmateria.detalleMateria.each{detinsc->
                        if(detinsc.materia.id==matcursar.id){
                            flagseleccionado="Yes"
                            idinscmatdetalle = detinsc.id
                            return
                        }
                    }
                    return
                }
            }
            materiasSerialized = materiasSerialized + '{"id":'+idinscmatdetalle+',"idid":'+idinscmatdetalle+',"idmateria":'+matcursar.id+',"denominacion":"'+matcursar.denominacion+'","seleccion":"'+flagseleccionado+'"}'
            flagcomilla = true
        }
        materiasSerialized += "]"
		if(preinscripcionInstance){
			if(preinscripcionInstance.estado.equals(EstadoPreinscripcion.ESTADO_INSCRIPTO)
				||
				preinscripcionInstance.estado.equals(EstadoPreinscripcion.ESTADO_PREINSCIRPTOANULADO)){
				if(preinscripcionInstance.estado.equals(EstadoPreinscripcion.ESTADO_INSCRIPTO))
					flash.message = g.message(code:"com.educacion.academico.Preinscripcion.estado.inscripto",args:[preinscripcionInstance?.alumno?.apellido+"-"+preinscripcionInstance?.alumno?.nombre,preinscripcionInstance?.alumno?.numeroDocumento])
				else
					flash.message = g.message(code:"com.educacion.academico.Preinscripcion.estado.anulado",args:[preinscripcionInstance?.alumno?.apellidoNombre,preinscripcionInstance?.alumno?.numeroDocumento])
				redirect(action:"list")	
			}else
				return [preinscripcionInstance:preinscripcionInstance,materiasSerialized:materiasSerialized]	
				
		}else{
			flash.message = g.message(code:"default.not.found.message",args:[g.message(code:"preinscripcion.label"),params.id])
			redirect(action:'list')
		}
	}

	
	
	def materiasmatriculacion = {
		log.info "INGRESANDO AL CLOSURE materiasmatriculacion"
		log.info "PARAMETROS $params"
		def preinscripcionInstance = Preinscripcion.get(params.id)
		
		def listmaterias = Materia.createCriteria().list(){
			and{
				nivel{
					carrera{
						eq("id",preinscripcionInstance?.carrera?.id)
					}
					//matregcursar:Materia,mataprobcursar:Materia,matregrendir:Materia,mataprobrendir:Materia
				}
				isEmpty("matregcursar")
				isEmpty("mataprobcursar")
				sizeEq("matregrendir",1)
				isEmpty("mataprobrendir")
			}
		}

		def totalregistros=listmaterias.size()
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		
		 
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
		listmaterias.each{
			
			if (flagaddcomilla)
				result=result+','
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+it.denominacion+'","'+it.nivel.descripcion+'","Yes"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

		
	}
	
	def confirminscripcion = {
		log.info "INGRESANDO AL CLOSURE confirminscripcion"
		log.info "PARAMETROS: $params"
		def preinscripcionInstance = Preinscripcion.get(params.insid)
		def inscripcionMatriculaInstance
		def materiasSerializedJson
		
		if(params.materiasSerialized)
            materiasSerializedJson = grails.converters.JSON.parse(params.materiasSerialized)
			

		
		if (preinscripcionInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (preinscripcionInstance.version > version) {
					
					preinscripcionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'preinscripcion.label', default: 'Preinscripcion')] as Object[], "Another user has updated this Preinscripcion while you were editing")
					render(view: "inscribir", model: [preinscripcionInstance: preinscripcionInstance])
					return
				}
			}


			Preinscripcion.withTransaction{TransactionStatus status->
                inscripcionMatriculaInstance = preinscripcionInstance.inscripcionMatricula
                inscripcionMatriculaInstance.estado = EstadoInscripcionMatriculaEnum.ESTADOINSMAT_CONFIRMADA
				preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_INSCRIPTO

                def inscripcionMateriaDetalleInstance
                def inscripcionMateriaInstance
                def materiaInstance
                inscripcionMatriculaInstance.inscripcionesmaterias.each{inscmat->
                    if(inscmat.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA)
                        inscripcionMateriaInstance = inscmat
                }
                materiasSerializedJson?.each {
                    if(it.seleccion.toUpperCase().equals("YES")){
                        materiaInstance = Materia.load(it.idmateria.toLong())
                        if(AcademicoUtil.validarCorrelatividades(it.idmateria.toLong(),TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR,inscripcionMateriaInstance.alumno.id)){

                                if(it.idid.toInteger()==0){
                                    inscripcionMateriaDetalleInstance = new InscripcionMateriaDetalle(materia:materiaInstance
                                            ,estado:EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_INSCRIPTO
                                            ,tipo:TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR
                                    )
                                    inscripcionMateriaInstance.addToDetalleMateria(inscripcionMateriaDetalleInstance)
                                }
                        }else{
                            inscripcionMateriaInstance.errors.rejectValue("detalleMateria","Error de correlatividad en la materia "+materiaInstance.denominacion)
                        }
                    }else{
                        if(it.idid.toInteger()>0){
                            inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.get(it.idid);
                            inscripcionMateriaInstance.removeFromDetalleMateria(inscripcionMateriaDetalleInstance)
                            inscripcionMateriaDetalleInstance.delete()
                        }

                    }

                }





				if (!preinscripcionInstance.hasErrors() && preinscripcionInstance.save() &&
                        !inscripcionMatriculaInstance.hasErrors() && inscripcionMatriculaInstance.save()) {
					flash.message = "${message(code: 'default.updated.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), preinscripcionInstance.id])}"
					redirect(action: "show", id: preinscripcionInstance.id)
				}
				else {
					status.setRollbackOnly()
					render(view: "inscribir", model: [preinscripcionInstance: preinscripcionInstance,materiasSerialized:params.materiasSerialized,inscripcionMatriculaInstance:inscripcionMatriculaInstance])
				}
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
			redirect(action: "list")
		}
	}
	

	
	def inscmateriasjson = {
		log.info "INGRESANDO AL CLOSURE insmateriasjson"
		log.info "PARAMETROS $params"
		
		def preinscripcionInstance = Preinscripcion.get(params.id)


		
		def listinscmaterias = preinscripcionInstance.inscripcionMatricula.inscripcionesmaterias
		def listinscdetallematerias
		listinscmaterias.each{
			if(it.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA){
				listinscdetallematerias = it.detalleMateria
				return 
			}
		}
		
		def totalregistros=listinscdetallematerias?.size()
		totalregistros = (totalregistros==null?0:totalregistros)
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		
		 
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
		listinscdetallematerias.each{
			
			if (flagaddcomilla)
				result=result+','
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.materia.denominacion+'","'+it.materia.nivel.descripcion+'","Yes"]}'
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}

	
	def reportepreinscripcion = {
		log.info "INGRESANDO AL CLOSURE reportepreinscripcion"
		log.info "PARAMETROS $params"
		
		def preinscripcionInstance = Preinscripcion.get(params.id)
		def list = new ArrayList()
		
		if (preinscripcionInstance) { 
			def materias = AcademicoUtil.getMateriasCursarDisponibles(
				preinscripcionInstance.carrera.id, preinscripcionInstance.alumno.id)
	
			list.add([preinscripcionInstance, materias])
			
			params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/preinscripcion/"))
			params.put("_format","PDF")
			
			params.put("_name","reportepreinscripcion")
			params.put("_file","preinscripcion/reportepreinscripcion")
			chain(controller:'jasper', action:'index', model:[data:list], params:params)
	
			
		} else {
			redirect(action: "list")
		}
		
    }
	
}
