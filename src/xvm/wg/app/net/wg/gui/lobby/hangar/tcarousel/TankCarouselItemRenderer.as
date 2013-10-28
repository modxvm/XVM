package net.wg.gui.lobby.hangar.tcarousel
{
   import net.wg.gui.components.controls.DragableListItemRenderer;
   import net.wg.gui.components.advanced.TankIcon;
   import net.wg.gui.components.controls.IconText;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.SoundManagerStates;
   import flash.display.FrameLabel;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import __AS3__.vec.Vector;


   public class TankCarouselItemRenderer extends DragableListItemRenderer
   {
          
      public function TankCarouselItemRenderer() {
         super();
         focusIndicator = this.focusIndicator1;
         if(this.hitMC)
         {
            this.hitArea = this.hitMC;
         }
      }

      private var _id:String = "";

      private var _image:String = "";

      private var _nation:Number = -1;

      private var _level:Number = -1;

      private var _stat:String = "";

      private var _current:Number = -1;

      private var _stateLevel:String = "";

      private var _doubleXPReceived:Number = 0;

      private var _compactDescr:Number = -1;

      private var _favorite:Boolean = false;

      private var _canSell:Boolean = false;

      private var _clanLock:Number = -1;

      private var _elite:Boolean = false;

      private var _premium:Boolean = false;

      private var _tankType:String = "";

      private var _exp:Number = 0;

      private var _buyTank:Boolean = false;

      private var _buySlot:Boolean = false;

      private var _avalibleSlots:Number = 0;

      private var _slotPrice:Number = 0;

      public var vehicleIcon:TankIcon;

      public var slotPrice:IconText;

      public var statusText:TextField;

      public var emptyInfoTxt:TextField;

      public var bg_switcher:MovieClip;

      public var hitMC:MovieClip;

      public var clanLockUI:ClanLockUI;

      public var focusIndicator1:MovieClip = null;

      override public function dispose() : void {
         if(this.vehicleIcon)
         {
            this.vehicleIcon.dispose();
            this.vehicleIcon = null;
         }
         if(this.vehicleIcon)
         {
            this.slotPrice.dispose();
            this.slotPrice = null;
         }
         if(this.statusText.filters)
         {
            this.statusText.filters.splice(0,this.statusText.filters.length);
         }
         this.statusText = null;
         this.emptyInfoTxt = null;
         this.bg_switcher = null;
         this.hitMC = null;
         if(this.clanLockUI)
         {
            this.clanLockUI.dispose();
            this.clanLockUI = null;
         }
         this.focusIndicator1 = null;
         super.dispose();
      }

      override protected function configUI() : void {
         var _loc2_:Object = null;
         super.configUI();
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.leading = -6;
         if(this.statusText)
         {
            this.statusText.autoSize = "center";
            this.statusText.text = this._stat == "undamaged"?"":"#menu:tankCarousel/vehicleStates/" + this._stat;
            this.statusText.setTextFormat(_loc1_);
            this.statusText.y = _height - this.statusText.textHeight >> 1;
            if(this._stat)
            {
               _loc2_ = this.getStatColor(this._stat);
               this.statusText.textColor = _loc2_.color;
               this.statusText.filters = _loc2_.filterArray;
            }
         }
         this.soundType = SoundTypes.CAROUSEL_BTN;
         this.soundId = SoundManagerStates.CAROUSEL_CELL_BTN;
      }

      override public function setData(param1:Object) : void {
         if(param1)
         {
            this.visible = true;
            this.data = param1;
            this.id = param1.id;
            label = param1.label;
            this.image = param1.image;
            this.nation = param1.nation;
            this.level = param1.level;
            this.stat = param1.stat;
            this.current = param1.current;
            this._stateLevel = param1.stateLevel;
            this._doubleXPReceived = param1.doubleXPReceived;
            this._compactDescr = param1.compactDescr;
            this.favorite = param1.favorite;
            this._canSell = param1.canSell;
            this._clanLock = param1.clanLock;
            this._elite = param1.elite;
            this._premium = param1.premium;
            this._exp = param1.exp;
            empty = param1.empty;
            this.buyTank = param1.buyTank;
            this.buySlot = param1.buySlot;
            this._tankType = param1.tankType;
            this._avalibleSlots = param1.avalibleSlots;
            this._slotPrice = param1.slotPrice;
            _dataDirty = true;
            invalidate();
         }
      }

      override protected function draw() : void {
         var _loc1_:* = false;
         super.draw();
         if(_dataDirty)
         {
            if(((this.vehicleIcon) && (!empty)) && (!this.buyTank) && !this.buySlot)
            {
               this.vehicleIcon.image = this._image;
               this.vehicleIcon.showName = true;
               this.vehicleIcon.tankName = _label;
               this.vehicleIcon.level = this._level;
               this.vehicleIcon.isElite = this._elite;
               this.vehicleIcon.isPremium = this._premium;
               this.vehicleIcon.favorite = this._favorite;
               this.vehicleIcon.nation = this._nation;
               this.vehicleIcon.showMultyXp = true;
               this.vehicleIcon.multyXpVal = this._doubleXPReceived;
               this.vehicleIcon.tankType = this._tankType;
               this.vehicleIcon.validateNow();
               this.clanLockUI.timer = this._clanLock;
               if(this._clanLock > 0)
               {
                  this.statusText.y = Math.round(this.clanLockUI.y - this.clanLockUI.textField.height);
               }
               else
               {
                  this.statusText.y = _height - this.statusText.textHeight >> 1;
               }
            }
            _loc1_ = !(this._stat == "undamaged") && !_empty;
            this.statusText.visible = _loc1_;
            this.emptyInfoTxt.visible = false;
            if(this.buyTank)
            {
               this.emptyInfoTxt.text = MENU.TANKCAROUSEL_VEHICLESTATES_BUYTANKEMPTYCOUNT;
               this.emptyInfoTxt.text = this.emptyInfoTxt.text + " " + this._avalibleSlots;
               this.emptyInfoTxt.visible = true;
            }
            if(this.buySlot)
            {
               this.slotPrice.text = this._slotPrice.toString();
            }
            if(empty)
            {
               this.emptyInfoTxt.text = "";
            }
            _dataDirty = false;
         }
         this.scaleX = this.scaleY = 1;
      }

      public function get favorite() : Boolean {
         return this._favorite;
      }

      public function set favorite(param1:Boolean) : void {
         if(this._favorite == param1)
         {
            return;
         }
         this._favorite = param1;
         _dataDirty = true;
         invalidate();
      }

      public function get buyTank() : Boolean {
         return this._buyTank;
      }

      public function set buyTank(param1:Boolean) : void {
         if(this._buyTank == param1)
         {
            return;
         }
         this._buyTank = param1;
         _dataDirty = true;
         focusable = tabEnabled = this._buyTank?false:!this._buyTank;
         setState(!enabled?"disabled":"up");
      }

      public function get buySlot() : Boolean {
         return this._buySlot;
      }

      public function set buySlot(param1:Boolean) : void {
         if(this._buySlot == param1)
         {
            return;
         }
         this._buySlot = param1;
         _dataDirty = true;
         focusable = tabEnabled = this._buySlot?false:!this._buySlot;
         setState(!enabled?"disabled":"up");
      }

      public function get id() : String {
         return this._id;
      }

      public function set id(param1:String) : void {
         if(param1 != "")
         {
            this._id = param1;
         }
      }

      public function get image() : String {
         return this._image;
      }

      public function set image(param1:String) : void {
         if(param1)
         {
            this._image = param1;
            _dataDirty = true;
            invalidate();
         }
      }

      public function get nation() : Number {
         return this._nation;
      }

      public function set nation(param1:Number) : void {
         if(param1 >= 0)
         {
            this._nation = param1;
            _dataDirty = true;
            invalidate();
         }
      }

      public function get level() : Number {
         return this._level;
      }

      public function set level(param1:Number) : void {
         if(param1 >= 1)
         {
            this._level = param1;
            _dataDirty = true;
            invalidate();
         }
      }

      public function get stat() : String {
         return this._stat;
      }

      public function set stat(param1:String) : void {
         var _loc2_:TextFormat = null;
         var _loc3_:Object = null;
         if(param1 != "")
         {
            this._stat = param1;
            this.bg_switcher.gotoAndPlay(this.getBgLable(this._stat));
            if((initialized) && (this.statusText))
            {
               _loc2_ = new TextFormat();
               _loc2_.leading = -4;
               this.statusText.autoSize = "center";
               this.statusText.text = this._stat == "undamaged"?"":MENU.tankcarousel_vehiclestates(this._stat);
               this.statusText.setTextFormat(_loc2_);
               this.statusText.y = _height - this.statusText.textHeight >> 1;
               _loc3_ = this.getStatColor(this._stat);
               this.statusText.textColor = _loc3_.color;
               this.statusText.filters = _loc3_.filterArray;
               this.statusText.visible = true;
            }
         }
      }

      private function getBgLable(param1:String) : String {
         var _loc5_:FrameLabel = null;
         var _loc2_:* = "ready";
         var _loc3_:Array = this.bg_switcher.currentLabels;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            if(_loc5_.name == param1)
            {
               _loc2_ = param1;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }

      public function get current() : Number {
         return this._current;
      }

      public function set current(param1:Number) : void {
         if(param1 >= 0)
         {
            this._current = param1;
         }
      }

      private function getStatColor(param1:String) : Object {
         var _loc15_:DropShadowFilter = null;
         var _loc16_:GlowFilter = null;
         var _loc17_:DropShadowFilter = null;
         var _loc2_:Object = new Object();
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         var _loc10_:Number = 2;
         var _loc11_:* = false;
         var _loc12_:* = false;
         var _loc13_:* = false;
         var _loc14_:Array = new Array();
         switch(param1)
         {
            case "battle":
               _loc2_.color = 13617064;
               _loc3_ = 0;
               _loc4_ = 90;
               _loc5_ = 0;
               _loc6_ = 0.25;
               _loc7_ = 8;
               _loc8_ = 8;
               _loc9_ = 16;
               _loc10_ = 2;
               _loc11_ = false;
               _loc12_ = false;
               _loc13_ = false;
               _loc15_ = new DropShadowFilter();
               _loc15_.distance = _loc3_;
               _loc15_.angle = _loc4_;
               _loc15_.color = _loc5_;
               _loc15_.alpha = _loc6_;
               _loc15_.blurX = _loc7_;
               _loc15_.blurY = _loc8_;
               _loc15_.strength = _loc9_;
               _loc15_.quality = _loc10_;
               _loc15_.inner = _loc11_;
               _loc15_.knockout = _loc12_;
               _loc15_.hideObject = _loc13_;
               _loc14_.push(_loc15_);
               _loc2_.filterArray = _loc14_;
               break;
            case "buyTank":
            case "buySlot":
               _loc2_.color = 15329754;
               _loc5_ = 16777150;
               _loc6_ = 0.2;
               _loc7_ = 15;
               _loc8_ = 15;
               _loc9_ = 4;
               _loc10_ = 2;
               _loc11_ = false;
               _loc12_ = false;
               _loc16_ = new GlowFilter();
               _loc16_.color = _loc5_;
               _loc16_.alpha = _loc6_;
               _loc16_.blurX = _loc7_;
               _loc16_.blurY = _loc8_;
               _loc16_.strength = _loc9_;
               _loc16_.quality = _loc10_;
               _loc16_.inner = _loc11_;
               _loc16_.knockout = _loc12_;
               _loc14_.push(_loc16_);
               _loc2_.filterArray = _loc14_;
               break;
            case "ammoNotFull":
            case "exploded":
            case "destroyed":
            case "damaged":
            case "serverRestriction":
            case "crewNotFull":
               _loc2_.color = 15400960;
               _loc3_ = 0;
               _loc4_ = 90;
               _loc5_ = 0;
               _loc6_ = 0.25;
               _loc7_ = 8;
               _loc8_ = 8;
               _loc9_ = 16;
               _loc10_ = 2;
               _loc11_ = false;
               _loc12_ = false;
               _loc13_ = false;
               _loc17_ = new DropShadowFilter();
               _loc17_.distance = _loc3_;
               _loc17_.angle = _loc4_;
               _loc17_.color = _loc5_;
               _loc17_.alpha = _loc6_;
               _loc17_.blurX = _loc7_;
               _loc17_.blurY = _loc8_;
               _loc17_.strength = _loc9_;
               _loc17_.quality = _loc10_;
               _loc17_.inner = _loc11_;
               _loc17_.knockout = _loc12_;
               _loc17_.hideObject = _loc13_;
               _loc14_.push(_loc17_);
               _loc2_.filterArray = _loc14_;
               break;
         }
         return _loc2_;
      }

      override protected function getStatePrefixes() : Vector.<String> {
         if((_selected) && !_empty && !this._buyTank && !this._buySlot)
         {
            return Vector.<String>(["selected_",""]);
         }
         if(_empty)
         {
            return Vector.<String>(["empty_"]);
         }
         if(this._buyTank)
         {
            return Vector.<String>(["buyTank_"]);
         }
         if(this._buySlot)
         {
            return Vector.<String>(["buySlot_"]);
         }
         return Vector.<String>([""]);
      }

      override public function toString() : String {
         return "[WG TankCarouselItemRenderer]";
      }

      override public function get displayFocus() : Boolean {
         return _displayFocus;
      }

      override public function set displayFocus(param1:Boolean) : void {
         if(param1 == _displayFocus)
         {
            return;
         }
         _displayFocus = param1;
         changeFocus();
      }
   }

}