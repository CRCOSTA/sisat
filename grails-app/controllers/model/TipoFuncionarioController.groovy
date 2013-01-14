package model

class TipoFuncionarioController extends BaseController{

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [tipoFuncionarioInstanceList: TipoFuncionario.list(params), tipoFuncionarioInstanceTotal: TipoFuncionario.count()]
    }

    def create = {
        def tipoFuncionarioInstance = new TipoFuncionario()
        tipoFuncionarioInstance.properties = params
        return [tipoFuncionarioInstance: tipoFuncionarioInstance]
    }

    def save = {
        def tipoFuncionarioInstance = new TipoFuncionario(params)
        if (!tipoFuncionarioInstance.hasErrors() && tipoFuncionarioInstance.save()) {
            flash.message = "tipoFuncionario.created"
            flash.args = [tipoFuncionarioInstance.id]
            flash.defaultMessage = "TipoFuncionario ${tipoFuncionarioInstance.id} created"
            redirect(action: "show", id: tipoFuncionarioInstance.id)
        }
        else {
            render(view: "create", model: [tipoFuncionarioInstance: tipoFuncionarioInstance])
        }
    }

    def show = {
        def tipoFuncionarioInstance = TipoFuncionario.get(params.id)
        if (!tipoFuncionarioInstance) {
            flash.message = "tipoFuncionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "TipoFuncionario not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [tipoFuncionarioInstance: tipoFuncionarioInstance]
        }
    }

    def edit = {
        def tipoFuncionarioInstance = TipoFuncionario.get(params.id)
        if (!tipoFuncionarioInstance) {
            flash.message = "tipoFuncionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "TipoFuncionario not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [tipoFuncionarioInstance: tipoFuncionarioInstance]
        }
    }

    def update = {
        def tipoFuncionarioInstance = TipoFuncionario.get(params.id)
        if (tipoFuncionarioInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tipoFuncionarioInstance.version > version) {
                    
                    tipoFuncionarioInstance.errors.rejectValue("version", "tipoFuncionario.optimistic.locking.failure", "Another user has updated this TipoFuncionario while you were editing")
                    render(view: "edit", model: [tipoFuncionarioInstance: tipoFuncionarioInstance])
                    return
                }
            }
            tipoFuncionarioInstance.properties = params
            if (!tipoFuncionarioInstance.hasErrors() && tipoFuncionarioInstance.save()) {
                flash.message = "tipoFuncionario.updated"
                flash.args = [params.id]
                flash.defaultMessage = "TipoFuncionario ${params.id} updated"
                redirect(action: "show", id: tipoFuncionarioInstance.id)
            }
            else {
                render(view: "edit", model: [tipoFuncionarioInstance: tipoFuncionarioInstance])
            }
        }
        else {
            flash.message = "tipoFuncionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "TipoFuncionario not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def tipoFuncionarioInstance = TipoFuncionario.get(params.id)
        if (tipoFuncionarioInstance) {
            try {
                tipoFuncionarioInstance.delete()
                flash.message = "tipoFuncionario.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "TipoFuncionario ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "tipoFuncionario.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "TipoFuncionario ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "tipoFuncionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "TipoFuncionario not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
