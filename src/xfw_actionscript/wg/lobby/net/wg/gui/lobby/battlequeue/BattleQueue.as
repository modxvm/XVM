package net.wg.gui.lobby.battlequeue
{
    import net.wg.infrastructure.base.meta.impl.BattleQueueMeta;
    import net.wg.infrastructure.base.meta.IBattleQueueMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.components.icons.BattleTypeIcon;
    import net.wg.gui.components.common.FrameStateCmpnt;
    import scaleform.clik.events.ButtonEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Values;
    import scaleform.clik.events.InputEvent;
    import flash.text.TextFieldAutoSize;

    public class BattleQueue extends BattleQueueMeta implements IBattleQueueMeta
    {

        private static const MIN_POS_Y:int = 80;

        private static const INV_TYPE_INFO:String = "InvTypeInfo";

        private static const TNK_ICON_SPACE:int = 32;

        private static const TNK_ICON_OFFSET:int = 25;

        private static const TICKER_HEIGHT:int = 22;

        public var timerLabel:TextField;

        public var timerText:TextField;

        public var tankLabel:TextField;

        public var tankName:TextField;

        public var tankIcon:UILoaderAlt;

        public var playersLabel:TextField;

        public var gameplayTip:TextField;

        public var additional:TextField;

        public var modeTitle:TextField;

        public var exitButton:ISoundButtonEx;

        public var listByType:ScrollingListEx;

        public var startButton:ISoundButtonEx;

        public var battleIcon:BattleTypeIcon;

        public var battleIconBg:FrameStateCmpnt;

        private var _typeInfo:BattleQueueTypeInfoVO;

        public function BattleQueue()
        {
            super();
            this.tankLabel.autoSize = TextFieldAutoSize.LEFT;
            this.tankName.autoSize = TextFieldAutoSize.LEFT;
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            this.x = param1 - this.actualWidth >> 1;
            this.y = Math.min(-parent.y + (param2 - this.actualHeight >> 1),MIN_POS_Y);
            if(App.globalVarsMgr.isShowTickerS())
            {
                this.y = this.y - TICKER_HEIGHT >> 1;
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.startButton.visible = false;
            this.listByType.mouseChildren = false;
            this.startButton.addEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
            this.exitButton.addEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
        }

        override protected function onDispose() : void
        {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
            this.listByType.disposeRenderers();
            this.startButton.removeEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
            this.exitButton.removeEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
            this.tankLabel = null;
            this.timerLabel = null;
            this.playersLabel = null;
            this.gameplayTip = null;
            this.modeTitle = null;
            this.timerText = null;
            this.tankName = null;
            this.exitButton.dispose();
            this.exitButton = null;
            this.listByType.dispose();
            this.listByType = null;
            this.startButton.dispose();
            this.startButton = null;
            this.battleIcon.dispose();
            this.battleIcon = null;
            this.additional = null;
            this._typeInfo.dispose();
            this._typeInfo = null;
            this.tankIcon.dispose();
            this.tankIcon = null;
            this.battleIconBg.dispose();
            this.battleIconBg = null;
            super.onDispose();
        }

        override protected function setDP(param1:DataProvider) : void
        {
            this.listByType.dataProvider = param1;
            if(!this.listByType.visible)
            {
                this.listByType.visible = true;
            }
        }

        override protected function setTypeInfo(param1:BattleQueueTypeInfoVO) : void
        {
            this._typeInfo = param1;
            invalidate(INV_TYPE_INFO);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._typeInfo && isInvalid(INV_TYPE_INFO))
            {
                this.modeTitle.text = this._typeInfo.title;
                this.battleIcon.type = this._typeInfo.iconLabel;
                this.battleIconBg.frameLabel = this._typeInfo.iconLabel;
                if(_baseDisposed)
                {
                    return;
                }
                this.gameplayTip.text = this._typeInfo.description;
                this.additional.htmlText = this._typeInfo.additional;
                this.tankLabel.htmlText = this._typeInfo.tankLabel;
                this.tankName.text = this._typeInfo.tankName;
                this.tankName.x = this.tankLabel.x + this.tankLabel.width + TNK_ICON_SPACE;
                if(this._typeInfo.tankIcon != Values.EMPTY_STR)
                {
                    this.tankIcon.source = this._typeInfo.tankIcon;
                    this.tankIcon.x = this.tankLabel.x + this.tankLabel.width - TNK_ICON_OFFSET;
                }
            }
        }

        public function as_setPlayers(param1:String) : void
        {
            this.playersLabel.htmlText = param1;
        }

        public function as_setTimer(param1:String, param2:String) : void
        {
            this.timerLabel.htmlText = param1;
            this.timerText.htmlText = param2;
        }

        public function as_showExit(param1:Boolean) : void
        {
            this.exitButton.visible = param1;
        }

        public function as_showStart(param1:Boolean) : void
        {
            this.startButton.visible = param1;
        }

        private function onExitButtonClickHandler(param1:ButtonEvent) : void
        {
            exitClickS();
        }

        private function onStartButtonClickHandler(param1:ButtonEvent) : void
        {
            startClickS();
        }

        private function handleEscape(param1:InputEvent) : void
        {
            onEscapeS();
        }
    }
}
