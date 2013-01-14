
<%@ page import="model.OrdemServico" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="logged" />
        <title>Pesquisa de Atendimentos</title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
		 <link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
		
    </head>
    <body>
       
    <div id="content-header">
		<h1>Pesquisa de atendimentos</h1>
				
	</div>
    <div id="breadcrumb">
			<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
			<a href="#" class="tip-bottom">Atendimentos</a>
			<a href="#" class="current">Pesquisa</a>
	</div>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
			
				<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-filter"></i>									
								</span>
								<h5>Campos para pesquisa</h5>
								<div class="buttons"><a href="#collapseFiltros" data-toggle="collapse" id="collapseFiltro"><i class="icon-minus"></i></a></div>
							</div>
							<div class="collapse in" id="collapseFiltros" >
								<div class="widget-content nopadding">
									 <g:form action="filtros" method="post" class="form-horizontal" >
										 <div class="control-group">
											<label class="control-label">N&uacute;mero do atendimento:</label>
											<div class="controls">
												 <g:textField style="width:250px"  name="numero" value="${session.numeroAtend}" />
											</div>
										</div>
										<div class="control-group">
											<label class="control-label">Funcion&aacute;rios</label>
											<div class="controls">
												 <g:select name="funcionario.id" from="${model.Funcionario.findAllByTipoFuncionarioNotAndAtivo(model.TipoFuncionario.get(1),true)}" optionKey="id" value="${session?.funcionarioId}" noSelection="${['null':'Selecionar...']}" style="width:260px" />
											</div>
										</div>
										<div class="control-group">
											<div class="span4">
												<label class="control-label">Data Inicio</label>
												<div class="controls">
	 												  
	 												  
	 												<div class="input-append date" id="datepickerInicio"  data-date="${session.dateIni}"  data-date-format="dd/mm/yyyy" >
	 													<input type="text"  id="inicio"  name="inicio" value="${session.dateIni}"  class="span2" style="width:90px;" readonly />
													    <span class="add-on"><i class="icon-th"></i></span>
													</div>
	 												  
												</div>			
											</div>	
											<div class="span4">
												<label class="control-label"> Data Fim</label>
												<div class="controls">
													<div class="input-append date" id="datepickerFinal" data-date="${session.dateFim}"  data-date-format="dd/mm/yyyy">
	 													<input type="text" name="final" id="final" class="span2" value="${session.dateFim}" style="width:90px;" readonly />
													    <span class="add-on"><i class="icon-th"></i></span>
													</div>
	 												  
												</div>			
											</div>	
											<div class="span4"></div>					
										</div>
										<div class="control-group">
											<label class="control-label">Acionamento</label>
											<div class="controls">
													  <g:select name="formaDeAcionamento" from="${ordemServicoInstance.constraints.formaDeAcionamento.inList}" value="${session.formaDeAcionamento}" valueMessagePrefix="ordemServico.formaDeAcionamento" noSelection="${['null':'Selecionar...']}" style="width:260px" />
											</div>
										</div>
									 	<div class="form-actions">
										 	<button type="submit" class="btn btn-primary" name="pesquisar" value="pesquisar"><i class="icon-search icon-white"></i> Pesquisar</button>
									 	</div>
									 </g:form>
								</div>
								
							</div>
				</div>
				
				<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-list-alt"></i>									
								</span>
								<h5>Lista de atendimentos</h5>
							</div>
							<div class="widget-content nopadding">
								<table class="table table-bordered data-table">
								<thead>
			                        <tr>
			                         	 <th>Status</th>
			                         	 
			                             <th>Número</th>
			
			                             <th>Prévia</th>
			
			                             <th>Modalidade</th>
			                        
				                   	     <th>Seguro</th>
				                   	    
				                   	     <th>Segurado</th>
				                        
			                             <th>Técnico</th>
			
			                             <th>Evento</th>
			                             
			                             
			                             <th></th>
								                        
			                        </tr>
			                    </thead>
			                    <tbody>
			                   
			                    <g:each in="${ordemServicoInstanceList}" status="i" var="ordemServicoInstance">
                   
				                    <tr class="gradeA">
									    <td class="taskStatus"><span id="status${ordemServicoInstance.id}" class="label label-${ordemServicoInstance.cssStatusColor}">${fieldValue(bean: ordemServicoInstance, field: "status")}</span></td>
			                            <td><g:link action="show" id="${ordemServicoInstance.id}">${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")}</g:link></td>
			                            <td><g:formatDate date="${ordemServicoInstance?.dataAtendimento}" format="dd/MM/yyyy" /> de ${fieldValue(bean: ordemServicoInstance, field: "previaInicial")} até ${fieldValue(bean: ordemServicoInstance, field: "previaFinal")}</td>
			                            <td>${fieldValue(bean: ordemServicoInstance, field: "modalidade")}</td>
			                            <td>${fieldValue(bean: ordemServicoInstance, field: "seguradora")}</td>
			                            <td>${fieldValue(bean: ordemServicoInstance, field: "segurado")} </td>
			                            <td id="nomefuncionario${ordemServicoInstance.id}">${fieldValue(bean: ordemServicoInstance, field: "funcionario")}</td>
			                            <td>1ª Visita
			                            
			                            	<div id="myModal${ordemServicoInstance.id}" class="modal hide">
												<div class="modal-header">
													<button data-dismiss="modal" class="close" type="button">×</button>
													<h5>Atendimento - ${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")} &nbsp;
													<span id="modalstatus${ordemServicoInstance.id}" class="label label-${ordemServicoInstance.cssStatusColor}">${fieldValue(bean: ordemServicoInstance, field: "status")}</span></h5>
												</div>
												<div class="modal-body">
												<h5>Endere&ccedil;o:</h5>
												<p>${fieldValue(bean: ordemServicoInstance, field: "endereco")}<br>
												${fieldValue(bean: ordemServicoInstance, field: "referencia")} <br>
												${fieldValue(bean: ordemServicoInstance, field: "cidade")} <br> 
												${fieldValue(bean: ordemServicoInstance, field: "bairro")}
												   <h5>Hist&oacute;rico:</h5>
												<span id="historicoPlace${ordemServicoInstance.id}">
												${ordemServicoInstance.historicos}
												</span>													

												</div>
												<div class="modal-footer">
													<g:if test="${!session?.user?.analista}">
														<div class="btn-group" style="width: auto;">
															
															<a href="#modalEncaminhar" id="encaminharBtn${ordemServicoInstance.id}"
															${(ordemServicoInstance.status=='aberta' || ordemServicoInstance.status=='com o tecnico')?"":"style='display:none;'"} 
															onclick="prepararFormEncaminhar('${ordemServicoInstance.id}')"  class="btn btn-primary btn-large tip-top" data-original-title="Encaminhar para o t&eacute;cnico"><i class="icon-user icon-white"></i></a>
															
															<a class="btn btn-primary btn-large tip-top" id="validarSenhaBtn${ordemServicoInstance.id}"
															${ordemServicoInstance.status=='com o tecnico'?"":"style='display:none;'"} 
															onclick="prepararFormValidarSenha('${ordemServicoInstance.id}');" 
															data-original-title="Validar senha"><i class="icon-lock icon-white"></i></a>
															
															<a onclick="prepararFormHistorico('${ordemServicoInstance.id}');"  
															class="btn btn-primary btn-large tip-top" data-original-title="Incluir hist&oacute;rico"><i class="icon-comment icon-white"></i></a>
															
															
															<g:if test="${ordemServicoInstance.status!='cancelado' && ordemServicoInstance.status!='aberta' && ordemServicoInstance.status!='com o tecnico'}">
																<a href='${request.contextPath}/ordemServico/fechamento/${ordemServicoInstance.id}' class="btn btn-primary btn-large tip-top" data-original-title="Finalizar atendimento"><i class="icon-ok icon-white"></i></a>
															</g:if>
															<g:if test="${ordemServicoInstance.status!='cancelado' && ordemServicoInstance.status!='aberta' && ordemServicoInstance.status!='com o tecnico'}">
																<a href='${request.contextPath}/imagem/create/${ordemServicoInstance.id}' class="btn btn-primary btn-large tip-top" data-original-title="Incluir fotos"><i class="icon-camera icon-white"></i></a>
															</g:if>
															<a class="btn btn-primary btn-large tip-top" data-original-title="Incluir material"><i class="icon-briefcase icon-white"></i></a>
															<g:if test="${session?.user?.admin}">
																<g:link action="edit" id="${ordemServicoInstance.id}" class="btn btn-primary btn-large tip-top" data-original-title="Editar"><i class="icon-edit icon-white"></i></g:link>
															</g:if>
															<g:if test="${!ordemServicoInstance?.recebida}">
																<a class="btn btn-primary btn-large tip-top" data-original-title="Recebimento de checklist"><i class="icon-inbox icon-white"></i></a>
															</g:if>
															<g:if test="${ordemServicoInstance?.fechada || ordemServicoInstance?.visitaPerdida}">
																<a class="btn btn-primary btn-large tip-top" data-original-title="Enviar para pagamento"><i class="icon-share icon-white"></i></a>
															</g:if>
															<g:if test="${ordemServicoInstance.status!='cancelado' && ordemServicoInstance.status!='fechada'}">
																<a class="btn btn-danger btn-large tip-top" data-original-title="Cancelar atendimento"><i class="icon-trash icon-white"></i></a>
															</g:if>
														</div>
													</g:if>
													</div>
											</div>
											
											
											
			                            </td>
			                         	<td class="taskStatus">
			                       		  	<a href="#myModal${ordemServicoInstance.id}" data-toggle="modal"  data-original-title="Histórico"><i class="icon-zoom-in"></i></a>
										</td>
										
			                        </tr>
			                    </g:each>
				                   <tfoot>
										<tr>
											<th colspan="7">
											Total de atendimentos 
											</th>
											<th colspan="2">${ordemServicoInstanceTotal}</th>
										</tr>
										</tfoot>
			                    </tbody>
								</table>
							</div>
				</div>
			
			
			</div>
		</div>
	</div>

             <g:javascript library="bootstrap-datepicker" />
             <g:javascript library="jquery.uniform" /> 
             <g:javascript library="jquery.ui.custom" />
             <g:javascript library="select2" /> 
             <g:javascript library="unicorn.form_common" />
             <g:javascript library="jquery.dataTables" />      
             <g:javascript library="unicorn.tables" />
  			 <g:javascript library="sisat.ordemservico.filtros" />
  			 
  			 
  			 
  			  <g:render template="encaminhar" />
  			  <g:render template="validarSenha"  />
  			  <g:render template="historicoAtendimento"/>
    </body>
</html>

