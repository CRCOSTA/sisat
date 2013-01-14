package model

class EmpresaController extends BaseController{

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [empresaInstanceList: Empresa.list(params), empresaInstanceTotal: Empresa.count()]
    }

    def create = {
        def empresaInstance = new Empresa()
        empresaInstance.properties = params
        return [empresaInstance: empresaInstance]
    }

    def save = {
        def empresaInstance = new Empresa(params)
        if (!empresaInstance.hasErrors() && empresaInstance.save()) {
            flash.message = "empresa.created"
            flash.args = [empresaInstance.id]
            flash.defaultMessage = "Empresa ${empresaInstance.id} created"
            redirect(action: "show", id: empresaInstance.id)
        }
        else {
            render(view: "create", model: [empresaInstance: empresaInstance])
        }
    }

    def show = {
        def empresaInstance = Empresa.get(params.id)
        if (!empresaInstance) {
            flash.message = "empresa.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Empresa not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [empresaInstance: empresaInstance]
        }
    }

    def edit = {
        def empresaInstance = Empresa.get(params.id)
        if (!empresaInstance) {
            flash.message = "empresa.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Empresa not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [empresaInstance: empresaInstance]
        }
    }

    def update = {
        def empresaInstance = Empresa.get(params.id)
        if (empresaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (empresaInstance.version > version) {
                    
                    empresaInstance.errors.rejectValue("version", "empresa.optimistic.locking.failure", "Another user has updated this Empresa while you were editing")
                    render(view: "edit", model: [empresaInstance: empresaInstance])
                    return
                }
            }
            empresaInstance.properties = params
            if (!empresaInstance.hasErrors() && empresaInstance.save()) {
                flash.message = "empresa.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Empresa ${params.id} updated"
                redirect(action: "show", id: empresaInstance.id)
            }
            else {
                render(view: "edit", model: [empresaInstance: empresaInstance])
            }
        }
        else {
            flash.message = "empresa.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Empresa not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def empresaInstance = Empresa.get(params.id)
        if (empresaInstance) {
            try {
                empresaInstance.delete()
                flash.message = "empresa.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Empresa ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "empresa.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Empresa ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "empresa.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Empresa not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
