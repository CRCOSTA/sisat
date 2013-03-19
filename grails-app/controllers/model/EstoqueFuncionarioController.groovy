package model

import java.text.DateFormat
import java.text.SimpleDateFormat

class EstoqueFuncionarioController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {

            def  Funcionario func
        if(params.funcionario?.id!=null){

            func = Funcionario.get(params.funcionario.id)
 
            [estoqueFuncionarioInstanceList: func.estoque, estoqueFuncionarioInstanceTotal: EstoqueFuncionario.count(),funcionario:func]

        }

       
    }

    def create = {
        def estoqueFuncionarioInstance = new EstoqueFuncionario()
        estoqueFuncionarioInstance.properties = params
        return [estoqueFuncionarioInstance: estoqueFuncionarioInstance]
    }

    def save = {
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy")
		
		params.dataInclusao = df.parse(  params.dataInclusao )
		
		def material = Material.get(Integer.parseInt( params.material.id))
		def funcionario = Funcionario.get(params.funcionario.id)
		
		def estoque = EstoqueFuncionario.findByMaterialAndFuncionario(material,funcionario)
		
		println estoque
		
		if(estoque){
			estoque.qtd = estoque.qtd + Integer.parseInt(params.qtd)
			estoque.dataInclusao = params.dataInclusao
			
			println estoque.qtd
			
			if (!estoque.hasErrors() && estoque.save()) {
				render "ok" 
			}else{
				render(status: 503, text: "erro ao inserir material no estoque do tecnico.")
			}
		}else{
		
			println "novo cadastro"
	        def estoqueFuncionarioInstance = new EstoqueFuncionario(params)
	        if (!estoqueFuncionarioInstance.hasErrors() && estoqueFuncionarioInstance.save()) {
	         	render "ok"
			}
	        else {
				render(status: 503, text: "erro ao inserir material no estoque do tecnico.")
	        }
		}
    }

    def show = {
        def estoqueFuncionarioInstance = EstoqueFuncionario.get(params.id)
        if (!estoqueFuncionarioInstance) {
            flash.message = "estoqueFuncionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EstoqueFuncionario not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [estoqueFuncionarioInstance: estoqueFuncionarioInstance]
        }
    }

    def edit = {
        def estoqueFuncionarioInstance = EstoqueFuncionario.get(params.id)
        if (!estoqueFuncionarioInstance) {
            flash.message = "estoqueFuncionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EstoqueFuncionario not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [estoqueFuncionarioInstance: estoqueFuncionarioInstance]
        }
    }

    def update = {
        def estoqueFuncionarioInstance = EstoqueFuncionario.get(params.id)
        if (estoqueFuncionarioInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (estoqueFuncionarioInstance.version > version) {
                    
                    estoqueFuncionarioInstance.errors.rejectValue("version", "estoqueFuncionario.optimistic.locking.failure", "Another user has updated this EstoqueFuncionario while you were editing")
                    render(view: "edit", model: [estoqueFuncionarioInstance: estoqueFuncionarioInstance])
                    return
                }
            }
            estoqueFuncionarioInstance.properties = params
            if (!estoqueFuncionarioInstance.hasErrors() && estoqueFuncionarioInstance.save()) {
                flash.message = "estoqueFuncionario.updated"
                flash.args = [params.id]
                flash.defaultMessage = "EstoqueFuncionario ${params.id} updated"
                redirect(action: "show", id: estoqueFuncionarioInstance.id)
            }
            else {
                render(view: "edit", model: [estoqueFuncionarioInstance: estoqueFuncionarioInstance])
            }
        }
        else {
            flash.message = "estoqueFuncionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EstoqueFuncionario not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def estoqueFuncionarioInstance = EstoqueFuncionario.get(params.id)
        if (estoqueFuncionarioInstance) {
            try {
                estoqueFuncionarioInstance.delete()
                flash.message = "estoqueFuncionario.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EstoqueFuncionario ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "estoqueFuncionario.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "EstoqueFuncionario ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "estoqueFuncionario.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "EstoqueFuncionario not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
