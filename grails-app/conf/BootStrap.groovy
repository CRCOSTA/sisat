import grails.converters.JSON
import model.EstoqueFuncionario

class BootStrap {

    def init = { servletContext ->
		JSON.registerObjectMarshaller(EstoqueFuncionario) {
			def returnArray = [:]
			returnArray['id'] = it.id
			returnArray['qtd'] = it.qtd
			returnArray['materialId'] = it.material.id
			returnArray['materialDesc'] = it.material.descricao
			returnArray['text'] = it.material.descricao +" - "+ it.qtd
			
			return returnArray
		}
    }
    def destroy = {
    }
}
