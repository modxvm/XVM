package net.wg.gui.lobby.hangar.seniorityAwards
{
    import net.wg.infrastructure.managers.counter.CounterProps;
    import flash.text.TextFormatAlign;
    import flash.display.MovieClip;
    import net.wg.utils.ICounterManager;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.managers.counter.CounterManager;

    public class SeniorityAwardsEntryPointHangar extends SeniorityAwardsEntryPoint
    {

        private static const HOVER_SHOW_LABEL:String = "show";

        private static const HOVER_HIDE_LABEL:String = "hide";

        private static const SMALL_FRAME_LBL:String = "small";

        private static const BIG_FRAME_LBL:String = "big";

        private static const OVER_SOUND:String = "gui_hangar_award_woosh";

        private static const HOVER_HIDE_FRAME_IDX:int = 27;

        private static const COUNTER_PROPS:CounterProps = new CounterProps(12,-2,TextFormatAlign.RIGHT);

        public var hover:MovieClip = null;

        public var hoverBG:MovieClip = null;

        private var _isSmall:Boolean = false;

        private var _counterMgr:ICounterManager;

        public function SeniorityAwardsEntryPointHangar()
        {
            this._counterMgr = App.utils.counterManager;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            bounds.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            bounds.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            openBtn.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            this._counterMgr.setCounter(DisplayObject(openBtn),CounterManager.EXCLAMATION_COUNTER_VALUE,null,COUNTER_PROPS);
        }

        override protected function onDispose() : void
        {
            bounds.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            bounds.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            openBtn.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            this.hover = null;
            this.hoverBG = null;
            this._counterMgr = null;
            super.onDispose();
        }

        public function setMode(param1:Boolean) : void
        {
            if(this._isSmall == param1 || !visible)
            {
                return;
            }
            this._isSmall = param1;
            if(this._isSmall)
            {
                gotoAndStop(SMALL_FRAME_LBL);
            }
            else
            {
                gotoAndStop(BIG_FRAME_LBL);
            }
            applyData();
            updatePosition();
        }

        public function updateSize(param1:Number, param2:Number) : void
        {
            var _loc3_:Boolean = param1 < SeniorityAwardsEntryPoint.SMALL_TRESHOLD_X || param2 < SeniorityAwardsEntryPoint.SMALL_TRESHOLD_Y;
            this.setMode(_loc3_);
        }

        private function onMouseRollOverHandler(param1:MouseEvent) : void
        {
            if(this.hover.currentFrame >= HOVER_HIDE_FRAME_IDX)
            {
                this.hover.gotoAndStop(HOVER_HIDE_LABEL);
                this.hoverBG.gotoAndStop(HOVER_HIDE_LABEL);
            }
            else
            {
                this.hover.gotoAndPlay(HOVER_SHOW_LABEL);
                this.hoverBG.gotoAndPlay(HOVER_SHOW_LABEL);
            }
            App.toolTipMgr.showComplex(TOOLTIPS.SENIORITYAWARDS_HANGARENTRYPOINT_TOOLTIP);
            playSoundS(OVER_SOUND);
        }

        private function onMouseRollOutHandler(param1:MouseEvent) : void
        {
            this.hover.gotoAndPlay(HOVER_HIDE_LABEL);
            this.hoverBG.gotoAndPlay(HOVER_HIDE_LABEL);
            App.toolTipMgr.hide();
        }
    }
}
