package model

class Modalidade {
	String descricao
    static constraints = {
		descricao(blank:false,maxSize:1000)
    }
	
	String toString(){
		return descricao
	}
}
