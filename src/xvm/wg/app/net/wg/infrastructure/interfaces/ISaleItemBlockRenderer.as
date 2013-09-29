package net.wg.infrastructure.interfaces 
{
    import scaleform.clik.interfaces.*;
    
    public interface ISaleItemBlockRenderer extends scaleform.clik.interfaces.IListItemRenderer
    {
        function get inInventory():Boolean;

        function get isRemovable():Boolean;

        function get moneyValue():Number;

        function get type():String;

        function get dataInfo():Object;

        function hideLine():void;

        function setColor(arg1:Number):void;

        function setSize(arg1:Number, arg2:Number):void;
    }
}
