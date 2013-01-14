package model

import java.text.DateFormat
import java.text.NumberFormat
import java.text.SimpleDateFormat

class OrdemServicoController extends BaseController{

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    static DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
	def filterListById={
		
	}

    def listOne = {
        
         render( view:"list",model:[ordemServicoInstanceList:OrdemServico.get(params.id), ordemServicoInstanceTotal: OrdemServico.count()],statusList:OrdemServico.constraints.status.inList)
    }
	
	def listByTecnico ={
		
		if(session.user.tecnico){
			params.funcionario = session.user
		}
		
		if((params.funcionario!=null && params.funcionario.id!="null")){
			def queryFilter = "from OrdemServico o where "
			def queryParams = new LinkedHashMap()
			
			def objFuncionario = Funcionario.get(params.funcionario.id)
			queryFilter = queryFilter + " o.funcionario=:p_funcionario"
			queryFilter = queryFilter + " and o.status in (:p_status)"
			queryParams.put("p_funcionario",objFuncionario)
			queryParams.put("p_status",["com o tecnico","senha validada"])
			queryFilter = queryFilter + " order by o.dataAtendimento , o.previaInicial asc"
		
			def list = OrdemServico.findAll(queryFilter,queryParams)
			
			[ordemServicoInstanceList: list, ordemServicoInstanceTotal:  list.size(),statusList:OrdemServico.constraints.status.inList]
		}
	}
	
	def filtros={
		def ordemServicoInstance = new OrdemServico()
		
		
		
		if(params.pesquisar!="pesquisar"){
			session.dateIni=df.format(new Date())
			session.dateFim=df.format(new Date())
			return [ordemServicoInstance: ordemServicoInstance]
		}

        def queryFilter = "from OrdemServico o where "
        def queryParams = new LinkedHashMap()
		def empresa = null;
		
		if(session.user.analista){
			empresa = Empresa.get(session.user.empresa.id)
		}

        if(params.numero!="" && params.barra!=""){
            
			if(empresa!=null){
				def ordemservicolist = OrdemServico.findAllByEmpresaAndNumeroLike(empresa,params.numero)

				[ordemServicoInstance: ordemServicoInstance,ordemServicoInstanceList: ordemservicolist, ordemServicoInstanceTotal: ordemservicolist.size() ,statusList:OrdemServico.constraints.status.inList]
			}else{
				queryFilter = queryFilter + "o.numero like '%"+params.numero+"%'"
				def ordemservicolist = OrdemServico.findAll(queryFilter)
			
			
				[ordemServicoInstance: ordemServicoInstance,ordemServicoInstanceList: ordemservicolist, ordemServicoInstanceTotal: ordemservicolist.size() ,statusList:OrdemServico.constraints.status.inList]
			}


        }else{


            if(params.inicio!=null && params.final!=null){
				
				Date dataIni = df.parse(params.inicio);
				Date dataFim = df.parse(params.final);
				session.dateIni=params.inicio
				session.dateFim=params.fim

                queryFilter = queryFilter + "o.dataAtendimento between :p_inicio and :p_final"
                queryParams.put("p_inicio",dataIni)
                queryParams.put("p_final",dataFim)

            }

            if(params.funcionario!=null && params.funcionario.id!="null"){
				session.funcionarioId=params.funcionario.id
                def objFuncionario = Funcionario.get(params.funcionario.id)
                queryFilter = queryFilter + " and o.funcionario=:p_funcionario"
                queryParams.put("p_funcionario",objFuncionario)

            }

            if(params.formaDeAcionamento!="" && params.formaDeAcionamento!="null"){
				session.formaAcionamento=params.formaDeAcionamento
                queryFilter = queryFilter + " and o.formaDeAcionamento = :p_formaDeAcionamento"
                queryParams.put("p_formaDeAcionamento",params.formaDeAcionamento)

            }


            queryFilter = queryFilter + " order by o.status asc"

            if(!queryParams.isEmpty()){

                def list = OrdemServico.findAll(queryFilter,queryParams)


                [ordemServicoInstance: ordemServicoInstance,ordemServicoInstanceList: list, ordemServicoInstanceTotal:  list.size(),statusList:OrdemServico.constraints.status.inList]

            }else{

                [ordemServicoInstance: ordemServicoInstance,ordemServicoInstanceList: OrdemServico.list(params), ordemServicoInstanceTotal: OrdemServico.count(),statusList:OrdemServico.constraints.status.inList]
            }
        }
        
    }

