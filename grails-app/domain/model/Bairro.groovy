package model

class Bairro {
    String descBairro
    String zona
    static constraints = {
        zona(inList:["Norte","Oeste","Sul","Centro","Baixada Fluminense"])
    }

    String toString(){
        return descBairro +" - "+zona
    }
}
