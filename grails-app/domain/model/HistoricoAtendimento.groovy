package model

class HistoricoAtendimento {
    static belongsTo = [ordemServico:OrdemServico]
    
    Date dataHora
    String analistaUSS
    String historico


    static constraints = {
        dataHora()
        analistaUSS(blank:false)
        historico(maxSize:4000,blank:false)
    }

    static mapping = {
        sort "dataHora"
        
    }
}
