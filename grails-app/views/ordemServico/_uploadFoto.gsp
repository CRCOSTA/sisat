<div id="modaluploadfoto" class="modal hide">
	 
	<div class="modal-header">
		<button onclick="$('#modaluploadfoto').hide();" class="close" type="button">×</button>
		<h5>Upload de Fotos</h5>
	</div>
	<div class="modal-body center">
	  
           	<g:hiddenField name="id" id="uploadFotoId" />
           	
			<input type="file" name="foto1" id="fotoFile"/>
				
    </div>
	<div class="modal-footer">
		<input type="button"  class="btn" onclick="$('#modaluploadfoto').hide();" value="Fechar"/>
	</div>
</div>