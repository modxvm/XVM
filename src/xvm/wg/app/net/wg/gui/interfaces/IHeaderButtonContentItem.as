package net.wg.gui.interfaces
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    
    public interface IHeaderButtonContentItem extends IUIComponentEx
    {
        
        function get data() : Object;
        
        function set data(param1:Object) : void;
        
        function get screen() : String;
        
        function updateScreen(param1:String, param2:Number, param3:Number) : void;
        
        function get readyToShow() : Boolean;
        
        function set readyToShow(param1:Boolean) : void;
        
        function setAvailableWidth(param1:Number) : void;
    }
}
