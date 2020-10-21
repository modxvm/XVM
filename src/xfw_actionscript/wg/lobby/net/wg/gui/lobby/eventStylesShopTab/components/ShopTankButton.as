package net.wg.gui.lobby.eventStylesShopTab.components
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.eventStylesTrade.data.SkinVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.eventStylesShopTab.events.StylesShopTabEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.DisplayObject;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import org.idmedia.as3commons.util.StringUtils;

    public class ShopTankButton extends SoundButtonEx
    {

        private static const SKINS:Array = ["Tank1SkinUI","Tank2SkinUI","Tank3SkinUI","Tank4SkinUI","Tank5SkinUI"];

        public var textDone:TextField = null;

        public var textNum:TextField = null;

        public var icon:Sprite = null;

        public var skin:Sprite = null;

        public var styleIcon:Sprite = null;

        public var rewardIcon:UILoaderAlt = null;

        private var _skinData:SkinVO = null;

        private var _toolTipMgr:ITooltipMgr;

        private var _index:int = -1;

        public function ShopTankButton()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
            preventAutosizing = true;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.styleIcon.useHandCursor = this.styleIcon.buttonMode = this.rewardIcon.useHandCursor = this.rewardIcon.buttonMode = true;
            this.styleIcon.mouseChildren = this.rewardIcon.mouseChildren = false;
            this.rewardIcon.addEventListener(MouseEvent.ROLL_OVER,this.onRewardIconRollOverHandler);
            this.rewardIcon.addEventListener(MouseEvent.ROLL_OUT,this.onRewardIconRollOutHandler);
            this.styleIcon.addEventListener(MouseEvent.ROLL_OVER,this.onStyleIconRollOverHandler);
            this.styleIcon.addEventListener(MouseEvent.ROLL_OUT,this.onStyleIconRollOutHandler);
            mouseChildren = true;
        }

        override protected function handleClick(param1:uint = 0) : void
        {
            super.handleClick(param1);
            dispatchEvent(new StylesShopTabEvent(StylesShopTabEvent.TANK_CLICK,this._index));
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                textField.mouseEnabled = this.textDone.mouseEnabled = this.skin.mouseEnabled = this.icon.mouseEnabled = this.textNum.mouseEnabled = false;
            }
            if(this._skinData != null && isInvalid(InvalidationType.DATA))
            {
                while(this.skin.numChildren > 0)
                {
                    this.skin.removeChildAt(0);
                }
                _loc1_ = SKINS[this._index];
                this.skin.addChild(DisplayObject(App.utils.classFactory.getObject(_loc1_)));
                this.textDone.visible = this._skinData.haveInStorage;
                if(this._skinData.haveInStorage)
                {
                    this.textDone.text = EVENT.STYLESSHOP_DONE;
                }
                this.rewardIcon.source = this._skinData.rewardIcon;
            }
        }

        override protected function updateText() : void
        {
            if(this._skinData != null)
            {
                this.textNum.visible = this.icon.visible = !this._skinData.haveInStorage;
                if(!this._skinData.haveInStorage)
                {
                    this.textNum.text = this._skinData.price.toString();
                }
                textField.text = App.utils.locale.makeString(EVENT.TRADESTYLES_SKINNAME,{"name":this._skinData.name});
            }
        }

        override protected function onDispose() : void
        {
            this.rewardIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onRewardIconRollOverHandler);
            this.rewardIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onRewardIconRollOutHandler);
            this.styleIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onStyleIconRollOverHandler);
            this.styleIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onStyleIconRollOutHandler);
            this._toolTipMgr = null;
            this.rewardIcon.dispose();
            this.rewardIcon = null;
            this.textDone = null;
            this.textNum = null;
            this._skinData = null;
            this.icon = null;
            this.skin = null;
            this.styleIcon = null;
            super.onDispose();
        }

        public function setData(param1:SkinVO, param2:int) : void
        {
            this._skinData = param1;
            this._index = param2;
            invalidateData();
        }

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            mouseChildren = true;
        }

        override protected function onMouseRollOverHandler(param1:MouseEvent) : void
        {
            super.onMouseRollOverHandler(param1);
            dispatchEvent(new StylesShopTabEvent(StylesShopTabEvent.TANK_OVER,this._index));
        }

        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            super.handleMouseRollOut(param1);
            dispatchEvent(new StylesShopTabEvent(StylesShopTabEvent.TANK_OUT,this._index));
        }

        private function onRewardIconRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:ToolTipVO = this._skinData.rewardTooltip;
            if(!_loc2_)
            {
                return;
            }
            if(StringUtils.isNotEmpty(_loc2_.tooltip))
            {
                this._toolTipMgr.showComplex(_loc2_.tooltip);
            }
            else
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[_loc2_.specialAlias,null].concat(_loc2_.specialArgs));
            }
        }

        private function onRewardIconRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onStyleIconRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:ToolTipVO = this._skinData.styleTooltip;
            if(!_loc2_)
            {
                return;
            }
            if(StringUtils.isNotEmpty(_loc2_.tooltip))
            {
                this._toolTipMgr.showComplex(_loc2_.tooltip);
            }
            else
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[_loc2_.specialAlias,null].concat(_loc2_.specialArgs));
            }
        }

        private function onStyleIconRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
