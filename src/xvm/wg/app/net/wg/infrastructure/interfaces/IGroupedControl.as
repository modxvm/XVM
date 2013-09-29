package net.wg.infrastructure.interfaces 
{
    import flash.events.*;
    import scaleform.clik.interfaces.*;
    
    public interface IGroupedControl extends flash.events.IEventDispatcher
    {
        function get selectedItem():Object;

        function get selectedRenderer():scaleform.clik.interfaces.IListItemRenderer;

        function get data():Object;

        function get name():String;
    }
}
