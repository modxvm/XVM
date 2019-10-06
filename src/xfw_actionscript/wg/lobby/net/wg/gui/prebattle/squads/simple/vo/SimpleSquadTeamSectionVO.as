package net.wg.gui.prebattle.squads.simple.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class SimpleSquadTeamSectionVO extends DAAPIDataClass
    {

        private static const BONUSES_FIELD:String = "bonuses";

        public var infoIconTooltip:String = "";

        public var infoIconTooltipType:String = "simple";

        public var isVisibleInfoIcon:Boolean = false;

        public var headerIconSource:String = "";

        public var isVisibleHeaderIcon:Boolean = false;

        public var headerMessageText:String = "";

        public var isVisibleHeaderMessage:Boolean = false;

        public var backgroundHeaderSource:String = "";

        public var bonuses:DataProvider = null;

        public function SimpleSquadTeamSectionVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == BONUSES_FIELD)
            {
                this.bonuses = new DataProvider();
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    this.bonuses.push(new SimpleSquadBonusVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            if(this.bonuses != null)
            {
                for each(_loc1_ in this.bonuses)
                {
                    _loc1_.dispose();
                }
                this.bonuses.cleanUp();
                this.bonuses = null;
            }
            super.onDispose();
        }
    }
}
