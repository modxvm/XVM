package net.wg.gui.lobby.eventBattleQueue
{
    import net.wg.infrastructure.base.meta.impl.EventBattleQueueMeta;
    import net.wg.infrastructure.base.meta.IEventBattleQueueMeta;
    import flash.text.TextField;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.common.FrameStateCmpnt;
    import scaleform.clik.events.ButtonEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import net.wg.gui.events.LobbyEvent;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.InputEvent;

    public class EventBattleQueue extends EventBattleQueueMeta implements IEventBattleQueueMeta
    {

        private static const DIFFICULTY_LABEL:String = "difficulty";

        private static const DIFFICULTY_OFFSET:int = 7;

        private static const DIFFICULTY_WIDTH:int = 9;

        public var titleLabel:TextField = null;

        public var timerLabel:TextField = null;

        public var difficultyLabel:TextField = null;

        public var tipsLabel:TextField = null;

        public var exitButton:ISoundButtonEx = null;

        public var difficulty:FrameStateCmpnt = null;

        private var _difficulty:int = 0;

        public function EventBattleQueue()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            this.x = param1 >> 1;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.exitButton.addEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
            this.exitButton.label = MENU.PREBATTLE_EXITBUTTON_EVENT;
            this.difficultyLabel.text = MENU.PREBATTLE_DIFFICULTYLABEL_EVENT;
            this.tipsLabel.text = MENU.PREBATTLE_TIPSLABEL_EVENT;
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            if(isInvalid(InvalidationType.STATE))
            {
                this.difficulty.frameLabel = DIFFICULTY_LABEL + this._difficulty.toString();
                _loc1_ = DIFFICULTY_WIDTH * this._difficulty + this._difficulty - 1;
                this.difficultyLabel.x = -(this.difficultyLabel.textWidth + DIFFICULTY_OFFSET + _loc1_) >> 1;
                this.difficulty.x = this.difficultyLabel.x + this.difficultyLabel.textWidth + DIFFICULTY_OFFSET;
            }
        }

        override protected function onBeforeDispose() : void
        {
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
            this.exitButton.removeEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
            this.titleLabel = null;
            this.timerLabel = null;
            this.difficultyLabel = null;
            this.tipsLabel = null;
            this.exitButton.dispose();
            this.exitButton = null;
            this.difficulty.dispose();
            this.difficulty = null;
            super.onDispose();
        }

        public function as_setTimer(param1:String, param2:String) : void
        {
            this.titleLabel.text = param1;
            this.timerLabel.text = param2;
        }

        public function as_showExit(param1:Boolean) : void
        {
            this.exitButton.visible = param1;
        }

        public function as_setDifficulty(param1:int) : void
        {
            this._difficulty = param1;
            invalidateState();
        }

        private function onExitButtonClickHandler(param1:ButtonEvent) : void
        {
            exitClickS();
        }

        private function handleEscape(param1:InputEvent) : void
        {
            onEscapeS();
        }
    }
}
