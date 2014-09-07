package net.wg.gui.rally.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.messenger.ChannelComponent;
    
    public interface IBaseChatSection extends IDisposable
    {
        
        function getChannelComponent() : ChannelComponent;
        
        function get rallyData() : IRallyVO;
        
        function set rallyData(param1:IRallyVO) : void;
        
        function setDescription(param1:String) : void;
        
        function get chatSubmitBtnTooltip() : String;
    }
}
