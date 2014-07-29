package net.wg.gui.components.advanced
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.filters.BitmapFilter;
    import flash.filters.DropShadowFilter;
    import flash.filters.GlowFilter;
    
    public class TankIcon extends UIComponent
    {
        
        public function TankIcon()
        {
            super();
        }
        
        public var flag:MovieClip;
        
        public var iconLoader:UILoaderAlt;
        
        public var tankTypeMc:MovieClip;
        
        public var levelMc:MovieClip;
        
        public var multyXp:MovieClip;
        
        public var xp:MovieClip;
        
        public var tankNameField:TextField;
        
        public var tankNameBg:MovieClip;
        
        public var favoriteMc:MovieClip;
        
        private var _favorite:Boolean = false;
        
        private var _favoriteDirty:Boolean = true;
        
        private var _showMultyXp:Boolean = false;
        
        private var _showMultyXpDirty:Boolean = true;
        
        private var _showXp:Boolean = false;
        
        private var _showXpDirty:Boolean = true;
        
        private var _showName:Boolean = false;
        
        private var _showNameDirty:Boolean = true;
        
        private var _nation:Number;
        
        private var _nationDirty:Boolean = true;
        
        private var _nationName:String;
        
        private var _nationNameDirty:Boolean = true;
        
        private var _image:String;
        
        private var _imageDirty:Boolean = true;
        
        private var _tankType:String;
        
        private var _tankTypeDirty:Boolean = true;
        
        private var _level:Number;
        
        private var _levelDirty:Boolean = true;
        
        private var _multyXpVal:Number;
        
        private var _multyXpValDirty:Boolean = true;
        
        private var _xpVal:Number = 0;
        
        private var _xpValDirty:Boolean = true;
        
        private var _tankName:String;
        
        private var _tankNameDirty:Boolean = true;
        
        private var _isElite:Boolean;
        
        private var _isEliteDirty:Boolean = true;
        
        private var _isPremium:Boolean;
        
        private var _isPremiumDirty:Boolean = true;
        
        public var DIRTY_FLAGS:Array = [_showMultyXpDirty,_showXpDirty,_showNameDirty,_nationDirty,_imageDirty,_tankTypeDirty,_levelDirty,_multyXpValDirty,_xpValDirty,_tankNameDirty,_isEliteDirty,_isPremiumDirty];
        
        override protected function onDispose() : void
        {
            this.flag = null;
            this.iconLoader.dispose();
            this.iconLoader = null;
            this.tankTypeMc = null;
            this.levelMc = null;
            this.multyXp = null;
            this.xp = null;
            this.tankNameField.filters.splice(0,this.tankNameField.filters.length);
            this.tankNameField = null;
            this.tankNameBg = null;
            this.favoriteMc = null;
            super.onDispose();
        }
        
        public function get favorite() : Boolean
        {
            return this._favorite;
        }
        
        public function set favorite(param1:Boolean) : void
        {
            if(this._favorite == param1)
            {
                return;
            }
            this._favorite = param1;
            this._favoriteDirty = true;
            invalidate();
        }
        
        public function get showMultyXp() : Boolean
        {
            return this._showMultyXp;
        }
        
        public function set showMultyXp(param1:Boolean) : void
        {
            this._showMultyXp = param1;
            this._showMultyXpDirty = true;
            invalidate();
        }
        
        public function get showXp() : Boolean
        {
            return this._showXp;
        }
        
        public function set showXp(param1:Boolean) : void
        {
            this._showXp = param1;
            this._showXpDirty = true;
            invalidate();
        }
        
        public function get showName() : Boolean
        {
            return this._showName;
        }
        
        public function set showName(param1:Boolean) : void
        {
            this._showName = param1;
            this._showNameDirty = true;
            invalidate();
        }
        
        public function get nation() : Number
        {
            return this._nation;
        }
        
        public function set nation(param1:Number) : void
        {
            if(param1 < 0 || param1 == this._nation)
            {
                return;
            }
            this._nation = param1;
            this._nationDirty = true;
            this._nationNameDirty = false;
            invalidate();
        }
        
        public function get nationName() : String
        {
            return this._nationName;
        }
        
        public function set nationName(param1:String) : void
        {
            if(!param1 || param1 == this._nationName)
            {
                return;
            }
            this._nationName = param1;
            this._nationNameDirty = true;
            this._nationDirty = false;
            invalidate();
        }
        
        public function get image() : String
        {
            return this._image;
        }
        
        public function set image(param1:String) : void
        {
            if(!param1 || param1 == this._image)
            {
                return;
            }
            this._image = param1;
            this._imageDirty = true;
            invalidate();
        }
        
        public function get tankType() : String
        {
            return this._tankType;
        }
        
        public function set tankType(param1:String) : void
        {
            if(!param1 || param1 == this._tankType)
            {
                return;
            }
            this._tankType = param1;
            this._tankTypeDirty = true;
            invalidate();
        }
        
        public function get level() : Number
        {
            return this._level;
        }
        
        public function set level(param1:Number) : void
        {
            if(param1 == this._level)
            {
                return;
            }
            this._level = param1;
            this._levelDirty = true;
            invalidate();
        }
        
        public function get multyXpVal() : Number
        {
            return this._multyXpVal;
        }
        
        public function set multyXpVal(param1:Number) : void
        {
            if(param1 == this._multyXpVal)
            {
                return;
            }
            this._multyXpVal = param1;
            this._multyXpValDirty = true;
            invalidate();
        }
        
        public function get xpVal() : Number
        {
            return this._xpVal;
        }
        
        public function set xpVal(param1:Number) : void
        {
            if(param1 == this._xpVal)
            {
                return;
            }
            this._xpVal = param1;
            this._xpValDirty = true;
            invalidate();
        }
        
        public function get tankName() : String
        {
            return this._tankName;
        }
        
        public function set tankName(param1:String) : void
        {
            if(param1 == this._tankName)
            {
                return;
            }
            this._tankName = param1;
            this._tankNameDirty = true;
            invalidate();
        }
        
        public function get isElite() : Boolean
        {
            return this._isElite;
        }
        
        public function set isElite(param1:Boolean) : void
        {
            if(param1 == this._isElite)
            {
                return;
            }
            this._isElite = param1;
            this._isEliteDirty = true;
            invalidate();
        }
        
        public function get isPremium() : Boolean
        {
            return this._isPremium;
        }
        
        public function set isPremium(param1:Boolean) : void
        {
            if(param1 == this._isPremium)
            {
                return;
            }
            this._isPremium = param1;
            this._isPremiumDirty = true;
            invalidate();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function draw() : void
        {
            super.draw();
            this.flag.visible = true;
            if(((this._multyXpValDirty) || (this._showMultyXpDirty)) && (this.multyXp))
            {
                this.updateMultyXp();
                this._multyXpValDirty = this._showMultyXpDirty = false;
            }
            if(((this._xpValDirty) || (this._showXpDirty)) && (this.xp))
            {
                this.xp.visible = this.showXp;
                if(this.showXp)
                {
                    this.xp.textField.text = String(this.xpVal);
                }
                this._xpValDirty = this._showXpDirty = false;
            }
            if((this._tankNameDirty || this._showNameDirty || this._isPremiumDirty) && (this.tankNameField) && (this.tankNameBg))
            {
                this.tankNameField.visible = this.tankNameBg.visible = this.showName;
                if(this.showName)
                {
                    this.tankNameField.text = this.tankName;
                }
                this.updateTankName();
                this._isPremiumDirty = this._tankNameDirty = this._showNameDirty = false;
            }
            if((this._nationDirty) && (this.flag) && this.nation >= 0)
            {
                this.flag.gotoAndStop(this.nation + 1);
                this._nationDirty = false;
            }
            if((this._nationNameDirty) && (this.flag) && (this.nationName))
            {
                this.flag.gotoAndStop(this.nationName);
                this._nationNameDirty = false;
            }
            if((this._imageDirty) && (this.iconLoader))
            {
                this.iconLoader.visible = true;
                this.iconLoader.source = this._image;
                this._imageDirty = false;
            }
            if(((this._isEliteDirty) || (this._tankTypeDirty)) && (this.tankTypeMc))
            {
                this.updateTankType();
                this._isEliteDirty = this._tankTypeDirty = false;
            }
            if((this._levelDirty) && (this.levelMc) && (this._level))
            {
                this.levelMc.gotoAndStop(this._level);
                this._levelDirty = false;
            }
            if((this._favoriteDirty) && (this.favoriteMc))
            {
                this.favoriteMc.visible = this.favorite;
                this._favoriteDirty = false;
            }
            if((this._showMultyXpDirty) || (this._showXpDirty) || (this._showNameDirty) || (this._nationDirty) || (this._imageDirty) || (this._tankTypeDirty) || (this._levelDirty) || (this._multyXpValDirty) || (this._xpValDirty) || (this._tankNameDirty) || (this._isEliteDirty) || (this._isPremiumDirty) || (this._favoriteDirty))
            {
                invalidate();
            }
        }
        
        private function updateTankType() : void
        {
            if(this.tankType)
            {
                this.tankTypeMc.gotoAndStop(this.tankType + (this.isElite?"_elite":""));
            }
            if(this.isElite)
            {
                this.levelMc.x = 21;
            }
            else
            {
                this.levelMc.x = Math.round(this.tankTypeMc.x + this.tankTypeMc.width + 3);
            }
        }
        
        private function updateMultyXp() : void
        {
            if(this.showMultyXp)
            {
                this.multyXp.visible = this.multyXpVal >= 2;
                if((this.multyXp.visible) && this.multyXpVal > 2)
                {
                    this.multyXp.gotoAndStop("action");
                    this.multyXp.textField.text = this.multyXpVal;
                    this.multyXp.textField.visible = true;
                }
                else if(this.multyXp.visible)
                {
                    this.multyXp.gotoAndStop("standart");
                    this.multyXp.textField.text = "";
                    this.multyXp.textField.visible = false;
                }
                
            }
            else
            {
                this.multyXp.visible = false;
            }
        }
        
        private function updateTankName() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            var _loc5_:* = NaN;
            var _loc6_:* = NaN;
            var _loc7_:* = NaN;
            var _loc8_:* = NaN;
            var _loc9_:* = NaN;
            var _loc10_:* = false;
            var _loc11_:* = false;
            var _loc12_:* = false;
            var _loc13_:BitmapFilter = null;
            var _loc14_:Array = null;
            if(this.showName)
            {
                _loc1_ = 0;
                _loc2_ = 90;
                _loc3_ = 16723968;
                _loc4_ = 16754521;
                _loc5_ = 0.7;
                _loc6_ = 12;
                _loc7_ = 12;
                _loc8_ = 3;
                _loc9_ = 2;
                _loc10_ = false;
                _loc11_ = false;
                _loc12_ = false;
                _loc14_ = new Array();
                if(this.isPremium)
                {
                    _loc13_ = new DropShadowFilter();
                    DropShadowFilter(_loc13_).distance = _loc1_;
                    DropShadowFilter(_loc13_).color = _loc3_;
                    DropShadowFilter(_loc13_).angle = _loc2_;
                    DropShadowFilter(_loc13_).blurX = _loc6_;
                    DropShadowFilter(_loc13_).blurY = _loc7_;
                    DropShadowFilter(_loc13_).alpha = _loc5_;
                    DropShadowFilter(_loc13_).strength = _loc8_;
                    DropShadowFilter(_loc13_).quality = _loc9_;
                    DropShadowFilter(_loc13_).inner = _loc10_;
                    DropShadowFilter(_loc13_).knockout = _loc11_;
                    DropShadowFilter(_loc13_).hideObject = _loc12_;
                    this.tankNameBg.visible = this.showName;
                }
                else
                {
                    _loc3_ = 16777150;
                    _loc4_ = 13224374;
                    _loc5_ = 0.2;
                    _loc6_ = 8;
                    _loc7_ = 8;
                    _loc8_ = 4;
                    _loc13_ = new GlowFilter(_loc3_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_);
                    this.tankNameBg.visible = false;
                }
                _loc14_.push(_loc13_);
                this.tankNameField.filters = _loc14_;
                this.tankNameField.textColor = _loc4_;
            }
            else
            {
                this.tankNameField.filters = [];
            }
        }
    }
}
