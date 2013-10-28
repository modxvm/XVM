package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ActionButtonVO extends DAAPIDataClass
   {
          
      public function ActionButtonVO(param1:Object) {
         super(param1);
      }

      public var stateString:String = "";

      public var stateColor:String = "green";

      public var label:String = "";

      public var isEnabled:Boolean = false;
   }

}