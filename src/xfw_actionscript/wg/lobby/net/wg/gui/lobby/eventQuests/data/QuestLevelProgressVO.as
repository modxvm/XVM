package net.wg.gui.lobby.eventQuests.data
{
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class QuestLevelProgressVO extends EventQuestVO
    {

        private static const REWARDS:String = "rewards";

        public var label:String = "";

        public var index:int = -1;

        public var unlocked:Boolean = false;

        public var current:Boolean = false;

        public var isLast:Boolean = false;

        private var _rewards:DataProvider;

        public function QuestLevelProgressVO(param1:Object)
        {
            this._rewards = new DataProvider();
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            if(param1 == REWARDS)
            {
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    this._rewards.push(new QuestItemVO(_loc3_[_loc5_]));
                    _loc5_++;
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            for each(_loc1_ in this._rewards)
            {
                _loc1_.dispose();
            }
            this._rewards.cleanUp();
            this._rewards = null;
            super.onDispose();
        }

        public function get rewards() : DataProvider
        {
            return this._rewards;
        }
    }
}
