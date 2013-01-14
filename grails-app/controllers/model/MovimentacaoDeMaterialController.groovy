package model

class MovimentacaoDeMaterialController extends BaseController{

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [movimentacaoDeMaterialInstanceList: MovimentacaoDeMaterial.list(params), movimentacaoDeMaterialInstanceTotal: MovimentacaoDeMaterial.count()]
    }

    def create = {
        def ordemServicoInstance = OrdemServico.get(params.id)
        if (!ordemServicoInstance) {
            flash.message = "ordemServico.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "OrdemServico not found with id ${params.id}"
            redirect(action: "list")
        }else{
            
            def movimentacaoDeMaterialInstance = new MovimentacaoDeMaterial()
            movimentacaoDeMaterialInstance.properties = params
            def movimentacaoDeMaterialPorOrdemServico = MovimentacaoDeMaterial.findAllByOrdemServico(ordemServicoInstance,[sort:"dataMovimentacao",order:"asc"]);
			
			def listMaterial = EstoqueFuncionario.findAllByFuncionario(ordemServicoInstance.funcionario);
			
			print listMaterial
			
			print ordemServicoInstance.funcionario
			
            return [movimentacaoDeMaterialInstance: movimentacaoDeMaterialInstance,ordemServicoInstance: ordemServicoInstance,movimentacaoDeMaterialPorOrdemServico:movimentacaoDeMaterialPorOrdemServico,listMaterial:listMaterial]
        }
    }

    def save = {
        def movimentacaoDeMaterialInstance = new MovimentacaoDeMaterial(params)
		
        if(movimentacaoDeMaterialInstance.tipo.equals("Saida")){
            movimentacaoDeMaterialInstance.quantidade=movimentacaoDeMaterialInstance.quantidade*-1
        }
		
		def ordemServicoInstance = OrdemServico.get(params.id);

        def funcionario = (Funcionario)session.user

        movimentacaoDeMaterialInstance.funcionario = funcionario
		
		movimentacaoDeMaterialInstance.ordemServico=ordemServicoInstance

        if (!movimentacaoDeMaterialInstance.hasErrors() && movimentacaoDeMaterialInstance.save()) {
			
			def estoqueFuncionario = EstoqueFuncionario.get(params.listMaterial.id)
			
            def material = movimentacaoDeMaterialInstance.material

            material.estoqueAtual = material.estoqueAtual+ movimentacaoDeMaterialInstance.quantidade;

            if (material.save()){

				estoqueFuncionario.qtd = estoqueFuncionario.qtd +  movimentacaoDeMaterialInstance.quantidade
				
				if(estoqueFuncionario.qtd<=0){
					estoqueFuncionario.delete();
				}else{
					estoqueFuncionario.save();
				}
				
				ordemServicoInstance.addToMateriais(movimentacaoDeMaterialInstance);
				ordemServicoInstance.save();
				
                flash.message = "movimentacaoDeMaterial.created"
                flash.args = [movimentacaoDeMaterialInstance.id]
                flash.defaultMessage = "MovimentacaoDeMaterial ${movimentacaoDeMaterialInstance.id} created"

                redirect(action: "create", id: params.id)
            }
            else {
                render(view: "create", model: [movimentacaoDeMaterialInstance: movimentacaoDeMaterialInstance,params:params])
            }
			
			
        }
        else {
			flash.message = "movimentacaoDeMaterial.not.found"
			flash.defaultMessage = "Erro ao criar movimenta‹o"
            redirect(action: "create", id:params.id)
        }
    }

    def show = {
        def movimentacaoDeMaterialInstance = MovimentacaoDeMaterial.get(params.id)
        if (!movimentacaoDeMaterialInstance) {
            flash.message = "movimentacaoDeMaterial.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MovimentacaoDeMaterial not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [movimentacaoDeMaterialInstance: movimentacaoDeMaterialInstance]
        }
    }

    def edit = {
        def movimentacaoDeMaterialInstance = MovimentacaoDeMaterial.get(params.id)
        if (!movimentacaoDeMaterialInstance) {
            flash.message = "movimentacaoDeMaterial.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MovimentacaoDeMaterial not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [movimentacaoDeMaterialInstance: movimentacaoDeMaterialInstance]
        }
    }

    def update = {
        def movimentacaoDeMaterialInstance = MovimentacaoDeMaterial.get(params.id)
        if (movimentacaoDeMaterialInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (movimentacaoDeMaterialInstance.version > version) {
                    
                    movimentacaoDeMaterialInstance.errors.rejectValue("version", "movimentacaoDeMaterial.optimistic.locking.failure", "Another user has updated this MovimentacaoDeMaterial while you were editing")
                    render(view: "edit", model: [movimentacaoDeMaterialInstance: movimentacaoDeMaterialInstance])
                    return
                }
            }
            movimentacaoDeMaterialInstance.properties = params
            if (!movimentacaoDeMaterialInstance.hasErrors() && movimentacaoDeMaterialInstance.save()) {
                flash.message = "movimentacaoDeMaterial.updated"
                flash.args = [params.id]
                flash.defaultMessage = "MovimentacaoDeMaterial ${params.id} updated"
                redirect(action: "show", id: movimentacaoDeMaterialInstance.id)
            }
            else {
                render(view: "edit", model: [movimentacaoDeMaterialInstance: movimentacaoDeMaterialInstance])
            }
        }
        else {
            flash.message = "movimentacaoDeMaterial.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MovimentacaoDeMaterial not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def movimentacaoDeMaterialInstance = MovimentacaoDeMaterial.get(params.id)
        if (movimentacaoDeMaterialInstance) {
            try {
                movimentacaoDeMaterialInstance.delete()
                flash.message = "movimentacaoDeMaterial.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "MovimentacaoDeMaterial ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "movimentacaoDeMaterial.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "MovimentacaoDeMaterial ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "movimentacaoDeMaterial.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "MovimentacaoDeMaterial not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
