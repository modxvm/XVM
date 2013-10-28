package net.wg.gui.lobby.settings.components
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([KeyInput,SoundVoiceWaves,SoundVoiceWaves,KeysItemRenderer,KeysScrollingList]));
      }
   }

}