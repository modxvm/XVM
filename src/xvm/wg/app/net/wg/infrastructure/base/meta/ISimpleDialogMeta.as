package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ISimpleDialogMeta extends flash.events.IEventDispatcher
    {
        function onButtonClickS(arg1:String):void;

        function as_setText(arg1:String):void;

        function as_setTitle(arg1:String):void;

        function as_setButtons(arg1:Array):void;

        function as_setButtonEnabling(arg1:String, arg2:Boolean):void;

        function as_setButtonFocus(arg1:String):void;
    }
}
