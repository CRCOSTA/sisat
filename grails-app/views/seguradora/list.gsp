
<%@ page import="model.Seguradora" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Pesquisa de seguradora</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Pesquisa de seguradoras</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Seguradoras</a> <a href="#" class="current">Pesquisa</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-list-alt"></i>
						</span>
						<h5>Lista de seguradoras</h5>
					</div>
					<div class="widget-content nopadding">

						<table class="table table-bordered data-table">
							<thead>
								<tr>

									<th>ID</th>
									<th>Nome</th>

									<th></th>

								</tr>
							</thead>
							<tbody>
								<g:each in="${seguradoraInstanceList}" status="i" var="seguradoraInstance">
									<tr>

										<td>
											${fieldValue(bean: seguradoraInstance, field: "id")}
										</td>

										<td>
											${fieldValue(bean: seguradoraInstance, field: "nome")}
										</td>

										<td class="taskStatus"><g:link action="show" id="${seguradoraInstance.id}" data-original-title="Dados da seguradora">
												<i class="icon-zoom-in"></i>
											</g:link></td>
									</tr>
								</g:each>

							</tbody>
						</table>

					</div>
				</div>


			</div>
		</div>


	</div>

	<g:javascript library="jquery.uniform" />
	<g:javascript library="jquery.dataTables" />
	<g:javascript library="unicorn.tables" />


</body>
</html>
