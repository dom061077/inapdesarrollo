package com.educacion.academico


import com.educacion.util.GUtilDomainClass

import java.text.SimpleDateFormat

import java.text.DateFormat

import java.text.ParseException



class CargaExamenController {


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
        def cargaExamenInstance = new CargaExamen()
        cargaExamenInstance.properties = params
        return [cargaExamenInstance: cargaExamenInstance]
    }

    def save = {
        log.info "INGRESANDO AL CLOSURE save"
        log.info "PARAMETROS: $params"

        def cargaExamenInstance = new CargaExamen(params)
        if (cargaExamenInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'cargaExamen.label', default: 'CargaExamen'), cargaExamenInstance.id])}"
            redirect(action: "show", id: cargaExamenInstance.id)
        }
        else {
            render(view: "create", model: [cargaExamenInstance: cargaExamenInstance])
        }
    }

    def show = {
        log.info "INGRESANDO AL CLOSURE show"
        log.info "PARAMETROS: $params"


        def cargaExamenInstance = CargaExamen.get(params.id)
        if (!cargaExamenInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cargaExamen.label', default: 'CargaExamen'), params.id])}"
            redirect(action: "list")
        }
        else {
            [cargaExamenInstance: cargaExamenInstance]
        }
    }

    def edit = {
        log.info "INGRESANDO AL CLOSURE edit"
        log.info "PARAMETROS: $params"


        def cargaExamenInstance = CargaExamen.get(params.id)
        if (!cargaExamenInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cargaExamen.label', default: 'CargaExamen'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [cargaExamenInstance: cargaExamenInstance]
        }
    }

    def update = {
        log.info "INGRESANDO AL CLOSURE update"
        log.info "PARAMETROS: $params"

        def cargaExamenInstance = CargaExamen.get(params.id)
        if (cargaExamenInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (cargaExamenInstance.version > version) {

                    cargaExamenInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'cargaExamen.label', default: 'CargaExamen')] as Object[], "Another user has updated this CargaExamen while you were editing")
                    render(view: "edit", model: [cargaExamenInstance: cargaExamenInstance])
                    return
                }
            }
            cargaExamenInstance.properties = params
            if (!cargaExamenInstance.hasErrors() && cargaExamenInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'cargaExamen.label', default: 'CargaExamen'), cargaExamenInstance.id])}"
                redirect(action: "show", id: cargaExamenInstance.id)
            }
            else {
                render(view: "edit", model: [cargaExamenInstance: cargaExamenInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cargaExamen.label', default: 'CargaExamen'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        log.info "INGRESANDO AL CLOSURE delete"
        log.info "PARAMETROS: $params"


        def cargaExamenInstance = CargaExamen.get(params.id)
        if (cargaExamenInstance) {
            try {
                cargaExamenInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'cargaExamen.label', default: 'CargaExamen'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'cargaExamen.label', default: 'CargaExamen'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cargaExamen.label', default: 'CargaExamen'), params.id])}"
            redirect(action: "list")
        }
    }

    def listjson = {
        log.info "INGRESANDO AL CLOSURE listjson"
        log.info "PARAMETROS: ${params}"
        def gud = new GUtilDomainClass(CargaExamen, params, grailsApplication)
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
        def list = CargaExamen.createCriteria().list() {
            like('nombre', '%' + params.term + '%')
        }
        render(contentType: "text/json") {
            array {
                for (obj in list) {
                    cargaexamen id: obj.id, label: obj.nombre, value: obj.nombre
                }
            }

        }
    }

    def listsearchjson = {
        log.info "INGRESANDO AL METODO listsearchjson"
        log.info "PARAMETROS: ${params}"
        def gud = new GUtilDomainClass(CargaExamen, params, grailsApplication)
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
