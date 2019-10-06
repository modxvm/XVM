package net.wg.gui.lobby.epicBattles.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class EpicMetaLevelIconVO extends DAAPIDataClass
    {

        public var level:String = "";

        public var prestigeLevelHtmlText:String = "";

        public var metLvlBGImageSrc:String = "";

        public var metLvlTopImageSrc:String = "";

        public function EpicMetaLevelIconVO(param1:Object)
        {
            super(param1);
        }
    }
}
