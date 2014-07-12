package net.wg.gui.login
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.interfaces.IUIComponent;
    import net.wg.gui.login.impl.components.Vo.RssItemVo;
    
    public interface IRssNewsFeedRenderer extends IDisposable, IUIComponent
    {
        
        function setData(param1:RssItemVo) : void;
        
        function get itemId() : String;
        
        function get itemHeight() : Number;
        
        function get itemWidth() : Number;
        
        function get itemDataVo() : RssItemVo;
        
        function moveToY(param1:Number) : void;
        
        function hide() : void;
        
        function get isUsed() : Boolean;
    }
}
