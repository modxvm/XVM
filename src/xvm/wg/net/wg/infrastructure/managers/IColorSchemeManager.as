package net.wg.infrastructure.managers 
{
    import flash.events.*;
    import flash.geom.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.interfaces.*;
    
    public interface IColorSchemeManager extends net.wg.infrastructure.base.meta.IColorSchemeManagerMeta, flash.events.IEventDispatcher
    {
        function getScheme(arg1:String):net.wg.infrastructure.interfaces.IColorScheme;

        function getAliasColor(arg1:String):String;

        function getRGB(arg1:String):Number;

        function getTransform(arg1:String):flash.geom.ColorTransform;
    }
}
