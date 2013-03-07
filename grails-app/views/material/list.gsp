
<%@ page import="model.Material"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="logged" />
<title>Pesquisa de material</title>

<link rel="stylesheet" href="${resource(dir:'css',file:'uniform.css')}" />

</head>
<body>

	<div id="content-header">
		<h1>Pesquisa de material</h1>

	</div>
	<div id="breadcrumb">
		<a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Material</a> <a href="#" class="current">Pesquisa</a>
	</div>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">

				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-list-alt"></i>
						</span>
						<h5>Lista de material</h5>
					</div>
					<div class="widget-content nopadding">

						<table class="table table-bordered data-table">
							<thead>
								<tr>


									<th>ID</th>

									<th>Descricao</th>

									<th>Marca</th>

									<th>Valor de Compra</th>

									<th>Valor de Venda</th>

									<th>Estoque M&iacute;nimo</th>

									<th>Estoque Atual</th>


									<th></th>

								</tr>
							</thead>
							<tbody>
								<g:each in="${materialInstanceList}" status="i" var="materialInstance">
									<tr class="${materialInstance.estoqueAtual < materialInstance.estoqueMinimo?'datatable-estoque-minimo':''}">

										<td>
											${fieldValue(bean: materialInstance, field: "id")}
										</td>

										<td>
											${fieldValue(bean: materialInstance, field: "descricao")}
										</td>

										<td>
											${fieldValue(bean: materialInstance, field: "marca")}
										</td>

										<td style="text-align:right;">
											<g:formatNumber number="${materialInstance?.valorCompra}" type="currency" currencyCode="BRL" />
										</td>

										<td style="text-align:right;">
											<g:formatNumber number="${materialInstance?.valorVenda}" type="currency" currencyCode="BRL" />
										</td>

										<td style="text-align:right;">
											${fieldValue(bean: materialInstance, field: "estoqueMinimo")}
										</td>

										<td style="text-align:right;">
											${fieldValue(bean: materialInstance, field: "estoqueAtual")}
										</td>

										<td class="taskStatus">
										<g:link action="show" id="${materialInstance.id}" data-original-title="Dados do material">
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
