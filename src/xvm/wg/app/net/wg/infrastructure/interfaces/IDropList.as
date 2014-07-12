package net.wg.infrastructure.interfaces
{
    public interface IDropList extends IUIComponentEx
    {
        
        function highlightList() : void;
        
        function hideHighLight() : void;
        
        function get selectable() : Boolean;
        
        function set selectable(param1:Boolean) : void;
    }
}
