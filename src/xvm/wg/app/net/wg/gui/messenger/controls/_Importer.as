package net.wg.gui.messenger.controls
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ChannelItemRenderer,MemberItemRenderer]));
      }
   }

}