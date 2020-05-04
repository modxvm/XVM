package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class ResultStatusVO extends DAAPIDataClass
    {

        public var title:String = "";

        public var subTitle:String = "";

        public function ResultStatusVO(param1:Object)
        {
            super(param1);
        }
    }
}
