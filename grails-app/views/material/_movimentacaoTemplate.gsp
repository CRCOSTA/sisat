<div class="widget-box">
	<div class="widget-title">
		<span class="icon"> <i class="icon-list-alt"></i>
		</span>
		<h5>Movimenta&ccedil;&atilde;o de material</h5>

	</div>
	<div class="widget-content nopadding">
		<table class="table table-bordered table-striped data-table" id="movMaterialPlace">
			<thead>
				<tr>
					<th>ID</th>
					<th>Descri&ccedil;&atilde;o</th>
					<th>Quantidade</th>
					<th>Atendimento</th>
					<th>Tipo</th>
					<th>Material</th>
					<th>Data</th>
					<th></th>
				</tr>
			</thead>

			<tbody>
				<g:each in="${materialInstance?.movimentos}" status="j" var="movimentacaoDeMaterialInstance">

					<tr>
						<td style="text-align: right;">
							${movimentacaoDeMaterialInstance.id}
						</td>
						<td>
							${movimentacaoDeMaterialInstance.descricao}
						</td>
						<td style="text-align: right;">
							${movimentacaoDeMaterialInstance.quantidade}
						</td>
						<td><g:link controller="ordemServico" action="show" id="${movimentacaoDeMaterialInstance.ordemServico?.id}" data-original-title="Dados do atendimento">
								${movimentacaoDeMaterialInstance.ordemServico?.numero}/${movimentacaoDeMaterialInstance.ordemServico?.barra}
							</g:link></td>

						<td>
							${movimentacaoDeMaterialInstance.tipo}
						</td>

						<td><g:link controller="material" action="show" id="${movimentacaoDeMaterialInstance?.material?.id}" data-original-title="Dados do material">
								${movimentacaoDeMaterialInstance?.material?.descricao}
							</g:link></td>

						<td style="text-align: center;"><g:formatDate date="${movimentacaoDeMaterialInstance?.dataMovimentacao}" format="dd/MM/yyyy hh:mm" /></td>
						<td class="taskStatus"><g:link action="show" id="${movimentacaoDeMaterialInstance.id}" data-original-title="Dados da movimenta&ccedil;&atilde;o material">
								<i class="icon-zoom-in"></i>
							</g:link></td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</div>
</div>
