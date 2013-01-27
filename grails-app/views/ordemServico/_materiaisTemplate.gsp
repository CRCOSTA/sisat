<div class="widget-box">
	<div class="widget-title">
		<span class="icon">
			<i class="icon-briefcase"></i>									
		</span>
		<h5>Materiais</h5>
		<div class="buttons"><a href="#collapseMateriais${ordemServicoInstance.id}" data-toggle="collapse" id="collapseMat${ordemServicoInstance.id}"><i class="icon-plus"></i></a></div>
	</div>
	<div class="collapse" id="collapseMateriais${ordemServicoInstance.id}" >
		<div class="widget-content nopadding">
			<table class="table table-bordered" id="materiais${ordemServicoInstance.id}">
			<thead>
			<tr>
				<th>
					 
				</th>
				<th>
					 Descri&ccedil;&otilde;o
				</th>
				<th>
					 Quantidade
				</th>
			</tr>
			</thead>
			
			<tbody>
			<g:each in="${ordemServicoInstance?.materiais}" status="j" var="material">
			
				<tr>
					<td>
						${material.descricao}
					</td>
					<td>
						 ${material.material.descricao}
					</td>
					<td>
							${material.quantidade*(-1)}
						</td>
				</tr>
			</g:each>
			</tbody>
			</table>
		</div>
	</div>		
</div>	