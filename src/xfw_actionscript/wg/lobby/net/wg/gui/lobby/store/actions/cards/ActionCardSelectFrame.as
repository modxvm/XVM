package net.wg.gui.lobby.store.actions.cards
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.store.actions.evnts.StoreActionsEvent;
    import net.wg.data.constants.Values;

    public class ActionCardSelectFrame extends MovieClip implements IDisposable
    {

        private static const ANIM_LABEL:String = "anim";

        private static const HIDE_LABEL:String = "hide";

        public var container:MovieClip = null;

        private var _labelsHash:Vector.<String> = null;

        public function ActionCardSelectFrame()
        {
            super();
            mouseEnabled = false;
            mouseChildren = false;
            var _loc1_:Array = this.container.currentLabels;
            var _loc2_:uint = _loc1_.length;
            this._labelsHash = new Vector.<String>(_loc2_);
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                this._labelsHash[_loc3_] = _loc1_[_loc3_].name;
                _loc3_++;
            }
            addFrameScript(this.totalFrames - 1,this.onAnimFinished);
        }

        public final function dispose() : void
        {
            stop();
            this._labelsHash.splice(0,this._labelsHash.length);
            this._labelsHash = null;
            this.container = null;
        }

        public function show(param1:String) : void
        {
            if(this._labelsHash.indexOf(param1) >= 0)
            {
                this.container.gotoAndStop(param1);
                gotoAndPlay(ANIM_LABEL);
            }
            else
            {
                gotoAndStop(HIDE_LABEL);
            }
        }

        private function onAnimFinished() : void
        {
            stop();
            dispatchEvent(new StoreActionsEvent(StoreActionsEvent.ANIM_FINISHED,Values.EMPTY_STR,Values.EMPTY_STR));
        }
    }
}
