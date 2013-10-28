package net.wg.gui.lobby.settings
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.lobby.settings.vo.SettingsKeyProp;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([SettingsWindow,SettingsConfig,ControlsSettings,AimSettings,GameSettings,GraphicSettings,MarkerSettings,SoundSettings,SettingsMarkersForm,SettingsAimForm,SettingsKeyProp,SettingsControlProp,SettingsWindow]));
      }
   }

}