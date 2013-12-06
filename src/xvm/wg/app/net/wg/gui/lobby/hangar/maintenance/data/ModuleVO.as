package net.wg.gui.lobby.hangar.maintenance.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.data.constants.Currencies;


   public class ModuleVO extends DAAPIDataClass
   {
          
      public function ModuleVO(param1:Object) {
         this.userCredits = [];
         super(param1);
         this._originalHash = param1;
      }

      private var _originalHash:Object;

      public var id:String = "";

      public var name:String = "";

      public var desc:String = "";

      public var target:int;

      public var compactDescr:int;

      public var prices:Array = null;

      public var defPrices:Array = null;

      public var actionPrc:Number = 0;

      public var currency:String = "";

      public var icon:String = "";

      public var index:int;

      public var slotIndex:int = 0;

      public var inventoryCount:int;

      public var vehicleCount:int;

      public var count:int;

      public var fits:Array = null;

      public var goldEqsForCredits:Boolean;

      public var userCredits:Array;

      public function clone(param1:int) : ModuleVO {
         var _loc2_:ModuleVO = new ModuleVO(this._originalHash);
         _loc2_.slotIndex = param1;
         return _loc2_;
      }

      public function get status() : String {
         return this.target == 1 && !(this.slotIndex == this.index)?MENU.MODULEFITS_WRONG_SLOT:this.fits[this.slotIndex];
      }

      public function get price() : int {
         return this.prices[this.currency == Currencies.CREDITS?0:1];
      }

      public function get defPrice() : int {
         return this.defPrices[this.currency == Currencies.CREDITS?0:1];
      }

      override public function dispose() : void {
         this.prices.splice(0);
         this.fits.splice(0);
         this._originalHash = null;
         super.dispose();
      }
   }

}