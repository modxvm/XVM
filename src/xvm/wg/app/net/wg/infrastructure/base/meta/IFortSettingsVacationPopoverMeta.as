package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    import net.wg.gui.lobby.fortifications.data.settings.VacationPopoverVO;
    
    public interface IFortSettingsVacationPopoverMeta extends IEventDispatcher
    {
        
        function onApplyS(param1:VacationPopoverVO) : void;
        
        function as_setTexts(param1:Object) : void;
        
        function as_setData(param1:Object) : void;
    }
}
