
<%@ page import="model.Empresa"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Pesquisa de tipos de funcion&aacute;rio</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Pesquisa de tipos de funcion&aacute;rio</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">tipos de funcion&aacute;rio</a> <a href="#" class="current">Pesquisa</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-list-alt"></i>
						</span>
						<h5>Lista de tipos de funcion&aacute;rios</h5>
					</div>
					<div class="widget-content nopadding">

						<table class="table table-bordered data-table">
							<thead>
								<tr>

									<th>ID</th>
									<th>Descri&ccedil;&atilde;o</th>

									<th></th>

								</tr>
							</thead>
							<tbody>
								<g:each in="${tipoFuncionarioInstanceList}" status="i" var="tipoFuncionarioInstance">
									<tr>

										<td>
											${fieldValue(bean: tipoFuncionarioInstance, field: "id")}
										</td>

										<td>
											${fieldValue(bean: tipoFuncionarioInstance, field: "descTipoFunc")}
										</td>

										<td class="taskStatus"><g:link action="show" id="${tipoFuncionarioInstance.id}" data-original-title="Dados do tipo de funcion&aacute;rio">
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
