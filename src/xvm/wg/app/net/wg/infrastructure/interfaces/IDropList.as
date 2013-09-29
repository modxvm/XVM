package net.wg.infrastructure.interfaces 
{
    import scaleform.clik.interfaces.*;
    
    public interface IDropList extends scaleform.clik.interfaces.IUIComponent
    {
        function get selectable():Boolean;

        function set selectable(arg1:Boolean):void;

        function highlightList():void;

        function hideHighLight():void;
    }
}
