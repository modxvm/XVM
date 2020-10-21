package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.gui.components.containers.GroupEx;

    public class ResultMissionsGroup extends GroupEx
    {

        private static const DELAY:int = 1000;

        private static const BIG_LABEL:String = "big";

        private static const SMALL_LABEL:String = "small";

        public function ResultMissionsGroup()
        {
            super();
        }

        public function appear() : void
        {
            var _loc2_:ResultMission = null;
            var _loc1_:int = numRenderers();
            var _loc3_:* = 0;
            while(_loc3_ < _loc1_)
            {
                _loc2_ = ResultMission(getRendererAt(_loc3_));
                _loc2_.appear(_loc3_ * DELAY);
                _loc3_++;
            }
        }

        public function immediateAppear() : void
        {
            var _loc2_:ResultMission = null;
            var _loc1_:int = numRenderers();
            var _loc3_:* = 0;
            while(_loc3_ < _loc1_)
            {
                _loc2_ = ResultMission(getRendererAt(_loc3_));
                _loc2_.immediateAppear();
                _loc3_++;
            }
        }

        public function setMin(param1:Boolean) : void
        {
            var _loc3_:ResultMission = null;
            var _loc2_:int = numRenderers();
            var _loc4_:String = param1?SMALL_LABEL:BIG_LABEL;
            var _loc5_:* = 0;
            while(_loc5_ < _loc2_)
            {
                _loc3_ = ResultMission(getRendererAt(_loc5_));
                _loc3_.gotoAndStop(_loc4_);
                if(_baseDisposed)
                {
                    return;
                }
                _loc5_++;
            }
            invalidateData();
        }
    }
}
