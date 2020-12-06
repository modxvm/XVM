package net.wg.gui.lobby.hangar.tcarousel
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.filters.DropShadowFilter;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.ImageComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.controls.ActionPrice;
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.IImage;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.components.common.AlphaPropertyWrapper;
    import net.wg.gui.components.carousels.data.VehicleCarouselVO;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.display.BlendMode;
    import flash.geom.Rectangle;

    public class BaseTankIcon extends UIComponentEx
    {

        private static const LABEL_WITH_NATION_CHANGE:String = "withNationChange";

        private static const LABEL_WITHOUT_NATION_CHANGE:String = "withoutNationChange";

        private static const PREM_FILTER:DropShadowFilter = new DropShadowFilter(0,90,16723968,0.7,12,12,3,2);

        private static const DEF_FILTER:DropShadowFilter = new DropShadowFilter(0,90,13224374,0.2,8,8,4,2);

        private static const TXT_INFO_CRIT_FILTER:DropShadowFilter = new DropShadowFilter(0,90,9831174,1,12,12,1.8,2);

        private static const TXT_INFO_WARN_FILTER:DropShadowFilter = new DropShadowFilter(0,90,0,1,12,12,1.8,2);

        private static const INFO_IMG_OFFSET_H:int = 32;

        private static const CRYSTALS_FRAME:String = "Active";

        private static const CRYSTALS_LIMIT_REACH_FRAME:String = "Deactivated";

        private static const NY_OVERLAY_LBL_CRYSTALS:String = "crystals";

        private static const NY_OVERLAY_LBL:String = "usual";

        private static const NY_ALPHA_ANIM_DUR:int = 500;

        public var mcFlag:MovieClip = null;

        public var imgIcon:ImageComponent = null;

        public var hoverImgIcon:ImageComponent = null;

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

        public var newYearOverlay:MovieClip = null;

        public var nyBlink:MovieClip = null;

        public var addImg:IImage = null;

        public var bpSpecialBorder:MovieClip = null;

        public var crystalsIcon:MovieClip = null;

        public var crystalsGlow:Sprite = null;

        public var crystalsGlowBlend:Sprite = null;

        protected var hasHoverImg:Boolean = false;

        private var _visibleVehicleInfo:Boolean = true;

        private var _showStats:Boolean = false;

        private var _infoImgOffset:int = 0;

        private var _isLockBackground:Boolean = false;

        private var _isBuySlot:Boolean = false;

        private var _isBuyTank:Boolean = false;

        private var _isRentPromotion:Boolean = false;

        private var _isEarnCrystals:Boolean = false;

        private var _rollAnim:Tween = null;

        private var _hoverImgAlphaWrapper:AlphaPropertyWrapper = null;

        private var _isNYSlot:Boolean = false;

        public function BaseTankIcon()
        {
            super();
            this.crystalsGlow.visible = false;
            this.crystalsGlowBlend.visible = false;
            this.statsBg.visible = false;
            this.statsTF.visible = false;
            this.crystalsIcon.visible = false;
            this.rentalHoverBG.visible = false;
            this.rentalBG.visible = false;
            this.addImg.visible = false;
            this.imgIcon.tooltipEnabled = false;
            this.hoverImgIcon.tooltipEnabled = false;
            this.hoverImgIcon.alpha = 0;
            this.imgIconBoundaries = this.maxIconBounds;
        }

        override protected function onDispose() : void
        {
            if(this._rollAnim)
            {
                this._rollAnim.paused = true;
                this._rollAnim.dispose();
                this._rollAnim = null;
            }
            if(this._hoverImgAlphaWrapper)
            {
                this._hoverImgAlphaWrapper.dispose();
                this._hoverImgAlphaWrapper = null;
            }
            this.mcFlag = null;
            this.imgIcon.dispose();
            this.imgIcon = null;
            this.hoverImgIcon.dispose();
            this.hoverImgIcon = null;
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
            this.newYearOverlay = null;
            this.nyBlink = null;
            this.bpSpecialBorder = null;
            this.crystalsGlow = null;
            this.crystalsGlowBlend = null;
            this.crystalsIcon = null;
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
                    this.statsBg.visible = this.statsTF.visible = this.crystalsIcon.visible = false;
                }
            }
            this.addImg.visible = StringUtils.isNotEmpty(param1.additionalImgSrc);
            this.hoverImgIcon.visible = this.hasHoverImg;
            if(this.hasHoverImg)
            {
                this.prepareHoverAnimation();
                this._rollAnim = new Tween(NY_ALPHA_ANIM_DUR,this._hoverImgAlphaWrapper,{"alpha":0});
            }
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
                    this.crystalsIcon.visible = this._isEarnCrystals;
                }
            }
            this.hoverImgIcon.visible = this.hasHoverImg;
            if(this.hasHoverImg)
            {
                this.prepareHoverAnimation();
                this._rollAnim = new Tween(NY_ALPHA_ANIM_DUR,this._hoverImgAlphaWrapper,{"alpha":1});
            }
        }

        private function prepareHoverAnimation() : void
        {
            if(!this.hoverImgIcon.visible)
            {
                this.hoverImgIcon.visible = true;
            }
            if(this._rollAnim)
            {
                this._rollAnim.paused = true;
            }
            if(!this._hoverImgAlphaWrapper)
            {
                this._hoverImgAlphaWrapper = new AlphaPropertyWrapper(this.hoverImgIcon);
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

        private function enableNyBlink(param1:VehicleCarouselVO) : void
        {
            if(this.nyBlink == null)
            {
                return;
            }
            var _loc2_:Boolean = param1 != null?param1.nyBlinkEnabled:false;
            this.nyBlink.visible = _loc2_;
            if(_loc2_)
            {
                this.nyBlink.blendMode = BlendMode.ADD;
                this.nyBlink.gotoAndPlay(0);
            }
            else
            {
                this.nyBlink.gotoAndStop(0);
            }
        }

        protected function updateData(param1:VehicleCarouselVO) : void
        {
            this.gotoAndStop(param1.isNationChangeAvailable?LABEL_WITH_NATION_CHANGE:LABEL_WITHOUT_NATION_CHANGE);
            this.enableNyBlink(param1);
            this.price.visible = this.actionPrice.visible = this.lockedBG.visible = this.infoImg.visible = false;
            this._showStats = param1.visibleStats;
            this._isEarnCrystals = param1.isEarnCrystals;
            if(StringUtils.isNotEmpty(param1.infoText) || StringUtils.isNotEmpty(param1.smallInfoText))
            {
                this.txtInfo.filters = param1.isCritInfo?[TXT_INFO_CRIT_FILTER]:[TXT_INFO_WARN_FILTER];
            }
            this.infoImg.visible = StringUtils.isNotEmpty(param1.infoImgSrc);
            this.addImg.visible = StringUtils.isNotEmpty(param1.additionalImgSrc);
            var _loc2_:Boolean = this._isEarnCrystals && !param1.isCrystalsLimitReached;
            this.crystalsGlow.visible = this.crystalsGlowBlend.visible = _loc2_;
            var _loc3_:Boolean = param1.hasNyBonus;
            this.newYearOverlay.visible = _loc3_;
            if(_loc3_)
            {
                this.newYearOverlay.gotoAndStop(_loc2_?NY_OVERLAY_LBL_CRYSTALS:NY_OVERLAY_LBL);
            }
            this._infoImgOffset = this.infoImg.visible?INFO_IMG_OFFSET_H:0;
            this._isBuySlot = param1.buySlot;
            this._isBuyTank = param1.buyTank || param1.restoreTank;
            this._isRentPromotion = param1.isRentPromotion;
            this.crystalsIcon.gotoAndStop(param1.isCrystalsLimitReached?CRYSTALS_LIMIT_REACH_FRAME:CRYSTALS_FRAME);
            this._isNYSlot = param1.nySlot;
            if(this._isBuyTank || this._isNYSlot)
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
                this.mcLevel.visible = param1.level != 0;
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

        private function updateLockBg() : void
        {
            if(this._isNYSlot)
            {
                this.lockedBG.visible = false;
            }
            else
            {
                this.lockedBG.visible = !(this._isBuySlot || this._isBuyTank) && (this._isLockBackground || !enabled);
            }
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

        protected function get maxIconBounds() : Rectangle
        {
            return null;
        }

        private function set imgIconBoundaries(param1:Rectangle) : void
        {
            if(!param1)
            {
                this.imgIcon.x = this.imgIcon.y = 0;
                this.imgIcon.adjustSize = true;
                this.hoverImgIcon.x = this.hoverImgIcon.y = 0;
                this.hoverImgIcon.adjustSize = true;
                return;
            }
            this.imgIcon.x = this.hoverImgIcon.x = param1.x;
            this.imgIcon.y = this.hoverImgIcon.y = param1.y;
            this.imgIcon.setSize(param1.width,param1.height);
            this.hoverImgIcon.setSize(param1.width,param1.height);
        }
    }
}
