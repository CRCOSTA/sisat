package model

import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.io.File;

import com.amazonaws.auth.PropertiesCredentials
import com.amazonaws.services.s3.AmazonS3
import com.amazonaws.services.s3.AmazonS3Client
import com.amazonaws.services.s3.model.DeleteObjectRequest
import com.amazonaws.services.s3.model.GetObjectRequest
import com.amazonaws.services.s3.model.ListObjectsRequest
import com.amazonaws.services.s3.model.ObjectMetadata
import com.amazonaws.services.s3.model.PutObjectRequest


class ImagemController extends BaseController{
	
	private static AmazonS3 s3
	private static PropertiesCredentials awsCreds
   
	def beforeInterceptor = {
		if (!s3) {
			
			def getResourceAsStream = Thread.currentThread().contextClassLoader.getResourceAsStream("AwsCredentials.properties")
			awsCreds=new PropertiesCredentials(getResourceAsStream)
			s3 = new AmazonS3Client(awsCreds);
		}
	  }

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [imagemInstanceList: Imagem.list(params), imagemInstanceTotal: Imagem.count()]
    }

    def create = {
        def ordemServicoInstance = OrdemServico.get(params.id)
         if (!ordemServicoInstance) {
            flash.message = "ordemServico.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "OrdemServico not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [ordemServicoInstance: ordemServicoInstance]
        }
    }
	
	def upload = {
		println params.idAtend
		def ordemServicoInstance = OrdemServico.get(params.idAtend)
		
		def imagefile = request.getFile('Filedata');
		
		
		if(!imagefile.empty){
			
			String nomeImg = imagefile.hashCode()+'.jpg'

			String pathDir = System.getProperty("java.io.tmpdir")+"/"+ordemServicoInstance.id+"/"
			
			File dir = new File(pathDir.trim());
			
			dir.mkdir()

			File f = new  File(pathDir.trim()+'/temp_' + nomeImg );
			imagefile.transferTo(f)
			
			createThumbnail(f,ordemServicoInstance.id,"thumb_"+nomeImg)
			createPhoto(f,ordemServicoInstance.id,nomeImg)
			
			f.delete()

			def foto = new Imagem(nomeImagem:nomeImg ,checklist:false)

			foto.ordemServico = ordemServicoInstance

			foto.save()

			gravaLog(ordemServicoInstance, LogOrdemServico.IMAGEM)
		}
		
		render ""
		
	}

    def save = {
            def ordemServicoInstance = OrdemServico.get(params.id)


            for(int i=1;i<9;i++){

                def imagefile = request.getFile('foto'+i);

                if(!imagefile.empty){

                    String nomeImg = imagefile.hashCode()+'.jpg'

					String pathDir = System.getProperty("java.io.tmpdir")+"/"+ordemServicoInstance.id+"/"
					
                    File dir = new File(pathDir.trim());
					
					println dir.mkdir()

                    File f = new  File(pathDir.trim()+'/temp_' + nomeImg );
                    imagefile.transferTo(f)
                    
                    createThumbnail(f,ordemServicoInstance.id,"thumb_"+nomeImg)
                    createPhoto(f,ordemServicoInstance.id,nomeImg)
                    
                    f.delete()

                    def foto = new Imagem(nomeImagem:nomeImg ,checklist:false)

                    foto.ordemServico = ordemServicoInstance

                    foto.save()

                    gravaLog(ordemServicoInstance, LogOrdemServico.IMAGEM)
                }
            }
			if(session?.user?.tecnico){
				redirect( controller:"ordemServico", action: "listByTecnico")
			}
				
             flash.message = "Fotos inclu&iacute;das com sucesso."
             flash.defaultMessage = "Fotos inclu&iacute;das com sucesso."
             redirect(action: "creadte", id: ordemServicoInstance.id)
    }

    def show = {
        def imagemInstance = Imagem.get(params.id)
        if (!imagemInstance) {
            flash.message = "imagem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Imagem not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [imagemInstance: imagemInstance]
        }
    }

    def edit = {
        def imagemInstance = Imagem.get(params.id)
        if (!imagemInstance) {
            flash.message = "imagem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Imagem not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [imagemInstance: imagemInstance]
        }
    }

    def update = {
        def imagemInstance = Imagem.get(params.id)
        if (imagemInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (imagemInstance.version > version) {
                    
                    imagemInstance.errors.rejectValue("version", "imagem.optimistic.locking.failure", "Another user has updated this Imagem while you were editing")
                    render(view: "edit", model: [imagemInstance: imagemInstance])
                    return
                }
            }
            imagemInstance.properties = params
            if (!imagemInstance.hasErrors() && imagemInstance.save()) {
                flash.message = "imagem.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Imagem ${params.id} updated"
                redirect(action: "show", id: imagemInstance.id)
            }
            else {
                render(view: "edit", model: [imagemInstance: imagemInstance])
            }
        }
        else {
            flash.message = "imagem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Imagem not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def imagemInstance = Imagem.get(params.id)

        if (imagemInstance) {
            try {
				s3.deleteObject(new DeleteObjectRequest(Imagem.BUCKET_NAME,imagemInstance.ordemServico.id+"/"+imagemInstance.nomeImagem ) )
				
				s3.deleteObject(new DeleteObjectRequest(Imagem.BUCKET_NAME,imagemInstance.ordemServico.id+"/thumb_"+imagemInstance.nomeImagem ) )
				
				
                imagemInstance.delete()
                flash.message = "imagem.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Imagem ${params.id} deleted"
                
				
                redirect(controller:"ordemServico",action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "imagem.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Imagem ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "imagem.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Imagem not found with id ${params.id}"
            redirect(action: "list")
        }
    }


    public static void createPhoto(File file,long ordemId,String photoname) throws IOException
    {


         BufferedImage img = ImageIO.read(file);
         int newW =800;
         int newH = 600;
         int w = img.getWidth();
         int h = img.getHeight();

         if(w<h){
             newW=600;
             newH=800;
         }

         BufferedImage dimg = new BufferedImage(newW, newH, img.getType());
         Graphics2D g = dimg.createGraphics();
         g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
         g.drawImage(img, 0, 0, newW, newH, 0, 0, w, h, null);
         g.dispose();
		 def temp = new File(file.getParent()+"/"+photoname)
         ImageIO.write(dimg, "jpg", temp);
		
		 s3.putObject(new PutObjectRequest(Imagem.BUCKET_NAME,ordemId+"/"+photoname, temp))
		 
		temp.delete()
    }

    public static void createThumbnail(File file,long ordemId,String thumbname) throws IOException
    {


         BufferedImage img = ImageIO.read(file);
         int newW =80;
         int newH = 60;
         int w = img.getWidth();
         int h = img.getHeight();

         if(w<h){
             newW=60;
             newH=80;
         }

         BufferedImage dimg = new BufferedImage(newW, newH, img.getType());
         Graphics2D g = dimg.createGraphics();
         g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
         g.drawImage(img, 0, 0, newW, newH, 0, 0, w, h, null);
         g.dispose();
		 
		 def temp = new File(file.getParent()+"/"+thumbname)
		 ImageIO.write(dimg, "jpg", temp);
		 
		 s3.putObject(new PutObjectRequest(Imagem.BUCKET_NAME,ordemId+"/"+thumbname, temp))
		 
		 temp.delete()


    }
	
	def migra={
		
		def i=38000;
		while(i>36200){
			println "------------------------------ MIGRANDO DE"+i+" ate "+(i-100)
		
			
			def images = Imagem.findAllByIdBetween(i-100,i)
			
			images.each{
				def img = (Imagem)it
				
				
				String pOrig = "/Users/thiago/Documents/crcostaassistencia/ROOT/"+img.ordemServico.numero+"/"+img.nomeImagem
				String pOrigT = "/Users/thiago/Documents/crcostaassistencia/ROOT/"+img.ordemServico.numero+"/thumb_"+img.nomeImagem
				
				File file = new File(pOrig)
				println "verificando foto - "+pOrig;
				if(file.exists()){
					println "movendo foto - "+img.ordemServico.id + "/" +img.nomeImagem;
					s3.putObject(new PutObjectRequest(Imagem.BUCKET_NAME,img.ordemServico.id + "/" +img.nomeImagem , file))
					img.imgMig=true
					img.save(flush:true)
				}
				
				File file2 = new File(pOrigT)
				println "verificando foto - "+pOrigT;
				if(file.exists()){
					println "enviando foto thumb -"+img.ordemServico.id + "/thumb_" +img.nomeImagem
					s3.putObject(new PutObjectRequest(Imagem.BUCKET_NAME,img.ordemServico.id + "/thumb_" +img.nomeImagem , file2))
					img.thumbMig=true
					img.save(flush:true)
					
					
					
				}
				
				
				
			}
			i=i-100;
		}
		
	}

   
}
