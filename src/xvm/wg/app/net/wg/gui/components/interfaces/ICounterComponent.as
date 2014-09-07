package net.wg.gui.components.interfaces
{
    import scaleform.clik.interfaces.IUIComponent;
    
    public interface ICounterComponent extends IUIComponent
    {
        
        function get text() : String;
        
        function set text(param1:String) : void;
    }
}
