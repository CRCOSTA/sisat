package model

class FuncionarioController extends BaseController{

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [funcionarioInstanceList: Funcionario.list(params), funcionarioInstanceTotal: Funcionario.count()]
    }

    def create = {
        def funcionarioInstance = new Funcionario()
        funcionarioInstance.properties = params
        return [funcionarioInstance: funcionarioInstance]
    }

    def save = {
        def funcionarioInstance = new Funcionario(params)
        if (!funcionarioInstance.hasErrors() && funcionarioInstance.save()) {
            flash.message = "funcionario.created"
            flash.args = [funcionarioInstance.id]
            flash.defaultMessage = "Funcionario ${funcionarioInstance.id} created"
            redirect(action: "show", id: funcionarioInstance.id)
        }
        else {
            render(view: "create", model: [funcionarioInstance: funcionarioInstance])
        }
    }

    def show = {
        def funcionarioInstance = Funcionario.get(params.id)
        if (!funcionarioInstance) {
            flash.message = "funcionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Funcionario not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [funcionarioInstance: funcionarioInstance]
        }
    }

    def edit = {
        def funcionarioInstance = Funcionario.get(params.id)
        if (!funcionarioInstance) {
            flash.message = "funcionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Funcionario not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [funcionarioInstance: funcionarioInstance]
        }
    }

    def update = {
        def funcionarioInstance = Funcionario.get(params.id)
        if (funcionarioInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (funcionarioInstance.version > version) {
                    
                    funcionarioInstance.errors.rejectValue("version", "funcionario.optimistic.locking.failure", "Another user has updated this Funcionario while you were editing")
                    render(view: "edit", model: [funcionarioInstance: funcionarioInstance])
                    return
                }
            }
            funcionarioInstance.properties = params
            if (!funcionarioInstance.hasErrors() && funcionarioInstance.save()) {
                flash.message = "funcionario.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Funcionario ${params.id} updated"
                redirect(action: "show", id: funcionarioInstance.id)
            }
            else {
                render(view: "edit", model: [funcionarioInstance: funcionarioInstance])
            }
        }
        else {
            flash.message = "funcionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Funcionario not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def funcionarioInstance = Funcionario.get(params.id)
        if (funcionarioInstance) {
            try {
                funcionarioInstance.delete()
                flash.message = "funcionario.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Funcionario ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "funcionario.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Funcionario ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "funcionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Funcionario not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
