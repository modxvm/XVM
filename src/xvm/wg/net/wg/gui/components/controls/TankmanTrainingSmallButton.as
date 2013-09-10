package net.wg.gui.components.controls 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.utils.*;
    
    public class TankmanTrainingSmallButton extends net.wg.gui.components.controls.SoundButton
    {
        public function TankmanTrainingSmallButton()
        {
            this._priceColors = {"normal":16314069, "disabled":16711680, "buy":5330004};
            super();
            _stateMap = {"up":["up"], "over":["over"], "down":["down"], "release":["release", "over"], "out":["out", "up"], "disabled":["disabled"], "selecting":["selecting", "over"], "toggle":["toggle", "up"], "kb_selecting":["kb_selecting", "up"], "kb_release":["kb_release", "out", "up"], "kb_down":["kb_down", "down"], "buy":["buy"]};
            soundType = net.wg.data.constants.SoundTypes.RNDR_NORMAL;
            soundId = "";
            return;
        }

        public function set retraining(arg1:Boolean):void
        {
            this._retraining = arg1;
            this.typeSwitcher.gotoAndPlay(this._retraining ? "retraining_" + this._type : this._type);
            this.trainingLabel.text = this._retraining ? MENU.TANKMANTRAININGBUTTON2_RETRAININGTO : MENU.TANKMANTRAININGBUTTON2_TRAININGTO;
            return;
        }

        public function get nation():Number
        {
            return this._nation;
        }

        public function set nation(arg1:Number):void
        {
            this.bg.gotoAndPlay(App.utils.nations.getNationName(arg1));
            return;
        }

        public function get level():Number
        {
            return this._level;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            this.labelField.text = MENU.tankmantrainingwindow(this._type);
            this.typeSwitcher.gotoAndPlay(this._retraining ? "retraining_" + this._type : this._type);
            if (this._type != "free") 
            {
                this.priceLabel.icon = this._type != "academy" ? "credits" : "gold";
                this.priceLabel.x = 268;
            }
            else 
            {
                this.priceLabel.icon = "empty";
                this.priceLabel.textAlign = "right";
                this.priceLabel.x = 268 + 10;
                this.priceLabel.text = MENU.TANKMANRETRAININGBTN_FREE;
            }
            if (this.priceLabel is net.wg.gui.components.controls.IconText) 
            {
                this.priceLabel.invalidate();
                this.priceLabel.validateNow();
            }
            return;
        }

        public function set level(arg1:Number):void
        {
            this._level = arg1;
            this.levelLabel.text = arg1.toString() + "%";
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function get price():String
        {
            return this.priceLabel.text;
        }

        public function set price(arg1:String):void
        {
            this.setTextColorToPriceLabel();
            var loc1:*=App.utils.locale;
            this.priceLabel.text = this._type != "academy" ? loc1.integer(arg1) : loc1.gold(arg1);
            return;
        }

        public function get buy():Boolean
        {
            return this._buy;
        }

        public function set buy(arg1:Boolean):void
        {
            this._buy = arg1;
            var loc1:*=this._buy ? "buy" : "up";
            if (this.isNativeVehicle) 
                if (this._buy) 
                    this.setState("buy");
            else if (currentLabel != "buy") 
                return;
            else 
                this.setState(this.hasMoney ? "up" : "disabled");
            return;
        }

        public function setData(arg1:Object, arg2:Number, arg3:Number, arg4:Number, arg5:Boolean, arg6:Boolean, arg7:int):void
        {
            if (arg1 == null) 
                return;
            this.isUpdated = false;
            this.model = arg1;
            this.isNativeVehicle = arg5;
            this.gold = arg2;
            this.credits = arg3;
            this.isPremium = this.model.isPremium;
            this.currentMoney = this.isPremium ? arg2 : arg3;
            this._specializationLevel = arg4;
            this.hasMoney = this.model.isPremium ? arg2 >= this.model.gold : arg3 >= this.model.credits;
            this.levelText = this.calculateCurrentLevel(arg6, arg4);
            this.level = this.levelText;
            this.setEnabled();
            this.setBUY();
            this.nation = arg7;
            this.retraining = !arg5;
            this.price = this.model.isPremium ? this.model.gold : this.model.credits == 0 ? null : this.model.credits;
            this.type = this._type;
            invalidate(UPDATE_DATA);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.typeSwitcher.gotoAndPlay(this._retraining ? "retraining_" + this._type : this._type);
            this.trainingLabel.text = this._retraining ? MENU.TANKMANTRAININGBUTTON2_RETRAININGTO : MENU.TANKMANTRAININGBUTTON2_TRAININGTO;
            this.type = this._type;
            if (label) 
            {
                this.labelField.text = label;
                this.trainingLabel.text = "";
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(UPDATE_DATA) && !this.isUpdated) 
                this.refreshData();
            this.setTextColorToPriceLabel();
            var loc1:*=this._scopeType;
            switch (loc1) 
            {
                case "dropSkills":
                    this.labelField.text = MENU.skilldropwindow_study(this.getLabelType(this._type));
                    this.trainingLabel.text = MENU.tankmantrainingwindow(this._type);
                    break;
                default:
                    this.labelField.text = MENU.tankmantrainingwindow(this._type);
                    break;
            }
            return;
        }

        internal function refreshData():void
        {
            this.isUpdated = true;
            this.level = this.levelText;
            this.retraining = !this.isNativeVehicle;
            return;
        }

        internal function getLabelType(arg1:String):String
        {
            var loc1:*="";
            var loc2:*=arg1;
            switch (loc2) 
            {
                case "academy":
                    loc1 = "goldLabel";
                    break;
                case "scool":
                    loc1 = "creditsLabel";
                    break;
                case "free":
                    loc1 = "freeLabel";
                    break;
            }
            return loc1;
        }

        internal function setTextColorToPriceLabel():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.model == null || this._specializationLevel == 0 || !this.priceLabel) 
                return;
            if (this.isNativeVehicle) 
                if (this._specializationLevel >= this.level) 
                    this.priceLabel.textColor = this._priceColors["buy"];
                else 
                {
                    loc1 = this.hasMoney ? "normal" : "disabled";
                    this.priceLabel.textColor = this._priceColors[loc1];
                }
            else if (this.hasMoney) 
            {
                loc2 = enabled ? "normal" : "buy";
                this.priceLabel.textColor = this._priceColors[loc2];
            }
            else 
                this.priceLabel.textColor = this._priceColors["disabled"];
            return;
        }

        internal function setEnabled():void
        {
            if (this.isNativeVehicle) 
                enabled = this._specializationLevel < this.level && this.hasMoney;
            else 
                enabled = this.hasMoney;
            return;
        }

        internal function calculateCurrentLevel(arg1:Boolean, arg2:Number):Number
        {
            var loc1:*=NaN;
            var loc4:*=NaN;
            var loc2:*=this.model.baseRoleLoss;
            var loc3:*=this.model.classChangeRoleLoss;
            if (arg1) 
                loc1 = arg2 - Math.floor(arg2 * loc2);
            else 
            {
                loc4 = loc2 + loc3;
                loc1 = arg2 - Math.floor(arg2 * loc4);
            }
            loc1 = loc1 < this.model.roleLevel ? this.model.roleLevel : loc1;
            return loc1;
        }

        public override function set selected(arg1:Boolean):void
        {
            var loc1:*=false;
            if (_selected == arg1) 
                return;
            _selected = arg1;
            if (enabled) 
            {
                if (_focused) 
                    if (_pressedByKeyboard && !(_focusIndicator == null)) 
                        this.setState("kb_selecting");
                    else 
                        this.setState("selecting");
                else 
                    this.setState("toggle");
                if (owner) 
                {
                    loc1 = _selected && !(owner == null) && checkOwnerFocused();
                    this.setState(loc1 && _focusIndicator == null ? "selecting" : "toggle");
                    displayFocus = loc1;
                }
            }
            else if (this._specializationLevel >= this.level) 
                this.setState("buy");
            else 
                this.setState("disabled");
            validateNow();
            dispatchEvent(new flash.events.Event(flash.events.Event.SELECT));
            return;
        }

        public function set scopeType(arg1:String):void
        {
            this._scopeType = arg1;
            this.draw();
            return;
        }

        protected override function setState(arg1:String):void
        {
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            _state = arg1;
            var loc1:*=getStatePrefixes();
            var loc2:*=_stateMap[arg1];
            if (loc2 == null || loc2.length == 0) 
                return;
            var loc3:*=loc1.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc5 = loc1[loc4];
                loc6 = loc2.length;
                loc7 = 0;
                while (loc7 < loc6) 
                {
                    loc8 = loc5 + loc2[loc7];
                    if (_labelHash[loc8]) 
                    {
                        _newFrame = loc8;
                        invalidateState();
                        return;
                    }
                    ++loc7;
                }
                ++loc4;
            }
            return;
        }

        internal function disposeComponent():void
        {
            this.bg = null;
            this.priceLabel.dispose();
            this.priceLabel = null;
            this.levelLabel = null;
            this.labelField = null;
            this.trainingLabel = null;
            this.model = null;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.disposeComponent();
            return;
        }

        public function setDataForDropSkills(arg1:Number, arg2:Boolean):void
        {
            if (!isNaN(arg1)) 
                this.price = arg1.toString();
            var loc1:*;
            this.hasMoney = loc1 = arg2;
            enabled = loc1;
            return;
        }

        public function get scopeType():String
        {
            return this._scopeType;
        }

        internal function setBUY():void
        {
            if (this.isNativeVehicle) 
                this.buy = this._specializationLevel >= this.level;
            else 
                this.buy = false;
            return;
        }

        public function get retraining():Boolean
        {
            return this._retraining;
        }

        internal static const UPDATE_DATA:String="setDataUpdate";

        public var bg:flash.display.MovieClip;

        public var typeSwitcher:flash.display.MovieClip;

        public var priceLabel:net.wg.gui.components.controls.IconText;

        public var levelLabel:flash.text.TextField;

        public var labelField:flash.text.TextField;

        public var _level:Number=0;

        public var _buy:Boolean=false;

        public var _nation:Number=0;

        public var _type:String="free";

        public var _retraining:Boolean=true;

        public var _scopeType:String="";

        internal var model:Object;

        internal var currentMoney:int;

        internal var hasMoney:Boolean=false;

        internal var credits:Number;

        internal var gold:Number;

        internal var isPremium:Boolean=false;

        internal var isNativeVehicle:Boolean=false;

        internal var _specializationLevel:int=0;

        internal var isUpdated:Boolean=true;

        public var inspectableGroupName:String;

        internal var _priceColors:Object;

        public var trainingLabel:flash.text.TextField;

        internal var levelText:Number=0;
    }
}
