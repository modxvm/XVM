package net.wg.infrastructure.interfaces 
{
    import flash.filters.*;
    import flash.geom.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IColorScheme extends net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function get schemeName():String;

        function get aliasColor():String;

        function get rgb():Number;

        function get colorTransform():flash.geom.ColorTransform;

        function get adjustOffset():flash.filters.BitmapFilter;
    }
}
