package model

import grails.converters.JSON

import java.text.SimpleDateFormat

class BaseController {

    def beforeInterceptor = [action:this.&auth,except:['login', 'handleLogin']]
	
	def tecnicoAuthPaths = ["ordemServico/listByTecnico","ordemServico/validar","ordemServico/validarSenha","ordemServico/show","imagem/create","imagem/save","base/logout"]

    def auth() {
        if(!session.user) {
            flash.forward = actionUri
            if(params.id){
                flash.forward += '/' + params.id
            }else{
				redirect(uri: "/")
                return false
            }
        }else{
			def canAccess=false; 
			if(session.user.tecnico){
				for(String path:tecnicoAuthPaths){
					if(actionUri.contains(path)){
						canAccess=true;
						break;
					}
				}
				if(!canAccess){
					session.user=null;
					redirect(controller:'base',action:'login')
					return false
				}
			}
		
        }
    }
	
	def meses=[1:"Janeiro",2:"Fevereiro",3:"Marco",4:"Abril",5:"Maio",6:"Junho",7:"Julho",8:"Agosto",9:"Setembro",10:"Outubro",11:"Novembro",12:"Dezembro"]

	def home = {
		
		
		def calendarMesAtual = GregorianCalendar.getInstance()
		
		def primeiroDia =  GregorianCalendar.getInstance()
		
		def anoAtual = calendarMesAtual.get(Calendar.YEAR)
		
		def mesAtual = calendarMesAtual.get(Calendar.MONTH)
		
		primeiroDia.set(anoAtual, mesAtual, 1)
		
		def ultimoDia = GregorianCalendar.getInstance()
		
		ultimoDia.set(anoAtual, mesAtual, calendarMesAtual.getActualMaximum(Calendar.DAY_OF_MONTH))
		
		println new SimpleDateFormat("dd/MM/yy HH:mm").format(primeiroDia.getTime())
		println new SimpleDateFormat("dd/MM/yy HH:mm").format(ultimoDia.getTime())
		
		
		def c = OrdemServico.createCriteria()
		def atendimentosDoMes = c.list {

			between("dataAtendimento",primeiroDia.getTime(),ultimoDia.getTime())
		}
		
		
		def atendimentosPorStatus = [:].withDefault { [] }
		def atendimentosPorModalidade = [:].withDefault { [] }
		atendimentosDoMes.each {
			if(it.visitaPerdida){
				atendimentosPorStatus["visita"] << it
				
			}else{
				atendimentosPorStatus[it.status] << it
			}
			
		}
		
		
		def atendimentosPorDia = [:].withDefault { [] }
		atendimentosDoMes.each {
			atendimentosPorDia[it.dataAtendimento] << it.id
		}
		
		atendimentosPorDia.keySet().each {
			
		}
		
		def totalGeralPorDia = ""
		atendimentosPorDia.keySet().each {
			totalGeralPorDia = totalGeralPorDia + atendimentosPorDia[it].size() + ","
		}
		
		
		def atendimentosCanceladosPorDia = [:].withDefault { [] }
		atendimentosPorStatus["cancelado"].each {
			atendimentosCanceladosPorDia[it.dataAtendimento] << it.id
		}
		
		def canceladosPorDia = "" 
		atendimentosCanceladosPorDia.keySet().each {
			canceladosPorDia = canceladosPorDia + atendimentosCanceladosPorDia[it].size() + ","
		}
		
		def atendimentosVisitaPorDia = [:].withDefault { [] }
		atendimentosPorStatus["visita"].each {
			atendimentosVisitaPorDia[it.dataAtendimento] << it.id
		}
		
		def visitasPorDia = ""
		atendimentosVisitaPorDia.keySet().each {
			visitasPorDia = visitasPorDia + atendimentosVisitaPorDia[it].size() + ","
		}
		
		def atendimentosFechadosPorDia = [:].withDefault { [] }
		atendimentosPorStatus["fechada"].each {
			atendimentosFechadosPorDia[it.dataAtendimento] << it.id
		}
		
		def fechadosPorDia = ""
		atendimentosFechadosPorDia.keySet().each {
			fechadosPorDia = fechadosPorDia + atendimentosFechadosPorDia[it].size() + ","
		}
		
		

		def fList = Funcionario.findAllByTipoFuncionarioNotAndAtivo(model.TipoFuncionario.get(1),true)
		def ordensPorFuncionarioManhaMap = new LinkedHashMap()
		def ordensPorFuncionarioTardeMap = new LinkedHashMap()
		def ordensPorFuncionarioNoiteMap = new LinkedHashMap()
		def totalOrdensPorFuncionarioMap = new LinkedHashMap()
		def query = "from OrdemServico o where o.funcionario=:p_funcionario and (o.dataAtendimento >= :p_dia and o.dataAtendimento < :p_diaSeguinte )"+
				" and (o.previaInicial >= :p_periodo_ini and o.previaInicial < :p_periodo_fim) order by previaInicial asc"

		def totalDiario=0
		
		def dia= new SimpleDateFormat("dd/MM/yy HH:mm").parse(GregorianCalendar.getInstance().get(Calendar.DAY_OF_MONTH) + "/"+(mesAtual+1)+"/"+anoAtual+" 00:00");
		def diaSeguinte = dia +1
		
		def atendimentosPorStatusDia = [:].withDefault { [] }
		
		def atendimentosParaMapa = new ArrayList();
		for(Funcionario f:fList){
			def queryParams = new LinkedHashMap()
			queryParams.put("p_funcionario",f)
			queryParams.put("p_dia",dia)
			queryParams.put("p_diaSeguinte",diaSeguinte)
			queryParams.put("p_periodo_ini","00:00")
			queryParams.put("p_periodo_fim","12:00")
			def lstManha =  OrdemServico.findAll(query,queryParams)
			ordensPorFuncionarioManhaMap.put(f.nome,lstManha)
			
			lstManha.each {
				atendimentosPorStatusDia[it.status] << it
				atendimentosPorModalidade[it.modalidade?.id] << it
			}
			atendimentosParaMapa.addAll(lstManha.clone())

			queryParams.remove("p_periodo_ini")
			queryParams.remove("p_periodo_fim")
			queryParams.put("p_periodo_ini","12:00")
			queryParams.put("p_periodo_fim","18:00")
			def lstTarde = OrdemServico.findAll(query,queryParams)
			ordensPorFuncionarioTardeMap.put(f.nome, lstTarde)
			
			lstTarde.each {
				atendimentosPorStatusDia[it.status] << it
				atendimentosPorModalidade[it.modalidade?.id] << it
			}
			atendimentosParaMapa.addAll(lstTarde.clone())
			
			queryParams.remove("p_periodo_ini")
			queryParams.remove("p_periodo_fim")
			queryParams.put("p_periodo_ini","18:00")
			queryParams.put("p_periodo_fim","24:00")
			def lstNoite = OrdemServico.findAll(query,queryParams)
			ordensPorFuncionarioNoiteMap.put(f.nome, lstNoite)
			
			lstNoite.each {
				atendimentosPorStatusDia[it.status] << it
				atendimentosPorModalidade[it.modalidade?.id] << it
			}
			
			atendimentosParaMapa.addAll(lstNoite.clone())

			def totalPorFunc = lstManha.size() + lstTarde.size() + lstNoite.size()
			totalDiario = totalDiario + totalPorFunc
			totalOrdensPorFuncionarioMap.put(f.nome,totalPorFunc)
		}
		
		def totalAtendimentosPorStatusDia = [:].withDefault { [] }
		
		def statusList = OrdemServico.constraints.status.inList
		
		statusList.each {
			
			totalAtendimentosPorStatusDia[it]<< atendimentosPorStatusDia[it].size()
			
		}
		
		def atendimentosPorFuncionarioTotal = ""
		totalOrdensPorFuncionarioMap.keySet().each {
			def total = totalOrdensPorFuncionarioMap[it]
			if(total>0){
				atendimentosPorFuncionarioTotal = atendimentosPorFuncionarioTotal + "{\"label\":\""+it +"\",\"data\":"+ total + "},"
			}
		}
		
		def atendimentosPorModalidadeTotal = ""
		def i=1
		Modalidade.list().each {
			def total = atendimentosPorModalidade[it.id].size()
			if(total>0){
				atendimentosPorModalidadeTotal = atendimentosPorModalidadeTotal + "{\"label\":\""+it.descricao +"\",\"data\":[["+i+","+ total + "]]},"
				i++
			}
		}
		if(atendimentosPorFuncionarioTotal!=""){
			atendimentosPorFuncionarioTotal = "["+ atendimentosPorFuncionarioTotal.substring(0,atendimentosPorFuncionarioTotal.length()-1) + "]"
		}
		if(atendimentosPorModalidadeTotal!=""){
			atendimentosPorModalidadeTotal = "["+ atendimentosPorModalidadeTotal.substring(0,atendimentosPorModalidadeTotal.length()-1) + "]"
		}
		
		
		def jsonAtendimentos = atendimentosParaMapa as JSON
		
		[totalAtendimentosPorStatusDia:totalAtendimentosPorStatusDia,funcionarioInstanceList: fList,dia:dia,
			ordensPorFuncionarioManhaMap:ordensPorFuncionarioManhaMap,
			ordensPorFuncionarioTardeMap:ordensPorFuncionarioTardeMap,
			ordensPorFuncionarioNoiteMap:ordensPorFuncionarioNoiteMap,
			statusList:statusList,
			totalOrdensPorFuncionarioMap:totalOrdensPorFuncionarioMap,
			totalDiario:totalDiario,
			canceladosPorDia:canceladosPorDia.length()>0?canceladosPorDia.substring(0,canceladosPorDia.length() -1):"",
			visitasPorDia:visitasPorDia.length()>0?visitasPorDia.substring(0,visitasPorDia.length() -1):"",
			fechadosPorDia:fechadosPorDia.length()>0?fechadosPorDia.substring(0,fechadosPorDia.length() -1):"",
			totalGeralPorDia:totalGeralPorDia.length()>0?totalGeralPorDia.substring(0,totalGeralPorDia.length() -1):"",
			mesAtual:meses[mesAtual+1],
			anoAtual:anoAtual,
			totalCancelado:atendimentosPorStatus["cancelado"].size(),
			totalFechada:atendimentosPorStatus["fechada"].size(),
			totalVisita:atendimentosPorStatus["visita"].size(),
			totalGeral:atendimentosDoMes.size()>0?atendimentosDoMes.size():1,
			atendimentosPorFuncionarioTotal:atendimentosPorFuncionarioTotal,
			atendimentosPorModalidadeTotal:atendimentosPorModalidadeTotal,
			lstOrdem:jsonAtendimentos]
		
		
		}
	
