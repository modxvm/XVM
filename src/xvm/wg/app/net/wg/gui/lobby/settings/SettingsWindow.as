package net.wg.gui.lobby.settings 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.ui.*;
    import net.wg.data.constants.*;
    import net.wg.data.managers.*;
    import net.wg.data.managers.impl.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.settings.evnts.*;
    import net.wg.gui.lobby.settings.vo.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.ui.*;
    
    public class SettingsWindow extends net.wg.infrastructure.base.meta.impl.SettingsWindowMeta implements net.wg.infrastructure.base.meta.ISettingsWindowMeta
    {
        public function SettingsWindow()
        {
            super();
            return;
        }

        internal function onTabChange(arg1:scaleform.clik.events.IndexEvent):void
        {
            __currentTab = arg1.index;
            App.toolTipMgr.hide();
            var loc1:*=net.wg.gui.lobby.settings.SoundSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS));
            if (loc1) 
            {
                loc1.onViewChanged();
            }
            return;
        }

        internal function onViewNeedUpdateHandler(arg1:net.wg.gui.events.ViewStackEvent):void
        {
            var loc1:*=arg1.view;
            loc1.update({"id":arg1.linkage, "data":this._settingsData[arg1.linkage]});
            if (arg1.linkage == net.wg.gui.lobby.settings.SettingsConfig.GRAPHIC_SETTINGS && net.wg.gui.lobby.settings.SettingsConfig.liveUpdateVideoSettingsData) 
            {
                net.wg.gui.lobby.settings.GraphicSettings(loc1).updateLiveVideoData();
            }
            return;
        }

        internal function onViewChangeHandler(arg1:net.wg.gui.events.ViewStackEvent):void
        {
            var loc1:*=arg1.view;
            if (arg1.linkage == net.wg.gui.lobby.settings.SettingsConfig.MARKER_SETTINGS) 
            {
                net.wg.gui.lobby.settings.MarkerSettings(loc1).updateShowContent();
                net.wg.gui.lobby.settings.MarkerSettings(loc1).updateShowContent();
            }
            return;
        }

        internal function onPTTControlChanged(arg1:net.wg.gui.lobby.settings.evnts.SettingViewEvent):void
        {
            var loc1:*=net.wg.gui.lobby.settings.vo.SettingsControlProp(net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS][net.wg.gui.lobby.settings.SettingsConfig.PTT]);
            loc1.current = arg1.controlValue;
            var loc2:*=net.wg.gui.lobby.settings.SoundSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS));
            if (loc2) 
            {
                loc2.updatePTTControl(loc1.current);
            }
            return;
        }

        internal function onControlChanged(arg1:net.wg.gui.lobby.settings.evnts.SettingViewEvent):void
        {
            var loc1:*=arg1.viewId;
            var loc2:*=arg1.controlId;
            var loc3:*=arg1.controlValue;
            onSettingsChangeS(loc2, loc3);
            var loc4:*=this.controlDefValEqNewVal(this._settingsData[loc1][loc2], loc3);
            this.checkChanges(loc4, loc2, loc3);
            return;
        }

        internal function checkChanges(arg1:Boolean, arg2:String, arg3:*):void
        {
            if (arg1) 
            {
                this.changesData.tryCutChanges(arg2, arg3);
            }
            else 
            {
                this.changesData.tryAddChanges(arg2, arg3);
            }
            this.updateApplayBtnState();
            return;
        }

        internal function onVivoxTest(arg1:net.wg.gui.lobby.settings.evnts.SettingViewEvent):void
        {
            var loc1:*=Boolean(arg1.controlValue);
            var loc2:*=startVOIPTestS(loc1);
            var loc3:*;
            if ((loc3 = net.wg.gui.lobby.settings.SoundSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS))) != null) 
            {
                loc3.setVoiceTestState(!(loc2 || !loc1));
            }
            return;
        }

        internal function onAutodetectQuality(arg1:net.wg.gui.lobby.settings.evnts.SettingViewEvent):void
        {
            var loc1:*=autodetectQualityS();
            var loc2:*=net.wg.gui.lobby.settings.GraphicSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.GRAPHIC_SETTINGS));
            if (loc2 != null) 
            {
                loc2.setPresetAfterAutoDetect(loc1);
            }
            return;
        }

        internal function onUpdateCaptureDevices(arg1:net.wg.gui.lobby.settings.evnts.SettingViewEvent):void
        {
            updateCaptureDevicesS();
            return;
        }

        internal function cancelBtnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=net.wg.gui.lobby.settings.SoundSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS));
            if (loc1) 
            {
                loc1.breakSoundCheck();
            }
            closeWindowS();
            return;
        }

        internal function applayBtnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.sendData(false);
            return;
        }

        internal function submitBtnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.sendData(true);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            super.handleInput(arg1);
            if (arg1.handled) 
            {
                return;
            }
            var loc1:*=arg1.details;
            if (arg1.details.code == flash.ui.Keyboard.ESCAPE && loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
            {
                arg1.handled = true;
                closeWindowS();
            }
            return;
        }

        
        {
            __currentTab = 0;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            this.x = arg1 - this.width >> 1;
            this.y = Math.max(arg2 - this.height >> 1, 10);
            return;
        }

        public function as_setCaptureDevices(arg1:Number, arg2:Array):void
        {
            var loc1:*=net.wg.gui.lobby.settings.SoundSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS));
            if (loc1 != null) 
            {
                loc1.setCaptureDevices(arg1, arg2);
            }
            return;
        }

        public function as_onVibroManagerConnect(arg1:Boolean):void
        {
            net.wg.gui.lobby.settings.vo.SettingsControlProp(net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.GAME_SETTINGS].vibroIsConnected).current = arg1;
            var loc1:*=net.wg.gui.lobby.settings.GameSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.GAME_SETTINGS));
            if (loc1 != null) 
            {
                loc1.onVibroManagerConnect();
            }
            return;
        }

        public function as_updateVideoSettings(arg1:Object):void
        {
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            if (arg1) 
            {
                loc2 = net.wg.gui.lobby.settings.SettingsConfig.liveUpdateVideoSettingsOrderData.length;
                loc3 = App.utils.commons;
                loc4 = 0;
                while (loc4 < loc2) 
                {
                    loc5 = net.wg.gui.lobby.settings.SettingsConfig.liveUpdateVideoSettingsOrderData[loc4];
                    if (arg1[loc5] != null) 
                    {
                        loc6 = new net.wg.gui.lobby.settings.vo.SettingsControlProp();
                        if (arg1[loc5] is Boolean || arg1[loc5] is String || arg1[loc5] is Number) 
                        {
                            loc6.current = arg1[loc5];
                        }
                        else if (arg1[loc5].current is Object && !(arg1[loc5].current == undefined)) 
                        {
                            loc6.current = arg1[loc5].real == null ? arg1[loc5].current : arg1[loc5].real;
                            if (arg1[loc5].options == undefined) 
                            {
                                loc6.options = [];
                            }
                            else 
                            {
                                loc6.options = loc3.cloneObject(arg1[loc5].options);
                            }
                        }
                    }
                    net.wg.gui.lobby.settings.SettingsConfig.liveUpdateVideoSettingsData[loc5] = loc6;
                    ++loc4;
                }
            }
            var loc1:*=net.wg.gui.lobby.settings.GraphicSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.GRAPHIC_SETTINGS));
            if (loc1) 
            {
                loc1.updateLiveVideoData();
            }
            return;
        }

        public function as_confirmWarningDialog(arg1:Boolean, arg2:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            if (arg1) 
            {
                this.updateSettingsConfig();
                if (arg2.indexOf(this.SOUND_MODE_WARNING, 0) >= 0) 
                {
                    loc1 = net.wg.gui.lobby.settings.vo.SettingsControlProp(net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS]["alternativeVoices"]);
                    loc1.current = 0;
                    if (!((loc2 = net.wg.gui.lobby.settings.SoundSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS))) == null) && !(loc2.alternativeVoicesDropDown == null)) 
                    {
                        loc2.alternativeVoicesDropDown.selectedIndex = 0;
                    }
                }
            }
            else 
            {
                loc3 = 2;
                if (arg2.indexOf(this.CONTROLS_WARNING, 0) >= 0) 
                {
                    loc3 = 3;
                }
                this.tabs.selectedIndex = loc3;
            }
            return;
        }

        public function as_setData(arg1:Object):void
        {
            this._settingsData = this.normalize(arg1);
            this.updateApplayBtnState();
            _invalid = true;
            validateNow();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.updateStage(App.appWidth, App.appHeight);
            this.onPopulate();
            return;
        }

        protected override function onPopulate():void
        {
            this.title.label = SETTINGS.TITLE;
            this.submitBtn.label = SETTINGS.OK_BUTTON;
            this.cancelBtn.label = SETTINGS.CANCEL_BUTTON;
            this.applyBtn.label = SETTINGS.APPLY_BUTTON;
            this.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.cancelBtnClickHandler, false, 0, true);
            this.applyBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.applayBtnClickHandler, false, 0, true);
            this.submitBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitBtnClickHandler, false, 0, true);
            if (this.tabs != null) 
            {
                this.tabs.dataProvider = new scaleform.clik.data.DataProvider(net.wg.gui.lobby.settings.SettingsConfig.tabsDataProvider);
                this.tabs.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onTabChange);
                this.view.addEventListener(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdateHandler);
                this.view.addEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.onViewChangeHandler);
            }
            this.changesData = new net.wg.gui.lobby.settings.SettingsChangesMap();
            this.addEventListener(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, this.onControlChanged);
            this.addEventListener(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_PTT_CONTROL_CHANGED, this.onPTTControlChanged);
            this.addEventListener(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_AUTO_DETECT_QUALITY, this.onAutodetectQuality);
            this.addEventListener(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_VIVOX_TEST, this.onVivoxTest);
            this.addEventListener(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE, this.onUpdateCaptureDevices);
            this.addEventListener(net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES, this.onAlternativeVoice);
            return;
        }

        protected override function draw():void
        {
            if (this.tabs.selectedIndex == -1) 
            {
                this.tabs.selectedIndex = __currentTab;
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.cancelBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.cancelBtnClickHandler);
            this.applyBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.applayBtnClickHandler);
            this.submitBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.submitBtnClickHandler);
            if (this.view) 
            {
                this.view.removeEventListener(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdateHandler);
                this.view.removeEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.onViewChangeHandler);
            }
            if (this.tabs) 
            {
                this.tabs.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onTabChange);
            }
            this.removeEventListener(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_PTT_CONTROL_CHANGED, this.onPTTControlChanged);
            this.removeEventListener(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, this.onControlChanged);
            this.removeEventListener(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_AUTO_DETECT_QUALITY, this.onAutodetectQuality);
            this.removeEventListener(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_VIVOX_TEST, this.onVivoxTest);
            this.removeEventListener(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE, this.onUpdateCaptureDevices);
            this.removeEventListener(net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES, this.onAlternativeVoice);
            this.changesData.clear();
            this.changesData = null;
            this._settingsData = null;
            return;
        }

        internal function controlDefValEqNewVal(arg1:*, arg2:*):Boolean
        {
            var loc1:*=null;
            if (arg1 is net.wg.gui.lobby.settings.vo.SettingsControlProp) 
            {
                return net.wg.gui.lobby.settings.vo.SettingsControlProp(arg1).current == arg2;
            }
            if (arg1 is net.wg.gui.lobby.settings.vo.SettingsKeyProp) 
            {
                return net.wg.gui.lobby.settings.vo.SettingsKeyProp(arg1).key == arg2;
            }
            if (!(arg2 is String) && !(arg2 is Number) && !(arg2 is Boolean)) 
            {
                var loc2:*=0;
                var loc3:*=arg2;
                for (loc1 in loc3) 
                {
                    if (arg1[loc1] == null) 
                    {
                        continue;
                    }
                    if (arg1[loc1] is net.wg.gui.lobby.settings.vo.SettingsControlProp) 
                    {
                        return net.wg.gui.lobby.settings.vo.SettingsControlProp(arg1[loc1]).current == arg2[loc1];
                    }
                    if (arg1[loc1] is net.wg.gui.lobby.settings.vo.SettingsKeyProp) 
                    {
                        return net.wg.gui.lobby.settings.vo.SettingsKeyProp(arg1[loc1]).key == arg2[loc1];
                    }
                    return this.controlDefValEqNewVal(arg1[loc1], arg2[loc1]);
                }
            }
            return false;
        }

        internal function onAlternativeVoice(arg1:net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (isSoundModeValidS()) 
            {
                altVoicesPreviewS();
            }
            else 
            {
                loc1 = net.wg.gui.lobby.settings.SoundSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS));
                loc2 = loc1.testAlternativeVoicesButton.x;
                loc3 = loc1.testAlternativeVoicesButton.y;
                loc4 = this.localToGlobal(new flash.geom.Point(loc2, loc3));
                loc5 = new net.wg.data.managers.impl.TooltipProps(net.wg.data.constants.Tooltips.TYPE_WARNING, loc4.x, loc4.y, 0, 0, 3000);
                loc6 = "<font color=\"" + net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT + "\">" + App.utils.locale.makeString(TOOLTIPS.SETTINGS_DIALOG_SOUND_SOUNDMODEINVALID) + "</font>";
                App.toolTipMgr.show(loc6, loc5);
            }
            return;
        }

        internal function updateApplayBtnState():void
        {
            this.applyBtn.enabled = this.changesData.length > 0;
            return;
        }

        internal function tryGetView(arg1:String):flash.display.MovieClip
        {
            var loc1:*=null;
            if (!this.view) 
            {
                return null;
            }
            if (this.view.cachedViews[arg1] != null) 
            {
                loc1 = this.view.cachedViews[arg1];
            }
            return loc1;
        }

        internal function normalize(arg1:Object):Object
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=net.wg.gui.lobby.settings.SettingsConfig.settingsData;
            for (loc1 in loc5) 
            {
                if (arg1[loc1] == undefined) 
                {
                    continue;
                }
                this.normalizeInside(arg1, net.wg.gui.lobby.settings.SettingsConfig.settingsData[loc1], loc1);
            }
            if (net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS][net.wg.gui.lobby.settings.SettingsConfig.PTT] && net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.CONTROLS_SETTINGS][net.wg.gui.lobby.settings.SettingsConfig.KEYBOARD][net.wg.gui.lobby.settings.SettingsConfig.PUSH_TO_TALK]) 
            {
                loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS][net.wg.gui.lobby.settings.SettingsConfig.PTT]);
                loc3 = net.wg.gui.lobby.settings.vo.SettingsKeyProp(net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.CONTROLS_SETTINGS][net.wg.gui.lobby.settings.SettingsConfig.KEYBOARD][net.wg.gui.lobby.settings.SettingsConfig.PUSH_TO_TALK]);
                loc2.current = loc3.key;
            }
            net.wg.gui.lobby.settings.vo.SettingsControlProp(net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.GAME_SETTINGS][net.wg.gui.lobby.settings.SettingsConfig.ENABLE_OL_FILTER]).readOnly = App.globalVarsMgr.isChinaS();
            return net.wg.gui.lobby.settings.SettingsConfig.settingsData;
        }

        internal function normalizeInside(arg1:Object, arg2:Object, arg3:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=App.utils.commons;
            var loc4:*=0;
            var loc5:*=arg2;
            for (loc2 in loc5) 
            {
                if (arg1[arg3][loc2] == undefined) 
                {
                    continue;
                }
                if (loc2 == net.wg.gui.lobby.settings.SettingsConfig.PRESETS || loc2 == net.wg.gui.lobby.settings.SettingsConfig.QUALITY_ORDER) 
                {
                    arg2[loc2] = loc1.cloneObject(arg1[arg3][loc2]);
                    continue;
                }
                if (loc2 == net.wg.gui.lobby.settings.SettingsConfig.KEYBOARD) 
                {
                    arg2[loc2] = {};
                    arg2[net.wg.gui.lobby.settings.SettingsConfig.KEYS_LAYOUT_ORDER] = [];
                    this.normalizeKays(arg1[arg3][loc2], arg1[arg3][loc2][net.wg.gui.lobby.settings.SettingsConfig.KEYS_LAYOUT], arg2[loc2], arg2[net.wg.gui.lobby.settings.SettingsConfig.KEYS_LAYOUT_ORDER]);
                    continue;
                }
                if (arg2[loc2] is net.wg.gui.lobby.settings.vo.SettingsControlProp) 
                {
                    loc3 = net.wg.gui.lobby.settings.vo.SettingsControlProp(arg2[loc2]);
                    if (arg1[arg3][loc2] is Boolean || arg1[arg3][loc2] is String || arg1[arg3][loc2] is Number) 
                    {
                        loc3.current = arg1[arg3][loc2];
                    }
                    else if (arg1[arg3][loc2].current is Object && !(arg1[arg3][loc2].current == undefined)) 
                    {
                        if (loc3.type != net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX) 
                        {
                            loc3.current = Math.max(arg1[arg3][loc2].current, 0);
                            if (arg3 == net.wg.gui.lobby.settings.SettingsConfig.CONTROLS_SETTINGS) 
                            {
                                if (arg1[arg3][loc2].hasOwnProperty("default")) 
                                {
                                    loc3._default = Math.max(arg1[arg3][loc2].default, 0);
                                }
                                else 
                                {
                                    loc3._default = 0;
                                }
                            }
                            if (arg1[arg3][loc2].options == undefined) 
                            {
                                loc3.options = [];
                            }
                            else 
                            {
                                loc3.options = loc1.cloneObject(arg1[arg3][loc2].options);
                            }
                        }
                        else 
                        {
                            loc3.current = Boolean(arg1[arg3][loc2].current);
                            if (arg3 == net.wg.gui.lobby.settings.SettingsConfig.CONTROLS_SETTINGS) 
                            {
                                if (arg1[arg3][loc2].hasOwnProperty("default")) 
                                {
                                    loc3._default = arg1[arg3][loc2].default != undefined ? Boolean(arg1[arg3][loc2].default) : false;
                                }
                                else 
                                {
                                    loc3._default = false;
                                }
                            }
                        }
                    }
                    continue;
                }
                this.normalizeInside(arg1[arg3], arg2[loc2], loc2);
            }
            return;
        }

        internal function normalizeKays(arg1:Object, arg2:Array, arg3:Object, arg4:Array):void
        {
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=false;
            var loc1:*=arg2.length;
            while (loc2 < loc1) 
            {
                loc3 = arg2[loc2].key;
                loc5 = (loc4 = arg2[loc2].values).length;
                arg4.push(loc3);
                arg3[loc3] = new net.wg.gui.lobby.settings.vo.SettingsKeyProp(loc3, true, loc3, null, NaN, NaN, null, false, loc2 != 0 ? 18 : 0);
                loc6 = 0;
                while (loc6 < loc5) 
                {
                    loc7 = loc4[loc6].key;
                    loc8 = loc4[loc6].cmd;
                    loc9 = loc4[loc6].hasOwnProperty("descr") ? loc4[loc6]["descr"] : null;
                    if (arg1[loc7].current != null) 
                    {
                        loc10 = arg1[loc7].current;
                        loc11 = arg1[loc7].default;
                        loc12 = true;
                        arg3[loc7] = new net.wg.gui.lobby.settings.vo.SettingsKeyProp(loc7, false, loc7, loc8, loc10, loc11, loc9, loc12);
                        arg4.push(loc7);
                    }
                    ++loc6;
                }
                ++loc2;
            }
            return;
        }

        internal function sendData(arg1:Boolean):void
        {
            var loc4:*=null;
            var loc1:*=net.wg.gui.lobby.settings.SoundSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.SOUND_SETTINGS));
            if (loc1) 
            {
                loc1.breakSoundCheck();
            }
            var loc2:*=this.checkControlsWrong();
            var loc3:*=!isSoundModeValidS();
            if (loc2 || loc3) 
            {
                loc4 = (loc4 = loc2 ? this.CONTROLS_WARNING : "") + (loc3 ? this.SOUND_MODE_WARNING : "");
                showWarningDialogS(loc4, this.changesData.getChanges(), arg1);
            }
            else 
            {
                applySettingsS(this.changesData.getChanges(), arg1);
                this.updateSettingsConfig();
            }
            return;
        }

        internal function checkControlsWrong():Boolean
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=false;
            var loc2:*=net.wg.gui.lobby.settings.ControlsSettings(this.tryGetView(net.wg.gui.lobby.settings.SettingsConfig.CONTROLS_SETTINGS));
            if (loc2) 
            {
                loc3 = loc2.getKeyasDataProvider();
                loc4 = loc3.length;
                loc5 = 0;
                while (loc5 < loc4) 
                {
                    if (net.wg.data.constants.KeysMap.KEY_NONE == loc3[loc5].key) 
                    {
                        loc1 = true;
                        break;
                    }
                    ++loc5;
                }
            }
            else 
            {
                loc6 = net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.CONTROLS_SETTINGS][net.wg.gui.lobby.settings.SettingsConfig.KEYBOARD];
                var loc9:*=0;
                var loc10:*=loc6;
                for (loc7 in loc10) 
                {
                    if ((loc8 = net.wg.gui.lobby.settings.vo.SettingsKeyProp(loc6[loc7])).key != net.wg.data.constants.KeysMap.KEY_NONE) 
                    {
                        continue;
                    }
                    loc1 = true;
                    break;
                }
            }
            return loc1;
        }

        internal function updateSettingsConfig():void
        {
            var loc1:*=null;
            if (this.changesData) 
            {
                loc1 = this.changesData.getChanges();
                this.searchAndOverride(0, net.wg.gui.lobby.settings.SettingsConfig.settingsData, loc1);
                this.changesData.clear();
                this.updateApplayBtnState();
            }
            return;
        }

        internal function searchAndOverride(arg1:uint, arg2:Object, arg3:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=arg3;
            for (loc1 in loc5) 
            {
                if (!(arg3[loc1] is Boolean || arg3[loc1] is Number || arg3[loc1] is String)) 
                {
                    loc2 = null;
                    if (arg1 != 0) 
                    {
                        loc2 = arg2[loc1];
                    }
                    else 
                    {
                        loc2 = this.getPropObj(arg2, loc1);
                    }
                    this.searchAndOverride(arg1 + 1, loc2, arg3[loc1]);
                    continue;
                }
                loc3 = null;
                if (arg1 != 0) 
                {
                    loc3 = arg2[loc1];
                }
                else 
                {
                    loc3 = this.getPropObj(arg2, loc1);
                }
                if (!(loc3 == null) && loc3 is net.wg.gui.lobby.settings.vo.SettingsControlProp) 
                {
                    net.wg.gui.lobby.settings.vo.SettingsControlProp(loc3).current = arg3[loc1];
                    continue;
                }
                if (!(!(loc3 == null) && loc3 is net.wg.gui.lobby.settings.vo.SettingsKeyProp)) 
                {
                    continue;
                }
                net.wg.gui.lobby.settings.vo.SettingsKeyProp(loc3).key = arg3[loc1];
            }
            return;
        }

        internal function getPropObj(arg1:Object, arg2:String):Object
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1;
            for (loc1 in loc3) 
            {
                if (!arg1[loc1].hasOwnProperty(arg2)) 
                {
                    continue;
                }
                return arg1[loc1][arg2];
            }
            return null;
        }

        internal const CONTROLS_WARNING:String="controlsWrongNotification";

        internal const SOUND_MODE_WARNING:String="soundModeInvalid";

        public var wndBg:flash.display.MovieClip=null;

        public var title:net.wg.gui.components.controls.TextFieldShort=null;

        public var tabs:net.wg.gui.components.advanced.ButtonBarEx=null;

        public var tabLine:flash.display.Sprite=null;

        public var view:net.wg.gui.components.advanced.ViewStack=null;

        public var cancelBtn:net.wg.gui.components.controls.SoundButtonEx=null;

        public var applyBtn:net.wg.gui.components.controls.SoundButtonEx=null;

        public var ddMenu_ScrollingList:scaleform.clik.controls.ScrollingList=null;

        public var ddListItemRendererSound:net.wg.gui.components.controls.DropDownListItemRendererSound=null;

        internal var _settingsData:Object=null;

        internal var changesData:net.wg.gui.lobby.settings.SettingsChangesMap=null;

        internal static var __currentTab:Number=0;

        public var submitBtn:net.wg.gui.components.controls.SoundButtonEx=null;
    }
}
