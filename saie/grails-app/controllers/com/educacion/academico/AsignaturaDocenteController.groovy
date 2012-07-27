package com.educacion.academico


import com.educacion.util.GUtilDomainClass
import com.educacion.academico.util.AcademicoUtil
import grails.converters.JSON



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
        asignaturaDocenteInstance.properties = params
        return [asignaturaDocenteInstance: asignaturaDocenteInstance]
    }

    def save = {
        log.info "INGRESANDO AL CLOSURE save"
        log.info "PARAMETROS: $params"
        def materiasSerializedJson
        if (params.materiasSerialized)
            materiasSerializedJson = JSON.parse(params.materiasSerialized)
        
        

        def asignaturaDocenteInstance = new AsignaturaDocente(params)
        AsignaturaDocente.withTransaction {Tra

        }
        if (asignaturaDocenteInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), asignaturaDocenteInstance.id])}"
            redirect(action: "show", id: asignaturaDocenteInstance.id)
        }
        else {
            render(view: "create", model: [asignaturaDocenteInstance: asignaturaDocenteInstance])
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
            return [asignaturaDocenteInstance: asignaturaDocenteInstance]
        }
    }

    def update = {
        log.info "INGRESANDO AL CLOSURE update"
        log.info "PARAMETROS: $params"

        def asignaturaDocenteInstance = AsignaturaDocente.get(params.id)
        if (asignaturaDocenteInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (asignaturaDocenteInstance.version > version) {

                    asignaturaDocenteInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente')] as Object[], "Another user has updated this AsignaturaDocente while you were editing")
                    render(view: "edit", model: [asignaturaDocenteInstance: asignaturaDocenteInstance])
                    return
                }
            }
            asignaturaDocenteInstance.properties = params
            if (!asignaturaDocenteInstance.hasErrors() && asignaturaDocenteInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), asignaturaDocenteInstance.id])}"
                redirect(action: "show", id: asignaturaDocenteInstance.id)
            }
            else {
                render(view: "edit", model: [asignaturaDocenteInstance: asignaturaDocenteInstance])
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


        def asignaturaDocenteInstance = AsignaturaDocente.get(params.id)
        if (asignaturaDocenteInstance) {
            try {
                asignaturaDocenteInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente'), params.id])}"
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


            result = result + '{"id":"' + it.id + '","cell":["' + it.id + '","' + (it.nombre == null ? "" : it.nombre) + '"]}'

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



}