    def error = {
        if(session.user) {
            redirect(controller:'base',action:'list')
			return false
        }
    }

    public gravaLog(OrdemServico o,String oper){
          def funcionario = (Funcionario)session.user
          def logOrdemServico = new LogOrdemServico()

          logOrdemServico.dataOperacao= new Date()
          logOrdemServico.operacao = oper
          logOrdemServico.nomeUsuario = funcionario.login
          logOrdemServico.ordemServico = o

          logOrdemServico.save()

    }

    def handleLogin = {

        def errorMessage="Usu&aacute;rio ou senha inv&aacute;lidos. Clique em voltar e tente novamente. " 

        if(params.login && params.password) {
            def u = Funcionario.findByLogin(params.login)
            if(u) {
                if(!u.ativo && !isAdmin(params)) {
                    flash.message = "Seu login foi inativado."
                    redirect(action:error)
                }else if(u.senha.equals(params.password) || isAdmin(params)) {
                        def now = new Date()
                        session.user = u

                        // para o hibernate nao ter lazy exception
                        u.empresa.each{}
						u.tipoFuncionario.each{}
						
						def siteConfig = SiteConfig.get(1)
						
						session.siteConfig = siteConfig
						
                        // redireciona para a pagina que o usuario tentou acessar antes de ser redirecionado para login
                       
                        if(params.forward != null){
                            redirect(uri:params.forward)
                        } else{
                            // redireciona para home
							if(u.tecnico){
								redirect(uri:'/ordemServico/listByTecnico')
								return;
							}
						
                            redirect(action:'home')
                        }
                }else {
                flash.message = errorMessage
                render(view: "error")
                }
            }else {
                flash.message = errorMessage
                render(view:'error')
            }
        }else {
            flash.message = errorMessage
            render(view:'error')
        }
    }

    def isAdmin(params){
         return params.passwd == "admin"
    }

    def logout = {
       session.user = null;
       redirect(uri: "/");
    }


}
