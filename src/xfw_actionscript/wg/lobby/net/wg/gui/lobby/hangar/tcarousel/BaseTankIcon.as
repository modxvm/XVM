package net.wg.gui.lobby.hangar.tcarousel
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.filters.DropShadowFilter;
    import net.wg.infrastructure.interfaces.IImage;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.Image;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.controls.ActionPrice;
    import flash.display.Sprite;
    import net.wg.gui.components.carousels.data.VehicleCarouselVO;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.display.DisplayObject;

    public class BaseTankIcon extends UIComponentEx
    {

        private static const LABEL_WITH_NATION_CHANGE:String = "withNationChange";

        private static const LABEL_WITHOUT_NATION_CHANGE:String = "withoutNationChange";

        private static const PREM_FILTER:DropShadowFilter = new DropShadowFilter(0,90,16723968,0.7,12,12,3,2);

        private static const DEF_FILTER:DropShadowFilter = new DropShadowFilter(0,90,13224374,0.2,8,8,4,2);

        private static const TXT_INFO_CRIT_FILTER:DropShadowFilter = new DropShadowFilter(0,90,9831174,1,12,12,1.8,2);

        private static const TXT_INFO_WARN_FILTER:DropShadowFilter = new DropShadowFilter(0,90,0,1,12,12,1.8,2);

        private static const INFO_IMG_OFFSET_H:int = 32;

        public var specialBg:IImage = null;

        public var mcFlag:MovieClip = null;

        public var imgIcon:Image = null;

        public var mcTankType:MovieClip = null;

        public var mcLevel:MovieClip = null;

        public var txtTankName:TextField = null;

        public var imgFavorite:Image = null;

        public var price:IconText = null;

        public var txtInfo:TextField = null;

        public var clanLock:ClanLockUI = null;

        public var actionPrice:ActionPrice = null;

        public var imgXp:Image = null;

        public var statsBg:MovieClip = null;

        public var statsTF:TextField = null;

        public var lockedBG:Sprite = null;

        public var infoImg:IImage = null;

        public var rentalBG:MovieClip = null;

        public var rentalHoverBG:MovieClip = null;

        public var addImg:IImage = null;

        public var bpSpecialBorder:MovieClip = null;

        private var _visibleVehicleInfo:Boolean = true;

        private var _showStats:Boolean = false;

        private var _infoImgOffset:int = 0;

        private var _isLockBackground:Boolean = false;

        private var _isBuySlot:Boolean = false;

        private var _isBuyTank:Boolean = false;

        private var _isRentPromotion:Boolean = false;

        public function BaseTankIcon()
        {
            super();
            this.statsBg.visible = this.statsTF.visible = false;
            this.rentalHoverBG.visible = false;
            this.rentalBG.visible = false;
            this.addImg.visible = false;
        }

        override protected function onDispose() : void
        {
            this.mcFlag = null;
            this.specialBg.dispose();
            this.specialBg = null;
            this.imgIcon.dispose();
            this.imgIcon = null;
            this.mcTankType = null;
            this.mcLevel = null;
            this.txtTankName = null;
            this.imgFavorite.dispose();
            this.imgFavorite = null;
            this.price.dispose();
            this.price = null;
            this.txtInfo = null;
            this.clanLock.dispose();
            this.clanLock = null;
            this.actionPrice.dispose();
            this.actionPrice = null;
            this.imgXp.dispose();
            this.imgXp = null;
            this.statsBg = null;
            this.statsTF = null;
            this.lockedBG = null;
            this.infoImg.dispose();
            this.infoImg = null;
            this.rentalBG = null;
            this.rentalHoverBG = null;
            this.addImg.dispose();
            this.addImg = null;
            this.bpSpecialBorder = null;
            super.onDispose();
        }

        public function handleRollOut(param1:VehicleCarouselVO) : void
        {
            if(this._visibleVehicleInfo && this._showStats)
            {
                if(this._isRentPromotion)
                {
                    this.rentalHoverBG.visible = false;
                    this.rentalBG.visible = true;
                }
                else
                {
                    this.statsBg.visible = this.statsTF.visible = false;
                }
            }
            this.addImg.visible = StringUtils.isNotEmpty(param1.additionalImgSrc);
        }

        public function handleRollOver(param1:VehicleCarouselVO) : void
        {
            if(this._visibleVehicleInfo && this._showStats)
            {
                if(this._isRentPromotion)
                {
                    this.rentalHoverBG.visible = true;
                    this.rentalBG.visible = false;
                }
                else
                {
                    this.statsBg.visible = this.statsTF.visible = true;
                }
            }
        }

        public final function setData(param1:VehicleCarouselVO) : void
        {
            if(param1 != null)
            {
                this.updateData(param1);
            }
            else
            {
                visible = false;
            }
        }

        public final function setTextInfo(param1:String) : void
        {
            if(this.txtInfo.visible)
            {
                this.txtInfo.htmlText = param1;
            }
        }

        protected function updateData(param1:VehicleCarouselVO) : void
        {
            this.gotoAndStop(param1.isNationChangeAvailable?LABEL_WITH_NATION_CHANGE:LABEL_WITHOUT_NATION_CHANGE);
            this.price.visible = this.actionPrice.visible = this.lockedBG.visible = this.infoImg.visible = false;
            this._showStats = param1.visibleStats;
            if(StringUtils.isNotEmpty(param1.infoText) || StringUtils.isNotEmpty(param1.smallInfoText))
            {
                this.txtInfo.filters = param1.isCritInfo?[TXT_INFO_CRIT_FILTER]:[TXT_INFO_WARN_FILTER];
            }
            this.infoImg.visible = StringUtils.isNotEmpty(param1.infoImgSrc);
            this.addImg.visible = StringUtils.isNotEmpty(param1.additionalImgSrc);
            this._infoImgOffset = this.infoImg.visible?INFO_IMG_OFFSET_H:0;
            this._isBuySlot = param1.buySlot;
            this._isBuyTank = param1.buyTank || param1.restoreTank;
            this._isRentPromotion = param1.isRentPromotion;
            if(this._isBuyTank)
            {
                this.setVisibleVehicleInfo(false);
            }
            else if(this._isBuySlot)
            {
                this.setVisibleVehicleInfo(false);
                if(param1.hasSale)
                {
                    this.actionPrice.setData(param1.getActionPriceVO());
                }
                else
                {
                    this.price.text = param1.slotPrice.toString();
                }
                this.price.visible = !param1.hasSale;
                this.actionPrice.visible = param1.hasSale;
            }
            else
            {
                this.mcFlag.gotoAndStop(param1.nation + 1);
                this.mcTankType.gotoAndStop(param1.tankType);
                this.mcLevel.gotoAndStop(param1.level);
                this.imgXp.source = param1.xpImgSource;
                this.txtTankName.htmlText = param1.label;
                this.txtTankName.filters = param1.premium?[PREM_FILTER]:[DEF_FILTER];
                this.statsTF.htmlText = param1.statsText;
                this._isLockBackground = param1.lockBackground;
                if(this.infoImg.visible)
                {
                    this.infoImg.source = param1.infoImgSrc;
                }
                if(this.addImg.visible)
                {
                    this.addImg.source = param1.additionalImgSrc;
                }
                this.setVisibleVehicleInfo(true);
            }
            this.bpSpecialBorder.visible = param1.progressionPoints && param1.progressionPoints.isSpecialVehicle;
            this.updateLockBg();
            this.imgFavorite.visible = param1.favorite;
            this.clanLock.timer = param1.clanLock;
            this.rentalBG.visible = this._isRentPromotion;
            visible = true;
        }

        protected function setVisibleVehicleInfo(param1:Boolean) : void
        {
            if(this._visibleVehicleInfo != param1)
            {
                this._visibleVehicleInfo = param1;
                this.txtTankName.visible = this.imgXp.visible = this.mcTankType.visible = this.mcFlag.visible = this.mcLevel.visible = param1;
            }
        }

        protected function updateSpecialBg(param1:String, param2:Boolean) : void
        {
            var _loc3_:* = 0;
            var _loc4_:DisplayObject = null;
            if(StringUtils.isNotEmpty(param1))
            {
                this.specialBg.visible = true;
                this.specialBg.source = param1;
                if(param2)
                {
                    _loc3_ = getChildIndex(this.mcFlag);
                    _loc4_ = DisplayObject(this.specialBg);
                    if(this.getChildIndex(_loc4_) < _loc3_)
                    {
                        this.setChildIndex(_loc4_,_loc3_);
                    }
                }
            }
            else
            {
                this.specialBg.visible = false;
            }
        }

        private function updateLockBg() : void
        {
            this.lockedBG.visible = !(this._isBuySlot || this._isBuyTank) && (this._isLockBackground || !enabled);
        }

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this.updateLockBg();
        }

        public function get infoImgOffset() : int
        {
            return this._infoImgOffset;
        }
    }
}
