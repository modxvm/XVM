package net.wg.gui.components.controls.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.data.constants.IconsTypes;
   import net.wg.utils.IAssertable;


   public class ActionPriceVO extends DAAPIDataClass
   {
          
      public function ActionPriceVO(param1:Object) {
         super(param1);
      }

      public static const STATE_DISCOUNT:String = "discount";

      public static const STATE_PENALTY:String = "penalty";

      public var type:String = "";

      public var key:String = "";

      public var isBuying:Boolean = false;

      public var _state:String = "discount";

      public var _states:Array = null;

      private var _oldPrices:Array = null;

      private var _newPrices:Array = null;

      public var newPriceBases:Array = null;

      public var oldPriceBases:Array = null;

      private var _oldPrice:Number = 0;

      private var _newPrice:Number = 0;

      private var _forCredits:Boolean = true;

      private var _ico:String = "credits";

      private var _useSign:Boolean = false;

      private var _externalSign:String = "";

      private var data:Object = null;

      public var useAction:Boolean = false;

      override public function fromHash(param1:Object) : void {
         super.fromHash(param1);
         this.data = param1;
      }

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == "newPrice")
         {
            this.newPrices = param2 as Array;
            this.newPriceBases = [this.newPrices[0],this.newPrices[1]];
            return false;
         }
         if(param1 == "oldPrice")
         {
            this.oldPrices = param2 as Array;
            this.oldPriceBases = [this.oldPrices[0],this.oldPrices[1]];
            return false;
         }
         if(param1 == "state")
         {
            this.states = param2 as Array;
            return false;
         }
         return this.hasOwnProperty(param1);
      }

      public function get state() : String {
         return this._state;
      }

      public function set state(param1:String) : void {
         this._state = param1;
      }

      public function get states() : Array {
         return this._states;
      }

      public function set states(param1:Array) : void {
         this._states = param1;
         this.updateState();
      }

      private function updateState() : void {
         if((this._states) && (this.ico))
         {
            this.state = this.ico == IconsTypes.CREDITS && (this._states[0])?this._states[0]:this._states[1];
         }
         this.useAction = (this.state) && !(this._newPrice == this._oldPrice);
      }

      public function get newPrices() : Array {
         return this._newPrices;
      }

      public function set newPrices(param1:Array) : void {
         this._newPrices = param1;
         this.ico = this._newPrices[0] != 0?IconsTypes.CREDITS:IconsTypes.GOLD;
         this.updateNewPrice();
      }

      public function get newPrice() : Number {
         return this._newPrice;
      }

      public function set newPrice(param1:Number) : void {
         this._newPrice = param1;
         this.updateState();
      }

      public function get oldPrices() : Array {
         return this._oldPrices;
      }

      public function set oldPrices(param1:Array) : void {
         this._oldPrices = param1;
         this.updateOldPrice();
      }

      private function updateOldPrice() : void {
         if((this._oldPrices) && this._oldPrices.length == 2)
         {
            this.oldPrice = this.ico == IconsTypes.CREDITS?this._oldPrices[0]:this._oldPrices[1];
         }
      }

      private function updateNewPrice() : void {
         if((this._newPrices) && this._newPrices.length == 2)
         {
            this.newPrice = this.ico == IconsTypes.CREDITS?this._newPrices[0]:this._newPrices[1];
         }
      }

      public function get oldPrice() : Number {
         return this._oldPrice;
      }

      public function set oldPrice(param1:Number) : void {
         this._oldPrice = param1;
         this.updateState();
      }

      public function get ico() : String {
         return this._ico;
      }

      public function set ico(param1:String) : void {
         this._ico = param1;
         this._forCredits = this._ico == IconsTypes.CREDITS;
         this.updateNewPrice();
         this.updateOldPrice();
      }

      public function get useSign() : Boolean {
         return this._useSign;
      }

      public function set useSign(param1:Boolean) : void {
         if(param1 == this._useSign)
         {
            return;
         }
         this._useSign = param1;
      }

      public function get forCredits() : Boolean {
         return this._forCredits;
      }

      public function set forCredits(param1:Boolean) : void {
         var _loc2_:IAssertable = App.utils.asserter;
         _loc2_.assertNotNull(this.data,"forCredits must be set after parse data for VO",ActionPriceVO);
         this._forCredits = param1;
         this._ico = this._forCredits?IconsTypes.CREDITS:IconsTypes.GOLD;
         this._newPrice = this._forCredits?this.newPrices[0]:this.newPrices[1];
         this._oldPrice = this._forCredits?this.oldPrices[0]:this.oldPrices[1];
         this.updateState();
      }

      public function get externalSign() : String {
         return this._externalSign;
      }

      public function set externalSign(param1:String) : void {
         if(param1 == this._externalSign)
         {
            return;
         }
         this._externalSign = param1;
      }
   }

}