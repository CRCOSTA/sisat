package model

class MovimentacaoDeMaterial {

    static belongsTo = [material:Material]

    String descricao;
    String tipo;
    int quantidade;    
    OrdemServico ordemServico;
    Date dataMovimentacao;
    Funcionario funcionario;
    
    static constraints = {
        descricao(blank:false,maxSize:2000)
        quantidade(blank:false)
        tipo(inList:["Entrada","Saida"])
        material(blank:false,nullable:false)
        ordemServico(blank:true,nullable:true)
		funcionario(blank:true,nullable:true)
        dataMovimentacao(blanck:false);
    }

    String toString(){
       "$tipo - $descricao - $quantidade "
    }
}
