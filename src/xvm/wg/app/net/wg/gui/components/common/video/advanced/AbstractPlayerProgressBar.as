package net.wg.gui.components.common.video.advanced 
{
    import flash.events.*;
    import scaleform.clik.core.*;
    
    public class AbstractPlayerProgressBar extends scaleform.clik.core.UIComponent
    {
        public function AbstractPlayerProgressBar()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(POSITION_INVALID)) 
            {
                this.applyTimeUpdating();
            }
            return;
        }

        protected function setUnderUsingState(arg1:Boolean):void
        {
            this._underUsing = arg1;
            dispatchEvent(new flash.events.Event(UNDER_USING_STATE));
            return;
        }

        protected function positionUpdated(arg1:Number):void
        {
            dispatchEvent(new net.wg.gui.components.common.video.advanced.ProgressBarEvent(net.wg.gui.components.common.video.advanced.ProgressBarEvent.POSITION_UPDATED, arg1));
            return;
        }

        protected function applyTimeUpdating():void
        {
            return;
        }

        public function get position():Number
        {
            return this._position;
        }

        public function set position(arg1:Number):void
        {
            this._position = arg1;
            invalidate(POSITION_INVALID);
            return;
        }

        public function get underUsing():Boolean
        {
            return this._underUsing;
        }

        public override function dispose():void
        {
            super.dispose();
            return;
        }

        public static const UNDER_USING_STATE:String="controlUnderUsing";

        internal static const POSITION_INVALID:String="timeInvalid";

        protected var _position:Number=0;

        protected var _underUsing:Boolean;
    }
}
