package net.wg.gui.lobby.questsWindow.components.interfaces
{
    import scaleform.clik.interfaces.IUIComponent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    
    public interface IResizableContent extends IUIComponent, IDisposable
    {
        
        function get isReadyForLayout() : Boolean;
        
        function set isReadyForLayout(param1:Boolean) : void;
        
        function get availableWidth() : Number;
        
        function set availableWidth(param1:Number) : void;
        
        function get contentAlign() : String;
        
        function set contentAlign(param1:String) : void;
        
        function get isNumerated() : Boolean;
        
        function set isNumerated(param1:Boolean) : void;
        
        function setData(param1:Object) : void;
    }
}
