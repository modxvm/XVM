package net.wg.gui.login.impl.components.Vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RssItemVo extends DAAPIDataClass
   {
      
      public function RssItemVo(param1:Object) {
         super(param1);
      }
      
      public var id:String = "";
      
      public var link:String = "";
      
      public var description:String = "";
   }
}
