package scaleform.clik.interfaces 
{
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public interface IListItemRenderer extends scaleform.clik.interfaces.IUIComponent
    {
        function get index():uint;

        function set index(arg1:uint):void;

        function get owner():scaleform.clik.core.UIComponent;

        function set owner(arg1:scaleform.clik.core.UIComponent):void;

        function get selectable():Boolean;

        function set selectable(arg1:Boolean):void;

        function get selected():Boolean;

        function set selected(arg1:Boolean):void;

        function get displayFocus():Boolean;

        function set displayFocus(arg1:Boolean):void;

        function setListData(arg1:scaleform.clik.data.ListData):void;

        function setData(arg1:Object):void;
    }
}
