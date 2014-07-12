package net.wg.gui.lobby.fortifications.cmp.build
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.lobby.fortifications.interfaces.IDirectionModeClient;
    import net.wg.gui.lobby.fortifications.interfaces.ICommonModeClient;
    import net.wg.gui.lobby.fortifications.data.BuildingVO;
    
    public interface IFortBuildingsContainer extends IUIComponentEx, IDirectionModeClient, ICommonModeClient
    {
        
        function update(param1:Vector.<BuildingVO>, param2:Boolean) : void;
        
        function getBuildingTooltipData(param1:String) : Array;
        
        function get buildings() : Vector.<IFortBuilding>;
        
        function setBuildingData(param1:BuildingVO, param2:Boolean) : void;
    }
}
