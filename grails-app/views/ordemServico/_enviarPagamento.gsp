<div id="modalenviarPagamento" class="modal hide">
 
<form class="form-horizontal" name="myForm" id="enviarPagamento">              
	 
	<div class="modal-header">
		<button onclick="$('#modalenviarPagamento').hide();" class="close" type="button">×</button>
		<h5>Inclus&atilde;o em lote de pagamento</h5>
	</div>
	<div class="modal-body">
	  
           	<g:hiddenField name="id" id="enviarPagamentoId" />
           	<g:hiddenField name="status" value="aguardando pagamento"/>
           	
           					 <div class="control-group">
	                             <label class="control-label">Valor MDO</label>
	                             <div class="controls">
										<g:textField style="width:80px"  name="valorMDO"  />

	                             </div>
	                         </div>
           	 				 <div class="control-group">
	                             <label class="control-label">Valor material</label>
	                             <div class="controls">
										<g:textField style="width:80px"  name="valorMaterial"  />

	                             </div>
	                         </div>
           					 <div class="control-group">
	                             <label class="control-label">Valor deslocamento</label>
	                             <div class="controls">
										<g:textField style="width:80px"  name="valorDeslocamento"  />

	                             </div>
	                         </div>
           	
           	
							<div class="control-group">
	                             <label class="control-label">Data do Lote </label>
	                             <div class="controls">
									<div class="input-append date" id="datepickerDataLote" data-date-format="dd/mm/yyyy">
										<input type="text" name="dataPagmento" id="dataPagamento" class="span2" style="width:90px;" readonly />
									    <span class="add-on"><i class="icon-th"></i></span>
									</div>
									
	                             </div>
	                         </div>
	                         
	                        
	                       
	                        
           	
           	
    </div>
	<div class="modal-footer">
		<input type="button" class="btn btn-primary" value="Salvar" onclick="enviarPagamento();" />
		<input type="button" class="btn" onclick="$('#modalenviarPagamento').hide();" value="Fechar"/>
	</div>
</form>	
</div>