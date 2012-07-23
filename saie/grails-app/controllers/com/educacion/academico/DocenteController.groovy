package com.educacion.academico


import com.educacion.util.GUtilDomainClass

import java.text.SimpleDateFormat

import java.text.DateFormat

import java.text.ParseException



class DocenteController {


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
        def docenteInstance = new Docente()
        docenteInstance.properties = params
        return [docenteInstance: docenteInstance]
    }

    def save = {
        log.info "INGRESANDO AL CLOSURE save"
        log.info "PARAMETROS: $params"

        def docenteInstance = new Docente(params)
        if (docenteInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'docente.label', default: 'Docente'), docenteInstance.id])}"
            redirect(action: "show", id: docenteInstance.id)
        }
        else {
            log.debug "ERRORES DE VALIDACION: "+docenteInstance.errors.allErrors
            render(view: "create", model: [docenteInstance: docenteInstance])
        }
    }

    def show = {
        log.info "INGRESANDO AL CLOSURE show"
        log.info "PARAMETROS: $params"


        def docenteInstance = Docente.get(params.id)
        if (!docenteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'docente.label', default: 'Docente'), params.id])}"
            redirect(action: "list")
        }
        else {
            [docenteInstance: docenteInstance]
        }
    }

    def edit = {
        log.info "INGRESANDO AL CLOSURE edit"
        log.info "PARAMETROS: $params"


        def docenteInstance = Docente.get(params.id)
        if (!docenteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'docente.label', default: 'Docente'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [docenteInstance: docenteInstance]
        }
    }

    def update = {
        log.info "INGRESANDO AL CLOSURE update"
        log.info "PARAMETROS: $params"

        def docenteInstance = Docente.get(params.id)
        if (docenteInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (docenteInstance.version > version) {

                    docenteInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'docente.label', default: 'Docente')] as Object[], "Another user has updated this Docente while you were editing")
                    render(view: "edit", model: [docenteInstance: docenteInstance])
                    return
                }
            }
            docenteInstance.properties = params
            if (!docenteInstance.hasErrors() && docenteInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'docente.label', default: 'Docente'), docenteInstance.id])}"
                redirect(action: "show", id: docenteInstance.id)
            }
            else {
                render(view: "edit", model: [docenteInstance: docenteInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'docente.label', default: 'Docente'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        log.info "INGRESANDO AL CLOSURE delete"
        log.info "PARAMETROS: $params"


        def docenteInstance = Docente.get(params.id)
        if (docenteInstance) {
            try {
                docenteInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'docente.label', default: 'Docente'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'docente.label', default: 'Docente'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'docente.label', default: 'Docente'), params.id])}"
            redirect(action: "list")
        }
    }

    def listjson = {
        log.info "INGRESANDO AL CLOSURE listjson"
        log.info "PARAMETROS: ${params}"
        def gud = new GUtilDomainClass(Docente, params, grailsApplication)
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


            result = result + '{"id":"' + it.id + '","cell":["' + it.id + '","' +it.numeroDocumento +'","'+it.apellido+'","'+it.nombre+ '"]}'

            flagaddcomilla = true
        }
        result = result + ']}'
        render result

    }

    def listjsonautocomplete = {
        log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
        log.info "PARAMETROS: ${params}"
        def list = Docente.createCriteria().list() {
            like('nombre', '%' + params.term + '%')
        }
        render(contentType: "text/json") {
            array {
                for (obj in list) {
                    docente id: obj.id, label: obj.nombre, value: obj.nombre
                }
            }

        }
    }

    def listsearchjson = {
        log.info "INGRESANDO AL METODO listsearchjson"
        log.info "PARAMETROS: ${params}"
        def gud = new GUtilDomainClass(Docente, params, grailsApplication)
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


}
