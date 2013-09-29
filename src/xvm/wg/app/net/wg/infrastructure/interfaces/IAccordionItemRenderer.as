package net.wg.infrastructure.interfaces 
{
    import scaleform.clik.interfaces.*;
    
    public interface IAccordionItemRenderer extends scaleform.clik.interfaces.IListItemRenderer
    {
        function set enableConstraints(arg1:Boolean):void;

        function get label():String;

        function set label(arg1:String):void;

        function get name():String;

        function setSize(arg1:Number, arg2:Number):void;
    }
}
