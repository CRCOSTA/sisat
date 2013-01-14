package model

import grails.converters.JSON

class RelatorioController extends BaseController{

	def index = {[dia:new Date()] }

	def totalPorFuncionario = {
		def inicio = params.inicio
		def fim = params.fim


		def c = OrdemServico.createCriteria()
		def totalOSporFuncionario = c.list {

			between("dataAtendimento",inicio,fim)


			projections {
				count "id", "total"
				groupProperty "funcionario.id"
				groupProperty "status"
				groupProperty "evento"
				groupProperty "domingo"
				groupProperty "periodo"
				groupProperty "complementar"
				groupProperty "visitaPerdida"
			}
		}
		def linhasPorFuncionario = new ArrayList();

		List<String> listaDefuncionario = new ArrayList();

		Map<String,Double> funcionarioValorTotal = new HashMap<String,Double>();

		Map<String,Integer> funcionarioTotalDeAssistencia = new HashMap<String,Integer>();

		Map<String,List> funcionarioValorDiscriminado = new HashMap<String,Double>();
		def nomeFunc = "";
		def novaLinha =  new ArrayList();
		Double valor = 0.0
		Double valorTotal = 0.0
		int totalAssistencias=0

		totalOSporFuncionario.each {

			def funcionario = Funcionario.get(it[1])

			if(!nomeFunc.equals(funcionario.nome)){
				if(!"".equals(nomeFunc)){
					listaDefuncionario.add(nomeFunc)
					funcionarioValorTotal.put(nomeFunc,valorTotal)
					funcionarioTotalDeAssistencia.put(nomeFunc,totalAssistencias)
					funcionarioValorDiscriminado.put(nomeFunc, linhasPorFuncionario)
					nomeFunc = funcionario.nome
					valorTotal=0
					totalAssistencias=0
					linhasPorFuncionario = new ArrayList()
				}else{
					nomeFunc = funcionario.nome
					linhasPorFuncionario = new ArrayList()
				}
			}


			novaLinha.add(it[2])
			novaLinha.add(it[3])
			novaLinha.add(it[4]==true?"DOMINGO":"DIA NORMAL")
			novaLinha.add(it[5])

			valor = funcionario.valorRealizada

			if(it[4]){
				//TESTA SE É DOMINGO
				if(it[7]){//VISITA PERDIDA
					if(it[5]=="NOTURNO"){
						valor = funcionario.valorVisitaNoite
					}else{
						valor = funcionario.valorVisitaDomingo
					}
				}else if(!it[6]){//não é complementar
					if(it[5]=="NOTURNO"){
						valor = funcionario.valorRealizadaNoite
					}else{
						valor = funcionario.valorRealizadaDomingo
					}
				}else{//é complementar
					if(it[5]=="NOTURNO"){
						valor = funcionario.valorComplementarNoite
					}else{
						valor = funcionario.valorComplementarDomingo
					}

				}
			}else{
				if(it[5]=="NOTURNO"){
					if(it[7]){//VISITA PERDIDA
						if(!it[6]){//não é complementar
							valor = funcionario.valorVisitaNoite
						}else{
							valor = 0.0//não paga visita para complementar
						}
					}else{
						if(!it[6]){//não é complementar
							valor = funcionario.valorRealizadaNoite
						}else{
							valor = funcionario.valorComplementarNoite
						}
					}
				}else{
					if(it[7]){
						if(!it[6]){//não é complementar
							valor = funcionario.valorVisita
						}else{
							valor = 0.0//não paga visita para complementar
						}
					}else{
						if(it[6]){//é complementar
							valor=funcionario.valorComplementar
						}
					}
				}

			}

			if(it[3]=="Garantia"){
				valor=0.0
			}

			if(it[2]=="cancelado"){
				valor=0.0
			}

			totalAssistencias = totalAssistencias + it[0]
			valorTotal = valorTotal + (valor*it[0])

			novaLinha.add(it[0])
			novaLinha.add(valor)
			novaLinha.add(valor*it[0])
			novaLinha.add(it[6]?"COMPLEMENTAR":"BARRA NORMAL")
			novaLinha.add(it[7]?"(VISITA PERDIDA)":"")

			linhasPorFuncionario.add(novaLinha)
			novaLinha = new ArrayList()

		}

		listaDefuncionario.add(nomeFunc)
		funcionarioValorTotal.put(nomeFunc,valorTotal)
		funcionarioValorDiscriminado.put(nomeFunc, linhasPorFuncionario)
		funcionarioTotalDeAssistencia.put(nomeFunc,totalAssistencias)

		/*println listaDefuncionario
		 println funcionarioValorTotal
		 println funcionarioValorDiscriminado
		 println funcionarioTotalDeAssistencia*/

		[totalGeral:totalOSporFuncionario.size(), listaDefuncionario:listaDefuncionario,
					funcionarioValorTotal:funcionarioValorTotal,
					funcionarioValorDiscriminado:funcionarioValorDiscriminado,
					funcionarioTotalDeAssistencia:funcionarioTotalDeAssistencia]
	}

