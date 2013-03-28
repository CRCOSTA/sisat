<!DOCTYPE html>
<html>
    <head>
        <title>Sistema Integrado de Controle de Atendimentos - SISAT Web - <g:layoutTitle /></title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-responsive.min.css')}" media="screen"/>
        <link rel="stylesheet" href="${resource(dir:'css',file:'unicorn.main.css')}" />
		<link rel="stylesheet" href="${resource(dir:'css',file:'unicorn.grey.css')}" />
		
		
     
        
        <g:layoutHead />
       
    </head>
    <body>
    
        <div id="header">
			<h1>SISAT Web</h1>		
		</div>
		
		
    
    	<div id="user-nav" class="navbar navbar-inverse">
            <ul class="nav btn-group">
                  <li class="btn btn-inverse"><g:link action="logout" controller="base"><i class="icon icon-share-alt"></i> <span class="text">Efetuar logout</span></g:link></li>
            </ul>
        </div>
        
                  
		<div id="sidebar">
			<ul>
				<li class="submenu active open">
					<a href="#"><i class="icon icon-list-alt"></i> <span>Principal </span> </a>
					<ul>
						<li><g:link action="homePesquisa" controller="base">Pesquisar Atendimentos</g:link></li>
						<li><g:link action="editPassword" controller="funcionario" id="${session?.user?.id}">Alterar senha</g:link></li>
						<g:if test="${session?.user?.operador}">
							<li><g:link action="createShort" controller="ordemServico">Novo Atendimento</g:link></li>
						</g:if>
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