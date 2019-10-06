package net.wg.gui.lobby.rankedBattles19.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class LeaguesViewVO extends DAAPIDataClass
    {

        public var title:String = "";

        public var descr:String = "";

        public var league:int = -1;

        public function LeaguesViewVO(param1:Object)
        {
            super(param1);
        }
    }
}
