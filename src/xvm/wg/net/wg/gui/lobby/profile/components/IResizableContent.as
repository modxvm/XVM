package net.wg.gui.lobby.profile.components 
{
    import net.wg.infrastructure.interfaces.*;
    
    public interface IResizableContent extends net.wg.infrastructure.interfaces.IViewStackContent
    {
        function setViewSize(arg1:Number, arg2:Number):void;

        function set centerOffset(arg1:int):void;

        function get centerOffset():int;

        function set active(arg1:Boolean):void;

        function get active():Boolean;
    }
}
