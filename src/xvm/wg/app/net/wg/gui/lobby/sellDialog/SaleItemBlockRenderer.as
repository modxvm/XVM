package net.wg.gui.lobby.sellDialog
{
   import scaleform.clik.controls.ListItemRenderer;
   import net.wg.infrastructure.interfaces.ISaleItemBlockRenderer;
   import net.wg.gui.components.controls.TextFieldShort;
   import scaleform.clik.controls.Button;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.IconText;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.data.constants.Tooltips;
   import net.wg.data.VO.SellDialogElement;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Currencies;
   import net.wg.gui.events.VehicleSellDialogEvent;


   public class SaleItemBlockRenderer extends ListItemRenderer implements ISaleItemBlockRenderer
   {
          
      public function SaleItemBlockRenderer() {
         super();
      }

      private static const RIGHT_MARGIN:Number = 7;

      public var tfShort:TextFieldShort;

      public var alertIcon:Button;

      public var ddm:DropdownMenu;

      public var money:IconText;

      public var clickArea:Button;

      public var itemUnderline:MovieClip;

      private var _inInventory:Boolean;

      private var _type:String;

      private var _id:String;

      private var _isRemovable:Boolean;

      private var _moneyValue:Number = 0;

      private var _dataInfo:Object = null;

      private var _removePrice:Number = 0;

      override public function dispose() : void {
         super.dispose();
         this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onAlertIconRollOverHdlr,false);
         this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onAlertIconRollOutHdlr,false);
         this.alertIcon.dispose();
         this.clickArea.removeEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver,false);
         this.clickArea.removeEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut,false);
         this.clickArea.removeEventListener(MouseEvent.MOUSE_DOWN,handleMousePress,false);
         this.clickArea.removeEventListener(MouseEvent.CLICK,handleMouseRelease,false);
         this.clickArea.removeEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease);
         this.clickArea.dispose();
         if(this.ddm)
         {
            this.ddm.removeEventListener(ListEvent.INDEX_CHANGE,this.onChangeHandler);
            this.ddm.dispose();
         }
         this.tfShort.dispose();
         this.money.dispose();
         this.clickArea.dispose();
         if(this._dataInfo)
         {
            this._dataInfo = null;
         }
      }

      override protected function configUI() : void {
         this.buttonMode = false;
         this.money.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
         this.ddm.dataProvider = new DataProvider([{"label":DIALOGS.SELLCONFIRMATION_SUBMIT},{"label":DIALOGS.VEHICLESELLDIALOG_UNLOAD}]);
         this.alertIcon.addEventListener(MouseEvent.ROLL_OVER,this.onAlertIconRollOverHdlr,false,0,true);
         this.alertIcon.addEventListener(MouseEvent.ROLL_OUT,this.onAlertIconRollOutHdlr,false,0,true);
         this.alertIcon.buttonMode = false;
         this.tfShort.buttonMode = false;
         if(this.clickArea)
         {
            this.clickArea.addEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver,false,0,true);
            this.clickArea.addEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut,false,0,true);
            this.clickArea.addEventListener(MouseEvent.MOUSE_DOWN,handleMousePress,false,0,true);
            this.clickArea.addEventListener(MouseEvent.CLICK,handleMouseRelease,false,0,true);
            this.clickArea.addEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease,false,0,true);
            this.clickArea.buttonMode = false;
         }
         if(!(_focusIndicator == null) && !_focused && _focusIndicator.totalFrames == 1)
         {
            focusIndicator.visible = false;
         }
      }

      private function onAlertIconRollOverHdlr(param1:MouseEvent) : void {
         var _loc2_:TooltipProps = new TooltipProps(Tooltips.TYPE_INFO,0,0,0,-1,0,330);
         App.toolTipMgr.showComplex(TOOLTIPS.VEHICLESELLDIALOG_RENDERER_ALERTICON,_loc2_);
      }

      private function onAlertIconRollOutHdlr(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      public function setColor(param1:Number) : void {
         this.money.textColor = param1;
      }

      public function get inInventory() : Boolean {
         return this._inInventory;
      }

      public function get isRemovable() : Boolean {
         return this._isRemovable;
      }

      public function get moneyValue() : Number {
         return this._moneyValue;
      }

      public function get type() : String {
         return this._type;
      }

      public function get dataInfo() : Object {
         return this._dataInfo;
      }

      override public function setData(param1:Object) : void {
         this.data = param1;
         var _loc2_:SellDialogElement = SellDialogElement(param1);
         this._inInventory = _loc2_.inInventory;
         this._isRemovable = _loc2_.isRemovable;
         this._moneyValue = _loc2_.moneyValue;
         this._dataInfo = _loc2_.data;
         this._type = _loc2_.type;
         this._id = _loc2_.id;
         this._removePrice = _loc2_.removePrice;
         invalidateData();
      }

      override protected function draw() : void {
         var _loc1_:String = null;
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (data))
         {
            this.ddm.addEventListener(ListEvent.INDEX_CHANGE,this.onChangeHandler);
            if(this.inInventory)
            {
               this.ddm.selectedIndex = 1;
            }
            else
            {
               this.ddm.selectedIndex = 0;
            }
            if(this.ddm.selectedIndex == 1)
            {
               if(!this.isRemovable)
               {
                  this.money.textColor = 16763253;
                  this.money.text = "- " + App.utils.locale.gold(this._removePrice);
                  this.money.icon = Currencies.GOLD;
                  this.alertIcon.visible = true;
               }
               else
               {
                  this.money.text = "0";
                  this.money.textColor = 13556185;
                  this.money.icon = Currencies.CREDITS;
                  this.alertIcon.visible = false;
               }
            }
            else
            {
               this.money.text = this.getCreditsString(this._moneyValue);
               this.money.textColor = 13556185;
               this.money.icon = Currencies.CREDITS;
               this.alertIcon.visible = false;
            }
         }
         if(this._type == "shells" || this._type == "invShells")
         {
            if(this._dataInfo.hasOwnProperty("kind"))
            {
               _loc1_ = App.utils.locale.makeString(ITEM_TYPES.shell_kindsabbreviation(this._dataInfo.kind));
               this.tfShort.label = _loc1_ + " " + this._id;
               this.tfShort.altToolTip = App.utils.locale.makeString(ITEM_TYPES.shell_kinds(this._dataInfo.kind)) + " " + data.id;
            }
         }
         else
         {
            this.tfShort.label = this._id;
         }
         constraints.update(this._width,this._height);
      }

      override public function setSize(param1:Number, param2:Number) : void {
         this.money.x = param1 - this.money.width - RIGHT_MARGIN;
         this.itemUnderline.width = param1;
      }

      private function onChangeHandler(param1:ListEvent) : void {
         if(param1.index == 1)
         {
            this._inInventory = true;
            if(!this.isRemovable)
            {
               this.money.text = "- " + App.utils.locale.gold(this._removePrice);
               this.money.textColor = 16763253;
               this.money.icon = Currencies.GOLD;
               this.alertIcon.visible = true;
            }
            else
            {
               this.money.text = "0";
               this.money.textColor = 13556185;
               this.money.icon = Currencies.CREDITS;
               this.alertIcon.visible = false;
            }
         }
         else
         {
            this._inInventory = false;
            this.money.text = this.getCreditsString(this.moneyValue);
            this.money.icon = Currencies.CREDITS;
            this.money.textColor = 13556185;
            this.alertIcon.visible = false;
         }
         dispatchEvent(new VehicleSellDialogEvent(VehicleSellDialogEvent.UPDATE_RESULT));
      }

      private function getCreditsString(param1:Number) : String {
         return (param1 != 0?"+ ":"") + App.utils.locale.gold(param1);
      }

      public function hideLine() : void {
         this.itemUnderline.visible = false;
      }
   }

}