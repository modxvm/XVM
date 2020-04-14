package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.base.meta.impl.DailyQuestMeta;
    import net.wg.infrastructure.base.meta.IDailyQuestMeta;
    import net.wg.utils.helpLayout.IHelpLayoutComponent;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import net.wg.data.constants.Directions;

    public class DailyQuestWidget extends DailyQuestMeta implements IDailyQuestMeta, IHelpLayoutComponent
    {

        private static const HELP_LAYOUT_ID_DELIMITER:String = "_";

        private var _helpLayoutId:String = "";

        public function DailyQuestWidget()
        {
            super();
        }

        public function as_showWidget() : void
        {
            if(!this.visible)
            {
                App.utils.helpLayout.registerComponent(this);
            }
            this.visible = true;
        }

        public function as_hideWidget() : void
        {
            this.visible = false;
            App.utils.helpLayout.unregisterComponent(this);
        }

        override protected function configUI() : void
        {
            super.configUI();
            App.utils.helpLayout.registerComponent(this);
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            if(!this._helpLayoutId)
            {
                this._helpLayoutId = name + HELP_LAYOUT_ID_DELIMITER + Math.random();
            }
            var _loc1_:HelpLayoutVO = new HelpLayoutVO();
            _loc1_.x = 0;
            _loc1_.y = 0;
            _loc1_.width = actualWidth;
            _loc1_.height = actualHeight;
            _loc1_.extensibilityDirection = Directions.RIGHT;
            _loc1_.message = QUESTS.DAILYQUESTS_HEADER_TITLE;
            _loc1_.id = this._helpLayoutId;
            _loc1_.scope = this;
            return new <HelpLayoutVO>[_loc1_];
        }
    }
}
