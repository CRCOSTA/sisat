<div id="modalValidar" class="modal hide">
 

 
 
<form class="form-horizontal" name="validarSenha" id="validarSenha">              
	 
	<div class="modal-header">
		<button onclick="$('#modalValidar').hide();" class="close" type="button">×</button>
		<h5>Validar senha</h5>
	</div>
	<div class="modal-body">
	  
           	<g:hiddenField name="id" id="validarSenhaId" />
           	<div class="control-group">
				<label class="control-label">Senha</label>
				<div class="controls">
				 	 <g:textField style="width:40px"  name="senha"  />
				</div>
			</div>	
    </div>
	<div class="modal-footer">
		<input type="button" class="btn btn-primary" value="Validar" onclick="window.validarSenha();" />
		<input type="button"  class="btn" onclick="$('#modalValidar').hide();" value="Fechar"/>
	</div>
</form>	
</div>