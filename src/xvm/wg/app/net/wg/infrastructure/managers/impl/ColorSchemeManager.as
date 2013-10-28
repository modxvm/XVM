package net.wg.infrastructure.managers.impl
{
   import net.wg.infrastructure.base.meta.impl.ColorSchemeManagerMeta;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.data.constants.Linkages;
   import flash.geom.ColorTransform;
   import net.wg.infrastructure.events.ColorSchemeEvent;


   public class ColorSchemeManager extends ColorSchemeManagerMeta implements IColorSchemeManager
   {
          
      public function ColorSchemeManager() {
         super();
      }

      public function getScheme(param1:String) : IColorScheme {
         var _loc2_:Class = App.utils.classFactory.getClass(Linkages.CLR_CSS);
         return new _loc2_(getColorSchemeS(param1));
      }

      public function getAliasColor(param1:String) : String {
         return this.getScheme(param1).aliasColor;
      }

      public function getRGB(param1:String) : Number {
         return this.getScheme(param1).rgb;
      }

      public function getTransform(param1:String) : ColorTransform {
         return this.getScheme(param1).colorTransform;
      }

      public function as_update() : void {
         dispatchEvent(new ColorSchemeEvent(ColorSchemeEvent.SCHEMAS_UPDATED));
      }
   }

}