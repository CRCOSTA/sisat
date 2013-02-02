<div id="modalEncaminhar" class="modal hide">
 
<form class="form-horizontal" name="myForm" id="encaminhar">              
	 
	<div class="modal-header">
		<button onclick="$('#modalEncaminhar').hide();" class="close" type="button">×</button>
		<h5>Encaminhar atendimento</h5>
	</div>
	<div class="modal-body">
	  		<div id="errorEncaminhar" class="alert alert-error alert-block" style="display:none">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4 class="alert-heading">Erro!</h4>
				<span id="msgErrorEncaminhar"></span>
			</div>
												
           	<g:hiddenField name="id" id="encaminharId" />
           	<div class="control-group">
				<label class="control-label">Funcion&aacute;rio</label>
				<div class="controls">
				 	<g:select name="funcionario.id" id="funcionario" from="${model.Funcionario.findAllByTipoFuncionarioNotAndAtivo(model.TipoFuncionario.get(1),true)}" optionKey="id"  noSelection="${['null':'Selecionar...']}"  style="width:260px;z-index:100000;"  />
				</div>
			</div>	
    </div>
	<div class="modal-footer">
		<input type="button" class="btn btn-primary" value="Encaminhar" onclick="server.encaminharParaTecnico();" />
		<input type="button" class="btn" onclick="$('#modalEncaminhar').hide();" value="Fechar"/>
	</div>
</form>	
</div>