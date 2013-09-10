package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class TankIcon extends scaleform.clik.core.UIComponent
    {
        public function TankIcon()
        {
            this.DIRTY_FLAGS = [this._showMultyXpDirty, this._showXpDirty, this._showNameDirty, this._nationDirty, this._imageDirty, this._tankTypeDirty, this._levelDirty, this._multyXpValDirty, this._xpValDirty, this._tankNameDirty, this._isEliteDirty, this._isPremiumDirty];
            super();
            return;
        }

        public function set tankName(arg1:String):void
        {
            if (arg1 == this._tankName) 
                return;
            this._tankName = arg1;
            this._tankNameDirty = true;
            invalidate();
            return;
        }

        public function get showName():Boolean
        {
            return this._showName;
        }

        public function get favorite():Boolean
        {
            return this._favorite;
        }

        public function set favorite(arg1:Boolean):void
        {
            if (this._favorite == arg1) 
                return;
            this._favorite = arg1;
            this._favoriteDirty = true;
            invalidate();
            return;
        }

        public function get showMultyXp():Boolean
        {
            return this._showMultyXp;
        }

        public function set showMultyXp(arg1:Boolean):void
        {
            this._showMultyXp = arg1;
            this._showMultyXpDirty = true;
            invalidate();
            return;
        }

        public function get showXp():Boolean
        {
            return this._showXp;
        }

        public function set showXp(arg1:Boolean):void
        {
            this._showXp = arg1;
            this._showXpDirty = true;
            invalidate();
            return;
        }

        public function set showName(arg1:Boolean):void
        {
            this._showName = arg1;
            this._showNameDirty = true;
            invalidate();
            return;
        }

        public function get nation():Number
        {
            return this._nation;
        }

        public function set nation(arg1:Number):void
        {
            if (arg1 < 0 || arg1 == this._nation) 
                return;
            this._nation = arg1;
            this._nationDirty = true;
            this._nationNameDirty = false;
            invalidate();
            return;
        }

        public function get nationName():String
        {
            return this._nationName;
        }

        public function set nationName(arg1:String):void
        {
            if (!arg1 || arg1 == this._nationName) 
                return;
            this._nationName = arg1;
            this._nationNameDirty = true;
            this._nationDirty = false;
            invalidate();
            return;
        }

        public function get image():String
        {
            return this._image;
        }

        public function set image(arg1:String):void
        {
            if (!arg1 || arg1 == this._image) 
                return;
            this._image = arg1;
            this._imageDirty = true;
            invalidate();
            return;
        }

        public function get tankType():String
        {
            return this._tankType;
        }

        public function set tankType(arg1:String):void
        {
            if (!arg1 || arg1 == this._tankType) 
                return;
            this._tankType = arg1;
            this._tankTypeDirty = true;
            invalidate();
            return;
        }

        public function get level():Number
        {
            return this._level;
        }

        public function set level(arg1:Number):void
        {
            if (arg1 == this._level) 
                return;
            this._level = arg1;
            this._levelDirty = true;
            invalidate();
            return;
        }

        public function get multyXpVal():Number
        {
            return this._multyXpVal;
        }

        public function set multyXpVal(arg1:Number):void
        {
            if (arg1 == this._multyXpVal) 
                return;
            this._multyXpVal = arg1;
            this._multyXpValDirty = true;
            invalidate();
            return;
        }

        public function get xpVal():Number
        {
            return this._xpVal;
        }

        public function set xpVal(arg1:Number):void
        {
            if (arg1 == this._xpVal) 
                return;
            this._xpVal = arg1;
            this._xpValDirty = true;
            invalidate();
            return;
        }

        public function get tankName():String
        {
            return this._tankName;
        }

        public function get isElite():Boolean
        {
            return this._isElite;
        }

        public function set isElite(arg1:Boolean):void
        {
            if (arg1 == this._isElite) 
                return;
            this._isElite = arg1;
            this._isEliteDirty = true;
            invalidate();
            return;
        }

        public function get isPremium():Boolean
        {
            return this._isPremium;
        }

        public function set isPremium(arg1:Boolean):void
        {
            if (arg1 == this._isPremium) 
                return;
            this._isPremium = arg1;
            this._isPremiumDirty = true;
            invalidate();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            this.flag.visible = true;
            if ((this._multyXpValDirty || this._showMultyXpDirty) && this.multyXp) 
            {
                this.updateMultyXp();
                var loc1:*;
                this._showMultyXpDirty = loc1 = false;
                this._multyXpValDirty = loc1;
            }
            if ((this._xpValDirty || this._showXpDirty) && this.xp) 
            {
                this.xp.visible = this.showXp;
                if (this.showXp) 
                    this.xp.textField.text = String(this.xpVal);
                this._showXpDirty = loc1 = false;
                this._xpValDirty = loc1;
            }
            if ((this._tankNameDirty || this._showNameDirty || this._isPremiumDirty) && this.tankNameField && this.tankNameBg) 
            {
                this.tankNameBg.visible = loc1 = this.showName;
                this.tankNameField.visible = loc1;
                if (this.showName) 
                    this.tankNameField.text = this.tankName;
                this.updateTankName();
                this._showNameDirty = loc1 = false;
                this._tankNameDirty = loc1 = loc1;
                this._isPremiumDirty = loc1;
            }
            if (this._nationDirty && this.flag && this.nation >= 0) 
            {
                this.flag.gotoAndStop(this.nation + 1);
                this._nationDirty = false;
            }
            if (this._nationNameDirty && this.flag && this.nationName) 
            {
                this.flag.gotoAndStop(this.nationName);
                this._nationNameDirty = false;
            }
            if (this._imageDirty && this.iconLoader) 
            {
                this.iconLoader.visible = true;
                this.iconLoader.source = this._image;
                this._imageDirty = false;
            }
            if ((this._isEliteDirty || this._tankTypeDirty) && this.tankTypeMc) 
            {
                this.updateTankType();
                this._tankTypeDirty = loc1 = false;
                this._isEliteDirty = loc1;
            }
            if (this._levelDirty && this.levelMc && this._level) 
            {
                this.levelMc.gotoAndStop(this._level);
                this._levelDirty = false;
            }
            if (this._favoriteDirty && this.favoriteMc) 
            {
                this.favoriteMc.visible = this.favorite;
                this._favoriteDirty = false;
            }
            if (this._showMultyXpDirty || this._showXpDirty || this._showNameDirty || this._nationDirty || this._imageDirty || this._tankTypeDirty || this._levelDirty || this._multyXpValDirty || this._xpValDirty || this._tankNameDirty || this._isEliteDirty || this._isPremiumDirty || this._favoriteDirty) 
                invalidate();
            return;
        }

        internal function updateTankType():void
        {
            if (this.tankType) 
                this.tankTypeMc.gotoAndStop(this.tankType + (this.isElite ? "_elite" : ""));
            if (this.isElite) 
                this.levelMc.x = 21;
            else 
                this.levelMc.x = Math.round(this.tankTypeMc.x + this.tankTypeMc.width + 3);
            return;
        }

        internal function updateMultyXp():void
        {
            if (this.showMultyXp) 
            {
                this.multyXp.visible = this.multyXpVal >= 2;
                if (this.multyXp.visible && this.multyXpVal > 2) 
                {
                    this.multyXp.gotoAndStop("action");
                    this.multyXp.textField.text = this.multyXpVal;
                    this.multyXp.textField.visible = true;
                }
                else if (this.multyXp.visible) 
                {
                    this.multyXp.gotoAndStop("standart");
                    this.multyXp.textField.text = "";
                    this.multyXp.textField.visible = false;
                }
            }
            else 
                this.multyXp.visible = false;
            return;
        }

        internal function updateTankName():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=false;
            var loc11:*=false;
            var loc12:*=false;
            var loc13:*=null;
            var loc14:*=null;
            if (this.showName) 
            {
                loc1 = 0;
                loc2 = 90;
                loc3 = 16723968;
                loc4 = 16754521;
                loc5 = 0.7;
                loc6 = 12;
                loc7 = 12;
                loc8 = 3;
                loc9 = 2;
                loc10 = false;
                loc11 = false;
                loc12 = false;
                loc14 = new Array();
                if (this.isPremium) 
                {
                    loc13 = new flash.filters.DropShadowFilter();
                    flash.filters.DropShadowFilter(loc13).distance = loc1;
                    flash.filters.DropShadowFilter(loc13).color = loc3;
                    flash.filters.DropShadowFilter(loc13).angle = loc2;
                    flash.filters.DropShadowFilter(loc13).blurX = loc6;
                    flash.filters.DropShadowFilter(loc13).blurY = loc7;
                    flash.filters.DropShadowFilter(loc13).alpha = loc5;
                    flash.filters.DropShadowFilter(loc13).strength = loc8;
                    flash.filters.DropShadowFilter(loc13).quality = loc9;
                    flash.filters.DropShadowFilter(loc13).inner = loc10;
                    flash.filters.DropShadowFilter(loc13).knockout = loc11;
                    flash.filters.DropShadowFilter(loc13).hideObject = loc12;
                    this.tankNameBg.visible = this.showName;
                }
                else 
                {
                    loc3 = 16777150;
                    loc4 = 13224374;
                    loc5 = 0.2;
                    loc6 = 8;
                    loc7 = 8;
                    loc8 = 4;
                    loc13 = new flash.filters.GlowFilter(loc3, loc5, loc6, loc7, loc8, loc9, loc10, loc11);
                    this.tankNameBg.visible = false;
                }
                loc14.push(loc13);
                this.tankNameField.filters = loc14;
                this.tankNameField.textColor = loc4;
            }
            else 
                this.tankNameField.filters = [];
            return;
        }

        internal var _isElite:Boolean;

        internal var _isEliteDirty:Boolean=true;

        public var favoriteMc:flash.display.MovieClip;

        internal var _isPremiumDirty:Boolean=true;

        internal var DIRTY_FLAGS:Array;

        public var flag:flash.display.MovieClip;

        public var iconLoader:net.wg.gui.components.controls.UILoaderAlt;

        public var tankTypeMc:flash.display.MovieClip;

        public var levelMc:flash.display.MovieClip;

        public var multyXp:flash.display.MovieClip;

        public var xp:flash.display.MovieClip;

        internal var _isPremium:Boolean;

        public var tankNameField:flash.text.TextField;

        public var tankNameBg:flash.display.MovieClip;

        internal var _favorite:Boolean=false;

        internal var _favoriteDirty:Boolean=true;

        internal var _showMultyXp:Boolean=false;

        internal var _showMultyXpDirty:Boolean=true;

        internal var _showXp:Boolean=false;

        internal var _showXpDirty:Boolean=true;

        internal var _showName:Boolean=false;

        internal var _showNameDirty:Boolean=true;

        internal var _nation:Number;

        internal var _nationDirty:Boolean=true;

        internal var _nationName:String;

        internal var _nationNameDirty:Boolean=true;

        internal var _image:String;

        internal var _imageDirty:Boolean=true;

        internal var _levelDirty:Boolean=true;

        internal var _tankType:String;

        internal var _tankTypeDirty:Boolean=true;

        internal var _level:Number;

        internal var _multyXpVal:Number;

        internal var _multyXpValDirty:Boolean=true;

        internal var _xpVal:Number=0;

        internal var _xpValDirty:Boolean=true;

        internal var _tankName:String;

        internal var _tankNameDirty:Boolean=true;
    }
}
