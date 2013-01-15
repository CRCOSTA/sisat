<div id="modalfechamento" class="modal hide">
 
<form class="form-horizontal" name="myForm" id="fechamento">              
	 
	<div class="modal-header">
		<button onclick="$('#modalfechamento').hide();" class="close" type="button">×</button>
		<h5>Fechamento do atendimento</h5>
	</div>
	<div class="modal-body">
	  
           	<g:hiddenField name="id" id="fechamentoId" />
           	
							<div class="control-group">
	                             <label class="control-label">Data/Hora Sa&iacute;da </label>
	                             <div class="controls">
									<div class="input-append date" id="datepickerSaida" data-date-format="dd/mm/yyyy">
										<input type="text" name="saida" id="saida" class="span2" style="width:90px;" readonly />
									    <span class="add-on"><i class="icon-th"></i></span>
									</div>
									<div class="input-append bootstrap-timepicker-component">
										<input type="text" name="horaSaida" id="horaSaida" class="input-small timepicker-default " style="width:50px;" readonly>
									    <span class="add-on">
									        <i class="icon-time"></i>
									    </span>
									</div>
	                             </div>
	                         </div>
	                         
	                         <div class="control-group">
	                             <label class="control-label">Avalia&ccedil;&atilde;o  </label>
	                             <div class="controls">
										<g:textArea style="width:320px;height:50px;"  name="avaliacao" rows="3" cols="150" />

	                             </div>
	                         </div>

	                         <div class="control-group">
	                             <label class="control-label"> Servi&ccedil;o executado </label>
	                             <div class="controls">
										 <g:textArea style="width:320px;height:50px;"  name="servicoExecutado" rows="3" cols="150" />
											
	                             </div>
	                         </div>

	                         <div class="control-group">
	                             <label class="control-label"> Diagn&oacute;tico </label>
	                             <div class="controls">
										 <g:textArea style="width:320px;height:50px;"  name="diagnostico" rows="3" cols="150"/>
										
	                             </div>
	                         </div>

	                         <div class="control-group">
	                             <label class="control-label">  Parecer T&eacute;cnico</label>
	                             <div class="controls">
      								<g:textArea style="width:320px;height:50px;"  name="parecer" rows="3" cols="150" />

	                             </div>
	                         </div>

	                         <div class="control-group">
	                             <label class="control-label"> Fotos? </label>
	                             <div class="controls">
									 <g:checkBox name="fotos"/><span>Visita perdida?</span> <g:checkBox name="visitaPerdida" />
	                             </div>
	                         </div>
	                         
	                        
           	
           	
    </div>
	<div class="modal-footer">
		<input type="button" class="btn btn-primary" value="fechamento" onclick="fecharAtendimento();" />
		<input type="button" class="btn" onclick="$('#modalfechamento').hide();" value="Fechar"/>
	</div>
</form>	
</div>