    def receberOS = {
        def ordemServicoInstance = OrdemServico.get(params.id)
        if (!ordemServicoInstance) {
            flash.message = "ordemServico.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "OrdemServico not found with id ${params.id}"
            redirect(action: "filtros")
        }
        else {
            ordemServicoInstance.recebida=true
         
            gravaLog(ordemServicoInstance, LogOrdemServico.RECEBIMENTO)
            
            if (!ordemServicoInstance.hasErrors() && ordemServicoInstance.save()) {
                flash.message = "ordemServico.updated"
                flash.args = [params.id]
                flash.defaultMessage = "OrdemServico ${params.id} updated"
                redirect(action: "filtros")
            }
            else {
                 redirect(action: "filtros")
            }
        }
    }

    def create = {
        def ordemServicoInstance = new OrdemServico()
        ordemServicoInstance.properties = params
        return [ordemServicoInstance: ordemServicoInstance]
    }

    def save = {
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		params.dataAcionamento = df.parse(  params.dataAcionamento )
		params.dataAtendimento = df.parse(  params.dataAtendimento )
		
        def ordemServicoInstance = new OrdemServico(params)
        //setando status da ordem de servico como aberta
        ordemServicoInstance.status="aberta"

		 
        if (!ordemServicoInstance.hasErrors() && ordemServicoInstance.save()) {
            gravaLog(ordemServicoInstance, LogOrdemServico.CADASTRO)
            flash.message = "ordemServico.created"
            flash.args = [ordemServicoInstance.id]
            flash.defaultMessage = "OrdemServico ${ordemServicoInstance.id} created"
            redirect(action: "show", id: ordemServicoInstance.id)
        }
        else {
            render(view: "create", model: [ordemServicoInstance: ordemServicoInstance])
        }
    }

     def fechamento ={
         def ordemServicoInstance = OrdemServico.get(params.id)
         if (!ordemServicoInstance) {
            flash.message = "ordemServico.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "OrdemServico not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [ordemServicoInstance: ordemServicoInstance]
        }
    }

    def fecharAtendimento={
         def ordemServicoInstance = OrdemServico.get(params.id)
		 
		 DateFormat df = new SimpleDateFormat("dd/MM/yyyy hh:mm");
		 
		 
          if (ordemServicoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (ordemServicoInstance.version > version) {

                    ordemServicoInstance.errors.rejectValue("version", "ordemServico.optimistic.locking.failure", "Another user has updated this OrdemServico while you were editing")
                    render(view: "edit", model: [ordemServicoInstance: ordemServicoInstance])
                    return
                }
            }
			
			def dataHoraSaida = params.saida + " " + params.horaSaida
			
            ordemServicoInstance.saida = df.parse(dataHoraSaida)
            ordemServicoInstance.avaliacao = params.avaliacao
            ordemServicoInstance.diagnostico=params.diagnostico
            ordemServicoInstance.servicoExecutado=params.servicoExecutado
            ordemServicoInstance.parecer=params.parecer
            ordemServicoInstance.fotos=params.fotos
			ordemServicoInstance.visitaPerdida=params.visitaPerdida!=null

            def checklistfile = request.getFile('checklist');
            
            if(!checklistfile.empty){
                (new File(Imagem.uploadPath+ordemServicoInstance.numero+'/')).mkdir();

                String nomeImg = checklistfile.hashCode() +'.jpg'

                String pathDir = System.getProperty("java.io.tmpdir")+"/"+ordemServicoInstance.id+"/"
					
                File dir = new File(pathDir.trim());
					
				dir.mkdir()

                File f = new  File(pathDir.trim()+'/temp_' + nomeImg );
                checklistfile.transferTo(f)
                    
                ImagemController.createThumbnail(f,ordemServicoInstance.id,"thumb_"+nomeImg)
				ImagemController.createThumbnail(f,ordemServicoInstance.id,nomeImg)
				
				f.delete()

                def checkListImage = new Imagem(nomeImagem:checklistfile.hashCode() +'.jpg',checklist:true)

                checkListImage.ordemServico = ordemServicoInstance

                checkListImage.save()

                gravaLog(ordemServicoInstance, LogOrdemServico.IMAGEM)
            }

            

            if(params.visitaPerdida){
                ordemServicoInstance.status = "visita perdida"
            }else{
                ordemServicoInstance.status = "fechada"
            }

            if (!ordemServicoInstance.hasErrors() && ordemServicoInstance.save()) {
                gravaLog(ordemServicoInstance, LogOrdemServico.FECHAMENTO)
                flash.message = "ordemServico.updated"
                flash.args = [params.id]
                flash.defaultMessage = "OrdemServico ${params.id} updated"
                redirect(action: "filtros")
            }
            else {
                render(view: "list")
            }
        }
        else {
            flash.message = "ordemServico.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "OrdemServico not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }



