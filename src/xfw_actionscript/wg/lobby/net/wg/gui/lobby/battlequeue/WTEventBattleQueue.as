package net.wg.gui.lobby.battlequeue
{
    import net.wg.infrastructure.base.meta.impl.WTEventBattleQueueMeta;
    import net.wg.infrastructure.base.meta.IWTEventBattleQueueMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.ScrollingListEx;
    import flash.display.Sprite;
    import net.wg.gui.lobby.techtree.helpers.TweenWrapper;
    import scaleform.clik.motion.Tween;
    import flash.display.DisplayObject;
    import scaleform.clik.events.ButtonEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Values;
    import fl.motion.easing.Cubic;
    import scaleform.clik.events.InputEvent;
    import flash.text.TextFieldAutoSize;

    public class WTEventBattleQueue extends WTEventBattleQueueMeta implements IWTEventBattleQueueMeta
    {

        private static const MIN_POS_Y:int = 80;

        private static const INV_TYPE_INFO:String = "InvTypeInfo";

        private static const TNK_ICON_SPACE:int = 32;

        private static const TNK_ICON_OFFSET:int = 16;

        private static const TWEEN_DURATION:int = 600;

        private static const WIDGET_TWEEN_Y_OFFSET:int = 129;

        private static const WIDGET_TWEEN_Y_DEFAULT_OFFSET:int = 10;

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

        public var changeWidget:WTEventChangeVehicleWidget;

        public var changeWidgetMask:Sprite;

        public var mcBonusDescr:Sprite;

        private var _typeInfo:BattleQueueTypeInfoVO;

        private var _changeWidgetTweenWrapper:TweenWrapper = null;

        private var _changeWidgetTween:Tween = null;

        private var _bonusLabelTween:Tween = null;

        private var _showedDefaultWidgetY:int = 0;

        private var _widgetVisible:Boolean = false;

        private var _maskHeight:int = 0;

        public function WTEventBattleQueue()
        {
            super();
            this.tankLabel.autoSize = TextFieldAutoSize.LEFT;
            this.tankName.autoSize = TextFieldAutoSize.LEFT;
            this._changeWidgetTweenWrapper = new TweenWrapper(this.changeWidget);
            this.changeWidget.mask = this.changeWidgetMask;
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            this.x = param1 - this.actualWidth >> 1;
            var _loc3_:DisplayObject = getChildAt(0);
            this.y = Math.min((param2 - _loc3_.height >> 1) - parent.y,MIN_POS_Y);
            this._showedDefaultWidgetY = param2 - this.changeWidget.height - this.y - WIDGET_TWEEN_Y_DEFAULT_OFFSET;
            if(this._widgetVisible && (this._changeWidgetTween == null || this._changeWidgetTween.paused))
            {
                this._changeWidgetTweenWrapper.y = this._showedDefaultWidgetY;
            }
            else if(!this._widgetVisible)
            {
                this._changeWidgetTweenWrapper.y = this._showedDefaultWidgetY + WIDGET_TWEEN_Y_OFFSET + WIDGET_TWEEN_Y_DEFAULT_OFFSET;
            }
            this.updateBonusDescrPosition();
            this._maskHeight = param2 - this.changeWidgetMask.y - this.y;
            this.changeWidgetMask.height = this._maskHeight;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.startButton.visible = false;
            this.listByType.mouseChildren = false;
            this.startButton.addEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
            this.exitButton.addEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
            this.changeWidget.addEventListener(ButtonEvent.CLICK,this.onChangeWidgetClickHandler);
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
            this.mcBonusDescr = null;
            this.exitButton.dispose();
            this.exitButton = null;
            this.listByType.dispose();
            this.listByType = null;
            this.startButton.dispose();
            this.startButton = null;
            this.additional = null;
            this._typeInfo.dispose();
            this._typeInfo = null;
            this.tankIcon.dispose();
            this.tankIcon = null;
            this.cleanTweens();
            this._changeWidgetTweenWrapper.dispose();
            this._changeWidgetTweenWrapper = null;
            this.changeWidget.removeEventListener(ButtonEvent.CLICK,this.onChangeWidgetClickHandler);
            this.changeWidget.mask = null;
            this.changeWidget = null;
            this.changeWidgetMask = null;
            super.onDispose();
        }

        override protected function setDP(param1:DataProvider) : void
        {
            this.listByType.dataProvider = param1;
            this.listByType.visible = true;
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
                if(_baseDisposed)
                {
                    return;
                }
                this.modeTitle.text = this._typeInfo.title;
                this.gameplayTip.text = this._typeInfo.description;
                this.additional.htmlText = this._typeInfo.additional;
                this.tankLabel.htmlText = this._typeInfo.tankLabel;
                this.tankName.text = this._typeInfo.tankName;
                this.tankName.x = this.tankLabel.x + this.tankLabel.width + TNK_ICON_SPACE >> 0;
                if(this._typeInfo.tankIcon != Values.EMPTY_STR)
                {
                    this.tankIcon.source = this._typeInfo.tankIcon;
                    this.tankIcon.x = this.tankLabel.x + this.tankLabel.width - TNK_ICON_OFFSET >> 0;
                }
            }
        }

        override protected function showSwitchVehicle(param1:WTEventChangeVehicleWidgetVO) : void
        {
            this.changeWidget.setData(param1);
            if(!this._widgetVisible)
            {
                this._widgetVisible = true;
                this._changeWidgetTweenWrapper.y = this._showedDefaultWidgetY + WIDGET_TWEEN_Y_OFFSET;
                this.updateBonusDescrPosition();
                this.changeWidgetMask.height = this._maskHeight;
                this.cleanTweens();
                this._changeWidgetTween = new Tween(TWEEN_DURATION,this._changeWidgetTweenWrapper,{
                    "y":this._showedDefaultWidgetY,
                    "alpha":1
                },{
                    "ease":Cubic.easeOut,
                    "paused":false,
                    "onComplete":this.onChangeShowWidgetTweenComplete
                });
                if(!param1.isBoss && !param1.needTicket)
                {
                    this._bonusLabelTween = new Tween(TWEEN_DURATION,this.mcBonusDescr,{"alpha":1},{
                        "ease":Cubic.easeOut,
                        "paused":false
                    });
                }
            }
        }

        public function as_hideSwitchVehicle() : void
        {
            this.cleanTweens();
            this._changeWidgetTween = new Tween(TWEEN_DURATION,this._changeWidgetTweenWrapper,{
                "y":this._showedDefaultWidgetY + WIDGET_TWEEN_Y_OFFSET,
                "alpha":0
            },{
                "ease":Cubic.easeInOut,
                "paused":false,
                "onComplete":this.onChangeHideWidgetTweenComplete
            });
            this._bonusLabelTween = new Tween(TWEEN_DURATION,this.mcBonusDescr,{"alpha":0},{
                "ease":Cubic.easeInOut,
                "paused":false
            });
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

        private function updateBonusDescrPosition() : void
        {
            this.mcBonusDescr.y = this._showedDefaultWidgetY + this.exitButton.y + this.exitButton.height - this.mcBonusDescr.height >> 1;
        }

        private function onChangeShowWidgetTweenComplete() : void
        {
            this.cleanTweens();
        }

        private function onChangeHideWidgetTweenComplete() : void
        {
            this.cleanTweens();
            onChangeWidgetHidedS();
        }

        private function cleanTweens() : void
        {
            if(this._changeWidgetTween != null)
            {
                this._changeWidgetTween.paused = true;
                this._changeWidgetTween.dispose();
                this._changeWidgetTween = null;
            }
            if(this._bonusLabelTween != null)
            {
                this._bonusLabelTween.paused = true;
                this._bonusLabelTween.dispose();
                this._bonusLabelTween = null;
            }
        }

        private function onExitButtonClickHandler(param1:ButtonEvent) : void
        {
            exitClickS();
        }

        private function onStartButtonClickHandler(param1:ButtonEvent) : void
        {
            startClickS();
        }

        private function onChangeWidgetClickHandler(param1:ButtonEvent) : void
        {
            onSwitchVehicleClickS();
        }

        private function handleEscape(param1:InputEvent) : void
        {
            onEscapeS();
        }
    }
}
