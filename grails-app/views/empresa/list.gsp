
<%@ page import="model.Empresa"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Pesquisa de empresas</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'select2.css')}" />
<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Pesquisa de empresas</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Empresas</a> <a href="#" class="current">Pesquisa</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-list-alt"></i>
						</span>
						<h5>Lista de empresas</h5>
					</div>
					<div class="widget-content nopadding">

						<table class="table table-bordered data-table">
							<thead>
								<tr>

									<th>id</th>

									<th>Raz&atilde;o social</th>

									<th>CNPJ</th>

									<th>contato</th>

									<th>Endereco</th>

									<th>CEP</th>

									<th>Telefone-1</th>
									<th></th>

								</tr>
							</thead>
							<tbody>
								<g:each in="${empresaInstanceList}" status="i" var="empresaInstance">
									<tr>
										<td>
											${fieldValue(bean: empresaInstance, field: "id")}
										</td>

										<td>
											${fieldValue(bean: empresaInstance, field: "nome")}
										</td>

										<td>
											${fieldValue(bean: empresaInstance, field: "cnpj")}
										</td>

										<td>
											${fieldValue(bean: empresaInstance, field: "contato")}
										</td>

										<td>
											${fieldValue(bean: empresaInstance, field: "endereco")}
										</td>

										<td>
											${fieldValue(bean: empresaInstance, field: "cep")}
										</td>
										<td>
											${fieldValue(bean: empresaInstance, field: "telefone1")}
										</td>

										<td class="taskStatus"><g:link action="show" id="${empresaInstance.id}" data-original-title="Dados da empresa">
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
