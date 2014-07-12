package net.wg.gui.intro
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class IntroInfoVO extends DAAPIDataClass
   {
      
      public function IntroInfoVO(param1:Object) {
         super(param1);
      }
      
      public var source:String = "";
      
      public var volume:Number;
   }
}
