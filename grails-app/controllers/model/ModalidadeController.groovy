package model

class ModalidadeController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [modalidadeInstanceList: Modalidade.list(params), modalidadeInstanceTotal: Modalidade.count()]
    }

    def create = {
        def modalidadeInstance = new Modalidade()
        modalidadeInstance.properties = params
        return [modalidadeInstance: modalidadeInstance]
    }

    def save = {
        def modalidadeInstance = new Modalidade(params)
        if (!modalidadeInstance.hasErrors() && modalidadeInstance.save()) {
            flash.message = "modalidade.created"
            flash.args = [modalidadeInstance.id]
            flash.defaultMessage = "Modalidade ${modalidadeInstance.id} created"
            redirect(action: "show", id: modalidadeInstance.id)
        }
        else {
            render(view: "create", model: [modalidadeInstance: modalidadeInstance])
        }
    }

    def show = {
        def modalidadeInstance = Modalidade.get(params.id)
        if (!modalidadeInstance) {
            flash.message = "modalidade.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Modalidade not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [modalidadeInstance: modalidadeInstance]
        }
    }

    def edit = {
        def modalidadeInstance = Modalidade.get(params.id)
        if (!modalidadeInstance) {
            flash.message = "modalidade.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Modalidade not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [modalidadeInstance: modalidadeInstance]
        }
    }

    def update = {
        def modalidadeInstance = Modalidade.get(params.id)
        if (modalidadeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (modalidadeInstance.version > version) {
                    
                    modalidadeInstance.errors.rejectValue("version", "modalidade.optimistic.locking.failure", "Another user has updated this Modalidade while you were editing")
                    render(view: "edit", model: [modalidadeInstance: modalidadeInstance])
                    return
                }
            }
            modalidadeInstance.properties = params
            if (!modalidadeInstance.hasErrors() && modalidadeInstance.save()) {
                flash.message = "modalidade.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Modalidade ${params.id} updated"
                redirect(action: "show", id: modalidadeInstance.id)
            }
            else {
                render(view: "edit", model: [modalidadeInstance: modalidadeInstance])
            }
        }
        else {
            flash.message = "modalidade.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Modalidade not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def modalidadeInstance = Modalidade.get(params.id)
        if (modalidadeInstance) {
            try {
                modalidadeInstance.delete()
                flash.message = "modalidade.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Modalidade ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "modalidade.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Modalidade ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "modalidade.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Modalidade not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
