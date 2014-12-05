package net.wg.gui.lobby.fortifications.cmp.main
{
    import net.wg.gui.lobby.fortifications.cmp.base.IFilledBar;
    import net.wg.infrastructure.interfaces.entity.IFocusContainer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconTextButton;
    import net.wg.gui.components.advanced.ToggleSoundButton;
    import net.wg.gui.interfaces.IButtonIconLoader;
    import net.wg.gui.lobby.fortifications.cmp.main.impl.VignetteYellow;
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.lobby.fortifications.cmp.main.impl.FortTimeAlertIcon;
    
    public interface IMainHeader extends IFilledBar, IFocusContainer
    {
        
        function get totalDepotQuantityText() : TextField;
        
        function set totalDepotQuantityText(param1:TextField) : void;
        
        function get statsBtn() : IconTextButton;
        
        function set statsBtn(param1:IconTextButton) : void;
        
        function get clanListBtn() : IconTextButton;
        
        function set clanListBtn(param1:IconTextButton) : void;
        
        function get calendarBtn() : IconTextButton;
        
        function set calendarBtn(param1:IconTextButton) : void;
        
        function get transportBtn() : ToggleSoundButton;
        
        function set transportBtn(param1:ToggleSoundButton) : void;
        
        function get settingBtn() : IButtonIconLoader;
        
        function set settingBtn(param1:IButtonIconLoader) : void;
        
        function get vignetteYellow() : VignetteYellow;
        
        function set vignetteYellow(param1:VignetteYellow) : void;
        
        function get clanInfo() : IFortHeaderClanInfo;
        
        function set clanInfo(param1:IFortHeaderClanInfo) : void;
        
        function get title() : TextField;
        
        function set title(param1:TextField) : void;
        
        function get infoTF() : TextField;
        
        function set infoTF(param1:TextField) : void;
        
        function get tutorialArrow() : IUIComponentEx;
        
        function set tutorialArrow(param1:IUIComponentEx) : void;
        
        function get timeAlert() : FortTimeAlertIcon;
        
        function set timeAlert(param1:FortTimeAlertIcon) : void;
    }
}
