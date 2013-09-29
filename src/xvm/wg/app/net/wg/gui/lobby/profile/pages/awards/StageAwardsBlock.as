package net.wg.gui.lobby.profile.pages.awards 
{
    import flash.events.*;
    
    public class StageAwardsBlock extends net.wg.gui.lobby.profile.pages.awards.AwardsBlock
    {
        public function StageAwardsBlock()
        {
            super();
            return;
        }

        public function get battlesCount():uint
        {
            return this._battlesCount;
        }

        public function set battlesCount(arg1:uint):void
        {
            if (arg1 != this._battlesCount) 
            {
                this._battlesCount = arg1;
                dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE, true));
            }
            return;
        }

        protected override function applyLabel():void
        {
            super.applyLabel();
            return;
        }

        public override function set visible(arg1:Boolean):void
        {
            super.visible = arg1 && this._battlesCount > 0;
            return;
        }

        internal var _battlesCount:uint=0;
    }
}
