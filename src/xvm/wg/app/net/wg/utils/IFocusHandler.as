package net.wg.utils 
{
    import flash.display.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.ui.*;
    
    public interface IFocusHandler extends net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function set stage(arg1:flash.display.Stage):void;

        function getFocus(arg1:uint):flash.display.InteractiveObject;

        function setFocus(arg1:flash.display.InteractiveObject, arg2:uint=0, arg3:Boolean=false):void;

        function input(arg1:scaleform.clik.ui.InputDetails):void;
    }
}
