package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IDismissTankmanDialogMeta extends flash.events.IEventDispatcher
    {
        function sendControlNumberS(arg1:String):void;

        function as_enabledButton(arg1:Boolean):void;

        function as_tankMan(arg1:Object):void;

        function as_setQuestionForUser(arg1:String):void;

        function as_controlTextInput(arg1:String):void;
    }
}
