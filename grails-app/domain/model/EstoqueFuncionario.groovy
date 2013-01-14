package model

class EstoqueFuncionario {
    static belongsTo = [funcionario:Funcionario]

    Material material
    int qtd
    Date dataInclusao
    
    static constraints = {
        material(blank:false)
        qtd(blank:false)
        
    }
	
	public String toString(){
		return material.id + " - " + material.descricao + "- Estoque do Funcionario: "  + qtd
	}
	
	
}
