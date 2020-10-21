package net.wg.gui.battle.pveEvent.views
{
    import net.wg.gui.bootcamp.introVideoPage.BCIntroVideoPage;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;

    public class EventBattleLoading extends BCIntroVideoPage
    {

        public function EventBattleLoading()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            btnLeft.addEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
            btnRight.addEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
            loadingProgress.visible = false;
            btnSkip.visible = false;
            closeBtn.visible = false;
            btnSelect.visible = false;
            btnSkipVideo.visible = false;
        }

        override protected function onDispose() : void
        {
            btnLeft.removeEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
            btnRight.removeEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
            super.onDispose();
        }

        override public function as_loaded() : void
        {
            loadingProgress.gotoAndStop(loadingProgress.totalFrames);
        }

        override protected function onStageClickHandler(param1:MouseEvent) : void
        {
            param1.stopPropagation();
        }

        protected function onButtonsClickHandler(param1:MouseEvent) : void
        {
            if(MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON || MouseEventEx(param1).buttonIdx == MouseEventEx.MIDDLE_BUTTON)
            {
                return;
            }
            if(!introData.showTutorialPages)
            {
                continueToBattle();
            }
            else
            {
                if(param1.currentTarget == btnRight)
                {
                    imageGoRight = true;
                }
                else if(param1.currentTarget == btnLeft)
                {
                    imageGoRight = false;
                }
                tweenFadeOut();
            }
        }
    }
}
