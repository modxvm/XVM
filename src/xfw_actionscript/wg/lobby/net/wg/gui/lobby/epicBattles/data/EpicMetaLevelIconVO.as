package net.wg.gui.lobby.epicBattles.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class EpicMetaLevelIconVO extends DAAPIDataClass
    {

        public var level:String = "";

        public var cycleNumberHtmlText:String = "";

        public var metLvlBGImageId:int = -1;

        public function EpicMetaLevelIconVO(param1:Object)
        {
            super(param1);
        }
    }
}
