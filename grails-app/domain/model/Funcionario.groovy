package model

class Funcionario {
    static hasMany = [estoque:EstoqueFuncionario]
	static transients = ['analistaExterno','tecnico','operador']
    static constraints = {
        empresa(blank:false)
        tipoFuncionario(blank:false)
        nome(blank:false,maxSize:200)
        email(blank:true,email:true)
        telefone()
        IDNextel()
        celular()
        login(black:false,maxsize:20)
        senha(blank:false, password:true)
        ativo()
		valorRealizada(blank:true,nullable:true)
		valorRealizadaNoite(blank:true,nullable:true)
		valorRealizadaDomingo(blank:true,nullable:true)
		valorVisita(blank:true,nullable:true)
		valorVisitaNoite(blank:true,nullable:true)
		valorVisitaDomingo(blank:true,nullable:true)
		valorComplementar(blank:true,nullable:true)
		valorComplementarNoite(blank:true,nullable:true)
		valorComplementarDomingo(blank:true,nullable:true)
		valorCheckup(blank:true,nullable:true)
		valorCheckupNoite(blank:true,nullable:true)
		valorCheckupDomingo(blank:true,nullable:true)
    }

    String nome
    String email
    String telefone
    String IDNextel
    String celular
    String login
    String senha
    Boolean ativo
    TipoFuncionario tipoFuncionario
    Empresa empresa
    Boolean admin
	
	Double valorRealizada
	Double valorRealizadaNoite	
	Double valorRealizadaDomingo
	
	Double valorVisita
	Double valorVisitaNoite
	Double valorVisitaDomingo
	
	Double valorComplementar
	Double valorComplementarNoite
	Double valorComplementarDomingo
	
	
	Double valorCheckup
	Double valorCheckupNoite
	Double valorCheckupDomingo

	
	

    String toString(){ "$nome - $empresa" }
    
	boolean isOperador(){
		
		return tipoFuncionario.id==12
	}
	
	boolean isAnalistaExterno(){
		
		return tipoFuncionario.id==10
	}
	
	boolean isTecnico(){
		return tipoFuncionario.tecnico
	}
}
