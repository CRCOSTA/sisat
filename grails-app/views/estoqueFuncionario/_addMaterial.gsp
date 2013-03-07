<div id="modalmaterialadd" class="modal hide">

	<form class="form-horizontal" name="materialForm" id="materialForm">

		<div class="modal-header">
			<button data-dismiss="modal" class="close" type="button">×</button>
			<h5>Adicionar material</h5>
		</div>
		<div class="modal-body">
			<g:hiddenField name="funcionario.id" id="funcionarioid" />
			<div id="alertSuccessMaterial" class="alert alert-success alert-block" style="display: none">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4 class="alert-heading">Sucesso!</h4>
				<span>Material incluido com sucesso.</span>
			</div>
			<div id="errorMaterial" class="alert alert-error alert-block" style="display: none">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4 class="alert-heading">Erro!</h4>
				<span>Erro ao incluir material na lista.</span>
			</div>
			<div class="control-group">
				<label class="control-label">Data da inclus&atilde;o </label>
				<div class="controls">
					<div class="input-append date" id="datepickerDataInclusao" data-date-format="dd/mm/yyyy">
						<input type="text" name="dataInclusao" id="dataInclusao" class="span2" style="width: 90px;" readonly /> <span class="add-on"><i class="icon-th"></i></span>
					</div>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Material</label>
				<div class="controls">
					<g:select name="material.id" id="materialId" style="width:300px" from="${model.Material.list()}" optionKey="id" value="${estoqueFuncionarioInstance?.material?.id}" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Quantidade</label>
				<div class="controls">
					<g:textField style="width:40px" name="qtd" id="qtd" placeholder="Qtd" />
				</div>
			</div>

		</div>
		<div class="modal-footer">
			<button type="button" onclick="server.addMaterialNoEstoque();" class="btn btn-success" data-original-title="Adicionar material">
				<i class="icon-plus icon-white"></i>&nbsp;Adicionar
			</button>
			<input type="button" class="btn" data-dismiss="modal" value="Fechar" />
		</div>
	</form>
</div>