
<%@ page import="model.Funcionario"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Visualiza&ccedil;&atilde;o  de funcion&aacute;rio</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'sistat.atendimento.show.print.css')}" media="print" />

</head>
<body>

	<div id="content-header">
		<h1>Visualiza&ccedil;&atilde;o  de funcion&aacute;rio</h1>
		
		<div class="btn-group" style="width: auto;">
			<g:if test="${session?.user?.admin}">
				<g:link action="edit" id="${funcionarioInstance.id}" class="btn btn-large tip-bottom" data-original-title="Editar">
					<i class="icon-edit"></i>
				</g:link>
			</g:if>
			<a class="btn btn-large tip-bottom" data-original-title="Imprimir" data-toggle="modal" id='btnPrint' onclick="window.print();"><i class="icon-print"></i></a>
			
		</div>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">funcion&aacute;rio</a> <g:link action="list" class="tip-bottom">Pesquisa</g:link> <a href="#" class="current">Visualiza&ccedil;&atilde;o</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<g:if test="${flash.message}">
					<div class="alert alert-success">
						<button class="close" data-dismiss="alert">×</button>
						<strong>Sucesso!</strong> <br>
						<g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" />
					</div>
				</g:if>
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-align-justify"></i>
						</span>
						<h5>Dados do funcion&aacute;rio</h5>
					</div>
					<div class="widget-content nopadding">
						<g:form class="form-horizontal" >

							<div class="control-group">
								<label class="control-label atendimento-dados-label">ID: </label>
								<div class="atendimento-dados">
									${fieldValue(bean: funcionarioInstance, field: "id")}
								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Empresa: </label>
								<div class="atendimento-dados">
									<g:link controller="empresa" action="show" id="${funcionarioInstance?.empresa?.id}">
										${funcionarioInstance?.empresa?.encodeAsHTML()}
									</g:link>
								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Tipo funcion&aacute;rio: </label>
								<div class="atendimento-dados">
									<g:link controller="tipoFuncionario" action="show" id="${funcionarioInstance?.tipoFuncionario?.id}">
										${funcionarioInstance?.tipoFuncionario?.encodeAsHTML()}
									</g:link>
								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Nome: </label>
								<div class="atendimento-dados">
									${fieldValue(bean: funcionarioInstance, field: 'nome')}
								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Email: </label>
								<div class="atendimento-dados">
									${fieldValue(bean: funcionarioInstance, field: 'email')}
								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Telefone: </label>
								<div class="atendimento-dados">
									${fieldValue(bean: funcionarioInstance, field: 'telefone')}
								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Nextel: </label>
								<div class="atendimento-dados">
									${fieldValue(bean: funcionarioInstance, field: 'IDNextel')}
								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Celular: </label>
								<div class="atendimento-dados">
									${fieldValue(bean: funcionarioInstance, field: 'celular')}
								</div>
							</div>
							<div class="control-group">
								<label class="control-label atendimento-dados-label">Login: </label>
								<div class="atendimento-dados">
									${fieldValue(bean: funcionarioInstance, field: 'login')}
								</div>
							</div>


							<div class="control-group">
								<label class="control-label atendimento-dados-label">Ativo: </label>
								<div class="atendimento-dados">
									<g:formatBoolean boolean="${funcionarioInstance?.ativo}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label">Administrador: </label>
								<div class="atendimento-dados">
									<g:formatBoolean boolean="${funcionarioInstance?.admin}" />
								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor realizada:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorRealizada}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor realizada noturno:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorRealizadaNoite}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor realizada domingo:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorRealizadaDomingo}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor visita:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorVisita}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor visita noturna:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorVisitaNoite}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor visita domingo:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorVisitaDomingo}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor complementar:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorComplementar}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor complementar noturna:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorComplementarNoite}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor complementar domingo:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorComplementarDomingo}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor checkup:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorCheckup}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor checkup noturna:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorCheckupNoite}" type="currency" currencyCode="BRL" />

								</div>
							</div>

							<div class="control-group">
								<label class="control-label atendimento-dados-label"> Valor checkup domingo:</label>
								<div class="atendimento-dados">
									<g:formatNumber number="${funcionarioInstance?.valorCheckupDomingo}" type="currency" currencyCode="BRL" />

								</div>
							</div>


						</g:form>
					</div>
				</div>


			</div>
		</div>


	</div>

	<g:javascript library="jquery.uniform" />



</body>
</html>
