package com.educacion.alumno

class AlumnoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [alumnoInstanceList: Alumno.list(params), alumnoInstanceTotal: Alumno.count()]
    }

    def create = {
        def alumnoInstance = new Alumno()
        alumnoInstance.properties = params
        return [alumnoInstance: alumnoInstance]
    }

    def save = {
        def alumnoInstance = new Alumno(params)
        if (alumnoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'alumno.label', default: 'Alumno'), alumnoInstance.id])}"
            redirect(action: "show", id: alumnoInstance.id)
        }
        else {
            render(view: "create", model: [alumnoInstance: alumnoInstance])
        }
    }

    def show = {
        def alumnoInstance = Alumno.get(params.id)
        if (!alumnoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
            redirect(action: "list")
        }
        else {
            [alumnoInstance: alumnoInstance]
        }
    }

    def edit = {
        def alumnoInstance = Alumno.get(params.id)
        if (!alumnoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [alumnoInstance: alumnoInstance]
        }
    }

    def update = {
        def alumnoInstance = Alumno.get(params.id)
        if (alumnoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (alumnoInstance.version > version) {
                    
                    alumnoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'alumno.label', default: 'Alumno')] as Object[], "Another user has updated this Alumno while you were editing")
                    render(view: "edit", model: [alumnoInstance: alumnoInstance])
                    return
                }
            }
            alumnoInstance.properties = params
            if (!alumnoInstance.hasErrors() && alumnoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'alumno.label', default: 'Alumno'), alumnoInstance.id])}"
                redirect(action: "show", id: alumnoInstance.id)
            }
            else {
                render(view: "edit", model: [alumnoInstance: alumnoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def alumnoInstance = Alumno.get(params.id)
        if (alumnoInstance) {
            try {
                alumnoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
            redirect(action: "list")
        }
    }
}
