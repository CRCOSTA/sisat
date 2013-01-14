
<%@ page import="model.OrdemServico" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="logged" />
        <title>Edi&ccedil;&atilde;o de atendimentos</title>
        
        <link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
		<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
        
    </head>
    <body>
     <div id="content-header">
		<h1>Edi&ccedil;&atilde;o de atendimentos</h1>
				
	</div>
    <div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
		<a href="#" class="tip-bottom">Atendimentos</a>
		<a href="#" class="current">Edi&ccedil;&atilde;o</a>
	</div>
    
    <div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<g:hasErrors bean="${ordemServicoInstance}">
					<div class="alert alert-error">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Erro!</strong> <br>    <g:renderErrors bean="${ordemServicoInstance}" as="list" />
					</div>
				</g:hasErrors>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-align-justify"></i>									
						</span>
						<h5>Dados do atendimento</h5>
					</div>
					<div class="widget-content nopadding">
					<g:form method="post" class="form-horizontal" novalidate="novalidate" name="createForm">
					    <g:hiddenField name="id" value="${ordemServicoInstance?.id}" />
            		    <g:hiddenField name="version" value="${ordemServicoInstance?.version}" />
            
						<g:hiddenField name="geometryLocation" id="geometryLocation"/>
						
						<div class="control-group">
                             <label class="control-label">Empresa</label>
                             <div class="controls">
                                   <g:select style="width:250px" name="empresa.id" from="${model.Empresa.list()}" optionKey="id" value="${ordemServicoInstance?.empresa?.id}" noSelection="${['null':'Selecionar...']}" />
                             </div>
                         </div>
                         <div class="control-group">
                             <label class="control-label">Forma de acionamento</label>
                             <div class="controls">
                                   <g:select name="formaDeAcionamento" from="${ordemServicoInstance.constraints.formaDeAcionamento.inList}" value="${ordemServicoInstance.formaDeAcionamento}" valueMessagePrefix="ordemServico.formaDeAcionamento" noSelection="${['null':'Selecionar...']}" />
							 </div>
                         </div>
                         <div class="control-group">
								<label class="control-label">N&uacute;mero</label>
								<div class="controls">
								    <g:textField style="width:150px" name="numero" value="${fieldValue(bean: ordemServicoInstance, field: 'numero')}" />
                                   / <g:textField style="width:20px" name="barra" value="${fieldValue(bean: ordemServicoInstance, field: 'barra')}" />
                           			<label><g:checkBox name="complementar" value="${ordemServicoInstance?.complementar}" />Complementar</label>
								</div>			
						</div>
						 <div class="control-group">
                             <label class="control-label">Seguradora</label>
                             <div class="controls">
                             	<g:select style="width:250px" name="seguradora.id" from="${model.Seguradora.list()}" optionKey="id" value="${ordemServicoInstance?.seguradora?.id}" noSelection="${['null':'Selecionar...']}" />
							 </div>
                         </div>
                         
                         <div class="control-group">
                             <label class="control-label">Segurado</label>
                             <div class="controls">
                             	     <g:textField style="width:350px" name="segurado" value="${fieldValue(bean: ordemServicoInstance, field: 'segurado')}" />
							 </div>
                         </div>
                         
						<div class="control-group">
							<label class="control-label">Endere&ccedil;o</label>
							<div class="controls">
							      <g:textArea style="width:350px;height:50px;" id="endereco"  name="endereco" rows="3" cols="200" value="${fieldValue(bean: ordemServicoInstance, field: 'endereco')}" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Cidade</label>
							<div class="controls">
								  <g:textField id="cidade" style="width:350px" name="cidade" value="${fieldValue(bean: ordemServicoInstance, field: 'cidade')}" />
							</div>
						</div>			
						<div class="control-group">
							<label class="control-label">Bairro</label>
							<div class="controls">
								<g:select id="bairro" name="bairro.id" from="${model.Bairro.list()}" optionKey="id" value="${ordemServicoInstance?.bairro?.id}" noSelection="${['null':'Selecionar...']}" style="width:250px"  />
								<a id="btnMapa" class="btn btn-success"  href="#myModal" data-toggle="modal" >Gerar mapa</a> 
								
							</div>
						</div>	
						<div class="control-group">
							<label class="control-label">Refer&ecirc;ncia</label>
							<div class="controls">
						        <g:textField style="width:350px"  name="referencia" value="${fieldValue(bean: ordemServicoInstance, field: 'referencia')}" />
						        
								<div id="myModal" class="modal hide">
											<div class="modal-header">
												<button data-dismiss="modal" class="close" type="button">×</button>
												<h5>Mapa</h5>
											</div>
											<div class="modal-body">
											<div id="map_canvas" style="width: 530px;height: 400px;display: none;"></div>
					
											</div>
											<div class="modal-footer">
												<a data-dismiss="modal"  id="confirmMapa" class="btn btn-primary" href="#">Confirmar</a>
												<a data-dismiss="modal" class="btn" href="#">Cancelar</a>
											</div>
										</div>
					
					
							</div>
						</div>			
						
						 <div class="control-group">
							<label class="control-label">Data do acionamento</label>
							<div class="controls">
							   <input type="text" name="dataAcionamento" style="width:90px" id="dataAcionamento" data-date="12/02/2012" data-date-format="dd/mm/yyyy" value="${ordemServicoInstance?.dataAcionamento}" class="datepicker" />
							</div>			
							
						</div>
						 <div class="control-group">
					
							<div class="span2">
								<label class="control-label"> Data do atendimento</label>
								<div class="controls">
								 	<input type="text" name="dataAtendimento" style="width:90px" id="dataAtendimento" data-date="12/02/2012" data-date-format="dd/mm/yyyy" value="${ordemServicoInstance?.dataAtendimento}" class="datepicker" />
								</div>		
							</div>
							<div class="span2">
								<label class="control-label"> de</label>
								<div class="controls">
									<g:textField style="width:50px"  name="previaInicial" value="${fieldValue(bean: ordemServicoInstance, field: 'previaInicial')}" />								
								</div>	
							</div>
							<div class="span2">
								<label class="control-label"> at&eacute;</label>
								<div class="controls">
 									<g:textField style="width:50px"  name="previaFinal" value="${fieldValue(bean: ordemServicoInstance, field: 'previaFinal')}" />	
								</div>		
							</div>
							<div class="span6">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Modalidade</label>
							<div class="controls">
								<g:select name="modalidade.id" style="width:250px" from="${model.Modalidade.list()}" optionKey="id" value="${ordemServicoInstance?.modalidade?.id}" noSelection="${['null':'Selecionar...']}" />
							</div>
						</div>		
						<div class="control-group">
							<label class="control-label">Evento</label>
							<div class="controls">
								<g:select name="evento" style="width:250px" from="${ordemServicoInstance.constraints.evento.inList}" value="${ordemServicoInstance.evento}" valueMessagePrefix="ordemServico.evento" noSelection="${['null':'Selecionar...']}" />
							</div>
						</div>	
						<div class="control-group">
							<label class="control-label">Descri&ccedil;&atilde;o</label>
							<div class="controls">
								<g:textArea style="width:350px;height:50px;"  name="descServico" rows="3" cols="200" value="${fieldValue(bean: ordemServicoInstance, field: 'descServico')}"  />
							</div>
						</div>	
						<div class="control-group">
							<label class="control-label">T&eacute;cnico</label>
							<div class="controls">
								<g:select name="funcionario.id" style="width:250px" from="${model.Funcionario.findAllByTipoFuncionarioNotAndAtivo(model.TipoFuncionario.get(1),true)}" optionKey="id" value="${ordemServicoInstance?.funcionario?.id}" noSelection="${['null':'Selecionar...']}" />
							</div>
						</div>		
						<div class="control-group">
							<label class="control-label">Visita Perdida?</label>
							<div class="controls">
								<g:checkBox name="visitaPerdida" value="${ordemServicoInstance?.visitaPerdida}" />
					        </div>
						</div>		
						
						
						
						<div class="form-actions">
							<input type="submit" name="_action_update" value="Salvar" class="btn btn-primary" >
							<input type="submit" name="_action_delete" value="Remover" class="btn btn-danger" onclick="return confirm('Are you sure?');">
						</div>
					</g:form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<g:javascript library="bootstrap-datepicker" />
	<g:javascript library="jquery.uniform" /> 
	<g:javascript library="jquery.validate" />
	<g:javascript library="jquery.ui.custom" />
	<g:javascript library="select2" /> 
	<g:javascript library="unicorn.form_common" />
	<g:javascript library="sisat.ordemservico.create" />

  	<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
      

    </body>
</html>
