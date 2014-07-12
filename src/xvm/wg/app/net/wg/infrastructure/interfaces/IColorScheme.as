package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.geom.ColorTransform;
   import flash.filters.BitmapFilter;
   
   public interface IColorScheme extends IDisposable
   {
      
      function get schemeName() : String;
      
      function get aliasColor() : String;
      
      function get rgb() : Number;
      
      function get colorTransform() : ColorTransform;
      
      function get adjustOffset() : BitmapFilter;
   }
}
