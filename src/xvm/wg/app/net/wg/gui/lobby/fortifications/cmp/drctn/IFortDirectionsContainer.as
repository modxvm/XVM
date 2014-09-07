package net.wg.gui.lobby.fortifications.cmp.drctn
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.lobby.fortifications.interfaces.ITransportModeClient;
    import net.wg.gui.lobby.fortifications.interfaces.IDirectionModeClient;
    import net.wg.gui.lobby.fortifications.data.BuildingVO;
    import net.wg.gui.lobby.fortifications.data.BattleNotifierVO;
    
    public interface IFortDirectionsContainer extends IUIComponentEx, ITransportModeClient, IDirectionModeClient
    {
        
        function update(param1:Vector.<BuildingVO>) : void;
        
        function updateBattleDirectionNotifiers(param1:Vector.<BattleNotifierVO>) : void;
    }
}
