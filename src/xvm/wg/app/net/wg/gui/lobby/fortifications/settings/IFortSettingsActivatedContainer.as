package net.wg.gui.lobby.fortifications.settings
{
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    
    public interface IFortSettingsActivatedContainer extends IFortSettingsContainer, IViewStackContent, IPopOverCaller
    {
        
        function canDisableDefHour(param1:Boolean) : void;
    }
}
