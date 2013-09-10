package net.wg.infrastructure.managers 
{
    import net.wg.infrastructure.base.meta.*;
    
    public interface IWaitingView extends net.wg.infrastructure.base.meta.IWaitingViewMeta
    {
        function get isVisible():Boolean;
    }
}