	def totalAtendimentosPorBairro = {
		def inicio = params.inicio
		def fim = params.fim
		def bairroList
		def zonas= params.zonas
		def empresasList 
	
	

		def totalPorBairro = new LinkedHashMap()
		def todasAsEmpresas = new LinkedHashMap()
		def totalGeralPorEmpresa = new LinkedHashMap()
		def totGeral = 0;


		if(inicio!=null && fim!=null){
			
			empresasList = Empresa.findAll()
			
			if(zonas instanceof String){
				bairroList =Bairro.findAllByZona(params.zonas,[sort:"zona", order:"desc"] )
			}else{
				bairroList =Bairro.findAllByZonaInList(params.zonas,[sort:"zona", order:"desc"] )
			}
			
			for(Bairro b:bairroList){
				def tot = OrdemServico.countByDataAtendimentoBetweenAndBairro(inicio,fim,b)
				totalPorBairro.put(b.descBairro,tot)
				def qtdPorBairroEmpresa = new LinkedHashMap()
				def params = new LinkedHashMap();
				for(Empresa empresa:empresasList){
					params.put("p_bairro",b);
					params.put("p_inicio",inicio);
					params.put("p_fim",fim);
					params.put("p_empresa",empresa);
					def totstatus= OrdemServico.executeQuery('select count(o) from OrdemServico o where (o.dataAtendimento >= :p_inicio and o.dataAtendimento < :p_fim ) and o.empresa=:p_empresa and o.bairro=:p_bairro',params)[0]
					qtdPorBairroEmpresa.put(empresa.nome,totstatus);

					if(totalGeralPorEmpresa.get(empresa.nome)==null){
						totalGeralPorEmpresa.put(empresa.nome,totstatus);
					}else{
						def x = totalGeralPorEmpresa.get(empresa.nome);

						totstatus = x +totstatus;

						totalGeralPorEmpresa.put(empresa.nome,totstatus);
					}

				}
				todasAsEmpresas.put(b.descBairro,qtdPorBairroEmpresa)

				totGeral = totGeral + tot
			}
		}

		def bairroInstance= new Bairro();
		def zonaList = bairroInstance.constraints.zona.inList
		bairroInstance=null
		[totalGeral:totGeral,totalPorBairroMap:totalPorBairro, bairros:bairroList,todasAsEmpresas:todasAsEmpresas,empresaList:empresasList,totalGeralPorEmpresa:totalGeralPorEmpresa,zonaList:zonaList];


	}

	def totalAtendimentosPorModalidade = {

		def inicio = params.inicio
		def fim = params.fim
		def modalidadesList = Modalidade.findAll()
		def totalPorModalidade = new LinkedHashMap()
		def empresasList = Empresa.findAll()
		def todasAsEmpresas = new LinkedHashMap()

		def totalGeralPorEmpresa = new LinkedHashMap()
		def totGeral = 0;

		if(inicio!=null && fim!=null){

			for(Modalidade m:modalidadesList){
				def tot = OrdemServico.countByDataAtendimentoBetweenAndModalidade(inicio,fim,m)
				totalPorModalidade.put(m.descricao,tot)
				def qtdPorModalidadeEmpresa = new LinkedHashMap()
				def params = new LinkedHashMap();
				for(Empresa empresa:empresasList){
					params.put("p_modalidade",m);
					params.put("p_inicio",inicio);
					params.put("p_fim",fim);
					params.put("p_empresa",empresa);
					def totstatus= OrdemServico.executeQuery('select count(o) from OrdemServico o where (o.dataAtendimento between :p_inicio and :p_fim ) and o.empresa=:p_empresa and o.modalidade=:p_modalidade',params)[0]
					qtdPorModalidadeEmpresa.put(empresa.nome,totstatus);

					if(totalGeralPorEmpresa.get(empresa.nome)==null){
						totalGeralPorEmpresa.put(empresa.nome,totstatus);
					}else{
						def x = totalGeralPorEmpresa.get(empresa.nome);

						totstatus = x +totstatus;

						totalGeralPorEmpresa.put(empresa.nome,totstatus);
					}

				}
				todasAsEmpresas.put(m.descricao,qtdPorModalidadeEmpresa)

				totGeral = totGeral + tot
			}

		}

		[totalGeral:totGeral,totalPorModalidadeMap:totalPorModalidade, modalidades:modalidadesList,todasAsEmpresas:todasAsEmpresas,empresaList:empresasList,totalGeralPorEmpresa:totalGeralPorEmpresa]

	}

