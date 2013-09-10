package net.wg.gui.lobby.hangar.tcarousel 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    
    public class TankCarouselItemRenderer extends net.wg.gui.components.controls.DragableListItemRenderer
    {
        public function TankCarouselItemRenderer()
        {
            super();
            focusIndicator = this.focusIndicator1;
            if (this.hitMC) 
            {
                this.hitArea = this.hitMC;
            }
            return;
        }

        internal function getBgLable(arg1:String):String
        {
            var loc4:*=null;
            var loc1:*="ready";
            var loc2:*=this.bg_switcher.currentLabels;
            var loc3:*=0;
            while (loc3 < loc2.length) 
            {
                if ((loc4 = loc2[loc3]).name == arg1) 
                {
                    loc1 = arg1;
                    break;
                }
                ++loc3;
            }
            return loc1;
        }

        public function set buyTank(arg1:Boolean):void
        {
            if (this._buyTank == arg1) 
            {
                return;
            }
            this._buyTank = arg1;
            _dataDirty = true;
            var loc1:*;
            tabEnabled = loc1 = this._buyTank ? false : !this._buyTank;
            focusable = loc1;
            setState(enabled ? "up" : "disabled");
            return;
        }

        protected override function configUI():void
        {
            var loc2:*=null;
            super.configUI();
            var loc1:*=new flash.text.TextFormat();
            loc1.leading = -6;
            if (this.statusText) 
            {
                this.statusText.autoSize = "center";
                this.statusText.multiline = true;
                this.statusText.text = this._stat != "undamaged" ? "#menu:tankCarousel/vehicleStates/" + this._stat : "";
                this.statusText.setTextFormat(loc1);
                this.statusText.y = _height - this.statusText.textHeight >> 1;
                if (this._stat) 
                {
                    loc2 = this.getStatColor(this._stat);
                    this.statusText.textColor = loc2.color;
                    this.statusText.filters = loc2.filterArray;
                }
            }
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1) 
            {
                this.visible = true;
                this.data = arg1;
                this.id = arg1.id;
                label = arg1.label;
                this.image = arg1.image;
                this.nation = arg1.nation;
                this.level = arg1.level;
                this.stat = arg1.stat;
                this.current = arg1.current;
                this._stateLevel = arg1.stateLevel;
                this._doubleXPReceived = arg1.doubleXPReceived;
                this._compactDescr = arg1.compactDescr;
                this.favorite = arg1.favorite;
                this._canSell = arg1.canSell;
                this._clanLock = arg1.clanLock;
                this._elite = arg1.elite;
                this._premium = arg1.premium;
                this._exp = arg1.exp;
                empty = arg1.empty;
                this.buyTank = arg1.buyTank;
                this.buySlot = arg1.buySlot;
                this._tankType = arg1.tankType;
                this._avalibleSlots = arg1.avalibleSlots;
                this._slotPrice = arg1.slotPrice;
                _dataDirty = true;
                invalidate();
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=false;
            super.draw();
            if (_dataDirty) 
            {
                if (this.vehicleIcon && !empty && !this.buyTank && !this.buySlot) 
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
                    if (this._clanLock >= 0) 
                    {
                        this.statusText.y = Math.round(this.clanLockUI.y - this.clanLockUI.textField.height);
                    }
                    else 
                    {
                        this.statusText.y = 39;
                    }
                }
                loc1 = !(this._stat == "undamaged") && !_empty;
                this.statusText.visible = loc1;
                this.emptyInfoTxt.visible = false;
                if (this.buyTank) 
                {
                    this.emptyInfoTxt.text = "#menu:tankCarousel/vehicleStates/buyTankEmptyCount";
                    this.emptyInfoTxt.text = this.emptyInfoTxt.text + " " + this._avalibleSlots;
                    this.emptyInfoTxt.visible = true;
                }
                if (this.buySlot) 
                {
                    this.slotPrice.text = this._slotPrice.toString();
                }
                if (empty) 
                {
                    this.emptyInfoTxt.text = "";
                }
                _dataDirty = false;
            }
            var loc2:*;
            this.scaleY = loc2 = 1;
            this.scaleX = loc2;
            return;
        }

        public function get favorite():Boolean
        {
            return this._favorite;
        }

        public function set favorite(arg1:Boolean):void
        {
            if (this._favorite == arg1) 
            {
                return;
            }
            this._favorite = arg1;
            _dataDirty = true;
            invalidate();
            return;
        }

        public function get buyTank():Boolean
        {
            return this._buyTank;
        }

        public function get buySlot():Boolean
        {
            return this._buySlot;
        }

        public function set buySlot(arg1:Boolean):void
        {
            if (this._buySlot == arg1) 
            {
                return;
            }
            this._buySlot = arg1;
            _dataDirty = true;
            var loc1:*;
            tabEnabled = loc1 = this._buySlot ? false : !this._buySlot;
            focusable = loc1;
            setState(enabled ? "up" : "disabled");
            return;
        }

        public function get id():String
        {
            return this._id;
        }

        public function set id(arg1:String):void
        {
            if (arg1 != "") 
            {
                this._id = arg1;
            }
            return;
        }

        public function get image():String
        {
            return this._image;
        }

        public function set image(arg1:String):void
        {
            if (arg1) 
            {
                this._image = arg1;
                _dataDirty = true;
                invalidate();
            }
            return;
        }

        public function get nation():Number
        {
            return this._nation;
        }

        public function set nation(arg1:Number):void
        {
            if (arg1 >= 0) 
            {
                this._nation = arg1;
                _dataDirty = true;
                invalidate();
            }
            return;
        }

        public function get level():Number
        {
            return this._level;
        }

        public function set level(arg1:Number):void
        {
            if (arg1 >= 1) 
            {
                this._level = arg1;
                _dataDirty = true;
                invalidate();
            }
            return;
        }

        public function get stat():String
        {
            return this._stat;
        }

        public function set stat(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 != "") 
            {
                this._stat = arg1;
                this.bg_switcher.gotoAndPlay(this.getBgLable(this._stat));
                if (initialized && this.statusText) 
                {
                    loc1 = new flash.text.TextFormat();
                    loc1.leading = -4;
                    this.statusText.autoSize = "center";
                    this.statusText.multiline = true;
                    this.statusText.text = this._stat != "undamaged" ? "#menu:tankCarousel/vehicleStates/" + this._stat : "";
                    this.statusText.setTextFormat(loc1);
                    this.statusText.y = _height - this.statusText.textHeight >> 1;
                    loc2 = this.getStatColor(this._stat);
                    this.statusText.textColor = loc2.color;
                    this.statusText.filters = loc2.filterArray;
                    this.statusText.visible = true;
                }
            }
            return;
        }

        public function get current():Number
        {
            return this._current;
        }

        public function set current(arg1:Number):void
        {
            if (arg1 >= 0) 
            {
                this._current = arg1;
            }
            return;
        }

        internal function getStatColor(arg1:String):Object
        {
            var loc14:*=null;
            var loc15:*=null;
            var loc16:*=null;
            var loc1:*=new Object();
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=2;
            var loc10:*=false;
            var loc11:*=false;
            var loc12:*=false;
            var loc13:*=new Array();
            var loc17:*=arg1;
            switch (loc17) 
            {
                case "battle":
                {
                    loc1.color = 13617064;
                    loc2 = 0;
                    loc3 = 90;
                    loc4 = 0;
                    loc5 = 0.25;
                    loc6 = 8;
                    loc7 = 8;
                    loc8 = 16;
                    loc9 = 2;
                    loc10 = false;
                    loc11 = false;
                    loc12 = false;
                    (loc14 = new flash.filters.DropShadowFilter()).distance = loc2;
                    loc14.angle = loc3;
                    loc14.color = loc4;
                    loc14.alpha = loc5;
                    loc14.blurX = loc6;
                    loc14.blurY = loc7;
                    loc14.strength = loc8;
                    loc14.quality = loc9;
                    loc14.inner = loc10;
                    loc14.knockout = loc11;
                    loc14.hideObject = loc12;
                    loc13.push(loc14);
                    loc1.filterArray = loc13;
                    break;
                }
                case "buyTank":
                case "buySlot":
                {
                    loc1.color = 15329754;
                    loc4 = 16777150;
                    loc5 = 0.2;
                    loc6 = 15;
                    loc7 = 15;
                    loc8 = 4;
                    loc9 = 2;
                    loc10 = false;
                    loc11 = false;
                    (loc15 = new flash.filters.GlowFilter()).color = loc4;
                    loc15.alpha = loc5;
                    loc15.blurX = loc6;
                    loc15.blurY = loc7;
                    loc15.strength = loc8;
                    loc15.quality = loc9;
                    loc15.inner = loc10;
                    loc15.knockout = loc11;
                    loc13.push(loc15);
                    loc1.filterArray = loc13;
                    break;
                }
                case "ammoNotFull":
                case "exploded":
                case "destroyed":
                case "damaged":
                case "crewNotFull":
                {
                    loc1.color = 15400960;
                    loc2 = 0;
                    loc3 = 90;
                    loc4 = 0;
                    loc5 = 0.25;
                    loc6 = 8;
                    loc7 = 8;
                    loc8 = 16;
                    loc9 = 2;
                    loc10 = false;
                    loc11 = false;
                    loc12 = false;
                    (loc16 = new flash.filters.DropShadowFilter()).distance = loc2;
                    loc16.angle = loc3;
                    loc16.color = loc4;
                    loc16.alpha = loc5;
                    loc16.blurX = loc6;
                    loc16.blurY = loc7;
                    loc16.strength = loc8;
                    loc16.quality = loc9;
                    loc16.inner = loc10;
                    loc16.knockout = loc11;
                    loc16.hideObject = loc12;
                    loc13.push(loc16);
                    loc1.filterArray = loc13;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return loc1;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            if (_selected && !_empty && !this._buyTank && !this._buySlot) 
            {
                return Vector.<String>(["selected_", ""]);
            }
            if (_empty) 
            {
                return Vector.<String>(["empty_"]);
            }
            if (this._buyTank) 
            {
                return Vector.<String>(["buyTank_"]);
            }
            if (this._buySlot) 
            {
                return Vector.<String>(["buySlot_"]);
            }
            return Vector.<String>([""]);
        }

        public override function toString():String
        {
            return "[WG TankCarouselItemRenderer]";
        }

        public override function get displayFocus():Boolean
        {
            return _displayFocus;
        }

        public override function set displayFocus(arg1:Boolean):void
        {
            if (arg1 == _displayFocus) 
            {
                return;
            }
            _displayFocus = arg1;
            changeFocus();
            return;
        }

        internal var _stateLevel:String="";

        internal var _id:String="";

        internal var _image:String="";

        internal var _nation:Number=-1;

        internal var _level:Number=-1;

        internal var _stat:String="";

        internal var _current:Number=-1;

        public var focusIndicator1:flash.display.MovieClip=null;

        internal var _doubleXPReceived:Number=0;

        internal var _compactDescr:Number=-1;

        internal var _favorite:Boolean=false;

        internal var _canSell:Boolean=false;

        internal var _clanLock:Number=-1;

        internal var _elite:Boolean=false;

        internal var _premium:Boolean=false;

        internal var _tankType:String="";

        internal var _exp:Number=0;

        internal var _buyTank:Boolean=false;

        internal var _buySlot:Boolean=false;

        internal var _avalibleSlots:Number=0;

        public var vehicleIcon:net.wg.gui.components.advanced.TankIcon;

        internal var _slotPrice:Number=0;

        public var slotPrice:net.wg.gui.components.controls.IconText;

        public var statusText:flash.text.TextField;

        public var emptyInfoTxt:flash.text.TextField;

        public var bg_switcher:flash.display.MovieClip;

        public var hitMC:flash.display.MovieClip;

        public var clanLockUI:net.wg.gui.lobby.hangar.tcarousel.ClanLockUI;
    }
}
