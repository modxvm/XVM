package net.wg.gui.battle.views.battleTimer
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class EventAdditionalTimeAnimation extends MovieClip implements IDisposable
    {

        private static const FIRST_FRAME:uint = 1;

        private static const SECOND_FRAME:uint = 2;

        public var tfContainer:EventAdditionalTimeText = null;

        public var bg:MovieClip = null;

        public function EventAdditionalTimeAnimation()
        {
            super();
        }

        public function dispose() : void
        {
            stop();
            this.tfContainer.dispose();
            this.tfContainer = null;
            this.bg.stop();
            this.bg = null;
        }

        public function playAddExtraTime(param1:String, param2:Boolean, param3:Number) : void
        {
            if(param2)
            {
                this.bg.gotoAndStop(SECOND_FRAME);
            }
            else
            {
                this.bg.gotoAndStop(FIRST_FRAME);
            }
            this.tfContainer.update(param1,param2,param3);
            gotoAndPlay(SECOND_FRAME);
        }

        public function updateTextMargin(param1:Number) : void
        {
            this.tfContainer.updateMargin(param1);
        }
    }
}
