package net.wg.gui.lobby.sellDialog
{
   import scaleform.clik.controls.ListItemRenderer;
   import net.wg.infrastructure.interfaces.ISaleItemBlockRenderer;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.controls.AlertIco;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.ActionPrice;
   import scaleform.clik.controls.Button;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ListEvent;
   import net.wg.data.VO.SellDialogElement;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Currencies;
   import net.wg.data.constants.FittingTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.data.constants.Tooltips;
   import net.wg.gui.events.VehicleSellDialogEvent;
   
   public class SaleItemBlockRenderer extends ListItemRenderer implements ISaleItemBlockRenderer
   {
      
      public function SaleItemBlockRenderer() {
         super();
      }
      
      private static const RIGHT_MARGIN:Number = 7;
      
      public var tfShort:TextFieldShort;
      
      public var alertIcon:AlertIco;
      
      public var ddm:DropdownMenu;
      
      public var money:IconText;
      
      public var actionPrice:ActionPrice;
      
      public var clickArea:Button;
      
      public var itemUnderline:MovieClip;
      
      private var _type:String;
      
      private var _toInventory:Boolean;
      
      private var _fromInventory:Boolean;
      
      private var _id:String;
      
      private var _isRemovable:Boolean;
      
      private var _moneyValue:Number = 0;
      
      private var _intCD:Number = -1;
      
      private var _count:Number = 1;
      
      public var _kind:String = "";
      
      private var _removePrice:Number = 0;
      
      private var _actionPriceDataVo:ActionPriceVO = null;
      
      private var _actionPriceRemoveVo:ActionPriceVO = null;
      
      private var _sellExternalData:Array = null;
      
      override protected function onDispose() : void {
         super.onDispose();
         this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onAlertIconRollOverHdlr,false);
         this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onAlertIconRollOutHdlr,false);
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.clickArea.removeEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver,false);
         this.clickArea.removeEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut,false);
         this.clickArea.removeEventListener(MouseEvent.MOUSE_DOWN,handleMousePress,false);
         this.clickArea.removeEventListener(MouseEvent.CLICK,handleMouseRelease,false);
         this.clickArea.removeEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease);
         this.clickArea.dispose();
         this.clickArea = null;
         if(this.ddm)
         {
            this.ddm.removeEventListener(ListEvent.INDEX_CHANGE,this.onChangeHandler);
            this.ddm.dispose();
         }
         this.ddm = null;
         this.tfShort.dispose();
         this.tfShort = null;
         this.money.dispose();
         this.money = null;
         this.actionPrice.dispose();
         this.actionPrice = null;
      }
      
      override public function setData(param1:Object) : void {
         this.data = param1;
         var _loc2_:SellDialogElement = SellDialogElement(param1);
         this._toInventory = _loc2_.toInventory;
         this._fromInventory = _loc2_.fromInventory;
         this._isRemovable = _loc2_.isRemovable;
         this._moneyValue = _loc2_.moneyValue;
         this._intCD = _loc2_.intCD;
         this._count = _loc2_.count;
         this._kind = _loc2_.kind;
         this._type = _loc2_.type;
         this._id = _loc2_.id;
         this._removePrice = _loc2_.removePrice;
         this._actionPriceRemoveVo = _loc2_.removeActionPriceVo;
         this._actionPriceDataVo = _loc2_.sellActionPriceVo;
         this._sellExternalData = _loc2_.sellExternalData;
         invalidateData();
      }
      
      override public function setSize(param1:Number, param2:Number) : void {
         this.money.x = param1 - this.money.width - RIGHT_MARGIN;
         this.actionPrice.x = param1 - 5;
         this.itemUnderline.width = param1;
      }
      
      public function setColor(param1:Number) : void {
         this.money.textColor = param1;
      }
      
      public function hideLine() : void {
         this.itemUnderline.visible = false;
      }
      
      public function get toInventory() : Boolean {
         return this._toInventory;
      }
      
      public function get fromInventory() : Boolean {
         return this._fromInventory;
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
      
      public function get intCD() : Number {
         return this._intCD;
      }
      
      public function get count() : Number {
         return this._count;
      }
      
      public function get sellExternalData() : Array {
         return this._sellExternalData;
      }
      
      override protected function configUI() : void {
         this.buttonMode = false;
         this.money.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
         this.actionPrice.textYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
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
      
      override protected function draw() : void {
         var _loc1_:String = null;
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (data))
         {
            this.ddm.addEventListener(ListEvent.INDEX_CHANGE,this.onChangeHandler);
            if(this.toInventory)
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
                  this.money.text = this.getSign(-this._removePrice,Currencies.GOLD);
                  this.money.icon = Currencies.GOLD;
                  this.alertIcon.visible = true;
                  if(this._removePrice != 0)
                  {
                     if(this._actionPriceRemoveVo)
                     {
                        this._actionPriceRemoveVo.useSign = true;
                        this._actionPriceRemoveVo.externalSign = "-";
                        this._actionPriceRemoveVo.forCredits = false;
                     }
                     this.actionPrice.setData(this._actionPriceRemoveVo);
                  }
                  else
                  {
                     this.actionPrice.visible = false;
                  }
               }
               else
               {
                  this.money.text = "0";
                  this.money.textColor = 13556185;
                  this.money.icon = Currencies.CREDITS;
                  this.alertIcon.visible = false;
                  this.actionPrice.visible = false;
               }
            }
            else
            {
               this.alertIcon.visible = false;
               this.money.text = this.getSign(this._moneyValue,Currencies.CREDITS);
               this.money.textColor = 13556185;
               this.money.icon = Currencies.CREDITS;
               if(this._actionPriceDataVo)
               {
                  this._actionPriceDataVo.useSign = true;
                  this._actionPriceDataVo.forCredits = true;
                  this._actionPriceDataVo.newPrice = this.moneyValue;
               }
               this.actionPrice.setData(this._actionPriceDataVo);
            }
            this.money.visible = !this.actionPrice.visible;
         }
         if(this._type == FittingTypes.SHELL)
         {
            if(this._kind != Values.EMPTY_STR)
            {
               _loc1_ = App.utils.locale.makeString(ITEM_TYPES.shell_kindsabbreviation(this._kind));
               this.tfShort.label = _loc1_ + " " + this._id;
               this.tfShort.altToolTip = App.utils.locale.makeString(ITEM_TYPES.shell_kinds(this._kind)) + " " + data.id;
            }
         }
         else
         {
            this.tfShort.label = this._id;
         }
         constraints.update(this._width,this._height);
      }
      
      private function getSign(param1:Number, param2:String) : String {
         if(param2 == Currencies.CREDITS)
         {
            return (param1 > 0?"+":"") + App.utils.locale.integer(param1);
         }
         return (param1 > 0?"+":"") + App.utils.locale.gold(param1);
      }
      
      private function onAlertIconRollOverHdlr(param1:MouseEvent) : void {
         var _loc2_:TooltipProps = null;
         if(this.ddm.selectedIndex == 1)
         {
            _loc2_ = new TooltipProps(Tooltips.TYPE_INFO,0,0,0,-1,0,330);
            App.toolTipMgr.showComplex(TOOLTIPS.VEHICLESELLDIALOG_RENDERER_ALERTICON,_loc2_);
         }
      }
      
      private function onAlertIconRollOutHdlr(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
      
      private function onChangeHandler(param1:ListEvent) : void {
         if(param1.index == 1)
         {
            this._toInventory = true;
            if(!this.isRemovable)
            {
               this.money.text = this.getSign(-this._removePrice,Currencies.GOLD);
               this.money.textColor = 16763253;
               this.money.icon = Currencies.GOLD;
               this.alertIcon.visible = true;
               if(this._removePrice != 0)
               {
                  if(this._actionPriceRemoveVo)
                  {
                     this._actionPriceRemoveVo.useSign = true;
                     this._actionPriceRemoveVo.externalSign = "-";
                     this._actionPriceRemoveVo.forCredits = false;
                  }
                  this.actionPrice.setData(this._actionPriceRemoveVo);
               }
               else
               {
                  this.actionPrice.visible = false;
               }
            }
            else
            {
               this.money.text = "0";
               this.money.textColor = 13556185;
               this.money.icon = Currencies.CREDITS;
               this.alertIcon.visible = false;
               this.actionPrice.visible = false;
            }
         }
         else
         {
            this.alertIcon.visible = false;
            this._toInventory = false;
            this.money.text = this.getSign(this.moneyValue,Currencies.CREDITS);
            this.money.icon = Currencies.CREDITS;
            this.money.textColor = 13556185;
            if(this._actionPriceDataVo)
            {
               this._actionPriceDataVo.useSign = true;
               this._actionPriceDataVo.forCredits = true;
               this._actionPriceDataVo.newPrice = this.moneyValue;
            }
            this.actionPrice.setData(this._actionPriceDataVo);
         }
         this.money.visible = !this.actionPrice.visible;
         dispatchEvent(new VehicleSellDialogEvent(VehicleSellDialogEvent.UPDATE_RESULT));
      }
   }
}
