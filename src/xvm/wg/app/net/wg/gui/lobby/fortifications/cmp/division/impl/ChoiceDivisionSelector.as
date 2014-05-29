package net.wg.gui.lobby.fortifications.cmp.division.impl
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.text.TextField;
   import net.wg.gui.lobby.fortifications.data.FortChoiceDivisionSelectorVO;


   public class ChoiceDivisionSelector extends SoundButtonEx
   {
          
      public function ChoiceDivisionSelector() {
         super();
         doubleClickEnabled = true;
         useFocusedAsSelect = true;
      }

      public var divisionName:TextField = null;

      public var divisionProfit:TextField = null;

      public var vehicleLevel:TextField = null;

      private var _model:FortChoiceDivisionSelectorVO = null;

      public function setData(param1:FortChoiceDivisionSelectorVO) : void {
         this._model = param1;
         this.divisionName.htmlText = param1.divisionName;
         this.divisionProfit.htmlText = param1.divisionProfit;
         this.vehicleLevel.htmlText = param1.vehicleLevel;
      }

      public function get divisionID() : int {
         return this._model.divisionID;
      }
   }

}