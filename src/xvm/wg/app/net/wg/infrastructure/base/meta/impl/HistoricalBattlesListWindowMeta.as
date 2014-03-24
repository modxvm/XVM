package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.prebattle.meta.abstract.PrequeueWindow;
   import net.wg.data.constants.Errors;


   public class HistoricalBattlesListWindowMeta extends PrequeueWindow
   {
          
      public function HistoricalBattlesListWindowMeta() {
         super();
      }

      public var onBattleSelected:Function = null;

      public var onVehicleSelected:Function = null;

      public var onPriceSelected:Function = null;

      public var showFullDescription:Function = null;

      public function onBattleSelectedS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.onBattleSelected,"onBattleSelected" + Errors.CANT_NULL);
         this.onBattleSelected(param1);
      }

      public function onVehicleSelectedS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.onVehicleSelected,"onVehicleSelected" + Errors.CANT_NULL);
         this.onVehicleSelected(param1);
      }

      public function onPriceSelectedS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.onPriceSelected,"onPriceSelected" + Errors.CANT_NULL);
         this.onPriceSelected(param1);
      }

      public function showFullDescriptionS() : void {
         App.utils.asserter.assertNotNull(this.showFullDescription,"showFullDescription" + Errors.CANT_NULL);
         this.showFullDescription();
      }
   }

}