package model

class TipoFuncionario {
   String descTipoFunc
   boolean tecnico

     String toString(){ "$descTipoFunc" }
   static constraint={descTipoFunc(black:false,descTipoFunc:true)}

}
