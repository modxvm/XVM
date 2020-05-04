package net.wg.gui.battle.views.postmortemPanel
{
    import net.wg.infrastructure.base.meta.impl.EventPostmortemPanelMeta;
    import net.wg.infrastructure.base.meta.IEventPostmortemPanelMeta;
    import flash.text.TextField;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import net.wg.data.VO.UserVO;

    public class EventPostmortemPanel extends EventPostmortemPanelMeta implements IEventPostmortemPanelMeta
    {

        private static const BG_X:int = -106;

        private static const BG_X_BIG:int = -255;

        private static const OBSERVER_X:int = -33;

        private static const OBSERVER_X_BIG:int = -182;

        public var timer:EventPostmortemTimer = null;

        public var hintTitleTF:TextField = null;

        public var hintDescTF:TextField = null;

        public function EventPostmortemPanel()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.timer.dispose();
            this.timer = null;
            this.hintTitleTF = null;
            this.hintDescTF = null;
            super.onDispose();
        }

        public function as_showLockedLives() : void
        {
            this.timer.setLockedState(true);
            this.timer.visible = true;
        }

        public function as_setTimer(param1:int) : void
        {
            this.timer.visible = param1 > 0;
            if(this.timer.visible)
            {
                this.timer.setLockedState(false);
                this.timer.updateRadialTimer(param1,0);
            }
            else
            {
                this.timer.stopTimer();
            }
        }

        public function as_setHintTitle(param1:String) : void
        {
            this.hintTitleTF.text = param1;
        }

        public function as_setHintDescr(param1:String) : void
        {
            this.hintDescTF.htmlText = param1;
        }

        public function as_setCanExit(param1:Boolean) : void
        {
            exitToHangarTitleTF.visible = param1;
            exitToHangarDescTF.visible = param1;
            if(param1)
            {
                bg.imageName = BATTLEATLAS.POSTMORTEM_TIPS_BG;
                bg.x = BG_X_BIG;
                observerModeDescTF.x = observerModeTitleTF.x = OBSERVER_X_BIG;
            }
            else
            {
                bg.imageName = BATTLEATLAS.POSTMORTEM_TIPS_EVENT_BG;
                bg.x = BG_X;
                observerModeDescTF.x = observerModeTitleTF.x = OBSERVER_X;
            }
        }

        override protected function setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String, param7:UserVO) : void
        {
            super.setDeadReasonInfo(param1,param2,param3,param4,param5,param6,null);
        }

        override protected function updatePlayerInfoPosition() : void
        {
            playerInfoTF.y = -BasePostmortemPanel.PLAYER_INFO_DELTA_Y - (App.appHeight >> 1);
        }
    }
}
