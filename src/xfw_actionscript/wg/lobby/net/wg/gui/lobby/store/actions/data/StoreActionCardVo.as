package net.wg.gui.lobby.store.actions.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.Errors;

    public class StoreActionCardVo extends DAAPIDataClass
    {

        private static const DESCRIPTION_FILED:String = "storeItemDescr";

        private static const TIME_FILED:String = "time";

        private static const BATTLEQUEST_INFO_FILED:String = "battleQuestsInfo";

        private static const LINK_BTN_LABEL_FILED:String = "linkBtnLabel";

        private static const ACTION_BTN_LABEL_FILED:String = "actionBtnLabel";

        private static const TITLE_FIELD:String = "title";

        private static const TOOLTIP_INFO_FIELD:String = "tooltipInfo";

        private static const PICTURE_FIELD:String = "picture";

        public var id:String = "";

        public var triggerChainID:String = "";

        public var linkage:String = "";

        public var isNew:Boolean = false;

        public var tooltipInfo:String = "";

        public var title:String = "";

        public var time:StoreActionTimeVo = null;

        public var header:String = "";

        public var picture:StoreActionPictureVo = null;

        public var discount:String = "";

        public var battleQuestsInfo:String = "";

        public var linkBtnLabel:String = "";

        public var actionBtnLabel:String = "";

        public var storeItemDescrVo:StoreActionCardDescrVo = null;

        public var hasBattleQuest:Boolean = false;

        public var hasLinkBtn:Boolean = false;

        public var hasActionBtn:Boolean = false;

        public function StoreActionCardVo(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == DESCRIPTION_FILED)
            {
                this.storeItemDescrVo = new StoreActionCardDescrVo(param2);
                return false;
            }
            if(param1 == TIME_FILED)
            {
                this.time = new StoreActionTimeVo(param2);
                return false;
            }
            if(param1 == TOOLTIP_INFO_FIELD)
            {
                this.tooltipInfo = param2?param2.toString():Values.EMPTY_STR;
                return false;
            }
            if(param1 == TITLE_FIELD)
            {
                this.title = param2?param2.toString():Values.EMPTY_STR;
                return false;
            }
            if(param1 == PICTURE_FIELD)
            {
                App.utils.asserter.assertNotNull(param2,"picture" + Errors.CANT_NULL);
                this.picture = new StoreActionPictureVo(param2);
                return false;
            }
            if(param1 == BATTLEQUEST_INFO_FILED)
            {
                this.hasBattleQuest = param2 != null && param2 != Values.EMPTY_STR;
            }
            if(param1 == LINK_BTN_LABEL_FILED)
            {
                this.hasLinkBtn = param2 != null && param2 != Values.EMPTY_STR;
            }
            if(param1 == ACTION_BTN_LABEL_FILED)
            {
                this.hasActionBtn = param2 != null && param2 != Values.EMPTY_STR;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.time != null)
            {
                this.time.dispose();
                this.time = null;
            }
            if(this.storeItemDescrVo != null)
            {
                this.storeItemDescrVo.dispose();
                this.storeItemDescrVo = null;
            }
            this.picture.dispose();
            this.picture = null;
            super.onDispose();
        }
    }
}
