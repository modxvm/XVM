package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.Event;
    import scaleform.clik.data.DataProvider;

    public class ResultMissions extends ResultAppearMovieClip implements IDisposable
    {

        private static const MISSION_RENDERER:String = "ResultMissionRendererUI";

        private static const RENDERER_WIDTH:int = 230;

        private static const RENDERER_HEIGHT:int = 223;

        private static const GAP_NORMAL:int = 90;

        private static const GAP_MIN:int = 20;

        public var missions:ResultMissionsGroup = null;

        private var _layout:ResultMissionsGroupLayout;

        public function ResultMissions()
        {
            this._layout = new ResultMissionsGroupLayout(RENDERER_WIDTH,RENDERER_HEIGHT);
            super();
            this._layout.gap = GAP_NORMAL;
            this.missions.layout = this._layout;
            this.missions.itemRendererLinkage = MISSION_RENDERER;
        }

        override public function appear() : void
        {
            super.appear();
            addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
        }

        override public function immediateAppear() : void
        {
            super.immediateAppear();
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            this.missions.immediateAppear();
        }

        public final function dispose() : void
        {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            this.missions.dispose();
            this.missions = null;
            this._layout = null;
        }

        public function setData(param1:DataProvider) : void
        {
            this.missions.dataProvider = param1;
        }

        public function setIsMin(param1:Boolean) : void
        {
            this._layout.gap = param1?GAP_MIN:GAP_NORMAL;
            this.missions.setMin(param1);
            this.missions.invalidateLayout();
        }

        private function onEnterFrameHandler(param1:Event) : void
        {
            if(currentFrameLabel == ResultAppearMovieClip.IDLE)
            {
                removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
                this.missions.appear();
            }
        }
    }
}
