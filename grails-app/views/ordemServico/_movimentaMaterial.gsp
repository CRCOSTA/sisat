<div id="modalmaterial" class="modal hide">
 

 
 
<form class="form-horizontal" name="materialForm" id="materialForm">              
	 
	<div class="modal-header">
		<button onclick="$('#modalmaterial').hide();" class="close" type="button">×</button>
		<h5>Adicionar material</h5>
	</div>
	<div class="modal-body">
			<div id="errorMaterial" class="alert alert-error alert-block" style="display:none">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4 class="alert-heading">Erro!</h4>
				<span id="msgErrorMaterial"></span>
			</div>
			<g:hiddenField  name="ordemServico.id" id="idAtend"  value="${ordemServicoInstance?.id}" />
            <g:hiddenField  name="funcionario.id" id="idFunc"  value="${ordemServicoInstance?.funcionario?.id}" />
            <g:hiddenField name="material.id" id="idMat" />
			 <input type="hidden"  name="listMaterial.id" id="selectMaterial"  style="width:400px"/>
			
	    	<g:textField style="width:40px"  name="quantidade"  id="quantidade" placeholder="Qtd" />
	    	
	    	<button type="button" onclick="server.addMaterial($('#idAtend').val());" class="btn btn-success" data-original-title="Adicionar material"><i class="icon-plus icon-white"></i></button>
			
 				
    </div>
	<div class="modal-footer">
		<input type="button"  class="btn" onclick="$('#modalmaterial').hide();" value="Fechar"/>
	</div>
</form>	
</div>