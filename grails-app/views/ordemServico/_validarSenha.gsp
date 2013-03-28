<div id="modalValidar" class="modal hide">
 

 
 
<form class="form-horizontal" name="validarSenha" id="validarSenha">              
	 
	<div class="modal-header">
		<button onclick="$('#modalValidar').hide();" data-dismiss="modal" class="close" type="button">×</button>
		<h5>Validar senha</h5>
	</div>
	<div class="modal-body">
			<div id="errorValidar" class="alert alert-error alert-block" style="display:none">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4 class="alert-heading">Erro!</h4>
				<span id="msgErrorValidar"></span>
			</div>
	  
           	<g:hiddenField name="id" id="validarSenhaId" />
           	<div class="control-group">
				<label class="control-label">Senha</label>
				<div class="controls">
				 	 <g:textField style="width:40px"  name="senha"  />
				</div>
			</div>	
    </div>
	<div class="modal-footer">
		<input type="button" class="btn btn-primary" value="Validar" onclick="server.validarSenha();" />
		<input type="button"  class="btn" data-dismiss="modal" onclick="$('#modalValidar').modal('hide');" value="Fechar"/>
	</div>
</form>	
</div>