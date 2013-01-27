package model

import java.text.DateFormat
import java.text.SimpleDateFormat

class OrdemServico {
	String numero
	int barra
	Empresa empresa
	String segurado
	String endereco
	Bairro bairro
	String referencia
	String cidade
	Date chegada
	Date saida
	Date dataAcionamento
	Date dataAtendimento // data para a qual o serviço foi agendado
	String previaInicial
	String previaFinal
	String descServico // descrição enviada pela USS

	Funcionario funcionario
	String formaDeAcionamento
	Modalidade modalidade
	String evento
	String avaliacao
	String diagnostico
	String servicoExecutado
	Boolean fotos
	String parecer
	String status
	Seguradora seguradora
	String senha

	Double valorMDO
	Double valorMaterial
	Double valorDeslocamento
	Double valorFechadoUSS

	String historicos
	Boolean visitaPerdida
	String cssStatusColor

	Boolean recebida

	String logs
	
	String diaDaSemana
	String periodo
	Boolean domingo
	Boolean complementar
	
	String numeroLotePagamento
	Date dataPagamento
	
	String geometryLocation
	
	Double getValorTotal(){
		return (valorMDO?valorMDO:0)+(valorMaterial?valorMaterial:0)+(valorDeslocamento?valorDeslocamento:0)
	}
	
	def beforeInsert() {
		def dias = [1:"DOMINGO",2:"SEGUNDA-FEIRA",3:"TERCA-FEIRA",4:"QUARTA-FEIRA",5:"QUINTA-FEIRA",6:"SEXTA-FEIRA",7:"SABADO"]
		
		Calendar ca1 = Calendar.getInstance();
		ca1.setTime(dataAtendimento);
		int dayweek = ca1.get(Calendar.DAY_OF_WEEK);
		diaDaSemana = dias.get(dayweek)
		domingo = dayweek==1;
		visitaPerdida=false
		
		if(previaInicial.length()>2){
			int valor = Integer.valueOf(previaInicial.substring(0,2));
			if(valor>=20 || valor <7){
				periodo="NOTURNO"
			}else{
				periodo="DIURNO"
			}
			
		}
			
	}

	String getCssStatusColor(){

		return status.replace(" ","_")

	}


	static hasMany = [historicoAtendimento:HistoricoAtendimento,imagens:Imagem,logOpercao:LogOrdemServico,materiais:MovimentacaoDeMaterial]
	static transients = ['historicos','cssStatusColor','logs','fechada','valorTotal']
	
	static mapping = {
		historicoAtendimento sort:'dataHora',order:'asc'
	}
	String toString(){
		return ""+numero;
	}

	String getHistoricos(){
		
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

		String historicos = ""

		def listHist = HistoricoAtendimento.findAllByOrdemServico(this,[sort:"dataHora",order:"asc"])
		for(HistoricoAtendimento h:listHist){
			historicos = historicos +"<p><strong>"+ df.format(h.dataHora)+"</strong>-" + h.analistaUSS +"-" + h.historico + "<br><br></p>"
		}

		return historicos
	}

	String getLogs(){

		String logs = ""
		int i=1;
		def logList = LogOrdemServico.findAllByOrdemServico(this,[sort:"dataOperacao",order:"asc"])

		for(LogOrdemServico log:logList){
			logs = logs+ i+" - " + log.operacao + " em " + log.dataOperacao + " por " + log.nomeUsuario + "<br>"
			i++
		}

		return logs

	}

	
	
	Boolean getFechada(){
		return status=='fechada'
	}


	static constraints = {
		numero(blank:false)
		barra(blank:false)
		seguradora(blank:false)
		segurado(blank:false)
		endereco(blank:false,maxSize:400)
		cidade(blank:true)
		bairro(blank:false)
		referencia(blank:true,maxSize:400)
		dataAcionamento(blank:false)		
		evento(inList:["1ª Visita","Retorno","Conclusão","Garantia"])
		formaDeAcionamento(blank:true,nullable:true,inList:["Eletronico","Telefonico"])
		chegada(blank:true,nullable:true)
		saida(blank:true,nullable:true)
		avaliacao(blank:true,nullable:true)
		diagnostico(blank:true,nullable:true)
		servicoExecutado(blank:true,nullable:true)
		fotos(blank:true,nullable:true)
		parecer(blank:true,nullable:true)
		status(blank:true,nullable:true,maxSize:400)
		senha(blank:true,nullable:true)
		status(inList:["aberta","com o tecnico","senha validada","visita perdida","fechada","cancelado","aguardando pagamento","liquidada"],nullable:true,maxSize:400)
		dataAtendimento(blank:false)
		previaInicial(blank:true,nullable:true,maxSize:5)
		previaFinal(blank:true,nullable:true,maxSize:5)
		descServico(blank:true,nullable:true,maxSize:4000)

		valorMDO(blank:true,nullable:true)
		valorMaterial(blank:true,nullable:true)
		valorDeslocamento(blank:true,nullable:true)
		valorFechadoUSS(blank:true,nullable:true)

		recebida(blank:true,nullable:true)

		diaDaSemana(blank:true,nullable:true)
		periodo(blank:true,nullable:true)
		domingo(blank:true,nullable:true)
		complementar(blank:true,nullable:true)
		geometryLocation(blank:true,nullable:true)
		dataPagamento(blank:true,nullable:true)
		numeroLotePagamento(blank:true,nullable:true)
	}
}
