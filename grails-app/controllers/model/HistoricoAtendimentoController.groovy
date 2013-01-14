package model

import java.text.DateFormat
import java.text.SimpleDateFormat

class HistoricoAtendimentoController extends BaseController{

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [historicoAtendimentoInstanceList: HistoricoAtendimento.list(params), historicoAtendimentoInstanceTotal: HistoricoAtendimento.count()]
    }

  

    def cancelar = {

        def ordemServicoInstance = OrdemServico.get(params.id)

        def historicoAtendimentoInstance = new HistoricoAtendimento()
        historicoAtendimentoInstance.properties = params
        historicoAtendimentoInstance.dataHora= new Date()
        historicoAtendimentoInstance.ordemServico=ordemServicoInstance

        //return [historicoAtendimentoInstance: historicoAtendimentoInstance,msgTitulo:"Cancelamento do Atendimento",cancelamento:true]
        render(view:"create",model:[historicoAtendimentoInstance: historicoAtendimentoInstance,msgTitulo:"Cancelamento do Atendimento",cancelamento:true])
    }

    def save = {
		params.dataHora=new Date()
        def historicoAtendimentoInstance = new HistoricoAtendimento(params)
        def ordem = OrdemServico.get(params.ordemServico.id)

        if(params.cancelamento=="true"){
            gravaLog(ordem, LogOrdemServico.CANCELAMENTO)
            ordem.status="cancelado"
            ordem.save()

        }

        if (!historicoAtendimentoInstance.hasErrors() && historicoAtendimentoInstance.save()) {
            gravaLog(ordem, LogOrdemServico.HISTORICO)
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			
            render "<p><strong>"+ df.format(historicoAtendimentoInstance.dataHora)+"</strong>-" + historicoAtendimentoInstance.analistaUSS +"-" + historicoAtendimentoInstance.historico + "</p>"
        }
        else {
            render "erro ao cadastrar historico"
        }
    }

    def show = {
        def historicoAtendimentoInstance = HistoricoAtendimento.get(params.id)
        if (!historicoAtendimentoInstance) {
            flash.message = "historicoAtendimento.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "HistoricoAtendimento not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [historicoAtendimentoInstance: historicoAtendimentoInstance]
        }
    }

    def edit = {
        def historicoAtendimentoInstance = HistoricoAtendimento.get(params.id)
        if (!historicoAtendimentoInstance) {
            flash.message = "historicoAtendimento.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "HistoricoAtendimento not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [historicoAtendimentoInstance: historicoAtendimentoInstance]
        }
    }

    def update = {
        def historicoAtendimentoInstance = HistoricoAtendimento.get(params.id)
        if (historicoAtendimentoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (historicoAtendimentoInstance.version > version) {
                    
                    historicoAtendimentoInstance.errors.rejectValue("version", "historicoAtendimento.optimistic.locking.failure", "Another user has updated this HistoricoAtendimento while you were editing")
                    render(view: "edit", model: [historicoAtendimentoInstance: historicoAtendimentoInstance])
                    return
                }
            }
            historicoAtendimentoInstance.properties = params
            if (!historicoAtendimentoInstance.hasErrors() && historicoAtendimentoInstance.save()) {
                flash.message = "historicoAtendimento.updated"
                flash.args = [params.id]
                flash.defaultMessage = "HistoricoAtendimento ${params.id} updated"
                redirect(action: "show", id: historicoAtendimentoInstance.id)
            }
            else {
                render(view: "edit", model: [historicoAtendimentoInstance: historicoAtendimentoInstance])
            }
        }
        else {
            flash.message = "historicoAtendimento.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "HistoricoAtendimento not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def historicoAtendimentoInstance = HistoricoAtendimento.get(params.id)
        if (historicoAtendimentoInstance) {
            try {
                historicoAtendimentoInstance.delete()
                flash.message = "historicoAtendimento.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "HistoricoAtendimento ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "historicoAtendimento.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "HistoricoAtendimento ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "historicoAtendimento.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "HistoricoAtendimento not found with id ${params.id}"
            redirect(action: "list")
        }
    }
}
