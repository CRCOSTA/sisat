package model

class SeguradoraController extends BaseController{

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [seguradoraInstanceList: Seguradora.list(params), seguradoraInstanceTotal: Seguradora.count()]
    }

    def create = {
        def seguradoraInstance = new Seguradora()
        seguradoraInstance.properties = params
        return [seguradoraInstance: seguradoraInstance]
    }

    def save = {
        def seguradoraInstance = new Seguradora(params)
        if (!seguradoraInstance.hasErrors() && seguradoraInstance.save()) {
            flash.message = "seguradora.created"
            flash.args = [seguradoraInstance.id]
            flash.defaultMessage = "Seguradora ${seguradoraInstance.id} created"
            redirect(action: "show", id: seguradoraInstance.id)
        }
        else {
            render(view: "create", model: [seguradoraInstance: seguradoraInstance])
        }
    }

    def show = {
        def seguradoraInstance = Seguradora.get(params.id)
        if (!seguradoraInstance) {
            flash.message = "seguradora.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Seguradora not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [seguradoraInstance: seguradoraInstance]
        }
    }

    def edit = {
        def seguradoraInstance = Seguradora.get(params.id)
        if (!seguradoraInstance) {
            flash.message = "seguradora.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Seguradora not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [seguradoraInstance: seguradoraInstance]
        }
    }

    def update = {
        def seguradoraInstance = Seguradora.get(params.id)
        if (seguradoraInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (seguradoraInstance.version > version) {
                    
                    seguradoraInstance.errors.rejectValue("version", "seguradora.optimistic.locking.failure", "Another user has updated this Seguradora while you were editing")
                    render(view: "edit", model: [seguradoraInstance: seguradoraInstance])
                    return
                }
            }
            seguradoraInstance.properties = params
            if (!seguradoraInstance.hasErrors() && seguradoraInstance.save()) {
                flash.message = "seguradora.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Seguradora ${params.id} updated"
                redirect(action: "show", id: seguradoraInstance.id)
            }
            else {
                render(view: "edit", model: [seguradoraInstance: seguradoraInstance])
            }
        }
        else {
            flash.message = "seguradora.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Seguradora not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def seguradoraInstance = Seguradora.get(params.id)
        if (seguradoraInstance) {
            try {
                seguradoraInstance.delete()
                flash.message = "seguradora.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Seguradora ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "seguradora.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Seguradora ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "seguradora.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Seguradora not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
