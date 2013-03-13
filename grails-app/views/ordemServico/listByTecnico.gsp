
<%@ page import="model.OrdemServico"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="tecnico" />
<title>Pesquisa de Atendimentos</title>
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />
<style>
.new-update .update-date-arrow {
	color: #BBBBBB;
	float: right;
	margin: 10px -2px 0 10px;
	text-align: center;
	width: 10px;
}
</style>

</head>
<body>

	<div id="content-header">
		<h1>Pesquisa de atendimentos</h1>

	</div>
	<div class="widget-content nopadding updates">
		<g:each in="${ordemServicoInstanceList}" status="i" var="ordemServicoInstance">

			<div class="new-update clearfix">
				<g:link action="showTecnico" id="${ordemServicoInstance.id} ">
					<div>
						<i class="icon-wrench"></i>
						<div class="update-done">
							<strong> ${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")}
							</strong> <span> ${ordemServicoInstance.bairro}
							</span>
						</div>
						<div class="update-date-arrow">
							<i class="icon-chevron-right"></i>
						</div>
						<div class="update-date">
							<span class="update-day"> ${fieldValue(bean: ordemServicoInstance, field: "previaInicial")}
							</span>
							<g:formatDate date="${ordemServicoInstance?.dataAtendimento}" format="dd/MM" />
						</div>
					</div>
				</g:link>
			</div>
		</g:each>
	</div>






</body>
</html>

