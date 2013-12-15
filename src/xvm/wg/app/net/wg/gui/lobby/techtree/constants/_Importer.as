package net.wg.gui.lobby.techtree.constants
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ActionName,ColorIndex,IconTextResolver,NamedLabels,NavIndicator,NodeEntityType,NodeState,OutLiteral,TTInvalidationType,TTSoundID,XpTypeStrings]));
      }
   }

}