package net.wg.gui.bootcamp.questsView
{
    import net.wg.infrastructure.base.meta.impl.BCQuestsViewMeta;
    import net.wg.infrastructure.base.meta.IBCQuestsViewMeta;
    import net.wg.gui.bootcamp.questsView.containers.MissionContainer;
    import flash.display.MovieClip;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.bootcamp.questsView.data.BCQuestsViewVO;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import fl.transitions.easing.None;
    import fl.transitions.easing.Regular;

    public class BCQuestsView extends BCQuestsViewMeta implements IBCQuestsViewMeta
    {

        private static const TWEEN_TIME_SEC:Number = 120;

        private static const STAGE_RESIZED:String = "stageResized";

        private static const ON_CLOSE_SCALE:Number = 0.8;

        public var mission:MissionContainer = null;

        public var blackBG:MovieClip = null;

        private var _tweens:Vector.<Tween>;

        private var _data:BCQuestsViewVO;

        private var _stageWidth:int = 0;

        private var _stageHeight:int = 0;

        public function BCQuestsView()
        {
            this._tweens = new Vector.<Tween>();
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            this._stageWidth = param1;
            this._stageHeight = param2;
            invalidate(STAGE_RESIZED);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.repositionWindow();
            this.animOpenMission();
            this.mission.btnClose.addEventListener(MouseEvent.CLICK,this.onBtnCloseClickHandler);
            this.blackBG.addEventListener(MouseEvent.CLICK,this.onBlackBgClickHandler);
        }

        override protected function onDispose() : void
        {
            var _loc1_:Tween = null;
            this.mission.btnClose.removeEventListener(MouseEvent.CLICK,this.onBtnCloseClickHandler);
            this.blackBG.removeEventListener(MouseEvent.CLICK,this.onBlackBgClickHandler);
            this.mission.dispose();
            this.mission = null;
            this.blackBG = null;
            this._data = null;
            for each(_loc1_ in this._tweens)
            {
                _loc1_.paused = true;
                _loc1_.dispose();
            }
            this._tweens.splice(0,this._tweens.length);
            this._tweens = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.mission.setData(this._data);
            }
            if(isInvalid(STAGE_RESIZED))
            {
                this.repositionWindow();
            }
        }

        override protected function setData(param1:BCQuestsViewVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        protected function repositionWindow() : void
        {
            this.mission.x = this._stageWidth >> 1;
            this.mission.y = this._stageHeight >> 1;
            this.blackBG.width = this._stageWidth;
            this.blackBG.height = this._stageHeight;
        }

        private function animOpenMission() : void
        {
            this.blackBG.alpha = 0;
            var _loc1_:Tween = new Tween(TWEEN_TIME_SEC,this.blackBG,{"alpha":1},{
                "paused":false,
                "frameBased":false,
                "ease":None.easeIn
            });
            this._tweens.push(_loc1_);
            this.mission.alpha = 0;
            var _loc2_:Tween = new Tween(TWEEN_TIME_SEC,this.mission,{"alpha":1},{
                "paused":false,
                "frameBased":false,
                "ease":None.easeIn
            });
            this._tweens.push(_loc2_);
            this.mission.scaleX = this.mission.scaleY = 1;
            this.mission.alpha = 1;
        }

        private function onAnimationCloseComplete(param1:Tween) : void
        {
            onCloseClickedS();
        }

        private function onBtnCloseClickHandler(param1:MouseEvent) : void
        {
            this.animCloseMission();
        }

        private function onBlackBgClickHandler(param1:MouseEvent) : void
        {
            this.animCloseMission();
        }

        private function animCloseMission() : void
        {
            var _loc1_:Tween = new Tween(TWEEN_TIME_SEC,this.mission,{
                "scaleX":ON_CLOSE_SCALE,
                "scaleY":ON_CLOSE_SCALE,
                "alpha":0
            },{
                "paused":false,
                "frameBased":false,
                "ease":Regular.easeOut
            });
            this._tweens.push(_loc1_);
            var _loc2_:Tween = new Tween(TWEEN_TIME_SEC,this.blackBG,{"alpha":0},{
                "paused":false,
                "frameBased":false,
                "ease":Regular.easeOut,
                "onComplete":this.onAnimationCloseComplete
            });
            this._tweens.push(_loc2_);
        }
    }
}
