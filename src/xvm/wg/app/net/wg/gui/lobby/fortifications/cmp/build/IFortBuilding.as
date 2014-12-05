package net.wg.gui.lobby.fortifications.cmp.build
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;
    import net.wg.gui.lobby.fortifications.data.BuildingVO;
    import flash.display.InteractiveObject;
    
    public interface IFortBuilding extends IUIComponentEx, IFortBuildingUIBase, ITransportingStepper, IPopOverCaller, ITweenAnimatorHandler
    {
        
        function setData(param1:BuildingVO) : void;
        
        function getCustomHitArea() : InteractiveObject;
        
        function isAvailable() : Boolean;
        
        function isExportAvailable() : Boolean;
        
        function isImportAvailable() : Boolean;
        
        function get uid() : String;
        
        function set uid(param1:String) : void;
        
        function set userCanAddBuilding(param1:Boolean) : void;
        
        function set forceSelected(param1:Boolean) : void;
        
        function get selected() : Boolean;
        
        function set getAdvancedToolTipFunc(param1:Function) : void;
    }
}
