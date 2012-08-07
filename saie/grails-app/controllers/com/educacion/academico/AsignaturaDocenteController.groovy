package com.educacion.academico


import com.educacion.util.GUtilDomainClass
import com.educacion.academico.util.AcademicoUtil
import grails.converters.JSON
import org.springframework.transaction.TransactionStatus



class AsignaturaDocenteController {


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
        def asignaturaDocenteInstance = new AsignaturaDocente()
        return[asignaturaDocenteInstance:asignaturaDocenteInstance]
    }

    def save = {
        log.info "INGRESANDO AL CLOSURE save"
        log.info "PARAMETROS: $params"
        def materiasSerializedJson
        def materiaInstance


        
        def asignaturaDocenteInstance = new AsignaturaDocente(params)

        if (params.materiasSerialized)
            materiasSerializedJson = JSON.parse(params.materiasSerialized)

        materiasSerializedJson.each{
            materiaInstance = Materia.get(it.idid)
            if (materiaInstance)
                asignaturaDocenteInstance.addToMaterias(materiaInstance)

        }
        AsignaturaDocente.withTransaction {TransactionStatus status->
            if (asignaturaDocenteInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), asignaturaDocenteInstance.id])}"
                redirect(action: "show", id: asignaturaDocenteInstance.id)
            }
            else {
                render(view: "create", model: [asignaturaDocenteInstance: asignaturaDocenteInstance,materiasSerialized:params.materiasSerialized])
            }
        }
    }

    def show = {
        log.info "INGRESANDO AL CLOSURE show"
        log.info "PARAMETROS: $params"


        def asignaturaDocenteInstance = AsignaturaDocente.get(params.id)
        if (!asignaturaDocenteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), params.id])}"
            redirect(action: "list")
        }
        else {
            [asignaturaDocenteInstance: asignaturaDocenteInstance]
        }
    }

    def edit = {
        log.info "INGRESANDO AL CLOSURE edit"
        log.info "PARAMETROS: $params"


        def asignaturaDocenteInstance = AsignaturaDocente.get(params.id)
        if (!asignaturaDocenteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), params.id])}"
            redirect(action: "list")
        }
        else {
            def materiasSerialized = "["
            def flagcomilla = false
            asignaturaDocenteInstance.materias.each {
                if(flagcomilla)
                    materiasSerialized+=","
                materiasSerialized += '{"id":'+it.id+',"idid":'+it.id+',"codigo":"'+it.codigo+'","denominacion":"'+it.denominacion+'","nivel":"'+it.nivel.descripcion+'","carrera":"'+it.nivel.carrera.denominacion+'"}'
                flagcomilla=true
            }
            materiasSerialized += "]"


            return [asignaturaDocenteInstance:asignaturaDocenteInstance,materiasSerialized: materiasSerialized]
        }
    }

    def update = {
        log.info "INGRESANDO AL CLOSURE update"
        log.info "PARAMETROS: $params"

        def asignaturaDocenteInstance = AsignaturaDocente.get(params.asigid)
        def materiasSerializedJson

        if (asignaturaDocenteInstance) {

            if (asignaturaDocenteInstance.version) {
                def version = asignaturaDocenteInstance.version.toLong()
                if (asignaturaDocenteInstance.version > version) {

                    asignaturaDocenteInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente')] as Object[], "Another user has updated this AsignaturaDocente while you were editing")
                    render(view: "edit", model: [asignaturaDocenteInstance: asignaturaDocenteInstance])
                    return
                }
            }
            //asignaturaDocenteInstance.properties = params
            asignaturaDocenteInstance.carrera = Carrera.get(params.carrera.id)
            asignaturaDocenteInstance.anioLectivo = AnioLectivo.get(params.anioLectivo.id)
            asignaturaDocenteInstance.docente = Docente.get(params.docente.id)
            if (params.materiasSerialized)
                materiasSerializedJson = JSON.parse(params.materiasSerialized)
            def materiaInstance

            asignaturaDocenteInstance.materias.clear()

            materiasSerializedJson.each{
                materiaInstance = Materia.get(it.idid)
                if (materiaInstance){
                    asignaturaDocenteInstance.addToMaterias(materiaInstance)
                    log.debug "SE AGREGO MATERIA "
                }
            }

            if (!asignaturaDocenteInstance.hasErrors() && asignaturaDocenteInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), asignaturaDocenteInstance.id])}"
                redirect(action: "show", id: asignaturaDocenteInstance.id)
            }
            else {
                render(view: "edit", model: [asignaturaDocenteInstance: asignaturaDocenteInstance,materiasSerialized: params.materiasSerialized])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        log.info "INGRESANDO AL CLOSURE delete"
        log.info "PARAMETROS: $params"
        def deletedId

        deletedId = params.asigid
        def asignaturaDocenteInstance = AsignaturaDocente.get(params.asigid)
        
        if(!asignaturaDocenteInstance){
            asignaturaDocenteInstance = AsignaturaDocente.get(params.id)
            deletedId = params.id
        }
        
        if (asignaturaDocenteInstance) {
            try {
                asignaturaDocenteInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), deletedId])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), deletedId])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), deletedId])}"
            redirect(action: "list")
        }
    }

    def listjson = {
        log.info "INGRESANDO AL CLOSURE listjson"
        log.info "PARAMETROS: ${params}"
        def gud = new GUtilDomainClass(AsignaturaDocente, params, grailsApplication)
        def list = gud.listrefactor(false)
        def totalregistros = gud.listrefactor(true)

        def totalpaginas = new Float(totalregistros / Integer.parseInt(params.rows))
        if (totalpaginas > 0 && totalpaginas < 1)
            totalpaginas = 1;
        totalpaginas = totalpaginas.intValue()



        def result = '{"page":' + params.page + ',"total":"' + totalpaginas + '","records":"' + totalregistros + '","rows":['
        def flagaddcomilla = false
        list.each {

            if (flagaddcomilla)
                result = result + ','


            result = result + '{"id":"' + it.id + '","cell":["' + it.id +'","'+g.formatDate(date: it.fechaAlta,format: "dd/MM/yyyy")+ '","' +it.carrera.denominacion+'","'+it.anioLectivo.anioLectivo+'","'+it.docente.apellido+'","'+it.docente.nombre+'","'+ '"]}'

            flagaddcomilla = true
        }
        result = result + ']}'
        render result

    }

    def listjsonautocomplete = {
        log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
        log.info "PARAMETROS: ${params}"
        def list = AsignaturaDocente.createCriteria().list() {
            like('nombre', '%' + params.term + '%')
        }
        render(contentType: "text/json") {
            array {
                for (obj in list) {
                    asignaturadocente id: obj.id, label: obj.nombre, value: obj.nombre
                }
            }

        }
    }

    def listsearchjson = {
        log.info "INGRESANDO AL METODO listsearchjson"
        log.info "PARAMETROS: ${params}"
        def gud = new GUtilDomainClass(AsignaturaDocente, params, grailsApplication)
        list = gud.listrefactor(false)
        def totalregistros = gud.listrefactor(true)

        def totalpaginas = new Float(totalregistros / Integer.parseInt(params.rows))
        if (totalpaginas > 0 && totalpaginas < 1)
            totalpaginas = 1;
        totalpaginas = totalpaginas.intValue()



        def result = '{"page":' + params.page + ',"total":"' + totalpaginas + '","records":"' + totalregistros + '","rows":['
        def flagaddcomilla = false
        list.each {

            if (flagaddcomilla)
                result = result + ','

            result = result + '{"id":"' + it.id + '","cell":["' + it.id + '","' + it.nombre + '"]}'

            flagaddcomilla = true
        }
        result = result + ']}'
        render result

    }

    def editmaterias = {
        render ""
    }


    def createasignatura = {AsignaturaDocenteCommand cmd ->
        log.debug "INGRESANDO AL CLOSURE createasignatura"
        log.debug "PARAMETROS: $params"

    }

    /*def listsearchjsondocentes = {

        def gud = new GUtilDomainClass(AsignaturaDocente, params, grailsApplication)
        list = gud.listrefactor(false)
        def totalregistros = gud.listrefactor(true)

        def totalpaginas = new Float(totalregistros / Integer.parseInt(params.rows))
        if (totalpaginas > 0 && totalpaginas < 1)
            totalpaginas = 1;
        totalpaginas = totalpaginas.intValue()



        def result = '{"page":' + params.page + ',"total":"' + totalpaginas + '","records":"' + totalregistros + '","rows":['
        def flagaddcomilla = false
        list.each {

            if (flagaddcomilla)
                result = result + ','

            result = result + '{"id":"' + it.id + '","cell":["' + it.id + '","' + it.docente.apellido +'","'+it.docente.nombre+'"]}'

            flagaddcomilla = true
        }
        result = result + ']}'
        render result

    } */

    def editurl = {
        render ""
    }
    
    def materiasjson = {
        def asignaturaDocenteInstance = AsignaturaDocente.get(params.id)
        def totalregistros = asignaturaDocenteInstance.materias.size()

        def totalpaginas = new Float(totalregistros / Integer.parseInt(params.rows))
        if (totalpaginas > 0 && totalpaginas < 1)
            totalpaginas = 1;
        totalpaginas = totalpaginas.intValue()



        def result = '{"page":' + params.page + ',"total":"' + totalpaginas + '","records":"' + totalregistros + '","rows":['
        def flagaddcomilla=false
        asignaturaDocenteInstance.materias.each{

            if (flagaddcomilla)
                result=result+','


            result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.codigo+'","'+(it.denominacion==null?"":it.denominacion)+'","'+(it.nivel?.descripcion==null?"":it.nivel?.descripcion)+'","'+(it.nivel?.carrera?.denominacion==null?"":it.nivel?.carrera?.denominacion)+'"]}'

            flagaddcomilla=true
        }
        result=result+']}'
        render result
        
    }


}

class AsignaturaDocenteCommand{
    String carreraId
    String carreraDesc
    String anioLectivoId
    String anioLectivo
    String docenteId
    String docenteDesc
    String materiasSerialized
    Long id
    Long version
    
    static constraints = {
        carreraId(nullable: false,blank: false)
        anioLectivoId(nullable: false,blank: false)
        //anioLectivo(nullable: false,blank: false)
        docenteId(nullable: false,blank: false)
        //docenteDesc(nullable: false,blank: false)
    }
}
