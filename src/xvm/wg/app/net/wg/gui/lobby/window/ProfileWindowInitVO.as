package net.wg.gui.lobby.window
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ProfileWindowInitVO extends DAAPIDataClass
   {
          
      public function ProfileWindowInitVO(param1:Object) {
         super(param1);
      }

      public var fullName:String = "";
   }

}