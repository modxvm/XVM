package net.wg.gui.lobby.window
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ExchangeWindow,ExchangeVcoinWindow,ExchangeCurrencyWindow,ExchangeXPWindow,ExchangeXPFromVehicleIR,ExchangeFreeToTankmanXpWindow,ProfileWindow,ExchangeHeader,ProfileWindowInitVO]));
      }
   }

}