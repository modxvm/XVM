package net.wg.utils 
{
    import flash.display.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IIME extends net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function init(arg1:Boolean):void;

        function setVisible(arg1:Boolean):void;

        function getContainer():flash.display.Sprite;

        function onLangBarResize(arg1:Number, arg2:Number):void;
    }
}
