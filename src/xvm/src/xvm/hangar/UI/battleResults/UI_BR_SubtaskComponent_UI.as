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
            progressList.linkage = getQualifiedClassName(UI_ProgressElement_UI);
        }

        override protected function draw():void
        {
            super.draw();
            if (isInvalid(InvalidationType.DATA))
            {
                if (this.data)
                {
                    var offsetTop:Number = 10;
                    var offsetMiddle:Number = 20;
                    var offsetBottom:Number = 30;

                    // move elements up
                    this.taskTF.y -= offsetTop;
                    this.linkBtn.y -= offsetTop;
                    this.statusMC.y -= offsetTop;
                    this.counter.y -= offsetMiddle;
                    this.alert.y -= offsetMiddle;
                    this.progressList.y -= offsetMiddle;
                    this.awards.y -= offsetBottom;

                    // resize
                    this.lineMC.y -= offsetBottom;

                    setSize(this.width, Math.round(this.lineMC.y));
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }
    }

}
