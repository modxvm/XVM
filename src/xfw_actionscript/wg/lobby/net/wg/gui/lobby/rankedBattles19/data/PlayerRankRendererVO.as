package net.wg.gui.lobby.rankedBattles19.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class PlayerRankRendererVO extends DAAPIDataClass
    {

        public var nickName:String = "";

        public var points:String = "";

        public var selected:Boolean = false;

        public var standoff:int = 0;

        public var nickNameHuge:String = "";

        public var pointsHuge:String = "";

        public function PlayerRankRendererVO(param1:Object)
        {
            super(param1);
        }
    }
}
