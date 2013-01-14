package model

class Imagem {
 
    static final String uploadPath ="/home/sisat/fotos/"
    //static final String uploadPath = '/Users/thiago/crcostaassistencia/webapps/ROOT/'
	static final String AMAZON_URL = "https://s3.amazonaws.com/"
	static final String BUCKET_NAME = "CRCOSTA"
    static belongsTo = [ordemServico:OrdemServico]
    String nomeImagem
    Boolean checklist
	Boolean imgMig
	Boolean thumbMig
    
    static constraints = {
		imgMig(black:true,nullable:true)
		thumbMig(black:true,nullable:true)
    }


}