    def encaminharParaTecnico={
         def ordemServicoInstance = OrdemServico.get(params.id)
          if (ordemServicoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (ordemServicoInstance.version > version) {
                    ordemServicoInstance.errors.rejectValue("version", "ordemServico.optimistic.locking.failure", "Another user has updated this OrdemServico while you were editing")
                    render "ordemServico.optimistic.locking.failure", "Another user has updated this OrdemServico while you were editing"
                }
            }
            ordemServicoInstance.funcionario = Funcionario.get(params.funcionario.id)
             ordemServicoInstance.status = "com o tecnico"
            if (!ordemServicoInstance.hasErrors() && ordemServicoInstance.save()) {
                gravaLog(ordemServicoInstance, LogOrdemServico.ENCAMINHAMENTO)
                render "ok"
            }else{
				render "erro ao encaminhar par tecnico "+params.id
            }

        }
        else {
			render "ordem de servico nao encontrada- encaminhar para tecnico"+ params.id
        }
    }

	
	def enviarPagamento ={
		def ordemServicoInstance = OrdemServico.get(params.id)
		if (!ordemServicoInstance) {
		   flash.message = "ordemServico.not.found"
		   flash.args = [params.id]
		   flash.defaultMessage = "OrdemServico not found with id ${params.id}"
		   redirect(action: "list")
	   }
	   else {
		   return [ordemServicoInstance: ordemServicoInstance]
	   }
   }
	
    def validarSenha={
         def ordemServicoInstance = OrdemServico.get(params.id)
          if (ordemServicoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (ordemServicoInstance.version > version) {

                    ordemServicoInstance.errors.rejectValue("version", "ordemServico.optimistic.locking.failure", "Another user has updated this OrdemServico while you were editing")
                    render "Another user has updated this OrdemServico while you were editing"
                    return
                }
            }

            ordemServicoInstance.senha = params.senha
            ordemServicoInstance.chegada = new Date()
            ordemServicoInstance.status = "senha validada"
            
            if (!ordemServicoInstance.hasErrors() && ordemServicoInstance.save()) {
                gravaLog(ordemServicoInstance, LogOrdemServico.VALIDACAO)
                flash.message = "ordemServico.updated"
                flash.args = [params.id]
                flash.defaultMessage = "OrdemServico ${params.id} updated"
				if(session?.user?.tecnico){
					redirect(  action: "listByTecnico")
				}
                render "OK"
            }
            else {
				if(session?.user?.tecnico){
					redirect( action: "listByTecnico")
				}
                render "Erro ao validar senha"
            }
        }
        else {
            flash.message = "ordemServico.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "OrdemServico not found with id ${params.id}"
			if(session?.user?.tecnico){
				redirect( action: "listByTecnico")
			}
           render "Ordem de servico nao encontrada"
        }
    }


    def show = {
        def ordemServicoInstance = OrdemServico.get(params.id)
        if (!ordemServicoInstance) {
            flash.message = "ordemServico.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "OrdemServico not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [ordemServicoInstance: ordemServicoInstance]
        }
    }

    def edit = {
        def ordemServicoInstance = OrdemServico.get(params.id)
        if (!ordemServicoInstance) {
            flash.message = "ordemServico.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "OrdemServico not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [ordemServicoInstance: ordemServicoInstance]
        }
    }

    def update = {
        def ordemServicoInstance = OrdemServico.get(params.id)
        if (ordemServicoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (ordemServicoInstance.version > version) {
                    
                    ordemServicoInstance.errors.rejectValue("version", "ordemServico.optimistic.locking.failure", "Another user has updated this OrdemServico while you were editing")
                    render(view: "edit", model: [ordemServicoInstance: ordemServicoInstance])
                    return
                }
            }
            ordemServicoInstance.properties = params
            if (!ordemServicoInstance.hasErrors() && ordemServicoInstance.save()) {
                gravaLog(ordemServicoInstance, LogOrdemServico.ALTERADO)
                flash.message = "ordemServico.updated"
                flash.args = [params.id]
                flash.defaultMessage = "OrdemServico ${params.id} updated"
                redirect(action: "show", id: ordemServicoInstance.id)
            }
            else {
                render(view: "edit", model: [ordemServicoInstance: ordemServicoInstance])
            }
        }
        else {
            flash.message = "ordemServico.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "OrdemServico not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def ordemServicoInstance = OrdemServico.get(params.id)
        if (ordemServicoInstance) {
            try {
                
                ordemServicoInstance.delete()
                
                flash.message = "ordemServico.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "OrdemServico ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "ordemServico.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "OrdemServico ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "ordemServico.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "OrdemServico not found with id ${params.id}"
            redirect(action: "list")
        }
    }
	
	def lotePagamento ={
		if(params.empresa!=null){
			def empresa = Empresa.get(params.empresa)
		
			def lote = OrdemServico.findAllByEmpresaAndDataPagamento(empresa,params.dataPagamento)
		
			[lote:lote]
		}
		
	}
	
	// Export service provided by Export plugin
	def exportService
	def grailsApplication  //inject GrailsApplication
	
	def lotePagamentoExport={
		if(params.empresa!=null){
			def empresa = Empresa.get(params.empresa)
		
			def lote = OrdemServico.findAllByEmpresaAndDataPagamento(empresa,params.dataPagamento)
			
			response.contentType = grailsApplication.config.grails.mime.types[params.format]
			response.setHeader("Content-disposition", "attachment; filename=loteAtendimentos.${params.extension}")
			
			def valor = { domain, value ->
				return NumberFormat.getCurrencyInstance(new Locale("pt", "BR")).format(domain?.valorMDO  + domain?.valorMaterial + domain?.valorDeslocamento)	
			}
			
			def numeroBarra = {domain ,value->
				return domain?.numero + "/" + domain?.barra
			}
			
			Map formatters = [valor: valor,numero:numeroBarra]
			
			List fields = ["numero", "modalidade","seguradora","segurado","evento","valor","numeroLotePagamento"]
			Map labels = ["numero": "Numero OS", "modalidade": "Modalidade","seguradora":"Seguradora","segurado":"Segurado","valor":"valor","numeroLotePagamento":"Lote"]
			
			exportService.export(params.format, response.outputStream,lote, fields, labels,formatters,[:])
		
			
		}
	}
	
	def liquidar={
		if(params.empresa!=null){
			def empresa = Empresa.get(params.empresa)
		
			def lote = OrdemServico.findAllByEmpresaAndDataPagamento(empresa,params.dataPagamento)
		
			lote.each {
				def ordemServicoInstance = (OrdemServico)it
				
				ordemServicoInstance.numeroLotePagamento = params.numeroLotePagamento
				
				ordemServicoInstance.status="liquidada"
				
				ordemServicoInstance.save()
			}
			
			flash.message = "material.created"
			flash.args = [params.numeroLotePagamento]
			flash.defaultMessage = "Lote ${params.numeroLotePagamento} atualizado."
			render(view: "lotePagamento")
			
			return
		}
		
	}
}