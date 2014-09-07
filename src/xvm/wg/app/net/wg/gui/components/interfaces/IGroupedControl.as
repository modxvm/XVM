package net.wg.gui.components.interfaces
{
    import flash.events.IEventDispatcher;
    import scaleform.clik.interfaces.IListItemRenderer;
    
    public interface IGroupedControl extends IEventDispatcher
    {
        
        function get selectedItem() : Object;
        
        function get selectedRenderer() : IListItemRenderer;
        
        function get data() : Object;
        
        function get name() : String;
    }
}
