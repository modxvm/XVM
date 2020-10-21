package net.wg.gui.lobby.eventQuests.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class QuestsChainVO extends DAAPIDataClass
    {

        private static const QUESTS:String = "quests";

        public var icon:String = "";

        public var label:String = "";

        public var isNew:Boolean = false;

        public var currentIndex:int = -1;

        private var _quests:DataProvider;

        public function QuestsChainVO(param1:Object)
        {
            this._quests = new DataProvider();
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == QUESTS)
            {
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,QUESTS + Errors.CANT_NULL);
                for each(_loc4_ in _loc3_)
                {
                    this._quests.push(new QuestLevelProgressVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            for each(_loc1_ in this._quests)
            {
                _loc1_.dispose();
            }
            this._quests.splice(0,this._quests.length);
            this._quests = null;
            super.onDispose();
        }

        public function get quests() : DataProvider
        {
            return this._quests;
        }
    }
}
