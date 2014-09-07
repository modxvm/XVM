package net.wg.gui.lobby.fortifications.utils
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.fortifications.interfaces.ITransportModeClient;
    import net.wg.gui.lobby.fortifications.data.FortModeVO;
    
    public interface ITransportingHelper extends IDisposable, ITransportModeClient
    {
        
        function getModeVO(param1:Boolean, param2:Boolean) : FortModeVO;
    }
}
