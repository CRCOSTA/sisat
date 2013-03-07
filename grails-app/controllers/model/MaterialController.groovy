package model

class MaterialController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {

        return [materialInstanceList: Material.list(params), materialInstanceTotal: Material.count()]
    }

    def create = {
        def materialInstance = new Material()
        materialInstance.properties = params
        return [materialInstance: materialInstance]
    }

    def save = {
        def materialInstance = new Material(params)
        if (!materialInstance.hasErrors() && materialInstance.save()) {
            flash.message = "material.created"
            flash.args = [materialInstance.id]
            flash.defaultMessage = "Material ${materialInstance.id} created"
            redirect(action: "show", id: materialInstance.id)
        }
        else {
            render(view: "create", model: [materialInstance: materialInstance])
        }
    }

    def show = {
        def materialInstance = Material.get(params.id)
        if (!materialInstance) {
            flash.message = "material.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Material not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [materialInstance: materialInstance]
        }
    }

    def edit = {
        def materialInstance = Material.get(params.id)
        if (!materialInstance) {
            flash.message = "material.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Material not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [materialInstance: materialInstance]
        }
    }

    def update = {
        def materialInstance = Material.get(params.id)
        if (materialInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (materialInstance.version > version) {
                    
                    materialInstance.errors.rejectValue("version", "material.optimistic.locking.failure", "Another user has updated this Material while you were editing")
                    render(view: "edit", model: [materialInstance: materialInstance])
                    return
                }
            }
            materialInstance.properties = params
            if (!materialInstance.hasErrors() && materialInstance.save()) {
                flash.message = "material.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Material ${params.id} updated"
                redirect(action: "show", id: materialInstance.id)
            }
            else {
                render(view: "edit", model: [materialInstance: materialInstance])
            }
        }
        else {
            flash.message = "material.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Material not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def materialInstance = Material.get(params.id)
        if (materialInstance) {
            try {
                materialInstance.delete()
                flash.message = "material.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Material ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "material.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Material ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "material.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Material not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