	def totalAtendimentos = {

		def inicio = params.inicio
		def fim = params.fim
		def empresasList = Empresa.findAll()
		def totalPorEmpresa = new LinkedHashMap()

		def todosOsStatus = new LinkedHashMap()
		def statusList = OrdemServico.constraints.status.inList;
		def totalGeralPorStatus = new LinkedHashMap()
		def totGeral = 0;

		if(inicio!=null && fim!=null){

			for(Empresa e:empresasList){
				def tot = OrdemServico.countByDataAtendimentoBetweenAndEmpresa(inicio,fim,e)
				totalPorEmpresa.put(e.nome,tot)
				def qtdPorEmpresaStatus = new LinkedHashMap()
				def params = new LinkedHashMap();
				for(String status:statusList){
					params.put("p_empresa",e);
					params.put("p_inicio",inicio);
					params.put("p_fim",fim);
					params.put("p_status",status);
					def totstatus= OrdemServico.executeQuery('select count(o) from OrdemServico o where (o.dataAtendimento between :p_inicio and :p_fim ) and o.empresa=:p_empresa and status=:p_status',params)[0]
					qtdPorEmpresaStatus.put(status,totstatus);

					if(totalGeralPorStatus.get(status)==null){
						totalGeralPorStatus.put(status,totstatus);
					}else{
						def x = totalGeralPorStatus.get(status);

						totstatus = x +totstatus;

						totalGeralPorStatus.put(status,totstatus);
					}

				}
				todosOsStatus.put(e.nome,qtdPorEmpresaStatus)

				totGeral = totGeral + tot
			}

		}

		[totalGeral:totGeral,totalPorEmpresaMap:totalPorEmpresa, empresas:empresasList,todosOsStatus:todosOsStatus,statusList:statusList,totalGeralPorStatus:totalGeralPorStatus]

	}

	def planilha = {
		def dia = params.inicio

		def fList = Funcionario.findAllByTipoFuncionarioNotAndAtivo(model.TipoFuncionario.get(1),true)
		def ordensPorFuncionarioManhaMap = new LinkedHashMap()
		def ordensPorFuncionarioTardeMap = new LinkedHashMap()
		def ordensPorFuncionarioNoiteMap = new LinkedHashMap()
		def totalOrdensPorFuncionarioMap = new LinkedHashMap()
		def query = "from OrdemServico o where o.funcionario=:p_funcionario and (o.dataAtendimento >= :p_dia and o.dataAtendimento < :p_diaSeguinte )"+
				" and (o.previaInicial >= :p_periodo_ini and o.previaInicial < :p_periodo_fim) order by previaInicial asc"


		def totalDiario=0
		if(dia!=null){
			def diaSeguinte = dia +1

			for(Funcionario f:fList){
				def queryParams = new LinkedHashMap()
				queryParams.put("p_funcionario",f)
				queryParams.put("p_dia",dia)
				queryParams.put("p_diaSeguinte",diaSeguinte)
				queryParams.put("p_periodo_ini","00:00")
				queryParams.put("p_periodo_fim","12:00")
				def lstManha =  OrdemServico.findAll(query,queryParams)
				ordensPorFuncionarioManhaMap.put(f.nome,lstManha)

				queryParams.remove("p_periodo_ini")
				queryParams.remove("p_periodo_fim")
				queryParams.put("p_periodo_ini","12:00")
				queryParams.put("p_periodo_fim","18:00")
				def lstTarde = OrdemServico.findAll(query,queryParams)
				ordensPorFuncionarioTardeMap.put(f.nome, lstTarde)

				queryParams.remove("p_periodo_ini")
				queryParams.remove("p_periodo_fim")
				queryParams.put("p_periodo_ini","18:00")
				queryParams.put("p_periodo_fim","24:00")
				def lstNoite = OrdemServico.findAll(query,queryParams)
				ordensPorFuncionarioNoiteMap.put(f.nome, lstNoite)

				def totalPorFunc = lstManha.size() + lstTarde.size() + lstNoite.size()
				totalDiario = totalDiario + totalPorFunc
				totalOrdensPorFuncionarioMap.put(f.nome,totalPorFunc)
			}


		}
		[funcionarioInstanceList: fList,ordensPorFuncionarioManhaMap:ordensPorFuncionarioManhaMap,dia:dia,ordensPorFuncionarioTardeMap:ordensPorFuncionarioTardeMap,ordensPorFuncionarioNoiteMap:ordensPorFuncionarioNoiteMap,statusList:OrdemServico.constraints.status.inList,totalOrdensPorFuncionarioMap:totalOrdensPorFuncionarioMap,totalDiario:totalDiario]
	}
	
	def mapa = {
		def dia = params.inicio
		def status = ""+params.status
		println status
		status = status.replace("[", "").replace(", ","','").replace("]","")
		println status
		def query = "from OrdemServico o where o.dataAtendimento >= :p_dia and o.dataAtendimento < :p_diaSeguinte and o.status in ('"+status+"')"
				
		def lstOrdem 

		def totalDiario=0
		if(dia!=null){
			def diaSeguinte = dia +1
			
			def queryParams = new LinkedHashMap()
			
			queryParams.put("p_dia",dia)
			queryParams.put("p_diaSeguinte",diaSeguinte)
			lstOrdem =  OrdemServico.findAll(query,queryParams)
			println status
			println lstOrdem

		}
		
		def converter = lstOrdem as JSON;
		println converter.toString();
		
		[lstOrdem:converter.toString(),dia:dia,statusList:OrdemServico.constraints.status.inList]
	}
}
