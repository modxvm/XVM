package xvm.UI.battleResults
{
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;

    public class UI_BR_SubtaskComponent_UI extends BR_SubtaskComponent_UI
    {
        override protected function draw():void
        {
            super.draw();
            if (isInvalid(InvalidationType.DATA))
            {
                if (this.data)
                {
                    var removePadding:Number = 10;

                    // move elements up
                    this.typeTF.y -= removePadding;
                    this.taskTF.y -= removePadding;
                    this.linkBtn.y -= removePadding;
                    this.statusMC.y -= removePadding;
                    this.counter.y -= removePadding;
                    this.progressIndicator.y -= removePadding;

                    // progress text color
                    this.progressIndicator.textField.textColor = 0xC9C9B6;

                    // resize
                    this.lineMC.y -= removePadding * 2;
                    var height:Number = Math.round(this.lineMC.y + this.lineMC.height);
                    setSize(this.width, height);
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }
    }

}