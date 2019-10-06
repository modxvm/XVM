package net.wg.gui.lobby.settings
{
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.gui.lobby.settings.events.SettingViewEvent;
    import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
    import net.wg.gui.lobby.settings.vo.SettingsControlProp;
    import scaleform.clik.events.IndexEvent;
    import net.wg.gui.lobby.settings.vo.SettingsTabNewCounterVo;
    import net.wg.gui.components.crosshairPanel.ICrosshair;
    import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
    import net.wg.gui.lobby.settings.config.SettingsConfigHelper;

    public class AimSettings extends AimSettingsBase
    {

        private static const CENTRAL_TAG_TYPE_STR:String = "centralTagType";

        private static const CENTRAL_TAG_STR:String = "centralTag";

        private static const NET_STR:String = "net";

        private static const NET_TYPE_STR:String = NET_STR + "Type";

        private static const RELOADER_STR:String = "reloader";

        private static const CONDITION_STR:String = "condition";

        private static const CASSETTE_STR:String = "cassette";

        private static const MIXING:String = "mixing";

        private static const GUN_TAG:String = "gunTag";

        private static const MIXING_TYPE:String = "mixingType";

        private static const GUN_TAG_TYPE:String = "gunTagType";

        private static const RELOADER_TIMER_STR:String = RELOADER_STR + "Timer";

        private static const ZOOM_INDICATOR_STR:String = "zoomIndicator";

        private static const PRC_DIVIDER:Number = 100;

        private static const DEFAULT_TYPE:Number = 0;

        private static const DEFAULT_ALPHA:Number = 0;

        private static const AIM_COUNTER_CONTAINER_ID:String = "AIM_COUNTER_CONTAINER_ID";

        private var _currentTab:uint = 0;

        private var _dynamicCursorsData:Object = null;

        private var _setDataInProgress:Boolean = false;

        private var _cursorTabsDataProvider:IDataProvider;

        public function AimSettings()
        {
            this._cursorTabsDataProvider = SettingsConfigHelper.instance.cursorTabsDataProvider;
            super();
        }

        override public function toString() : String
        {
            return "[WG AimSettings " + name + "]";
        }

        override protected function getContainerId() : String
        {
            return AIM_COUNTER_CONTAINER_ID;
        }

        override protected function configUI() : void
        {
            super.configUI();
            arcadeForm.addEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
            sniperForm.addEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
        }

        override protected function setData(param1:SettingsDataVo) : void
        {
            var _loc12_:* = 0;
            var _loc13_:SettingsArcadeForm = null;
            super.setData(param1);
            this._dynamicCursorsData = {};
            this._setDataInProgress = true;
            var _loc2_:Vector.<String> = param1.keys;
            var _loc3_:Vector.<Object> = param1.values;
            var _loc4_:int = _loc2_.length;
            var _loc5_:SettingsDataVo = null;
            var _loc6_:Vector.<String> = null;
            var _loc7_:Vector.<Object> = null;
            var _loc8_:String = Values.EMPTY_STR;
            var _loc9_:* = 0;
            var _loc10_:String = Values.EMPTY_STR;
            var _loc11_:* = 0;
            while(_loc11_ < _loc4_)
            {
                _loc8_ = _loc2_[_loc11_];
                _loc5_ = _loc3_[_loc11_] as SettingsDataVo;
                App.utils.asserter.assertNotNull(_loc5_,"values[i] must be SettingsDataVo");
                if(this[_loc8_ + FORM])
                {
                    _loc13_ = SettingsArcadeForm(this[_loc8_ + FORM]);
                    _loc13_.setData(_loc8_,_loc5_);
                    _loc13_.addEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onFormAimOnControlChangeHandler);
                }
                _loc6_ = _loc5_.keys;
                _loc7_ = _loc5_.values;
                _loc9_ = _loc5_.keys.length;
                _loc12_ = 0;
                while(_loc12_ < _loc9_)
                {
                    _loc10_ = _loc6_[_loc12_];
                    if(!this._dynamicCursorsData.hasOwnProperty(_loc8_))
                    {
                        this._dynamicCursorsData[_loc8_] = {};
                    }
                    this._dynamicCursorsData[_loc8_][_loc10_] = SettingsControlProp(_loc7_[_loc12_]).current?SettingsControlProp(_loc7_[_loc12_]).current:0;
                    _loc12_++;
                }
                _loc11_++;
            }
            this._setDataInProgress = false;
            tabs.dataProvider = this._cursorTabsDataProvider;
            tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
            tabs.selectedIndex = this._currentTab;
        }

        override protected function onBeforeDispose() : void
        {
            tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
            arcadeForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onFormAimOnControlChangeHandler);
            sniperForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onFormAimOnControlChangeHandler);
            arcadeForm.removeEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
            sniperForm.removeEventListener(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,this.onFormOnControlNewCountersVisitedHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this._dynamicCursorsData = null;
            this._cursorTabsDataProvider = null;
            super.onDispose();
        }

        override protected function updateNewCountersControls(param1:Vector.<SettingsTabNewCounterVo>) : void
        {
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            var _loc2_:int = this._cursorTabsDataProvider.length;
            var _loc3_:String = null;
            var _loc4_:String = null;
            var _loc5_:SettingsArcadeForm = null;
            var _loc6_:* = 0;
            while(_loc6_ < _loc2_)
            {
                _loc3_ = this._cursorTabsDataProvider[_loc6_].id;
                _loc4_ = this._cursorTabsDataProvider[_loc6_].formID;
                _loc7_ = param1.length;
                _loc8_ = 0;
                while(_loc8_ < _loc7_)
                {
                    if(_loc3_ == param1[_loc8_].subTabId)
                    {
                        _loc5_ = this[_loc4_];
                        if(_loc5_)
                        {
                            _loc5_.updateNewCounters(param1[_loc8_].counters);
                        }
                    }
                    _loc8_++;
                }
                _loc6_++;
            }
        }

        private function updateShowContent() : void
        {
            var _loc3_:SettingsArcadeForm = null;
            var _loc4_:ICrosshair = null;
            var _loc1_:uint = this._cursorTabsDataProvider.length;
            var _loc2_:uint = 0;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = SettingsArcadeForm(this[this._cursorTabsDataProvider[_loc2_].formID]);
                _loc3_.visible = _loc3_.formId == this._cursorTabsDataProvider[this._currentTab].id;
                _loc4_ = ICrosshair(this[this._cursorTabsDataProvider[_loc2_].crosshairID]);
                _loc4_.visible = _loc3_.visible;
                _loc2_++;
            }
            this.updateCrosshairs(this._currentTab);
        }

        private function updateCrosshairs(param1:Number) : void
        {
            var _loc2_:String = this._cursorTabsDataProvider[param1].id;
            var _loc3_:Object = this._dynamicCursorsData[_loc2_];
            var _loc4_:Number = _loc3_[CENTRAL_TAG_TYPE_STR]?_loc3_[CENTRAL_TAG_TYPE_STR]:DEFAULT_TYPE;
            var _loc5_:Number = _loc3_[CENTRAL_TAG_STR]?_loc3_[CENTRAL_TAG_STR] / PRC_DIVIDER:DEFAULT_ALPHA;
            var _loc6_:Number = _loc3_[NET_TYPE_STR]?_loc3_[NET_TYPE_STR]:DEFAULT_TYPE;
            var _loc7_:Number = _loc3_[NET_STR]?_loc3_[NET_STR] / PRC_DIVIDER:DEFAULT_ALPHA;
            var _loc8_:Number = _loc3_[RELOADER_STR]?_loc3_[RELOADER_STR] / PRC_DIVIDER:DEFAULT_ALPHA;
            var _loc9_:Number = _loc3_[CONDITION_STR]?_loc3_[CONDITION_STR] / PRC_DIVIDER:DEFAULT_ALPHA;
            var _loc10_:Number = _loc3_[RELOADER_TIMER_STR]?_loc3_[RELOADER_TIMER_STR] / PRC_DIVIDER:DEFAULT_ALPHA;
            var _loc11_:Number = _loc3_[CASSETTE_STR]?_loc3_[CASSETTE_STR] / PRC_DIVIDER:DEFAULT_ALPHA;
            var _loc12_:Boolean = _loc3_[ZOOM_INDICATOR_STR];
            var _loc13_:Number = _loc12_?_loc3_[ZOOM_INDICATOR_STR] / PRC_DIVIDER:DEFAULT_ALPHA;
            var _loc14_:Number = _loc3_[MIXING]?_loc3_[MIXING] / PRC_DIVIDER:DEFAULT_ALPHA;
            var _loc15_:Number = _loc3_[GUN_TAG]?_loc3_[GUN_TAG] / PRC_DIVIDER:DEFAULT_ALPHA;
            var _loc16_:Number = _loc3_[MIXING_TYPE];
            var _loc17_:Number = _loc3_[GUN_TAG_TYPE];
            var _loc18_:ICrosshair = null;
            switch(param1)
            {
                case 0:
                    _loc18_ = arcadeCrosshair;
                    break;
                case 1:
                    _loc18_ = sniperCrosshair;
                    break;
            }
            if(_loc18_)
            {
                _loc18_.setCenterType(_loc4_);
                _loc18_.setNetType(_loc6_);
                _loc18_.setComponentsAlpha(_loc7_,_loc5_,_loc8_,_loc9_,_loc11_,_loc10_,_loc13_);
                _loc18_.setReloadingTime(RELOADING_TIME);
                _loc18_.setReloadingState(CrosshairConsts.RELOADING_ENDED);
                _loc18_.setHealth(CrosshairConsts.MAX_HEALTH);
                if(_loc12_)
                {
                    _loc18_.setZoom(App.utils.locale.makeString(SETTINGS.AIM_X2));
                }
            }
            gunMarker.setSettings(_loc17_,_loc16_,_loc15_,_loc14_);
        }

        private function onFormOnControlNewCountersVisitedHandler(param1:SettingViewEvent) : void
        {
            var _loc2_:String = param1.viewId?param1.viewId:viewId;
            var _loc3_:SettingViewEvent = new SettingViewEvent(SettingViewEvent.ON_CONTROL_NEW_COUNTERS_VISITED,_loc2_,param1.subViewId,param1.controlId,param1.controlValue);
            dispatchEvent(_loc3_);
        }

        private function onFormAimOnControlChangeHandler(param1:SettingsSubVewEvent) : void
        {
            if(this._setDataInProgress)
            {
                return;
            }
            var _loc2_:String = param1.subViewId;
            var _loc3_:String = param1.controlId;
            if(this._dynamicCursorsData != null)
            {
                this._dynamicCursorsData[_loc2_][param1.controlId] = param1.controlValue;
            }
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,_loc2_,_loc3_,param1.controlValue));
            this.updateCrosshairs(this._currentTab);
        }

        private function onTabIndexChangeHandler(param1:IndexEvent) : void
        {
            this._currentTab = param1.index;
            this.updateShowContent();
        }
    }
}
