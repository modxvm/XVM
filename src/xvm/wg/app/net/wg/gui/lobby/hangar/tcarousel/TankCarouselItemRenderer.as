package net.wg.gui.lobby.hangar.tcarousel
{
    import net.wg.gui.components.controls.DragableListItemRenderer;
    import net.wg.gui.components.advanced.TankIcon;
    import net.wg.gui.components.controls.IconText;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.ActionPrice;
    import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;
    import net.wg.data.constants.SoundTypes;
    import net.wg.data.constants.SoundManagerStates;
    import flash.text.TextFormat;
    import flash.display.FrameLabel;
    import flash.filters.GlowFilter;
    import flash.filters.DropShadowFilter;
    
    public class TankCarouselItemRenderer extends DragableListItemRenderer
    {
        
        public function TankCarouselItemRenderer()
        {
            super();
            focusIndicator = this.focusIndicator1;
        }
        
        public var vehicleIcon:TankIcon;
        
        public var slotPrice:IconText;
        
        public var statusText:TextField;
        
        public var emptyInfoTxt:TextField;
        
        public var bg_switcher:MovieClip;
        
        public var hitMC:MovieClip;
        
        public var clanLockUI:ClanLockUI;
        
        public var actionPrice:ActionPrice;
        
        public var focusIndicator1:MovieClip = null;
        
        public var dataVO:VehicleCarouselVO = null;
        
        private var STATUS_MARGIN:Number = 5;
        
        override protected function onDispose() : void
        {
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
            super.onDispose();
        }
        
        public function setDataVO(param1:VehicleCarouselVO) : void
        {
            if(param1)
            {
                this.dataVO = VehicleCarouselVO(param1);
                this.visible = false;
                this.enabled = true;
                empty = this.dataVO.empty;
                _dataDirty = true;
                invalidate();
            }
        }
        
        override public function toString() : String
        {
            return "[WG TankCarouselItemRenderer]";
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            useHandCursor = param1;
            if((this.dataVO) && (this.dataVO.buySlot))
            {
                this.mouseChildren = param1;
            }
        }
        
        override public function get displayFocus() : Boolean
        {
            return _displayFocus;
        }
        
        override public function set displayFocus(param1:Boolean) : void
        {
            if(param1 == _displayFocus)
            {
                return;
            }
            _displayFocus = param1;
            changeFocus();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.soundType = SoundTypes.CAROUSEL_BTN;
            this.soundId = SoundManagerStates.CAROUSEL_CELL_BTN;
            if(this.hitMC)
            {
                this.hitArea = this.hitMC;
            }
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:TextFormat = null;
            var _loc3_:Object = null;
            super.draw();
            if(_baseDisposed)
            {
                return;
            }
            if(_dataDirty)
            {
                if((this.vehicleIcon && !empty) && (!this.dataVO.buyTank) && !this.dataVO.buySlot)
                {
                    this.vehicleIcon.image = this.dataVO.image;
                    this.vehicleIcon.showName = true;
                    this.vehicleIcon.tankName = this.dataVO.label;
                    this.vehicleIcon.level = this.dataVO.level;
                    this.vehicleIcon.isElite = this.dataVO.elite;
                    this.vehicleIcon.isPremium = this.dataVO.premium;
                    this.vehicleIcon.favorite = this.dataVO.favorite;
                    this.vehicleIcon.nation = this.dataVO.nation;
                    this.vehicleIcon.showMultyXp = true;
                    this.vehicleIcon.multyXpVal = this.dataVO.doubleXPReceived;
                    this.vehicleIcon.tankType = this.dataVO.tankType;
                    this.vehicleIcon.rentInfo = this.dataVO.rentLeft;
                    this.vehicleIcon.validateNow();
                    this.clanLockUI.timer = this.dataVO.clanLock;
                }
                if((this.dataVO.stat) && (this.bg_switcher))
                {
                    this.bg_switcher.gotoAndPlay(this.getBgLable(this.dataVO.stat));
                }
                if(this.statusText)
                {
                    if(this.dataVO.stat)
                    {
                        _loc2_ = new TextFormat();
                        if((this.dataVO.buyTank) || (this.dataVO.buySlot))
                        {
                            _loc2_.leading = -6;
                        }
                        else
                        {
                            _loc2_.leading = -4;
                        }
                        this.statusText.autoSize = "center";
                        this.statusText.text = this.dataVO.stat == "undamaged"?"":MENU.tankcarousel_vehiclestates(this.dataVO.stat);
                        this.statusText.setTextFormat(_loc2_);
                        _loc3_ = this.getStatColor(this.dataVO.stateLevel);
                        this.statusText.textColor = _loc3_.color;
                        this.statusText.filters = _loc3_.filterArray;
                        this.statusText.visible = true;
                    }
                    if(this.clanLockUI.visible)
                    {
                        this.statusText.y = Math.round(this.clanLockUI.y + this.clanLockUI.textField.height + this.STATUS_MARGIN);
                    }
                    else
                    {
                        this.statusText.y = _height - this.statusText.textHeight >> 1;
                    }
                    _loc1_ = !(this.dataVO.stat == "undamaged") && !_empty;
                    this.statusText.visible = _loc1_;
                }
                this.emptyInfoTxt.visible = false;
                if(this.dataVO.buyTank)
                {
                    this.emptyInfoTxt.text = MENU.TANKCAROUSEL_VEHICLESTATES_BUYTANKEMPTYCOUNT;
                    this.emptyInfoTxt.text = this.emptyInfoTxt.text + " " + this.dataVO.availableSlots;
                    this.emptyInfoTxt.visible = true;
                }
                if((this.dataVO.buySlot) && (this.slotPrice))
                {
                    this.slotPrice.text = this.dataVO.slotPrice.toString();
                    if(this.actionPrice)
                    {
                        this.actionPrice.setData(this.dataVO.slotPriceActionData);
                        this.slotPrice.visible = !this.actionPrice.visible;
                        this.actionPrice.setup(this);
                    }
                }
                if(empty)
                {
                    this.emptyInfoTxt.text = "";
                }
                focusable = tabEnabled = (this.dataVO.buySlot) || (this.dataVO.buyTank)?false:!this.dataVO.buySlot || !this.dataVO.buyTank;
                _dataDirty = false;
            }
            this.scaleX = this.scaleY = 1;
        }
        
        override protected function getStatePrefixes() : Vector.<String>
        {
            if((_selected && !_empty && this.dataVO) && (!this.dataVO.buyTank) && !this.dataVO.buySlot)
            {
                return Vector.<String>(["selected_",""]);
            }
            if(_empty)
            {
                return Vector.<String>(["empty_"]);
            }
            if((this.dataVO) && (this.dataVO.buyTank))
            {
                return Vector.<String>(["buyTank_"]);
            }
            if((this.dataVO) && (this.dataVO.buySlot))
            {
                return Vector.<String>(["buySlot_"]);
            }
            return Vector.<String>([""]);
        }
        
        private function getBgLable(param1:String) : String
        {
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
        
        private function getStatColor(param1:String) : Object
        {
            var _loc15_:GlowFilter = null;
            var _loc16_:DropShadowFilter = null;
            var _loc17_:DropShadowFilter = null;
            var _loc2_:Object = {};
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
            var _loc14_:Array = [];
            switch(param1)
            {
                case "buyState":
                    _loc2_.color = 15329754;
                    _loc5_ = 16777150;
                    _loc6_ = 0.2;
                    _loc7_ = 15;
                    _loc8_ = 15;
                    _loc9_ = 4;
                    _loc10_ = 2;
                    _loc11_ = false;
                    _loc12_ = false;
                    _loc15_ = new GlowFilter();
                    _loc15_.color = _loc5_;
                    _loc15_.alpha = _loc6_;
                    _loc15_.blurX = _loc7_;
                    _loc15_.blurY = _loc8_;
                    _loc15_.strength = _loc9_;
                    _loc15_.quality = _loc10_;
                    _loc15_.inner = _loc11_;
                    _loc15_.knockout = _loc12_;
                    _loc14_.push(_loc15_);
                    _loc2_.filterArray = _loc14_;
                    break;
                case "critical":
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
                    _loc16_ = new DropShadowFilter();
                    _loc16_.distance = _loc3_;
                    _loc16_.angle = _loc4_;
                    _loc16_.color = _loc5_;
                    _loc16_.alpha = _loc6_;
                    _loc16_.blurX = _loc7_;
                    _loc16_.blurY = _loc8_;
                    _loc16_.strength = _loc9_;
                    _loc16_.quality = _loc10_;
                    _loc16_.inner = _loc11_;
                    _loc16_.knockout = _loc12_;
                    _loc16_.hideObject = _loc13_;
                    _loc14_.push(_loc16_);
                    _loc2_.filterArray = _loc14_;
                    break;
                case "info":
                default:
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
            }
            return _loc2_;
        }
    }
}
