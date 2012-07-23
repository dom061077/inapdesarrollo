package com.educacion.academico


import com.educacion.util.GUtilDomainClass
import com.educacion.enums.examen.TipoExamenEnum
import com.educacion.enums.examen.ModalidadExamenEnum




class ExamenController {


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
        def examenInstance = new Examen()
        examenInstance.properties = params
        return [examenInstance: examenInstance]
    }

    def save = {
        log.info "INGRESANDO AL CLOSURE save"
        log.info "PARAMETROS: $params"

        def examenInstance = new Examen(params)
        if (examenInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'examen.label', default: 'Examen'), examenInstance.id])}"
            redirect(action: "show", id: examenInstance.id)
        }
        else {
            render(view: "create", model: [examenInstance: examenInstance])
        }
    }

    def show = {
        log.info "INGRESANDO AL CLOSURE show"
        log.info "PARAMETROS: $params"


        def examenInstance = Examen.get(params.id)
        if (!examenInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'examen.label', default: 'Examen'), params.id])}"
            redirect(action: "list")
        }
        else {
            [examenInstance: examenInstance]
        }
    }

    def edit = {
        log.info "INGRESANDO AL CLOSURE edit"
        log.info "PARAMETROS: $params"


        def examenInstance = Examen.get(params.id)
        if (!examenInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'examen.label', default: 'Examen'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [examenInstance: examenInstance]
        }
    }

    def update = {
        log.info "INGRESANDO AL CLOSURE update"
        log.info "PARAMETROS: $params"

        def examenInstance = Examen.get(params.id)
        if (examenInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (examenInstance.version > version) {

                    examenInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'examen.label', default: 'Examen')] as Object[], "Another user has updated this Examen while you were editing")
                    render(view: "edit", model: [examenInstance: examenInstance])
                    return
                }
            }
            examenInstance.properties = params
            if (!examenInstance.hasErrors() && examenInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'examen.label', default: 'Examen'), examenInstance.id])}"
                redirect(action: "show", id: examenInstance.id)
            }
            else {
                render(view: "edit", model: [examenInstance: examenInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'examen.label', default: 'Examen'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        log.info "INGRESANDO AL CLOSURE delete"
        log.info "PARAMETROS: $params"


        def examenInstance = Examen.get(params.id)
        if (examenInstance) {
            try {
                examenInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'examen.label', default: 'Examen'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'examen.label', default: 'Examen'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'examen.label', default: 'Examen'), params.id])}"
            redirect(action: "list")
        }
    }

    def listjson = {
        log.info "INGRESANDO AL CLOSURE listjson"
        log.info "PARAMETROS: ${params}"
        def gud = new GUtilDomainClass(Examen, params, grailsApplication)
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
        def list = Examen.createCriteria().list() {
            like('nombre', '%' + params.term + '%')
        }
        render(contentType: "text/json") {
            array {
                for (obj in list) {
                    examen id: obj.id, label: obj.nombre, value: obj.nombre
                }
            }

        }
    }

    def listsearchjson = {
        log.info "INGRESANDO AL METODO listsearchjson"
        log.info "PARAMETROS: ${params}"
        def gud = new GUtilDomainClass(Examen, params, grailsApplication)
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

    def createexamen = { ExamenCommand cmd ->
        log.debug "INGRESANDO AL CLOSURE createexamen"
        log.debug "PARAMETROS: $params"

    }
    
    def saveexamen = { ExamenCommand cmd ->
        log.info "INGRESANDO AL CLOSURE saveexamen"
        log.info "PARAMETROS $params"
        if (cmd.validate()){

        }
    }

}

class ExamenCommand{
    String carreraId
    String carreraDesc
    String nivelId
    String nivelDesc
    String materiaId
    String materiaDesc
    String docenteId
    String docenteDesc
    String titulo
    TipoExamenEnum tipo
    ModalidadExamenEnum moddalidad
    static constraints = {
         carreraId(nullable: false, blank: false,validator: {v,cmd ->
                if(v){
                    def carreraInstance = Carrera.get(cmd.carreraId)
                    if(carreraInstance){
                        return true
                    }else
                        return false
                }
         })
         nivelId(nullable: false, blank: false,validator: {v,cmd ->
                if(v){
                    def nivelInstance = Nivel.get(cmd.nivelId)
                    if(nivelIInstance)
                        return true
                    else
                        return false
                }             
         })
         materiaId(nullable: false, blank: false,validator: {v,cmd ->
                if(v){
                    def materiaInstance = Materia.get(cmd.materiaId)
                    if(materiaInstance)
                        return true
                    else
                       return false
                }
             
         })
         docenteId(nullable: false, blank: false,validator: {v,cmd ->
                if(v){
                    def docenteInstance = Docente.get(cmd.docenteId)
                    if(docenteInstance)
                        return true
                    else
                        return false
                }
         })
    }
}

