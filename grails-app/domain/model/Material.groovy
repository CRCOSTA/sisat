package model

class Material {

    static hasMany = [movimentos:MovimentacaoDeMaterial]

    String descricao
    String marca
    Double valorCompra
    Double valorVenda
    int estoqueMinimo
    int estoqueAtual
    

    static constraints = {
        descricao(blank:false,maxSize:2000)
        marca(black:true,nullable:true)
        valorCompra(blank:false)
        valorVenda()
        estoqueMinimo(blank:false)
        estoqueAtual(blank:false)

    }

    String toString(){
        return descricao + " | estoque->" + estoqueAtual
    }
}
