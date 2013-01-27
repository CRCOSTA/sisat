package model

class LogOrdemServico {

    static final String CADASTRO        = "cadastro"
    static final String VALIDACAO       = "validacao de senha"
    static final String ENCAMINHAMENTO  = "encaminhamento"
    static final String CANCELAMENTO    = "cancelamento"
    static final String HISTORICO       = "historico cadastrado"
    static final String RECEBIMENTO     = "recebimento"
    static final String FECHAMENTO      = "fechamento"
    static final String ALTERADO        = "alterado"
    static final String IMAGEM          = "imagem cadastrada"
	static final String LIQUIDACAO      = "Ordem de servico liquidada"
	static final String MATERIAL        = "inclusao de material"
	
    static belongsTo = [ordemServico:OrdemServico]
    String operacao
    Date dataOperacao
    String nomeUsuario

    static constraints = {
    }
}
