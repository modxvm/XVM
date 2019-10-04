package net.wg.gui.bootcamp.battleResult.containers
{
    import net.wg.gui.components.containers.GroupEx;
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;

    public class BattleResultsGroup extends GroupEx
    {

        private var _elementId:String = "";

        public function BattleResultsGroup()
        {
            super();
        }

        public function showAppearAnimation() : void
        {
            var _loc2_:MovieClip = null;
            var _loc1_:int = numRenderers();
            var _loc3_:* = 0;
            while(_loc3_ < _loc1_)
            {
                _loc2_ = MovieClip(getRendererAt(_loc3_));
                _loc2_.play();
                _loc3_++;
            }
            dispatchEvent(new BattleViewEvent(BattleViewEvent.ANIMATIONS_QUEUE_START,this._elementId,true));
        }

        public function set elementId(param1:String) : void
        {
            this._elementId = param1;
        }
    }
}
