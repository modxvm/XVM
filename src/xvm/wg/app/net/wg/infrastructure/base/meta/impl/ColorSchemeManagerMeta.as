package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.data.constants.Errors;
   
   public class ColorSchemeManagerMeta extends BaseDAAPIModule
   {
      
      public function ColorSchemeManagerMeta() {
         super();
      }
      
      public var getColorScheme:Function = null;
      
      public function getColorSchemeS(param1:String) : Object {
         App.utils.asserter.assertNotNull(this.getColorScheme,"getColorScheme" + Errors.CANT_NULL);
         return this.getColorScheme(param1);
      }
   }
}
