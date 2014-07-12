package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.base.meta.IColorSchemeManagerMeta;
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import flash.geom.ColorTransform;
   
   public interface IColorSchemeManager extends IColorSchemeManagerMeta, IEventDispatcher
   {
      
      function getScheme(param1:String) : IColorScheme;
      
      function getAliasColor(param1:String) : String;
      
      function getRGB(param1:String) : Number;
      
      function getTransform(param1:String) : ColorTransform;
   }
}
