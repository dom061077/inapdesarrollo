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
		def carreraInstance = Carrera.get(params.id)
		def anioLectivoInstance = AcademicoUtil.getAnioLectivoCarrera(carreraInstance.id)

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
        def list =  Carrera.executeQuery(hqlstr,["carrera":preinscripcionInstance.carrera?.id,"estado":EstadoPreinscripcion.ESTADO_PREINSCRIPTOANULADO])
        def datosCarrera = list?.get(0)
        def cupodisponible=0
        def cupo = 0
        def cuposuplentes = 0
        def inscriptos = 0

        //el indice 6 es el cupo, el 7 cupo suplente, el 8 la cantidad de preinscripciones
        if((!datosCarrera[6]) || (datosCarrera[6]==0)){
            flash.message = "No hay un cupo cargado para el año lectivo ${preinscripcionInstance.anioLectivo.anioLectivo}"
            redirect(action:"carrerasdisponibles")
            return
        }
        cupo = anioLectivoInstance.cupo
        if(datosCarrera[7])
            cuposuplentes = datosCarrera[7]
        if(datosCarrera[8])
            inscriptos = datosCarrera[8]

        if((cupo+cuposuplentes)<(inscriptos+1)){
            flash.message="No hay un cupo para esta inscripción"
            redirect(action:"carrerasdisponibles")
            return
        }





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
            materiasSerialized = materiasSerialized + '{"id":'+it.id+',"nivel":"'+it.nivel.descripcion+'","codigomateria":"'+it.codigo+'","idid":'+it.id+',"estado":"'+TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR.name+'","denominacion":"'+it.denominacion+'","seleccion":"Yes"}'
            flagcomilla = true
        }
        materiasSerialized += "]"

        def requisitosSerialized = "["
        flagcomilla = false
        carreraInstance.requisitos.each {
            if (flagcomilla)
                requisitosSerialized = requisitosSerialized + ","
            requisitosSerialized = requisitosSerialized + '{"id":'+it.id+',"idid":'+it.id+',"descripcion":"'+it.descripcion+'","seleccion":"No"}'
            flagcomilla = true
        }
        requisitosSerialized += "]"
        return [preinscripcionInstance: preinscripcionInstance,materiasSerialized: materiasSerialized,requisitosSerialized:requisitosSerialized]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
        def inscripcionMatriculaInstance
        def materiasJson
        def requisitosJson

        if(params.materiasSerialized)
            materiasJson = grails.converters.JSON.parse(params.materiasSerialized)
        
        if (params.requisitosSerialized)
            requisitosJson = grails.converters.JSON.parse(params.requisitosSerialized)

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
		def list =  Carrera.executeQuery(hqlstr,["carrera":preinscripcionInstance.carrera?.id,"estado":EstadoPreinscripcion.ESTADO_PREINSCRIPTOANULADO])
		def datosCarrera = list?.get(0)
		def cupodisponible=0
		def cupo = 0
		def cuposuplentes = 0
		def inscriptos = 0
		
		//el indice 6 es el cupo, el 7 cupo suplente, el 8 la cantidad de preinscripciones
		if((!datosCarrera[6]) || (datosCarrera[6]==0)){
			flash.message = "No hay un cupo cargado para el año lectivo ${preinscripcionInstance.anioLectivo.anioLectivo}"
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
			    preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_PREINSCRIPTO
        }
																 

		Preinscripcion.withTransaction{TransactionStatus status ->
			def inscripcionDetalleInstance = new InscripcionDetalleRequisito()
			
			/*preinscripcionInstance.carrera?.requisitos?.each{
				inscripcionDetalleInstance = new InscripcionDetalleRequisito()
				inscripcionDetalleInstance.requisito = it
				inscripcionDetalleInstance.estado = EstadoDetalleInscripcionRequisito.ESTADOINSREQ_INSATISFECHO
				preinscripcionInstance.addToDetalle(inscripcionDetalleInstance)
			}*/

            if (requisitosJson){
                def requisitoInstance
                requisitosJson.each{
                    requisitoInstance = Requisito.get(it.idid)
                    inscripcionDetalleInstance = new InscripcionDetalleRequisito(requisito: requisitoInstance)
                    if (it.seleccion.toUpperCase().equals("YES"))
                        inscripcionDetalleInstance.estado = EstadoDetalleInscripcionRequisito.ESTADOINSREQ_SATISFECHO
                    else
                        inscripcionDetalleInstance.estado = EstadoDetalleInscripcionRequisito.ESTADOINSREQ_INSATISFECHO
                    preinscripcionInstance.addToDetalle(inscripcionDetalleInstance)
                }
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
                        if(it.seleccion.toUpperCase().equals("YES")){
                            materiaInstance = Materia.load(it.idid)
                            inscripcionMateriaInstance.addToDetalleMateria(new InscripcionMateriaDetalle(materia:materiaInstance
                                    ,tipo:it.estado))
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
                        render(view: "create", model: [preinscripcionInstance: preinscripcionInstance,alumnoInstance:alumnoInstance,materiasSerialized:params.materiasSerialized,requisitosSerialized:params.requisitosSerialized])
                    }
                }else{
                    status.setRollbackOnly()
                    render(view: "create", model: [inscripcionMatriculaInstance:inscripcionMatriculaInstance,preinscripcionInstance: preinscripcionInstance,alumnoInstance:alumnoInstance,materiasSerialized:params.materiasSerialized,requisitosSerialized:params.requisitosSerialized])

                }
            }else {
				status.setRollbackOnly()
				render(view: "create", model: [preinscripcionInstance: preinscripcionInstance,alumnoInstance:alumnoInstance,materiasSerialized:params.materiasSerialized,requisitosSerialized:params.requisitosSerialized])
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
            if (preinscripcionInstance.estado!=EstadoPreinscripcion.ESTADO_ASPIRANTE
                && preinscripcionInstance.estado!=EstadoPreinscripcion.ESTADO_ASPIRANTESUPLENTE
                && preinscripcionInstance.estado!=EstadoPreinscripcion.ESTADO_PREINSCRIPTO
                && preinscripcionInstance.estado!=EstadoPreinscripcion.ESTADO_PREINSCRIPTOSUPLENTE){
                flash.message="${message(code: 'preinscripcion.update.estado.error',args: [preinscripcionInstance.estado.name])}"
                redirect(action: "show",id: preinscripcionInstance.id)
                return
            }

            def flagcomilla = false
            def flagseleccionado
            def idinscmatdetalle
            def tipo
            def materiasSerialized = "["
            def requisitosSerialized = "["

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
                                tipo = detinsc.tipo.name
                                return
                            }
                        }
                        return
                    }
                }
                materiasSerialized = materiasSerialized + '{"id":'+matcursar.id+',"idid":'+idinscmatdetalle+',"nivel":"'+matcursar.nivel.descripcion+'","codigomateria":"'+matcursar.codigo+'","idmateria":'+matcursar.id+',"denominacion":"'+matcursar.denominacion+'","tipo":"'+(tipo!=null?tipo:TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR.name)+'","seleccion":"'+flagseleccionado+'"}'
                flagcomilla = true
            }

            flagcomilla = false
            def checked
            preinscripcionInstance.detalle.each {
                if(flagcomilla)
                    requisitosSerialized +=  ","
                log.debug "ESTADO REQUISITO: "+it.estado
                if(it.estado==EstadoDetalleInscripcionRequisito.ESTADOINSREQ_SATISFECHO)
                    checked = "Yes"
                else
                    checked = "No"
                requisitosSerialized = requisitosSerialized + '{"id":'+it.id+',"idid":'+it.id+',"descripcion":"'+it.requisito.descripcion+'","seleccion":"'+checked+'"}'
                flagcomilla=true
            }

            materiasSerialized += "]"
            requisitosSerialized += "]"

            return [preinscripcionInstance: preinscripcionInstance, materiasSerialized: materiasSerialized, requisitosSerialized: requisitosSerialized]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
        def materiasSerializedJson
        def requisitosSerializedJson

        if(params.materiasSerialized)
            materiasSerializedJson = grails.converters.JSON.parse(params.materiasSerialized)
        if(params.requisitosSerialized)
            requisitosSerializedJson = grails.converters.JSON.parse(params.requisitosSerialized)

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
            Preinscripcion.withTransaction {TransactionStatus status->
                def oldEstado = preinscripcionInstance.estado
                preinscripcionInstance.properties = params
                def materiaInstance
                def inscripcionMateriaDetalleInstance
                def inscripcionMateriaInstance
                preinscripcionInstance.inscripcionMatricula.inscripcionesmaterias.each{
                    if(it.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA){
                        inscripcionMateriaInstance = it
                        return
                    }
                }
                def inscDetalleRequisitoInstance
                requisitosSerializedJson.each{req->
                    inscDetalleRequisitoInstance = InscripcionDetalleRequisito.get(req.idid)
                    if(req.seleccion.toUpperCase().equals("YES")){
                        log.debug "REQUISITO CHECKED"
                        preinscripcionInstance.detalle.getElement(inscDetalleRequisitoInstance).estado=EstadoDetalleInscripcionRequisito.ESTADOINSREQ_SATISFECHO
                    }else
                        preinscripcionInstance.detalle.getElement(inscDetalleRequisitoInstance).estado=EstadoDetalleInscripcionRequisito.ESTADOINSREQ_INSATISFECHO
                }

                materiasSerializedJson.each{mat ->
                    if(mat.seleccion.toUpperCase().equals("YES")){
                        materiaInstance = Materia.load(mat.idmateria.toLong())
                        if (materiaInstance){
                            if(mat.idid.toInteger()==0){
                                inscripcionMateriaDetalleInstance = new InscripcionMateriaDetalle(materia:materiaInstance
                                        ,estado:EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_INSCRIPTO
                                        ,tipo:TipoInscripcionMateriaEnum."${mat.tipovalue}")
                                preinscripcionInstance.inscripcionMatricula.inscripcionesmaterias.getElement(inscripcionMateriaInstance).addToDetalleMateria(inscripcionMateriaDetalleInstance)
                            }else{
                                log.debug "TIPO VALUE: "+mat.tipovalue+" tipo: "+mat.tipo
                                inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.get(mat.idid)
                                inscripcionMateriaDetalleInstance.tipo = TipoInscripcionMateriaEnum."${mat.tipovalue}"
                            }
                        }
                    }else{
                        if(mat.idid.toInteger()>0){
                            inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.get(mat.idid);
                            preinscripcionInstance.inscripcionMatricula.inscripcionesmaterias.getElement(inscripcionMateriaInstance).removeFromDetalleMateria(inscripcionMateriaDetalleInstance)
                            inscripcionMateriaDetalleInstance.delete()
                        }

                    }

                }


                //------------si la preinscripcion es modificada para ser anulada es necesario reorganizar el estado
                //------------ de acuerdo a si era suplente o no------
                if(preinscripcionInstance.estado == EstadoPreinscripcion.ESTADO_PREINSCRIPTOANULADO &&
                    (oldEstado == EstadoPreinscripcion.ESTADO_ASPIRANTE || oldEstado == EstadoPreinscripcion.ESTADO_PREINSCRIPTO)){
                    def preinscripcionInstanceparaCupo = Preinscripcion.createCriteria().get {
                        and{
                            carrera{
                                eq("id",preinscripcionInstance.carrera.id)
                            }
                            anioLectivo{
                                eq("id",preinscripcionInstance.anioLectivo.id)
                            }
                            or{
                                eq("estado",EstadoPreinscripcion.ESTADO_ASPIRANTESUPLENTE)
                                eq("estado",EstadoPreinscripcion.ESTADO_PREINSCRIPTOSUPLENTE)
                            }
                        }
                        maxResults(1)
                        order("fechaAlta","asc")
                    }
                    if (preinscripcionInstanceparaCupo){
                        if (preinscripcionInstanceparaCupo.estado == EstadoPreinscripcion.ESTADO_ASPIRANTESUPLENTE)
                            preinscripcionInstanceparaCupo.estado = EstadoPreinscripcion.ESTADO_ASPIRANTE
                        if (preinscripcionInstanceparaCupo.estado == EstadoPreinscripcion.ESTADO_PREINSCRIPTOSUPLENTE)
                            preinscripcionInstanceparaCupo.estado = EstadoPreinscripcion.ESTADO_PREINSCRIPTO
                        preinscripcionInstanceparaCupo.save()
                    }
                }
                //-------------------------------------------------------

                if (!preinscripcionInstance.hasErrors() && preinscripcionInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), preinscripcionInstance.id])}"
                    redirect(action: "show", id: preinscripcionInstance.id)
                }
                else {
                    render(view: "edit", model: [preinscripcionInstance: preinscripcionInstance,materiasSerialized: params.materiasSerialized,requisitosSerialized:params.requisitosSerialized ])
                }
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

        //def materiasCursar = AcademicoUtil.getMateriasCursarDisponibles(preinscripcionInstance?.carrera?.id,preinscripcionInstance?.alumno?.id)

        def flagcomilla = false
        def flagseleccionado
        def idinscmatdetalle
        def materiasSerialized = "["


        /*materiasCursar.each{ matcursar->
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
            materiasSerialized = materiasSerialized + '{"id":'+idinscmatdetalle+',"idid":'+idinscmatdetalle+',"idmateria":'+matcursar.id+',"nivel":"'+matcursar.nivel.descripcion+'","denominacion":"'+matcursar.denominacion+'","codigo":"'+matcursar.codigo+'","seleccion":"'+flagseleccionado+'"}'
            flagcomilla = true
        }*/
        preinscripcionInstance.inscripcionMatricula.inscripcionesmaterias.each{inscmateria ->
            if (inscmateria.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA){
                inscmateria.detalleMateria.each{detinsc->
                    if (flagcomilla)
                        materiasSerialized += ","
                    materiasSerialized = materiasSerialized + '{"id":'+detinsc.id+',"idid":'+detinsc.id+',"idmateria":'+detinsc.materia.id+',"nivel":"'+detinsc.materia.nivel.descripcion+'","denominacion":"'+detinsc.materia.denominacion+'","codigo":"'+detinsc.materia.codigo+'","seleccion":"Yes"}'
                    flagcomilla = true
                    
                }
                return
            }
        }
        materiasSerialized += "]"
		if(preinscripcionInstance){
			if(preinscripcionInstance.estado.equals(EstadoPreinscripcion.ESTADO_INSCRIPTO)
				||
				preinscripcionInstance.estado.equals(EstadoPreinscripcion.ESTADO_PREINSCRIPTOANULADO)){
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
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.materia.codigo+'","'+it.materia.denominacion+'","'+it.materia.nivel.descripcion+'","'+it.tipo.name+'","Yes"]}'
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
			//def materias = AcademicoUtil.getMateriasCursarDisponibles(
			//	preinscripcionInstance.carrera.id, preinscripcionInstance.alumno.id)
            def materias = new ArrayList()
            preinscripcionInstance.inscripcionMatricula.inscripcionesmaterias.each {inscmat ->
                if(inscmat.origen==OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA){
                    materias.addAll(inscmat.detalleMateria)
                    inscmat.detalleMateria.each{}
                    return
                }
            }
            def materiasIz
            def materiasDer
            if (materias?.size()>7){
            materiasIz = materias.subList(0,7)
            materiasDer = materias.subList(8,materias.size()-1)
            }else
                materiasIz = materias
            preinscripcionInstance.alumno.apellido
			list.add([preinscripcionInstance,materiasIz,materiasDer])
			
			params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/preinscripcion/"))
			params.put("_format","PDF")
			
			params.put("_name","reportepreinscripcion")
			params.put("_file","preinscripcion/reportepreinscripcion")
			chain(controller:'jasper', action:'index', model:[data:list], params:params)
	
			
		} else {
			redirect(action: "list")
		}
		
    }
    
    def listrequisitos = {
        def preinscripcionInstance = Preinscripcion.get(params.id)
        if (preinscripcionInstance){
            def requisitos = preinscripcionInstance.detalle
            def totalregistros=preinscripcionInstance.detalle.size()
            totalregistros = (totalregistros==null?0:totalregistros)

            def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
            if (totalpaginas>0 && totalpaginas<1)
                totalpaginas=1;
            totalpaginas=totalpaginas.intValue()



            def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
            def flagaddcomilla=false
            def checked
            requisitos.each{

                if (flagaddcomilla)
                    result=result+','
                if (it.estado==EstadoDetalleInscripcionRequisito.ESTADOINSREQ_SATISFECHO)
                    checked = true
                else
                    checked = false
                result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.requisito.descripcion+'","'+checked+'"]}'
                flagaddcomilla=true
            }
            result=result+']}'
            render result

        }else
            render ""
    }

    def editmateriajson = {

        render ""
    }



}
