package net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults
{
    import scaleform.clik.controls.ListItemRenderer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.rankedBattles19.data.PlayerRankRendererVO;
    import net.wg.utils.ICommons;
    import flash.events.MouseEvent;
    import flash.text.TextFormat;
    import net.wg.data.constants.Values;
    import org.idmedia.as3commons.util.StringUtils;

    public class PlayerRankedRenderer extends ListItemRenderer
    {

        public static const RENDERER_HEIGHT:int = 28;

        public static const HUGE_RENDERER_HEIGHT:int = 32;

        private static const STATE_BLINK:String = "show";

        private static const STANDOFF_HUGE_OFFSET_Y:int = 2;

        private static const FONT_SIZE_COMPACT:int = 14;

        private static const FONT_SIZE_INCOMPACT:int = 16;

        public var selectBackground:MovieClip = null;

        public var nickName:TextField = null;

        public var standoff:MovieClip = null;

        public var points:TextField = null;

        public var wave:MovieClip = null;

        private var _selectedActive:Boolean = false;

        private var _standoffVisible:Boolean = false;

        private var _isCompact:Boolean = false;

        private var _standoffY:int = -1;

        private var _standoffHugeY:int = -1;

        private var _tooltipMgr:ITooltipMgr = null;

        private var _dataVo:PlayerRankRendererVO = null;

        private var _tooltipNickName:String = "";

        private var _commons:ICommons = null;

        public function PlayerRankedRenderer()
        {
            super();
            this._tooltipMgr = App.toolTipMgr;
            this._commons = App.utils.commons;
        }

        override public function setData(param1:Object) : void
        {
            this._dataVo = PlayerRankRendererVO(param1);
            var _loc2_:int = this._dataVo.standoff;
            this._standoffVisible = Boolean(_loc2_);
            this._selectedActive = this._dataVo.selected;
            this.selectBackground.visible = this._selectedActive;
            this.standoff.visible = this._standoffVisible;
            if(this._standoffVisible)
            {
                this.standoff.gotoAndStop(_loc2_);
            }
            this.updateTexts();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._standoffY = this.standoff.y;
            this._standoffHugeY = this._standoffY + STANDOFF_HUGE_OFFSET_Y;
            this.nickName.addEventListener(MouseEvent.MOUSE_OVER,this.onNickNameMouseOverHandler);
            this.nickName.addEventListener(MouseEvent.MOUSE_OUT,this.onNickNameMouseOutHandler);
            this.points.mouseEnabled = false;
            mouseEnabled = false;
            mouseChildren = true;
        }

        override protected function onDispose() : void
        {
            this.nickName.removeEventListener(MouseEvent.MOUSE_OVER,this.onNickNameMouseOverHandler);
            this.nickName.removeEventListener(MouseEvent.MOUSE_OUT,this.onNickNameMouseOutHandler);
            this._dataVo = null;
            this.selectBackground = null;
            this.nickName = null;
            this.standoff = null;
            this.points = null;
            _owner = null;
            this.wave = null;
            this._tooltipMgr = null;
            this._commons = null;
            super.onDispose();
        }

        public function blink() : void
        {
            this.wave.gotoAndPlay(STATE_BLINK);
        }

        public function setCompact(param1:Boolean) : void
        {
            if(this._isCompact == param1)
            {
                return;
            }
            this._isCompact = param1;
            this.selectBackground.height = param1?RENDERER_HEIGHT:HUGE_RENDERER_HEIGHT;
            this.standoff.y = param1?this._standoffY:this._standoffHugeY;
            this.updateTexts();
        }

        private function updateTexts() : void
        {
            var _loc1_:String = null;
            var _loc2_:* = 0;
            var _loc3_:TextFormat = null;
            var _loc4_:String = null;
            if(this._dataVo)
            {
                if(this._isCompact)
                {
                    this.points.htmlText = this._dataVo.points;
                    _loc1_ = this._dataVo.nickName;
                    _loc2_ = FONT_SIZE_COMPACT;
                }
                else
                {
                    this.points.htmlText = this._dataVo.pointsHuge;
                    _loc1_ = this._dataVo.nickNameHuge;
                    _loc2_ = FONT_SIZE_INCOMPACT;
                }
                _loc3_ = this.nickName.getTextFormat();
                _loc3_.size = _loc2_;
                this.nickName.defaultTextFormat = _loc3_;
                _loc4_ = this._commons.truncateTextFieldText(this.nickName,_loc1_,true,true);
                if(_loc4_ && _loc4_ != _loc1_)
                {
                    this._tooltipNickName = this._commons.cutHtmlText(_loc1_);
                }
                else
                {
                    this._tooltipNickName = Values.EMPTY_STR;
                }
            }
        }

        private function showTooltipFullName(param1:String) : void
        {
            if(StringUtils.isNotEmpty(param1))
            {
                this._tooltipMgr.show(param1);
            }
        }

        override public function set selected(param1:Boolean) : void
        {
            _selected = param1;
            this.selectBackground.visible = param1;
        }

        public function get selectedActive() : Boolean
        {
            return this._selectedActive;
        }

        public function get standoffVisible() : Boolean
        {
            return this._standoffVisible;
        }

        private function onNickNameMouseOverHandler(param1:MouseEvent) : void
        {
            this.showTooltipFullName(this._tooltipNickName);
        }

        private function onNickNameMouseOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }
    }
}
