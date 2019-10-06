package net.wg.gui.lobby.settings.feedback.questsProgress
{
    import net.wg.gui.lobby.settings.feedback.FeedbackBaseForm;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.lobby.settings.components.RadioButtonBar;
    import net.wg.infrastructure.managers.IColorSchemeManager;
    import net.wg.infrastructure.events.ColorSchemeEvent;
    import net.wg.data.constants.Linkages;

    public class QuestsProgressForm extends FeedbackBaseForm
    {

        private static const STANDARD_SETTINGS_ID:int = 0;

        private static const SHOW_ALL_SETTINGS_ID:int = 0;

        private static const PROGRESS_VIEW_TYPE_CONTROL_ID:String = "progressViewType";

        private static const PROGRESS_VIEW_CONDITIONS_CONTROL_ID:String = "progressViewConditions";

        private static const QUESTS_PROGRESS_COUNTER_CONTAINER_ID:String = "QUESTS_PROGRESS_COUNTER_CONTAINER_ID";

        private static const PROGRESS_VIEW_CONDITIONS_LABEL_ENABLED_ALPHA:Number = 1;

        private static const PROGRESS_VIEW_CONDITIONS_LABEL_DISABLED_ALPHA:Number = 0.5;

        public var fragsIndicator:MovieClip = null;

        public var questsProgressControls:QuestsProgressControls = null;

        public var progressViewTypeLabel:TextField = null;

        public var progressViewConditionsLabel:TextField = null;

        public var progressViewTypeButtonBar:RadioButtonBar = null;

        public var progressViewConditionsButtonBar:RadioButtonBar = null;

        public var bg:MovieClip = null;

        private var _colorMgr:IColorSchemeManager = null;

        private var _data:Object = null;

        public function QuestsProgressForm()
        {
            super();
            this._colorMgr = App.colorSchemeMgr;
            this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorMgrSchemasUpdateHandler);
        }

        override public function updateContent(param1:Object) : void
        {
            super.updateContent(param1);
            this._data = param1;
            var _loc2_:* = param1[PROGRESS_VIEW_TYPE_CONTROL_ID] == STANDARD_SETTINGS_ID;
            var _loc3_:* = param1[PROGRESS_VIEW_CONDITIONS_CONTROL_ID] == SHOW_ALL_SETTINGS_ID;
            this.questsProgressControls.setFlagVisible(_loc3_);
            this.progressViewTypeButtonBar.validateNow();
            this.progressViewConditionsButtonBar.validateNow();
            this.updateControls(_loc2_);
        }

        override protected function getContainerId() : String
        {
            return QUESTS_PROGRESS_COUNTER_CONTAINER_ID;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.progressViewTypeLabel.text = SETTINGS.FEEDBACK_TAB_QUESTSPROGRESS_TYPELABEL;
            this.progressViewConditionsLabel.text = SETTINGS.FEEDBACK_TAB_QUESTSPROGRESS_CONDITIONSLABEL;
        }

        override protected function onDispose() : void
        {
            this.fragsIndicator = null;
            this.questsProgressControls.dispose();
            this.questsProgressControls = null;
            this.progressViewTypeLabel = null;
            this.progressViewConditionsLabel = null;
            this.progressViewTypeButtonBar.dispose();
            this.progressViewTypeButtonBar = null;
            this.progressViewConditionsButtonBar.dispose();
            this.progressViewConditionsButtonBar = null;
            this.bg = null;
            this._colorMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorMgrSchemasUpdateHandler);
            this._colorMgr = null;
            this._data = null;
            super.onDispose();
        }

        override protected function onButtonBarIndexChange(param1:RadioButtonBar) : void
        {
            var _loc3_:* = false;
            var _loc4_:* = false;
            super.onButtonBarIndexChange(param1);
            var _loc2_:int = param1.dataProvider[param1.selectedIndex].data;
            if(param1 == this.progressViewTypeButtonBar)
            {
                _loc3_ = _loc2_ == STANDARD_SETTINGS_ID;
                this.updateControls(_loc3_);
            }
            else if(param1 == this.progressViewConditionsButtonBar)
            {
                _loc4_ = _loc2_ == SHOW_ALL_SETTINGS_ID;
                this.questsProgressControls.setFlagVisible(_loc4_);
            }
        }

        private function updateControls(param1:Boolean) : void
        {
            setElementEnabled(this.progressViewConditionsButtonBar,param1);
            this.progressViewConditionsButtonBar.enabled = param1;
            this.progressViewConditionsLabel.alpha = param1?PROGRESS_VIEW_CONDITIONS_LABEL_ENABLED_ALPHA:PROGRESS_VIEW_CONDITIONS_LABEL_DISABLED_ALPHA;
            this.questsProgressControls.visible = param1;
            var _loc2_:uint = this._colorMgr.getIsColorBlindS() + 1;
            this.fragsIndicator.gotoAndStop(_loc2_);
        }

        override public function get formId() : String
        {
            return Linkages.FEEDBACK_QUESTS_PROGRESS;
        }

        private function onColorMgrSchemasUpdateHandler(param1:ColorSchemeEvent) : void
        {
            this.updateContent(this._data);
        }
    }
}
