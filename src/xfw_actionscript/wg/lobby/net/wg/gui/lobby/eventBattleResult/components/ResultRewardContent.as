package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.utils.ICommons;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class ResultRewardContent extends UIComponentEx
    {

        private static const PADDING:int = 38;

        public var textFieldCredits:TextField = null;

        public var textFieldXP:TextField = null;

        public var textFieldFreeXP:TextField = null;

        public var iconCredits:MovieClip = null;

        public var iconXP:MovieClip = null;

        public var iconFreeXP:MovieClip = null;

        private var _commons:ICommons;

        private var _locale:ILocale;

        private var _credits:int = 0;

        private var _exp:int = 0;

        private var _freeXP:int = 0;

        private var _creditsTooltip:ToolTipVO = null;

        private var _expTooltip:ToolTipVO = null;

        private var _freeXPTooltip:ToolTipVO = null;

        private var _tooltipItems:Vector.<DisplayObject> = null;

        private var _tooltipMgr:ITooltipMgr;

        public function ResultRewardContent()
        {
            this._commons = App.utils.commons;
            this._locale = App.utils.locale;
            this._tooltipMgr = App.toolTipMgr;
            super();
            this._tooltipItems = new <DisplayObject>[this.textFieldCredits,this.textFieldXP,this.textFieldFreeXP,this.iconCredits,this.iconXP,this.iconFreeXP];
        }

        override protected function configUI() : void
        {
            var _loc1_:DisplayObject = null;
            super.configUI();
            for each(_loc1_ in this._tooltipItems)
            {
                _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.textFieldCredits.text = this._locale.integer(this._credits);
                this.textFieldXP.text = this._locale.integer(this._exp);
                this.textFieldFreeXP.text = this._locale.integer(this._freeXP);
                this._commons.updateTextFieldSize(this.textFieldCredits,true,false);
                this._commons.updateTextFieldSize(this.textFieldXP,true,false);
                this._commons.updateTextFieldSize(this.textFieldFreeXP,true,false);
                this.iconCredits.x = -(this.textFieldCredits.width + this.iconCredits.width + PADDING + this.textFieldXP.width + this.iconXP.width + PADDING + this.textFieldFreeXP.width + this.iconFreeXP.width >> 1);
                this.textFieldCredits.x = this.iconCredits.x + this.iconCredits.width >> 0;
                this.iconXP.x = this.textFieldCredits.x + this.textFieldCredits.width + PADDING >> 0;
                this.textFieldXP.x = this.iconXP.x + this.iconXP.width >> 0;
                this.iconFreeXP.x = this.textFieldXP.x + this.textFieldXP.width + PADDING >> 0;
                this.textFieldFreeXP.x = this.iconFreeXP.x + this.iconFreeXP.width >> 0;
            }
        }

        public function setData(param1:int, param2:int, param3:int) : void
        {
            if(this._credits != param1 || this._exp != param2 || this._freeXP != param3)
            {
                this._credits = param1;
                this._exp = param2;
                this._freeXP = param3;
                invalidateData();
            }
        }

        override protected function onBeforeDispose() : void
        {
            var _loc1_:DisplayObject = null;
            for each(_loc1_ in this._tooltipItems)
            {
                _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            }
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this._tooltipItems.splice(0,this._tooltipItems.length);
            this._tooltipItems = null;
            this.textFieldCredits = null;
            this.textFieldXP = null;
            this.textFieldFreeXP = null;
            this.iconCredits = null;
            this.iconXP = null;
            this.iconFreeXP = null;
            this._commons = null;
            this._locale = null;
            this._creditsTooltip = null;
            this._expTooltip = null;
            this._freeXPTooltip = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        public function setTooltips(param1:ToolTipVO, param2:ToolTipVO, param3:ToolTipVO) : void
        {
            this._creditsTooltip = param1;
            this._expTooltip = param2;
            this._freeXPTooltip = param3;
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            switch(param1.currentTarget)
            {
                case this.textFieldCredits:
                case this.iconCredits:
                    this.showTooltip(this._creditsTooltip);
                    break;
                case this.textFieldXP:
                case this.iconXP:
                    this.showTooltip(this._expTooltip);
                    break;
                case this.textFieldFreeXP:
                case this.iconFreeXP:
                    this.showTooltip(this._freeXPTooltip);
                    break;
            }
        }

        private function showTooltip(param1:ToolTipVO) : void
        {
            if(param1 == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(param1.tooltip))
            {
                this._tooltipMgr.showComplex(param1.tooltip);
            }
            else
            {
                this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[param1.specialAlias,null].concat(param1.specialArgs));
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }
    }
}
