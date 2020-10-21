package net.wg.gui.lobby.eventDifficulties.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class EventDifficultiesVO extends DAAPIDataClass
    {

        private static const LEVELS:String = "levels";

        public var levels:Vector.<EventDifficultyLevelVO> = null;

        public function EventDifficultiesVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == LEVELS)
            {
                this.levels = new Vector.<EventDifficultyLevelVO>(0);
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    this.levels.push(new EventDifficultyLevelVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:EventDifficultyLevelVO = null;
            for each(_loc1_ in this.levels)
            {
                _loc1_.dispose();
            }
            this.levels.splice(0,this.levels.length);
            this.levels = null;
            super.onDispose();
        }
    }
}
