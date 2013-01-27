<div class="widget-box">
	<div class="widget-title">
		<span class="icon">
			<i class="icon-list-alt"></i>									
		</span>
		<h5>Hist&oacute;rico do atendimento</h5>
		<div class="buttons"><a href="#collapseHistorico${ordemServicoInstance.id}" data-toggle="collapse" id="collapseHist${ordemServicoInstance.id}"><i class="icon-plus"></i></a></div>
	</div>
	<div class="collapse" id="collapseHistorico${ordemServicoInstance.id}" >
		<div class="widget-content nopadding">
			<table class="table table-bordered table-striped" id="historicoPlace${ordemServicoInstance.id}">
			<thead>
			<tr>
				<th>
					 Data
				</th>
				<th>
					 Atendente
				</th>
				<th>
					 Hist&oacute;rico
				</th>
			</tr>
			</thead>
			
			<tbody>
			<g:each in="${ordemServicoInstance?.historicoAtendimento}" status="j" var="historico">
			
				<tr>
					<td>
						<g:formatDate date="${historico.dataHora}" format="dd/MM/yyyy hh:mm" />
					</td>
					<td>
						 ${historico.analistaUSS}
					</td>
					<td>
					     ${historico.historico}
					</td>
				</tr>
			</g:each>
			</tbody>
			</table>
		</div>
	</div>		
</div>	