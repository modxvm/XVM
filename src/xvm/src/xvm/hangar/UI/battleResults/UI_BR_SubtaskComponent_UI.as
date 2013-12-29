package xvm.hangar.UI.battleResults
{
    import flash.events.Event;
    import flash.utils.*;
    import scaleform.clik.constants.InvalidationType;
    import xvm.hangar.UI.battleResults.UI_ProgressElement_UI;

    /**
     * @author Pavel Máca
     */
    public dynamic class UI_BR_SubtaskComponent_UI extends BR_SubtaskComponent_UI
    {
        override protected function configUI():void
        {
            super.configUI();
            this.progressList.linkage = getQualifiedClassName(UI_ProgressElement_UI);
        }

        override protected function draw():void
        {
            super.draw();
            if (isInvalid(InvalidationType.DATA))
            {
                if (this.data)
                {
                    var removePadding:Number = 10;

                    // move elements up
                    this.taskTF.y -= removePadding;
                    this.linkBtn.y -= removePadding;
                    this.statusMC.y -= removePadding;
                    this.counter.y -= removePadding;
                    this.alert.y -= removePadding;
                    this.progressList.y -= removePadding;
                    this.awards.y -= removePadding * 2;

                    // resize
                    this.lineMC.y -= removePadding * 2;

                    setSize(this.width, Math.round(this.lineMC.y));
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }
    }

}
