<div id="modalHistorico" class="modal hide">
 
<form class="form-horizontal" name="myForm" id="historico">              
	 
	<div class="modal-header">
		<button onclick="$('#modalHistorico').hide();" class="close" type="button">×</button>
		<h5>Hist&oacute;rico</h5>
	</div>
	<div class="modal-body">
	
			<div id="errorHistorico" class="alert alert-error alert-block" style="display:none">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4 class="alert-heading">Erro!</h4>
				<span id="msgErrorHistorico"></span>
			</div>
	  
           	<g:hiddenField name="ordemServico.id" id="historicoId" />
           	<g:hiddenField name="cancelamento" value="false" />
           	
           	<div class="control-group">
				<label class="control-label">Analista:</label>
				<div class="controls">
    				<g:textField name="analistaUSS" value="" />
				</div>
			</div>	
           	<div class="control-group">
				<label class="control-label">Hist&oacute;rico</label>
				<div class="controls">
					<g:textArea name="historico" rows="5" cols="40"  />
				</div>
			</div>	

    </div>
	<div class="modal-footer">
		<input type="button" class="btn btn-primary" value="Salvar" onclick="server.gravarHistorico();" />
		<input type="button" class="btn" onclick="$('#modalHistorico').hide();" value="Fechar"/>
	</div>
</form>	
</div>