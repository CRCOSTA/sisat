<div id="myModal${ordemServicoInstance.id}" class="modal hide">
	<div class="modal-header">
		<button data-dismiss="modal" class="close" type="button">×</button>
		<h5>
			Atendimento -
			${fieldValue(bean: ordemServicoInstance, field: "numero")}/${fieldValue(bean: ordemServicoInstance, field: "barra")}
			&nbsp; <span id="modalstatus${ordemServicoInstance.id}" class="label label-${ordemServicoInstance.cssStatusColor}"> ${fieldValue(bean: ordemServicoInstance, field: "status")}
			</span>
		</h5>
	</div>
	<div class="modal-body">


		<div id="alertSuccess${ordemServicoInstance.id}" class="alert alert-success alert-block" style="display: none">
			<a class="close" data-dismiss="alert" href="#">×</a>
			<h4 class="alert-heading">Sucesso!</h4>
			<span id="msgTxt${ordemServicoInstance.id}"></span>
		</div>


		<p>
			<strong>Endere&ccedil;o:</strong>&nbsp;${fieldValue(bean: ordemServicoInstance, field: "endereco")}
		</p>
		<p>
			<strong>Refer&ecirc;ncia:</strong>&nbsp;${fieldValue(bean: ordemServicoInstance, field: "referencia")}
		</p>
		<p>
			<strong>Cidade:</strong>&nbsp;${fieldValue(bean: ordemServicoInstance, field: "cidade")}
		</p>
		<p>
			<strong>Bairro:</strong>&nbsp;${fieldValue(bean: ordemServicoInstance, field: "bairro")}
		</p>


		<g:render template="/ordemServico/historicosTemplate" bean="${ordemServicoInstance}" var="ordemServicoInstance" />

		<g:render template="/ordemServico/materiaisTemplate" bean="${ordemServicoInstance}" var="ordemServicoInstance" />


	</div>
	<div class="modal-footer">
		<g:if test="${!session?.user?.analista}">
			<div class="btn-group" style="width: auto;" id="actionGroup${ordemServicoInstance.id}">

				<button id="encaminharBtn${ordemServicoInstance.id}" onclick="prepararFormEncaminhar('${ordemServicoInstance.id}')" class="btn btn-primary btn-large tip-top aberta com_o_tecnico"
					data-original-title="Encaminhar para o t&eacute;cnico">
					<i class="icon-user icon-white"></i>
				</button>

				<button class="btn btn-primary btn-large tip-top aberta com_o_tecnico" id="validarSenhaBtn${ordemServicoInstance.id}" onclick="prepararFormValidarSenha('${ordemServicoInstance.id}');"
					data-original-title="Validar senha">
					<i class="icon-lock icon-white"></i>
				</button>

				<button onclick="prepararFormHistorico('${ordemServicoInstance.id}');" class="btn btn-primary btn-large tip-top aberta com_o_tecnico senha_validada fechada aguardando_pagamento visita_perdida"
					data-original-title="Incluir hist&oacute;rico">
					<i class="icon-comment icon-white"></i>
				</button>

				<button onclick="prepararFormUploadFoto('${ordemServicoInstance.id}');" class="btn btn-primary btn-large tip-top senha_validada fechada aguardando_pagamento visita_perdida"
					data-original-title="Incluir fotos">
					<i class="icon-camera icon-white"></i>
				</button>

				<button onclick="server.prepararFormMaterial('${ordemServicoInstance.id}');" class="btn btn-primary btn-large tip-top aberta com_o_tecnico senha_validada fechada"
					data-original-title="Incluir material">
					<i class="icon-briefcase icon-white"></i>
				</button>

				<button onclick="server.receberOrdem('${ordemServicoInstance.id}');" class="btn btn-primary btn-large tip-top fechada" data-original-title="Recebimento de checklist">
					<i class="icon-inbox icon-white"></i>
				</button>

				<button onclick="prepararFormEnviarPagamento('${ordemServicoInstance.id}');" class="btn btn-primary btn-large tip-top fechada visita_perdida" data-original-title="Enviar para pagamento">
					<i class="icon-share icon-white"></i>
				</button>

				<button onclick="prepararFormFechamento('${ordemServicoInstance.id}');" class="btn btn-primary btn-large tip-top senha_validada" data-original-title="Finalizar atendimento">
					<i class="icon-ok icon-white"></i>
				</button>

				<g:if test="${session?.user?.admin}">
					<g:link controller="ordemServico" action="edit" id="${ordemServicoInstance.id}" class="btn btn-primary btn-large tip-top" data-original-title="Editar">
						<i class="icon-edit icon-white"></i>
					</g:link>
				</g:if>


			</div>
		</g:if>
	</div>
</div>