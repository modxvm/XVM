package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.utils.ILocale;
   import flash.events.Event;
   import __AS3__.vec.Vector;
   import net.wg.data.constants.SoundTypes;


   public class TankmanTrainingSmallButton extends SoundButton
   {
          
      public function TankmanTrainingSmallButton() {
         this._priceColors =
            {
               "normal":16314069,
               "disabled":16711680,
               "buy":5330004
            }
         ;
         super();
         _stateMap =
            {
               "up":["up"],
               "over":["over"],
               "down":["down"],
               "release":["release","over"],
               "out":["out","up"],
               "disabled":["disabled"],
               "selecting":["selecting","over"],
               "toggle":["toggle","up"],
               "kb_selecting":["kb_selecting","up"],
               "kb_release":["kb_release","out","up"],
               "kb_down":["kb_down","down"],
               "buy":["buy"]
            }
         ;
         soundType = SoundTypes.RNDR_NORMAL;
         soundId = "";
      }

      private static const UPDATE_DATA:String = "setDataUpdate";

      public var bg:MovieClip;

      public var typeSwitcher:MovieClip;

      public var actionPrice:ActionPrice;

      public var priceLabel:IconText;

      public var levelLabel:TextField;

      public var labelField:TextField;

      public var trainingLabel:TextField;

      public var _level:Number = 0;

      public var _buy:Boolean = false;

      public var _nation:Number = 0;

      public var _type:String = "free";

      public var _retraining:Boolean = true;

      public var _scopeType:String = "";

      protected var model:Object;

      private var currentMoney:int;

      protected var hasMoney:Boolean = false;

      private var credits:Number;

      private var gold:Number;

      private var isPremium:Boolean = false;

      private var isNativeVehicle:Boolean = false;

      protected var _specializationLevel:int = 0;

      private var levelText:Number = 0;

      private var isUpdated:Boolean = true;

      public var inspectableGroupName:String;

      private var _priceColors:Object;

      public function setDataForDropSkills(param1:Number, param2:Boolean, param3:Number=0, param4:Number=0) : void {
         if(!isNaN(param1))
         {
            this.price = param1.toString();
         }
         this.enabled = this.hasMoney = param2;
         var _loc5_:String = !param2?"disabled":"normal";
         this.priceLabel.textColor = this._priceColors[_loc5_];
         this.actionPrice.textColorType = param2?ActionPrice.TEXT_COLOR_TYPE_ICON:ActionPrice.TEXT_COLOR_TYPE_ERROR;
         var _loc6_:ActionPriceVO = new ActionPriceVO(param3,param1,param4,this.getIcoOfButtonType());
         this.actionPrice.setData(_loc6_);
         this.actionPrice.setup(this);
         this.priceLabel.visible = !this.actionPrice.visible;
      }

      public function get scopeType() : String {
         return this._scopeType;
      }

      public function set scopeType(param1:String) : void {
         this._scopeType = param1;
         this.draw();
      }

      public function get retraining() : Boolean {
         return this._retraining;
      }

      public function set retraining(param1:Boolean) : void {
         this._retraining = param1;
         this.typeSwitcher.gotoAndPlay(this._retraining?"retraining_" + this._type:this._type);
         this.trainingLabel.text = this._retraining?MENU.TANKMANTRAININGBUTTON2_RETRAININGTO:MENU.TANKMANTRAININGBUTTON2_TRAININGTO;
      }

      public function get nation() : Number {
         return this._nation;
      }

      public function set nation(param1:Number) : void {
         this.bg.gotoAndPlay(App.utils.nations.getNationName(param1));
      }

      public function get level() : Number {
         return this._level;
      }

      public function set level(param1:Number) : void {
         this._level = param1;
         this.levelLabel.text = param1.toString() + "%";
      }

      public function set type(param1:String) : void {
         this._type = param1;
         this.labelField.text = MENU.tankmantrainingwindow(this._type);
         this.typeSwitcher.gotoAndPlay(this._retraining?"retraining_" + this._type:this._type);
         if(this._type == "free")
         {
            this.priceLabel.icon = "empty";
            this.priceLabel.textAlign = "right";
            this.priceLabel.x = 268 + 10;
            this.priceLabel.text = MENU.TANKMANRETRAININGBTN_FREE;
            this.actionPrice.visible = false;
            this.priceLabel.visible = !this.actionPrice.visible;
         }
         else
         {
            this.priceLabel.icon = this._type == "academy"?"gold":"credits";
            this.priceLabel.x = 268;
         }
         if(this.priceLabel  is  ActionPrice)
         {
            this.priceLabel.invalidate();
            this.priceLabel.validateNow();
         }
         if(this.priceLabel  is  IconText)
         {
            this.priceLabel.invalidate();
            this.priceLabel.validateNow();
         }
      }

      public function get type() : String {
         return this._type;
      }

      public function get price() : String {
         return this.priceLabel.text;
      }

      public function set price(param1:String) : void {
         this.setTextColorToPriceLabel();
         var _loc2_:ILocale = App.utils.locale;
         this.priceLabel.text = this._type == "academy"?_loc2_.gold(param1):_loc2_.integer(param1);
      }

      public function get buy() : Boolean {
         return this._buy;
      }

      public function set buy(param1:Boolean) : void {
         this._buy = param1;
         if(this.isNativeVehicle)
         {
            if(this._buy)
            {
               this.setState("buy");
            }
         }
         else
         {
            if(currentLabel == "buy")
            {
               this.setState(this.hasMoney?"up":"disabled");
            }
         }
      }

      public function setData(param1:Object, param2:Number, param3:Number, param4:Number, param5:Boolean, param6:Boolean, param7:int, param8:Number) : void {
         if(param1 == null)
         {
            return;
         }
         this.isUpdated = false;
         this.model = param1;
         this.isNativeVehicle = param5;
         this.gold = param2;
         this.credits = param3;
         this.isPremium = this.model.isPremium;
         this.currentMoney = this.isPremium?param2:param3;
         this._specializationLevel = param4;
         this.hasMoney = this.model.isPremium?param2 >= this.model.gold:param3 >= this.model.credits;
         this.levelText = this.calculateCurrentLevel(param6,param4,this.model.baseRoleLoss,this.model.classChangeRoleLoss,this.model.roleLevel);
         this.level = this.levelText;
         this.setEnabled();
         this.setBUY();
         this.nation = param7;
         this.retraining = !param5;
         var _loc9_:Number = this.model.isPremium?this.model.gold:this.model.credits != 0?this.model.credits:null;
         var _loc10_:Number = this.model.isPremium?this.model.defGold:this.model.defCredits != 0?this.model.defCredits:null;
         this.price = _loc9_.toString();
         var _loc11_:ActionPriceVO = new ActionPriceVO(param8,_loc9_,_loc10_,this.getIcoOfButtonType());
         this.actionPrice.setData(_loc11_);
         this.actionPrice.textColorType = this.hasMoney?ActionPrice.TEXT_COLOR_TYPE_ICON:ActionPrice.TEXT_COLOR_TYPE_ERROR;
         this.actionPrice.setup(this);
         this.priceLabel.visible = !this.actionPrice.visible;
         this.type = this._type;
         invalidate(UPDATE_DATA);
      }

      private function getIcoOfButtonType() : String {
         var _loc1_:String = this._type == "free"?"":this._type == "academy"?"gold":"credits";
         return _loc1_;
      }

      override protected function configUI() : void {
         super.configUI();
         this.typeSwitcher.gotoAndPlay(this._retraining?"retraining_" + this._type:this._type);
         this.trainingLabel.text = this._retraining?MENU.TANKMANTRAININGBUTTON2_RETRAININGTO:MENU.TANKMANTRAININGBUTTON2_TRAININGTO;
         this.type = this._type;
         if(label)
         {
            this.labelField.text = label;
            this.trainingLabel.text = "";
         }
         if(this.actionPrice)
         {
            this.actionPrice.setup(this);
         }
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(UPDATE_DATA)) && !this.isUpdated)
         {
            this.refreshData();
         }
         this.setTextColorToPriceLabel();
         switch(this._scopeType)
         {
            case "dropSkills":
               this.labelField.text = MENU.skilldropwindow_study(this.getLabelType(this._type));
               this.trainingLabel.text = MENU.tankmantrainingwindow(this._type);
               break;
            default:
               this.labelField.text = MENU.tankmantrainingwindow(this._type);
         }
      }

      private function refreshData() : void {
         this.isUpdated = true;
         this.level = this.levelText;
         this.retraining = !this.isNativeVehicle;
      }

      private function getLabelType(param1:String) : String {
         var _loc2_:* = "";
         switch(param1)
         {
            case "academy":
               _loc2_ = "goldLabel";
               break;
            case "scool":
               _loc2_ = "creditsLabel";
               break;
            case "free":
               _loc2_ = "freeLabel";
               break;
         }
         return _loc2_;
      }

      private function setTextColorToPriceLabel() : void {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(this.model == null || this._specializationLevel == 0 || !this.priceLabel)
         {
            return;
         }
         if(this.isNativeVehicle)
         {
            if(this._specializationLevel >= this.level)
            {
               this.priceLabel.textColor = this._priceColors["buy"];
               this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_DISABLE;
            }
            else
            {
               _loc1_ = !this.hasMoney?"disabled":"normal";
               this.priceLabel.textColor = this._priceColors[_loc1_];
               this.actionPrice.textColorType = this.hasMoney?ActionPrice.TEXT_COLOR_TYPE_ICON:ActionPrice.TEXT_COLOR_TYPE_ERROR;
            }
         }
         else
         {
            if(!this.hasMoney)
            {
               this.priceLabel.textColor = this._priceColors["disabled"];
               this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
            }
            else
            {
               _loc2_ = enabled?"normal":"buy";
               this.priceLabel.textColor = this._priceColors[_loc2_];
               this.actionPrice.textColorType = enabled?ActionPrice.TEXT_COLOR_TYPE_ICON:ActionPrice.TEXT_COLOR_TYPE_DISABLE;
            }
         }
      }

      protected function setEnabled() : void {
         if(this.isNativeVehicle)
         {
            this.enabled = this._specializationLevel < this.level && (this.hasMoney);
         }
         else
         {
            this.enabled = this.hasMoney;
         }
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         if(this.actionPrice)
         {
            this.actionPrice.setup(this);
         }
      }

      protected function setBUY() : void {
         if(this.isNativeVehicle)
         {
            this.buy = this._specializationLevel >= this.level;
         }
         else
         {
            this.buy = false;
         }
      }

      protected function calculateCurrentLevel(param1:Boolean, param2:Number, param3:Number, param4:Number, param5:Number) : Number {
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         if(param1)
         {
            _loc6_ = param2 - Math.floor(param2 * param3);
         }
         else
         {
            _loc7_ = param3 + param4;
            _loc6_ = param2 - Math.floor(param2 * _loc7_);
         }
         _loc6_ = _loc6_ < param5?param5:_loc6_;
         return _loc6_;
      }

      override public function set selected(param1:Boolean) : void {
         var _loc2_:* = false;
         var _loc3_:* = false;
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         if(enabled)
         {
            if(!_focused)
            {
               this.setState("toggle");
            }
            else
            {
               if((_pressedByKeyboard) && !(_focusIndicator == null))
               {
                  this.setState("kb_selecting");
               }
               else
               {
                  this.setState("selecting");
               }
            }
            if(owner)
            {
               _loc2_ = (_selected) && !(owner == null) && (checkOwnerFocused());
               this.setState((_loc2_) && _focusIndicator == null?"selecting":"toggle");
               displayFocus = _loc2_;
            }
         }
         else
         {
            _loc3_ = this._specializationLevel >= this.level;
            if((this.isNativeVehicle) && (_loc3_) || !this.isNativeVehicle && (_loc3_) && (this.hasMoney))
            {
               this.setState("buy");
            }
            else
            {
               this.setState("disabled");
            }
         }
         validateNow();
         dispatchEvent(new Event(Event.SELECT));
      }

      override protected function setState(param1:String) : void {
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         _state = param1;
         var _loc2_:Vector.<String> = getStatePrefixes();
         var _loc3_:Array = _stateMap[param1];
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return;
         }
         var _loc4_:uint = _loc2_.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc2_[_loc5_];
            _loc7_ = _loc3_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc9_ = _loc6_ + _loc3_[_loc8_];
               if(_labelHash[_loc9_])
               {
                  _newFrame = _loc9_;
                  invalidateState();
                  return;
               }
               _loc8_++;
            }
            _loc5_++;
         }
      }

      private function disposeComponent() : void {
         this.bg = null;
         this.priceLabel.dispose();
         this.priceLabel = null;
         this.actionPrice.dispose();
         this.actionPrice = null;
         this.levelLabel = null;
         this.labelField = null;
         this.trainingLabel = null;
         this.model = null;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.disposeComponent();
      }
   }

}