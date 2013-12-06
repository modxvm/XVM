package net.wg.gui.lobby.sellDialog
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.ActionPrice;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.TankIcon;
   import net.wg.gui.components.controls.DropdownMenu;
   import flash.display.MovieClip;
   import net.wg.utils.ILocale;
   import flash.text.TextFormat;
   import scaleform.clik.data.DataProvider;


   public class SellHeaderComponent extends UIComponent
   {
          
      public function SellHeaderComponent() {
         super();
         this.locale = App.utils.locale;
      }

      private static const VEHICLE_LEVELS:Array;

      private static const PADDING_FOR_NEXT_ELEMENT:int = 8;

      private static function showLevel(param1:Number) : String {
         return VEHICLE_LEVELS[param1-1].toString();
      }

      public var emptySellIT:IconText;

      public var vehicleActionPrice:ActionPrice;

      public var tankLevelTF:TextField;

      public var tankNameTF:TextField;

      public var tankPriceTF:TextField;

      public var tankDescribeTF:TextField;

      public var tankIcon:TankIcon;

      public var crewTF:TextField;

      public var inBarracsDrop:DropdownMenu;

      public var crewBG:MovieClip;

      private var _tankPrice:Number = 0;

      private var _tankGoldPrice:Number = 0;

      private var _creditsCommon:Number = 0;

      private var locale:ILocale;

      override public function dispose() : void {
         super.dispose();
         this.vehicleActionPrice.dispose();
         this.emptySellIT.dispose();
         this.inBarracsDrop.dispose();
         this.tankIcon.dispose();
      }

      override protected function configUI() : void {
         super.configUI();
         this.tankPriceTF.text = DIALOGS.VEHICLESELLDIALOG_VEHICLE_EMPTYSELLPRICE;
         this.emptySellIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
         this.vehicleActionPrice.textYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
      }

      public function get tankGoldPrice() : Number {
         return this._tankGoldPrice;
      }

      public function set tankGoldPrice(param1:Number) : void {
         this._tankGoldPrice = param1;
      }

      public function set tankPrice(param1:Number) : void {
         this._tankPrice = param1;
      }

      public function get tankPrice() : Number {
         return this._tankPrice;
      }

      public function set creditsCommon(param1:Number) : void {
         this._creditsCommon = param1;
      }

      public function get creditsCommon() : Number {
         return this._creditsCommon;
      }

      public function setData(param1:Object) : void {
         var _loc2_:String = null;
         this.tankNameTF.text = param1.userName;
         if(param1.isElite)
         {
            _loc2_ = this.locale.makeString(TOOLTIPS.tankcaruseltooltip_vehicletype_elite(param1.type),{});
         }
         else
         {
            _loc2_ = this.locale.makeString(DIALOGS.vehicleselldialog_vehicletype(param1.type),{});
         }
         this.tankDescribeTF.text = _loc2_;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_ = this.tankLevelTF.getTextFormat();
         _loc3_.color = 16643278;
         var _loc4_:String = showLevel(param1.level);
         this.tankLevelTF.text = _loc4_ + " " + this.locale.makeString(DIALOGS.VEHICLESELLDIALOG_VEHICLE_LEVEL);
         this.tankLevelTF.setTextFormat(_loc3_,0,_loc4_.length);
         this.tankIcon.image = param1.icon;
         this.tankIcon.level = param1.level;
         this.tankIcon.isElite = param1.isElite;
         this.tankIcon.isPremium = param1.isPremium;
         this.tankIcon.tankType = param1.type;
         this.tankIcon.nation = param1.nationID;
         var _loc5_:String = this.locale.makeString(DIALOGS.GATHERINGXPFORM_HEADERBUTTONS_CREW);
         this.inBarracsDrop.dataProvider = new DataProvider([{"label":MENU.BARRACKS_BTNUNLOAD},{"label":MENU.BARRACKS_BTNDISSMISS}]);
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         while(_loc7_ < param1.crew.length)
         {
            if(param1.crew[_loc7_] != (undefined))
            {
               _loc6_++;
            }
            _loc7_++;
         }
         if(_loc6_ == 0)
         {
            this.inBarracsDrop.selectedIndex = 1;
            this.inBarracsDrop.enabled = false;
         }
         else
         {
            this.inBarracsDrop.selectedIndex = 0;
            this.inBarracsDrop.enabled = true;
         }
         this.inBarracsDrop.validateNow();
         this.crewTF.text = _loc5_.toUpperCase() + ": ";
         if(param1.sellPrice[1] > 0)
         {
            this._tankGoldPrice = param1.sellPrice[1];
            this._tankPrice = 0;
            this.showPrice(true,this._tankGoldPrice,param1.defSellPrice[1],param1.sellActionPrc);
         }
         else
         {
            this._tankPrice = param1.sellPrice[0];
            this._tankGoldPrice = 0;
            this.showPrice(false,this._tankPrice,param1.defSellPrice[0],param1.sellActionPrc);
            this._creditsCommon = this._creditsCommon + this.tankPrice;
         }
      }

      private function showPrice(param1:Boolean, param2:Number, param3:Number, param4:Number) : void {
         if(param1)
         {
            this.emptySellIT.text = "+ " + this.locale.gold(param2);
         }
         else
         {
            this.emptySellIT.text = "+ " + this.locale.integer(param2);
         }
         this.emptySellIT.icon = param1?IconText.GOLD:IconText.CREDITS;
         this.emptySellIT.textColor = param1?16763253:13556185;
         this.emptySellIT.validateNow();
         this.vehicleActionPrice.setData(param4,param2,param3,param1?IconText.GOLD:IconText.CREDITS,false,ActionPrice.ITEM_TYPE_VEHICLE);
         this.emptySellIT.visible = !this.vehicleActionPrice.visible;
      }

      public function getNextPosition() : int {
         return this.crewBG.y + this.crewBG.height + PADDING_FOR_NEXT_ELEMENT;
      }
   }

}