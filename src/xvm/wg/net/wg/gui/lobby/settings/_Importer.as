package net.wg.gui.lobby.settings 
{
    import __AS3__.vec.*;
    import net.wg.gui.lobby.settings.vo.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.settings.SettingsWindow, net.wg.gui.lobby.settings.SettingsConfig, net.wg.gui.lobby.settings.ControlsSettings, net.wg.gui.lobby.settings.AimSettings, net.wg.gui.lobby.settings.GameSettings, net.wg.gui.lobby.settings.GraphicSettings, net.wg.gui.lobby.settings.MarkerSettings, net.wg.gui.lobby.settings.SoundSettings, net.wg.gui.lobby.settings.SettingsMarkersForm, net.wg.gui.lobby.settings.SettingsAimForm, net.wg.gui.lobby.settings.vo.SettingsKeyProp, net.wg.gui.lobby.settings.vo.SettingsControlProp, net.wg.gui.lobby.settings.SettingsWindow]));
            return;
        }
    }
}
