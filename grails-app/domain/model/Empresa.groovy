package model

class Empresa {

    static constraints = {

        nome(blank:false,maxSize:100)
        cnpj(blank:false)
        contato()
        endereco()
        cep()
        telefone1()
        telefone2()
        telefone3()
        

    }

    String nome
    String endereco
    String telefone1
    String telefone2
    String telefone3
    String contato
    String cep
    String cnpj

    String toString(){
        return nome;
    }

}
