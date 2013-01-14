
<%@ page import="model.OrdemServico" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="logged" />
        <title>Fechamento</title>
        
        <link rel="stylesheet" href="${resource(dir:'css',file:'datepicker.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'timepicker.css')}" />
		<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
        
    </head>
    <body>
     <div id="content-header">
		<h1>Fechamento</h1>
				
	</div>
    <div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
		<a href="#" class="tip-bottom">Atendimentos</a>
		<a href="#" class="tip-bottom">Pesquisar</a>
		<a href="#" class="current">Fechamento</a>
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
    			        <g:form  action="fecharAtendimento" method="post" class="form-horizontal" novalidate="novalidate" enctype="multipart/form-data">
	              			 <g:hiddenField name="id" value="${ordemServicoInstance?.id}" />
	              			 <div class="control-group">
	                             <label class="control-label">N&uacute;mero</label>
	                             <div class="controls">
	                                  ${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")}
	                             </div>
	                         </div>
	                          <div class="control-group">
	                             <label class="control-label">Seguradora </label>
	                             <div class="controls">
									  ${ordemServicoInstance?.seguradora?.encodeAsHTML()}
	                             </div>
	                         </div>
							<div class="control-group">
	                             <label class="control-label">Data atendimento </label>
	                             <div class="controls">
									 <g:formatDate date="${ordemServicoInstance?.dataAtendimento}" format="dd/MM/yyyy" /> de: ${ordemServicoInstance?.previaInicial} até: ${ordemServicoInstance?.previaFinal}
	                             </div>
	                         </div>
							<div class="control-group">
	                             <label class="control-label">Modalidade </label>
	                             <div class="controls">
									 ${fieldValue(bean: ordemServicoInstance, field: "modalidade")}
	                             </div>
	                         </div>
							<div class="control-group">
	                             <label class="control-label">Descri&ccedil;&atilde;o do servi&ccedil;o </label>
	                             <div class="controls">
									${ordemServicoInstance?.descServico?.encodeAsHTML()}
	                             </div>
	                         </div>
							<div class="control-group">
	                             <label class="control-label">Data Hora Chegada </label>
	                             <div class="controls">
									<g:formatDate date="${ordemServicoInstance?.chegada}" format="dd/MM/yyyy hh:mm" />
	                             </div>
	                         </div>
							<div class="control-group">
	                             <label class="control-label">Data/Hora Sa&iacute;da </label>
	                             <div class="controls">
									<div class="input-append date" id="datepickerSaida" data-date-format="dd/mm/yyyy">
										<input type="text" name="saida" id="saida" class="span2" style="width:90px;" readonly />
									    <span class="add-on"><i class="icon-th"></i></span>
									</div>
									<div class="input-append bootstrap-timepicker-component">
										<input type="text" name="horaSaida" id="horaSaida" class="input-small timepicker-default " style="width:50px;" readonly>
									    <span class="add-on">
									        <i class="icon-time"></i>
									    </span>
									</div>
	                             </div>
	                         </div>
	                         
	                         <div class="control-group">
	                             <label class="control-label">Avalia&ccedil;&atilde;o  </label>
	                             <div class="controls">
										<g:textArea style="width:350px;height:50px;"  name="avaliacao" rows="3" cols="200" value="${fieldValue(bean: ordemServicoInstance, field: 'avaliacao')}"  />

	                             </div>
	                         </div>

	                         <div class="control-group">
	                             <label class="control-label"> Servi&ccedil;o executado </label>
	                             <div class="controls">
										 <g:textArea style="width:350px;height:50px;"  name="servicoExecutado" rows="3" cols="200" value="${fieldValue(bean: ordemServicoInstance, field: 'servicoExecutado')}"  />
											
	                             </div>
	                         </div>

	                         <div class="control-group">
	                             <label class="control-label"> Diagn&oacute;tico </label>
	                             <div class="controls">
										 <g:textArea style="width:350px;height:50px;"  name="diagnostico" rows="3" cols="200" value="${fieldValue(bean: ordemServicoInstance, field: 'diagnostico')}"  />
										
	                             </div>
	                         </div>

	                         <div class="control-group">
	                             <label class="control-label">  Parecer T&eacute;cnico</label>
	                             <div class="controls">
      								<g:textArea style="width:350px;height:50px;"  name="parecer" rows="3" cols="200" value="${fieldValue(bean: ordemServicoInstance, field: 'parecer')}"  />

	                             </div>
	                         </div>

	                         <div class="control-group">
	                             <label class="control-label"> Fotos? </label>
	                             <div class="controls">
									 <g:checkBox name="fotos" value="${ordemServicoInstance?.fotos}" />
	                             </div>
	                         </div>
	                         
	                         <div class="control-group">
	                             <label class="control-label"> Visita perdida? </label>
	                             <div class="controls">
									 <g:checkBox name="visitaPerdida" value="${ordemServicoInstance?.visitaPerdida}" />
	                             </div>
	                         </div>
	                         
	                         <div class="control-group">
	                             <label class="control-label"> Check list </label>
	                             <div class="controls">
									 <input type="file" name="checklist"/>
	                             </div>
	                         </div>
	                         <div class="form-actions">
								<input type="submit" value="Fechar Atendimento" id="create" class="btn btn-primary">
							</div>
	                         </g:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<g:javascript library="bootstrap-datepicker" />
	<g:javascript library="locales/bootstrap-datepicker.pt-BR" />
	<g:javascript library="bootstrap-timepicker" />
	<g:javascript library="jquery.uniform" /> 
	<g:javascript library="jquery.validate" />
	<g:javascript library="jquery.ui.custom" />
	<g:javascript library="select2" /> 
	<g:javascript library="unicorn.form_common" />
	<g:javascript library="sisat.ordemservico.fechamento" />
    </body>
</html>
