package net.wg.gui.bootcamp.questsView.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class BCQuestsViewVO extends DAAPIDataClass
    {

        public var showRewards:Boolean = false;

        public var goldText:String = "";

        public var goldIcon:String = "";

        public var premiumText:String = "";

        public var premiumIcon:String = "";

        public function BCQuestsViewVO(param1:Object)
        {
            super(param1);
        }
    }
}
