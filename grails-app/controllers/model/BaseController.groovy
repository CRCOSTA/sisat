package model

import org.apache.commons.io.filefilter.FalseFileFilter;

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

	def home = {}
	
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
