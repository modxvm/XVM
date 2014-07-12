package net.wg.infrastructure.interfaces
{
    import scaleform.clik.interfaces.IListItemRenderer;
    
    public interface ISaleItemBlockRenderer extends IListItemRenderer
    {
        
        function hideLine() : void;
        
        function setColor(param1:Number) : void;
        
        function setSize(param1:Number, param2:Number) : void;
        
        function get toInventory() : Boolean;
        
        function get fromInventory() : Boolean;
        
        function get isRemovable() : Boolean;
        
        function get moneyValue() : Number;
        
        function get type() : String;
        
        function get intCD() : Number;
        
        function get count() : Number;
        
        function get sellExternalData() : Array;
    }
}
