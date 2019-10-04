package net.wg.gui.lobby.settings.feedback.damageIndicator
{
    import net.wg.gui.lobby.settings.feedback.FeedbackBaseForm;
    import flash.text.TextField;
    import net.wg.gui.lobby.settings.components.RadioButtonBar;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.damageIndicator.DamageIndicator;
    import net.wg.infrastructure.managers.IColorSchemeManager;
    import net.wg.gui.components.damageIndicator.DamageIndicatorStandardSetting;
    import net.wg.gui.components.damageIndicator.DamageIndicatorExtendedSetting;
    import net.wg.data.constants.generated.DAMAGEINDICATOR;
    import net.wg.gui.components.controls.InfoIcon;
    import net.wg.infrastructure.events.ColorSchemeEvent;
    import net.wg.data.constants.Linkages;
    import net.wg.data.constants.generated.DAMAGE_SOURCE_TYPES;
    import net.wg.data.constants.Values;

    public class DamageIndicatorForm extends FeedbackBaseForm
    {

        private static const EXTENDED_SETTINGS_ID:int = 1;

        private static const WITH_CRITS_ID:int = 0;

        private static const DAMAGE_INDICATOR_TYPE_CONTROL_ID:String = "damageIndicatorType";

        private static const DAMAGE_INDICATOR_PRESETS_CONTROL_ID:String = "damageIndicatorPresets";

        private static const WITH_TANK_INFO_CONTROL_ID:String = "damageIndicatorVehicleInfo";

        private static const WITH_VALUE_CONTROL_ID:String = "damageIndicatorDamageValue";

        private static const T57_58:String = "#usa_vehicles:T57_58_short";

        private static const M103:String = "#usa_vehicles:M103";

        private static const T34:String = "#usa_vehicles:T34_hvy";

        private static const DAMAGE_INDICATOR_COUNTER_CONTAINER_ID:String = "DAMAGE_INDICATOR_COUNTER_CONTAINER_ID ";

        public var damageIndicatorTypeLabel:TextField = null;

        public var damageIndicatorPresetsLabel:TextField = null;

        public var damageIndicatorItemsLabel:TextField = null;

        public var damageIndicatorTypeButtonBar:RadioButtonBar = null;

        public var damageIndicatorPresetsButtonBar:RadioButtonBar = null;

        public var damageIndicatorDamageValueCheckbox:CheckBox = null;

        public var damageIndicatorDynamicIndicatorCheckbox:CheckBox = null;

        public var damageIndicatorVehicleInfoCheckbox:CheckBox = null;

        public var damageIndicatorAnimationCheckbox:CheckBox = null;

        public var damageIndicatorContainer:DamageIndicatorsContainer = null;

        public var damageIndicator:DamageIndicator = null;

        private var _colorMgr:IColorSchemeManager = null;

        private var _data:Object = null;

        private var _standardSettings:Vector.<DamageIndicatorStandardSetting>;

        private var _extendedSettings:Vector.<DamageIndicatorExtendedSetting>;

        public function DamageIndicatorForm()
        {
            this._standardSettings = new <DamageIndicatorStandardSetting>[new DamageIndicatorStandardSetting(0,DAMAGEINDICATOR.DAMAGE_STANDARD,DAMAGEINDICATOR.DAMAGE_STANDARD_BLIND,270,400,-0.25),new DamageIndicatorStandardSetting(1,DAMAGEINDICATOR.BLOCKED_STANDARD,DAMAGEINDICATOR.BLOCKED_STANDARD,140,400,0.43)];
            this._extendedSettings = new <DamageIndicatorExtendedSetting>[new DamageIndicatorExtendedSetting(0,DAMAGEINDICATOR.CRIT,DAMAGEINDICATOR.CRIT_BLIND,DAMAGEINDICATOR.TRACKS_CIRCLE,DAMAGEINDICATOR.TRACKS_CIRCLE,T57_58,DAMAGE_SOURCE_TYPES.HEAVY_TANK,Values.EMPTY_STR,220,280,-0.43),new DamageIndicatorExtendedSetting(1,DAMAGEINDICATOR.BLOCKED_SMALL,DAMAGEINDICATOR.BLOCKED_SMALL,DAMAGEINDICATOR.BLOCK_CIRCLE,DAMAGEINDICATOR.BLOCK_CIRCLE,M103,DAMAGE_SOURCE_TYPES.HEAVY_TANK,"400",260,245,0),new DamageIndicatorExtendedSetting(2,DAMAGEINDICATOR.DAMAGE_SMALL,DAMAGEINDICATOR.DAMAGE_SMALL_BLIND,DAMAGEINDICATOR.DAMAGE_CIRCLE,DAMAGEINDICATOR.DAMAGE_CIRCLE_BLIND,T34,DAMAGE_SOURCE_TYPES.HEAVY_TANK,"400",290,280,0.43)];
            super();
            this._colorMgr = App.colorSchemeMgr;
            this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorMgrSchemasUpdateHandler);
        }

        override public function updateContent(param1:Object) : void
        {
            var _loc6_:String = null;
            var _loc7_:DamageIndicatorExtendedSetting = null;
            var _loc8_:DamageIndicatorStandardSetting = null;
            super.updateContent(param1);
            this._data = param1;
            var _loc2_:* = param1[DAMAGE_INDICATOR_TYPE_CONTROL_ID] == EXTENDED_SETTINGS_ID;
            var _loc3_:* = param1[DAMAGE_INDICATOR_PRESETS_CONTROL_ID] == WITH_CRITS_ID;
            var _loc4_:Boolean = param1[WITH_TANK_INFO_CONTROL_ID];
            var _loc5_:Boolean = param1[WITH_VALUE_CONTROL_ID];
            this.damageIndicatorPresetsButtonBar.validateNow();
            this.setEnableExtendedParams(_loc2_);
            this.damageIndicatorContainer.updateSettings(!_loc2_,_loc5_,_loc3_);
            this.damageIndicator.hideAll();
            if(_loc2_)
            {
                for each(_loc7_ in this._extendedSettings)
                {
                    _loc6_ = _loc7_.getBg();
                    if(!(!_loc3_ && (_loc6_ == DAMAGEINDICATOR.CRIT || _loc6_ == DAMAGEINDICATOR.CRIT_BLIND)))
                    {
                        this.damageIndicator.showSettingExtended(_loc7_,_loc5_,_loc4_);
                    }
                }
            }
            else
            {
                for each(_loc8_ in this._standardSettings)
                {
                    this.damageIndicator.showSettingStandard(_loc8_);
                }
            }
        }

        override protected function getContainerId() : String
        {
            return DAMAGE_INDICATOR_COUNTER_CONTAINER_ID;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.damageIndicatorTypeLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_TYPELABEL;
            this.damageIndicatorPresetsLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_PRESETS;
            this.damageIndicatorItemsLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_ITEMS;
            this.damageIndicatorDamageValueCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_ITEMS_DAMAGE;
            this.damageIndicatorDynamicIndicatorCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_ITEMS_DYNAMICINDICATOR;
            this.damageIndicatorDynamicIndicatorCheckbox.toolTip = TOOLTIPS.SETTINGS_FEEDBACK_INDICATORS_DYNAMICWIDTH;
            this.damageIndicatorDynamicIndicatorCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
            this.damageIndicatorVehicleInfoCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_ITEMS_TANKNAME;
            this.damageIndicatorAnimationCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_ITEMS_ANIMATION;
            this.damageIndicatorAnimationCheckbox.toolTip = TOOLTIPS.SETTINGS_FEEDBACK_INDICATORS_ANIMATION;
            this.damageIndicatorAnimationCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        }

        override protected function onDispose() : void
        {
            var _loc1_:DamageIndicatorStandardSetting = null;
            var _loc2_:DamageIndicatorExtendedSetting = null;
            this.damageIndicatorContainer.dispose();
            this.damageIndicatorContainer = null;
            this.damageIndicatorTypeLabel = null;
            this.damageIndicatorPresetsLabel = null;
            this.damageIndicatorItemsLabel = null;
            this.damageIndicatorTypeButtonBar.dispose();
            this.damageIndicatorTypeButtonBar = null;
            this.damageIndicatorPresetsButtonBar.dispose();
            this.damageIndicatorPresetsButtonBar = null;
            this.damageIndicatorDamageValueCheckbox.dispose();
            this.damageIndicatorDamageValueCheckbox = null;
            this.damageIndicatorVehicleInfoCheckbox.dispose();
            this.damageIndicatorVehicleInfoCheckbox = null;
            this.damageIndicatorAnimationCheckbox.dispose();
            this.damageIndicatorAnimationCheckbox = null;
            this.damageIndicatorDynamicIndicatorCheckbox.dispose();
            this.damageIndicatorDynamicIndicatorCheckbox = null;
            super.onDispose();
            this._colorMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorMgrSchemasUpdateHandler);
            this._colorMgr = null;
            for each(_loc1_ in this._standardSettings)
            {
                _loc1_.dispose();
            }
            this._standardSettings.splice(0,this._standardSettings.length);
            this._standardSettings = null;
            for each(_loc2_ in this._extendedSettings)
            {
                _loc2_.dispose();
            }
            this._extendedSettings.splice(0,this._extendedSettings.length);
            this._extendedSettings = null;
            this._data = null;
        }

        override protected function onButtonBarIndexChange(param1:RadioButtonBar) : void
        {
            super.onButtonBarIndexChange(param1);
            var _loc2_:* = param1.dataProvider[param1.selectedIndex].data == EXTENDED_SETTINGS_ID;
            switch(param1)
            {
                case this.damageIndicatorTypeButtonBar:
                    this.setEnableExtendedParams(_loc2_);
                    break;
                case this.damageIndicatorPresetsButtonBar:
                    break;
            }
        }

        private function setEnableExtendedParams(param1:Boolean) : void
        {
            setElementEnabled(this.damageIndicatorPresetsButtonBar,param1);
            setElementEnabled(this.damageIndicatorDamageValueCheckbox,param1);
            setElementEnabled(this.damageIndicatorVehicleInfoCheckbox,param1);
            setElementEnabled(this.damageIndicatorAnimationCheckbox,param1);
            this.damageIndicatorDynamicIndicatorCheckbox.enabled = param1;
        }

        override public function get formId() : String
        {
            return Linkages.FEEDBACK_DAMAGE_INDICATOR;
        }

        private function onColorMgrSchemasUpdateHandler(param1:ColorSchemeEvent) : void
        {
            this.updateContent(this._data);
        }
    }
}
