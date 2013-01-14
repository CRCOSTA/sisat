<!DOCTYPE html>
<html>
    <head>
        <title>Sistema Integrado de Constrole de Atendimentos - SICA WEB - <g:layoutTitle /></title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-responsive.min.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'unicorn.main.css')}" />
		<link rel="stylesheet" href="${resource(dir:'css',file:'unicorn.grey.css')}" />
		
		
     
        
        <g:layoutHead />
       
    </head>
    <body>
    
        <div id="header">
			<h1>SICA WEB</h1>		
		</div>
		
		<div id="search">
			<input type="text" placeholder="N&uacute;mero do Atendimento..."/><button type="submit" class="tip-right" title="Buscar"><i class="icon-search icon-white"></i></button>
		</div>
    
    	<div id="user-nav" class="navbar navbar-inverse">
            <ul class="nav btn-group">
                  <li class="btn btn-inverse"><g:link action="logout" controller="base"><i class="icon icon-share-alt"></i> <span class="text">Efetuar logout</span></g:link></li>
            </ul>
        </div>
        
                  
		<div id="sidebar">
			<ul>
				<li class="active"><a href="#"><i class="icon icon-home"></i> <span>Principal</span></a></li>
				<li class="submenu">
					<a href="#"><i class="icon icon-list-alt"></i> <span>Atendimentos</span> </a>
					<ul>
						<li><g:link action="filtros" controller="ordemServico">Pesquisar Atendimentos</g:link></li>
						<li><g:link action="create" controller="ordemServico">Novo Atendimento</g:link></li>
						<li><g:link action="ordemServico" controller="lotePagamento">Lotes de Pagamento</g:link></li>
					</ul>
				</li>
				<li class="submenu">
					<a href="#"><i class="icon icon-briefcase"></i> <span>Material</span> </a>
					<ul>
						<li><g:link action="material" controller="list">Pesquisar Material</g:link></li>
						<li><g:link action="material" controller="create">Novo Material</g:link></li>
						<li><g:link action="estoqueFuncionario" controller="list">Estoque do funcion&aacute;rio</g:link></li>
						<li><g:link action="movimentacaoDeMaterial" controller="create">Movimenta&ccedil;&atilde;o</g:link></li>
					</ul>
				</li>
				<li class="submenu">
					<a href="#"><i class="icon icon-briefcase"></i> <span>Empresa</span> </a>
					<ul>
						<li><g:link action="empresa" controller="list">Pesquisar Empresa</g:link></li>
						<li><g:link action="empresa" controller="create">Nova Empresa</g:link></li>
					</ul>
				</li>
				<li class="submenu">
					<a href="#"><i class="icon icon-briefcase"></i> <span>Seguradora</span> </a>
					<ul>
						<li><g:link action="seguradora" controller="list">Pesquisar Seguradora</g:link></li>
						<li><g:link action="seguradora" controller="create">Nova Seguradora</g:link></li>
					</ul>
				</li>
				<li class="submenu">
					<a href="#"><i class="icon icon-user"></i> <span>Funcion&aacute;rio</span> </a>
					<ul>
						<li><g:link action="funcionario" controller="list">Pesquisar Funcion&aacute;rio</g:link></li>
						<li><g:link action="funcionario" controller="create">Novo Funcion&aacute;rio</g:link></li>
						<li><g:link action="tipoFuncionario" controller="list">Pesquisar Tipo de Funcion&aacute;rio</g:link></li>
						<li><g:link action="tipoFuncionario" controller="create">Novo Tipo de Funcion&aacute;rio</g:link></li>
					</ul>
				</li>
				
				<li class="submenu">
					<a href="#"><i class="icon icon-user"></i> <span>Localiza&ccedil;&atilde;o</span> </a>
					<ul>
						<li><g:link action="bairro" controller="list">Bairro</g:link></li>
						<li><g:link action="bairro" controller="list">Cidade</g:link></li>
						<li><g:link action="bairro" controller="list">Estado</g:link></li>
						
					</ul>
				</li>
				
				<li class="submenu">
					<a href="#"><i class="icon icon-user"></i> <span>Relat&oacute;rios</span> </a>
					<ul>
						<li><g:link action="planilha" controller="relatorio">Planilha de Atendimentos</g:link> </li>
						<li><g:link action="mapa" controller="relatorio">Mapa de Atendimentos</g:link></li>
						<li><g:link action="totalAtendimentos" controller="relatorio">Total geral</g:link></li>
						<li><g:link action="totalAtendimentosPorModalidade" controller="relatorio">Total por Modalidade</g:link></li>
						<li><g:link action="totalPorFuncionario" controller="relatorio">Total por Funcionário</g:link></li>
						<li><g:link action="totalAtendimentosPorBairro" controller="relatorio">Total por Bairro</g:link></li>
						
					</ul>
				</li>
				
			</ul>
		
		</div>
		
	    <g:javascript library="jquery.min" />
        <g:javascript library="bootstrap" />  
        <g:javascript library="unicorn" />   
        
           
    	<div id="content">
    
        	<g:layoutBody />
        </div>
        
           
        <g:javascript library="sisat" />   
       
    </body>
</html>