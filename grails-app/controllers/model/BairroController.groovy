package model

class BairroController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [bairroInstanceList: Bairro.list(params), bairroInstanceTotal: Bairro.count()]
    }

    def create = {
        def bairroInstance = new Bairro()
        bairroInstance.properties = params
        return [bairroInstance: bairroInstance]
    }

    def save = {
        def bairroInstance = new Bairro(params)
        if (!bairroInstance.hasErrors() && bairroInstance.save()) {
            flash.message = "bairro.created"
            flash.args = [bairroInstance.id]
            flash.defaultMessage = "Bairro ${bairroInstance.id} created"
            redirect(action: "show", id: bairroInstance.id)
        }
        else {
            render(view: "create", model: [bairroInstance: bairroInstance])
        }
    }

    def show = {
        def bairroInstance = Bairro.get(params.id)
        if (!bairroInstance) {
            flash.message = "bairro.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Bairro not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [bairroInstance: bairroInstance]
        }
    }

    def edit = {
        def bairroInstance = Bairro.get(params.id)
        if (!bairroInstance) {
            flash.message = "bairro.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Bairro not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [bairroInstance: bairroInstance]
        }
    }

    def update = {
        def bairroInstance = Bairro.get(params.id)
        if (bairroInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (bairroInstance.version > version) {
                    
                    bairroInstance.errors.rejectValue("version", "bairro.optimistic.locking.failure", "Another user has updated this Bairro while you were editing")
                    render(view: "edit", model: [bairroInstance: bairroInstance])
                    return
                }
            }
            bairroInstance.properties = params
            if (!bairroInstance.hasErrors() && bairroInstance.save()) {
                flash.message = "bairro.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Bairro ${params.id} updated"
                redirect(action: "show", id: bairroInstance.id)
            }
            else {
                render(view: "edit", model: [bairroInstance: bairroInstance])
            }
        }
        else {
            flash.message = "bairro.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Bairro not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def bairroInstance = Bairro.get(params.id)
        if (bairroInstance) {
            try {
                bairroInstance.delete()
                flash.message = "bairro.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Bairro ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "bairro.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Bairro ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "bairro.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Bairro not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
