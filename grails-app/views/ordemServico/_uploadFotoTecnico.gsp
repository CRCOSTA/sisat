<div id="modaluploadfoto" class="modal hide">
	 <g:form action="save" controller="imagem" method="post" enctype="multipart/form-data">
	<div class="modal-header">
		<button data-dismiss="modal" class="close" type="button">×</button>
		<h5>Upload de Fotos</h5>
	</div>
	<div class="modal-body center">
	  
           	 
           	 <g:hiddenField name="id" value="${ordemServicoInstance?.id}" />
           	 <input type="file" name="foto1" placeholder="Foto 1"/>
           	  <input type="file" name="foto2" placeholder="Foto 2"/>
           	   <input type="file" name="foto3" placeholder="Foto 3"/>
           	    <input type="file" name="foto4" placeholder="Foto 4"/>
           	     <input type="file" name="foto5" placeholder="Foto 5"/>
           	 
				
    </div>
	<div class="modal-footer">
	<g:submitButton name="create" class="btn btn-primary" value="Salvar Fotos" />
		<input type="button"  class="btn" data-dismiss="modal"  onclick="$('#modaluploadfoto').hide();" value="Fechar"/>
	</div>
	</g:form>
</div>