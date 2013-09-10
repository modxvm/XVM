package net.wg.gui.lobby.settings 
{
    import flash.events.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.settings.evnts.*;
    import net.wg.gui.lobby.settings.vo.*;
    import net.wg.utils.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class GraphicSettings extends net.wg.gui.lobby.settings.SettingsBaseView
    {
        public function GraphicSettings()
        {
            super();
            return;
        }

        internal function updateGraphicsQualityDataForAdvanced(arg1:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=NaN;
            if (this.useAdvancedGraphic != arg1) 
            {
                this.useAdvancedGraphic = arg1;
                loc1 = "";
                var loc8:*=0;
                var loc9:*=this.graphicsQualityDataProv;
                label332: for (loc1 in loc9) 
                {
                    loc4 = net.wg.gui.lobby.settings.vo.SettingsControlProp(this.graphicsQualityDataProv[loc1]);
                    var loc10:*=loc4.type;
                    switch (loc10) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                            continue label332;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                            continue label332;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                            loc4.options = new Array();
                            loc10 = 0;
                            var loc11:*=_data[loc1].options;
                            for (loc5 in loc11) 
                            {
                                if (!(arg1 || !_data[loc1].options[loc5].advanced)) 
                                    continue;
                                loc4.options.push(net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc1]).options[loc5]);
                            }
                            continue label332;
                    }
                }
                loc2 = this.useAdvancedGraphic ? net.wg.gui.lobby.settings.SettingsConfig.CUSTOM_AA : net.wg.gui.lobby.settings.SettingsConfig.MULTISAMPLING;
                (loc3 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.SMOOTHING])).options = _data[loc2].options;
                if (this[net.wg.gui.lobby.settings.SettingsConfig.SMOOTHING + loc3.type]) 
                {
                    loc7 = (loc6 = this[net.wg.gui.lobby.settings.SettingsConfig.SMOOTHING + loc3.type]).selectedIndex;
                    loc6.enabled = loc3.options && loc3.options.length > 0;
                    loc6.dataProvider = new scaleform.clik.data.DataProvider(loc3.options);
                    if (loc7 != _data[loc2].lastVal) 
                    {
                        loc6.selectedIndex = _data[loc2].lastVal;
                        dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, net.wg.gui.lobby.settings.SettingsConfig.SMOOTHING, loc6.selectedIndex));
                    }
                }
            }
            return;
        }

        public override function update(arg1:Object):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            this.graphicsQualityDataProv = {};
            var loc1:*=arg1.data;
            this.qualityOrder = loc1.qualityOrder;
            if (this.qualityOrder is Array) 
            {
                loc2 = this.qualityOrder.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc4 = this.qualityOrder[loc3];
                    if (loc1[loc4] != undefined) 
                        this.graphicsQualityDataProv[loc4] = net.wg.gui.lobby.settings.vo.SettingsControlProp(loc1[loc4]).clone();
                    ++loc3;
                }
            }
            super.update(arg1);
            return;
        }

        public override function dispose():void
        {
            if (this.graphicsQualityDropDown.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
                this.graphicsQualityDropDown.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onGraphicsQualityChangePresset);
            if (this.autodetectQuality.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
                this.autodetectQuality.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onAutodetectPress);
            var loc1:*="";
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=this.qualityOrder;
            label392: for (loc1 in loc7) 
            {
                if (!(!(_data[loc1] == undefined) && this[loc1 + _data[loc1].type])) 
                    continue;
                loc5 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc1]);
                var loc8:*=loc5.type;
                switch (loc8) 
                {
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                        loc2 = this[loc1 + loc5.type];
                        if (loc2.hasEventListener(flash.events.Event.SELECT)) 
                            loc2.removeEventListener(flash.events.Event.SELECT, this.onGraphicsCheckBoxChange);
                        continue label392;
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                        continue label392;
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                        loc3 = this[loc1 + loc5.type];
                        if (loc3.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
                            loc3.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onGraphicsDropDownChange);
                        continue label392;
                }
            }
            loc6 = 0;
            loc7 = _data;
            label742: for (loc1 in loc7) 
            {
                if (!(_data[loc1] && this[loc1 + _data[loc1].type])) 
                    continue;
                loc5 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc1]);
                loc8 = loc5.type;
                switch (loc8) 
                {
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                        loc2 = this[loc1 + loc5.type];
                        if (loc2.hasEventListener(flash.events.Event.SELECT)) 
                            loc2.removeEventListener(flash.events.Event.SELECT, this.onCheckBoxChange);
                        continue label742;
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                        if ((loc4 = this[loc1 + loc5.type]).hasEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE)) 
                            loc4.removeEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                        continue label742;
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                        loc3 = this[loc1 + loc5.type];
                        if (loc3.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
                            loc3.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onDropDownChange);
                        continue label742;
                }
            }
            super.dispose();
            return;
        }

        public override function toString():String
        {
            return "[WG GraphicSettings " + name + "]";
        }

        public function setPresetAfterAutoDetect(arg1:Number):void
        {
            this._presets.current = Math.min(this._presets.current, arg1);
            this.setPresets();
            this.autodetectQuality.enabled = true;
            return;
        }

        public function updateLiveVideoData():void
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=NaN;
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            loc3 = net.wg.gui.lobby.settings.SettingsConfig.liveUpdateVideoSettingsOrderData.length;
            var loc4:*=App.utils.commons;
            var loc5:*=0;
            while (loc5 < loc3) 
            {
                loc6 = net.wg.gui.lobby.settings.SettingsConfig.liveUpdateVideoSettingsOrderData[loc5];
                loc7 = net.wg.gui.lobby.settings.vo.SettingsControlProp(net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.GRAPHIC_SETTINGS][loc6]);
                if (net.wg.gui.lobby.settings.SettingsConfig.liveUpdateVideoSettingsData[loc6]) 
                {
                    loc8 = net.wg.gui.lobby.settings.vo.SettingsControlProp(net.wg.gui.lobby.settings.SettingsConfig.liveUpdateVideoSettingsData[loc6]);
                    loc7.options = loc4.cloneObject(loc8.options);
                }
                if (loc7 && this[loc6 + loc7.type]) 
                {
                    var loc12:*=loc7.type;
                    switch (loc12) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                            loc1 = net.wg.gui.components.controls.CheckBox(this[loc6 + loc7.type]);
                            loc1.selected = Boolean(loc8.current);
                            break;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                            break;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                            loc2 = net.wg.gui.components.controls.DropdownMenu(this[loc6 + loc7.type]);
                            if (loc6 != net.wg.gui.lobby.settings.SettingsConfig.SIZE) 
                            {
                                loc2.dataProvider = new scaleform.clik.data.DataProvider(loc8.options);
                                loc2.selectedIndex = loc8.current;
                            }
                            else 
                            {
                                loc9 = this.fullScreenCheckbox.selected ? net.wg.gui.lobby.settings.SettingsConfig.RESOLUTION : net.wg.gui.lobby.settings.SettingsConfig.WINDOW_SIZE;
                                loc10 = net.wg.gui.lobby.settings.vo.SettingsControlProp(net.wg.gui.lobby.settings.SettingsConfig.liveUpdateVideoSettingsData[loc9]);
                                loc11 = this.monitorDropDown.selectedIndex;
                                net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc9]).lastVal[loc11] = loc10.current;
                                if (loc10 && loc10.options is Array) 
                                {
                                    loc2.dataProvider = new scaleform.clik.data.DataProvider(loc10.options[loc11]);
                                    loc2.selectedIndex = loc10.current;
                                }
                            }
                            break;
                    }
                }
                if (loc6 != net.wg.gui.lobby.settings.SettingsConfig.SIZE) 
                    dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc6, loc8.current));
                ++loc5;
            }
            return;
        }

        protected override function configUI():void
        {
            this.monitorLabel.text = SETTINGS.MONITOR;
            this.fullScreenCheckbox.label = SETTINGS.FULLSCREENMODE;
            this.sizesLabel.text = SETTINGS.RESOLUTION;
            this.vertSyncCheckbox.label = SETTINGS.VERTICAL_SYNC;
            this.aspectRatioLabel.text = SETTINGS.ASPECTRATIO;
            this.smoothingLabel.text = SETTINGS.MULTISAMPLINGTYPE;
            this.tripleBufferedCheckbox.label = SETTINGS.TRIPLEBUFFERED;
            this.gammaLabel.text = SETTINGS.GAMMA;
            this.isColorBlindCheckbox.label = SETTINGS.ISCOLORBLIND;
            this.graphicsQualityLabel.text = SETTINGS.GRAPHICS_DETAILS;
            this.autodetectQuality.label = SETTINGS.AUTODETECTBUTTON;
            this.RENDER_PIPELINELabel.text = "";
            this.TEXTURE_QUALITYLabel.text = "";
            this.DECALS_QUALITYLabel.text = "";
            this.SHADOWS_QUALITYLabel.text = "";
            this.TERRAIN_QUALITYLabel.text = "";
            this.WATER_QUALITYLabel.text = "";
            this.LIGHTING_QUALITYLabel.text = "";
            this.SPEEDTREE_QUALITYLabel.text = "";
            this.FLORA_QUALITYLabel.text = "";
            this.EFFECTS_QUALITYLabel.text = "";
            this.POST_PROCESSING_QUALITYLabel.text = "";
            this.FAR_PLANELabel.text = "";
            this.OBJECT_LODLabel.text = "";
            this.SNIPER_MODE_EFFECTS_QUALITYLabel.text = "";
            this.fpsPerfomancerCheckbox.label = "";
            this.SNIPER_MODE_GRASS_ENABLEDCheckbox.label = "";
            this.VEHICLE_DUST_ENABLEDCheckbox.label = "";
            this.VEHICLE_TRACES_ENABLEDCheckbox.label = "";
            this.autodetectQuality.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onAutodetectPress);
            super.configUI();
            return;
        }

        protected override function setData(arg1:Object):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc1:*=false;
            if (_data.presets.options) 
            {
                loc2 = _data.presets.options.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    if (_data.presets.current == _data.presets.options[loc3].index) 
                        loc1 = _data.presets.options[loc3].key != net.wg.gui.lobby.settings.SettingsConfig.CUSTOM ? false : true;
                    ++loc3;
                }
            }
            this.setControllsData(arg1, loc1);
            this.setPresets();
            return;
        }

        internal function setControllsData(arg1:Object, arg2:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc3:*=false;
            var loc4:*=false;
            var loc5:*=null;
            var loc6:*=false;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=null;
            var loc15:*=NaN;
            var loc16:*=0;
            var loc17:*=0;
            var loc18:*=null;
            var loc19:*=null;
            var loc20:*=null;
            var loc21:*=NaN;
            var loc22:*=null;
            var loc23:*=0;
            var loc24:*=_data;
            for (loc1 in loc24) 
            {
                loc2 = this.qualityOrder && this.qualityOrder.indexOf(loc1, 0) == -1 ? false : true;
                loc3 = false;
                loc4 = arg2 && loc2;
                if (_data[loc1] && !(this[loc1 + _data[loc1].type] == undefined)) 
                {
                    loc6 = !((loc5 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc1])).current == null || loc5.readOnly);
                    var loc25:*=loc5.type;
                    switch (loc25) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                            if ((loc7 = this[loc1 + loc5.type]).label == "") 
                                loc7.label = net.wg.gui.lobby.settings.SettingsConfig.LOCALIZATION + loc1;
                            if (loc4 || !loc2) 
                                loc7.selected = loc5.current;
                            if (loc2) 
                                loc7.addEventListener(flash.events.Event.SELECT, this.onGraphicsCheckBoxChange);
                            else 
                                loc7.addEventListener(flash.events.Event.SELECT, this.onCheckBoxChange);
                            loc7.enabled = loc6;
                            break;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                            loc8 = this[loc1 + loc5.type];
                            if (loc4 || !loc2) 
                                loc8.value = loc5.current;
                            if (!loc2) 
                                loc8.addEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                            if (loc1 == net.wg.gui.lobby.settings.SettingsConfig.GAMMA) 
                                loc6 = (loc3 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.FULL_SCREEN]).current) && loc6;
                            loc8.enabled = loc6;
                            break;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                            loc9 = this[loc1 + loc5.type];
                            if (loc1 == net.wg.gui.lobby.settings.SettingsConfig.SIZE) 
                            {
                                loc10 = _data[net.wg.gui.lobby.settings.SettingsConfig.FULL_SCREEN].current ? net.wg.gui.lobby.settings.SettingsConfig.RESOLUTION : net.wg.gui.lobby.settings.SettingsConfig.WINDOW_SIZE;
                                this.sizesLabel.text = net.wg.gui.lobby.settings.SettingsConfig.LOCALIZATION + loc10;
                                loc11 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc10]);
                                loc12 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.RESOLUTION]);
                                loc13 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.WINDOW_SIZE]);
                                loc15 = (loc14 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.MONITOR])).current;
                                if (loc11 && loc11.options is Array) 
                                {
                                    loc5.options = loc11.options[loc15];
                                    loc5.current = loc11.current;
                                }
                                loc6 = loc5.options is Array && loc5.options.length > 0;
                                loc16 = 0;
                                loc17 = loc14.options is Array ? loc14.options.length : 0;
                                loc12.lastVal = [];
                                loc13.lastVal = [];
                                loc16 = 0;
                                while (loc16 < loc17) 
                                {
                                    loc12.lastVal[loc16] = loc16 != loc14.current ? (loc12.options[loc16].length - 1) : loc12.current;
                                    loc13.lastVal[loc16] = loc16 != loc14.current ? (loc13.options[loc16].length - 1) : loc13.current;
                                    ++loc16;
                                }
                            }
                            if (loc1 == net.wg.gui.lobby.settings.SettingsConfig.ASPECTRATIO) 
                                loc6 = (loc3 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.FULL_SCREEN]).current) && loc6;
                            if (loc1 == net.wg.gui.lobby.settings.SettingsConfig.SMOOTHING) 
                            {
                                loc18 = _data[net.wg.gui.lobby.settings.SettingsConfig.RENDER_PIPELINE].current != 0 ? net.wg.gui.lobby.settings.SettingsConfig.MULTISAMPLING : net.wg.gui.lobby.settings.SettingsConfig.CUSTOM_AA;
                                loc5.options = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc18]).options;
                                loc5.current = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc18]).current;
                                loc19 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.CUSTOM_AA]);
                                loc20 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.MULTISAMPLING]);
                                loc19.lastVal = loc19.current;
                                loc20.lastVal = loc20.current;
                                loc6 = loc5.options && loc5.options is Array && loc5.options.length > 0;
                            }
                            if (loc4 || !loc2) 
                            {
                                loc9.dataProvider = new scaleform.clik.data.DataProvider(loc5.options);
                                if (loc4) 
                                {
                                    loc21 = 0;
                                    loc25 = 0;
                                    var loc26:*=loc5.options;
                                    for (loc22 in loc26) 
                                    {
                                        if (loc5.options[loc22].hasOwnProperty("data") && loc5.current == loc5.options[loc22].data) 
                                            break;
                                        ++loc21;
                                    }
                                    loc9.selectedIndex = loc21;
                                }
                                else 
                                    loc9.selectedIndex = loc5.current;
                            }
                            if (loc2) 
                                loc9.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onGraphicsDropDownChange);
                            else 
                                loc9.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onDropDownChange);
                            loc9.enabled = loc6;
                            break;
                    }
                }
                else if (loc1 == net.wg.gui.lobby.settings.SettingsConfig.PRESETS && !this._presets) 
                    this._presets = _data[loc1];
                else if (!loc5.readOnly && net.wg.gui.lobby.settings.SettingsConfig.reservedImaginaryControls.indexOf(loc1) == -1) 
                    DebugUtils.LOG_WARNING("ERROR in" + this + " control " + loc1 + " can not find");
                trySetLabel(loc1);
            }
            return;
        }

        internal function setPresets():void
        {
            var loc1:*=[];
            var loc2:*="";
            var loc6:*=0;
            var loc7:*=this._presets.options;
            for (loc2 in loc7) 
                loc1[this._presets.options[loc2].index] = {"label":SETTINGS.graphicsquality(this._presets.options[loc2].key), "settings":this._presets.options[loc2].settings, "key":this._presets.options[loc2].key};
            this.graphicsQualityDropDown.dataProvider = new scaleform.clik.data.DataProvider(loc1);
            this.graphicsQualityDropDown.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onGraphicsQualityChangePresset);
            this.graphicsQualityDropDown.selectedIndex = this._presets.current;
            this.graphicsQualityDropDown.enabled = true;
            if (net.wg.gui.lobby.settings.SettingsConfig.settingsData.GraphicSettings.graphicsQuality != undefined) 
                net.wg.gui.lobby.settings.SettingsConfig.settingsData.GraphicSettings.graphicsQuality.current = this._presets.current;
            var loc3:*=null;
            var loc4:*=this._presets.options is Array ? this._presets.options.length : 0;
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                if (this._presets.current == this._presets.options[loc5].index) 
                {
                    loc3 = this._presets.options[loc5];
                    break;
                }
                ++loc5;
            }
            if (loc3) 
                this.updateGraphicsQualityControlsForPresset(this._presets.current, loc3);
            else 
            {
                this.graphicsQualityDropDown.enabled = false;
                this.autodetectQuality.enabled = false;
            }
            return;
        }

        internal function updateGraphicsQualityControlsForPresset(arg1:Number, arg2:Object):void
        {
            var loc2:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=0;
            var loc1:*=arg2.key;
            loc2 = "";
            var loc3:*=0;
            var loc4:*=0;
            this.allowCheckPresets = false;
            var loc5:*=false;
            if (loc1 != net.wg.gui.lobby.settings.SettingsConfig.CUSTOM) 
                loc5 = arg2.settings[net.wg.gui.lobby.settings.SettingsConfig.RENDER_PIPELINE] == 0;
            else 
                loc5 = (loc6 = this[net.wg.gui.lobby.settings.SettingsConfig.RENDER_PIPELINE + net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN]).selectedIndex == 0;
            this.updateGraphicsQualityDataForAdvanced(loc5);
            if (loc1 != net.wg.gui.lobby.settings.SettingsConfig.CUSTOM) 
            {
                loc4 = 0;
                while (loc4 < this.qualityOrder.length) 
                {
                    loc2 = this.qualityOrder[loc4];
                    if (!(this.graphicsQualityDataProv[loc2] == undefined) && !(this[loc2 + net.wg.gui.lobby.settings.vo.SettingsControlProp(this.graphicsQualityDataProv[loc2]).type] == undefined)) 
                    {
                        loc7 = net.wg.gui.lobby.settings.vo.SettingsControlProp(this.graphicsQualityDataProv[loc2]);
                        var loc13:*=loc7.type;
                        switch (loc13) 
                        {
                            case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                                (loc8 = this[loc2 + loc7.type]).selected = Boolean(arg2.settings[loc2]);
                                loc8.enabled = Boolean(this.useAdvancedGraphic || !loc7.advanced);
                                dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, loc8.selected));
                                break;
                            case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                                break;
                            case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                                (loc9 = this[loc2 + loc7.type]).menuRowCount = loc7.options.length;
                                loc9.dataProvider = new scaleform.clik.data.DataProvider(loc7.options);
                                loc10 = 0;
                                loc11 = 0;
                                loc12 = loc7.options.length;
                                loc3 = 0;
                                while (loc3 < loc12) 
                                {
                                    if (arg2.settings[loc2] == loc7.options[loc3].data) 
                                    {
                                        loc10 = loc3;
                                        loc11 = loc7.options[loc3].data;
                                        break;
                                    }
                                    ++loc3;
                                }
                                loc9.selectedIndex = loc10;
                                dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, loc11));
                                break;
                        }
                    }
                    ++loc4;
                }
            }
            this.allowCheckPresets = true;
            return;
        }

        internal function updateGraphicsQualityIfChangeAdvanced():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=0;
            var loc9:*=NaN;
            var loc10:*=0;
            this.allowCheckPresets = false;
            var loc11:*=0;
            var loc12:*=this.graphicsQualityDataProv;
            label573: for (loc1 in loc12) 
            {
                if (!this[loc1 + net.wg.gui.lobby.settings.vo.SettingsControlProp(this.graphicsQualityDataProv[loc1]).type]) 
                    continue;
                loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(this.graphicsQualityDataProv[loc1]);
                var loc13:*=loc2.type;
                switch (loc13) 
                {
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                        loc3 = this[loc1 + loc2.type];
                        loc4 = loc3.selected;
                        if (!this.useAdvancedGraphic) 
                            loc3.selected = Boolean(this.useAdvancedGraphic || !loc2.advanced);
                        loc3.enabled = Boolean(this.useAdvancedGraphic || !loc2.advanced);
                        if (loc4 != loc3.selected) 
                            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc1, loc3.selected));
                        continue label573;
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                        continue label573;
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                        loc6 = (loc5 = this[loc1 + loc2.type]).dataProvider[loc5.selectedIndex].data;
                        loc7 = -1;
                        loc8 = loc2.options.length;
                        loc10 = 0;
                        while (loc10 < loc8) 
                        {
                            if (loc2.options[loc10].data == loc6) 
                            {
                                loc7 = loc10;
                                break;
                            }
                            ++loc10;
                        }
                        loc5.menuRowCount = loc2.options.length;
                        loc5.dataProvider = new scaleform.clik.data.DataProvider(loc2.options);
                        loc5.selectedIndex = loc7 == -1 ? (loc2.options.length - 1) : loc7;
                        loc9 = loc2.options[loc5.selectedIndex].data;
                        if (loc6 != loc9) 
                            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc1, loc9));
                        continue label573;
                }
            }
            this.allowCheckPresets = true;
            return;
        }

        internal function checkForCustomsPreset():void
        {
            var loc2:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            if (!this.allowCheckPresets) 
                return;
            var loc1:*=0;
            loc2 = "";
            var loc3:*={};
            var loc4:*=this.qualityOrder.length;
            loc1 = 0;
            while (loc1 < loc4) 
            {
                loc2 = this.qualityOrder[loc1];
                if (!(_data[loc2] == undefined) && this[loc2 + _data[loc2].type]) 
                {
                    loc10 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc2]);
                    var loc14:*=loc10.type;
                    switch (loc14) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                            loc11 = this[loc2 + loc10.type];
                            loc3[loc2] = Number(loc11.selected);
                            break;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                            break;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                            loc12 = this[loc2 + loc10.type];
                            loc3[loc2] = net.wg.gui.lobby.settings.vo.SettingsControlProp(this.graphicsQualityDataProv[loc2]).options[loc12.selectedIndex].data;
                            break;
                    }
                }
                ++loc1;
            }
            var loc5:*=-1;
            var loc6:*="";
            var loc7:*=true;
            var loc8:*=this._presets.options.length;
            var loc9:*="";
            loc1 = 0;
            while (loc1 < loc8) 
            {
                if (this._presets.options[loc1].key != net.wg.gui.lobby.settings.SettingsConfig.CUSTOM) 
                {
                    loc7 = true;
                    loc14 = 0;
                    var loc15:*=loc3;
                    for (loc9 in loc15) 
                    {
                        if (this._presets.options[loc1].settings[loc9] == loc3[loc9]) 
                            continue;
                        loc7 = false;
                        break;
                    }
                    if (loc7) 
                    {
                        loc5 = this._presets.options[loc1].index;
                        loc6 = this._presets.options[loc1].key;
                        break;
                    }
                }
                else 
                {
                    loc6 = this._presets.options[loc1].key;
                    loc5 = this._presets.options[loc1].index;
                }
                ++loc1;
            }
            loc3 = null;
            if (this.graphicsQualityDropDown.selectedIndex != loc5) 
            {
                this.graphicsQualityDropDown.selectedIndex = loc5;
                loc13 = net.wg.gui.lobby.settings.SettingsConfig.GRAPHIC_QUALITY;
                dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc13, loc5));
            }
            return;
        }

        internal function onAutodetectPress(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.autodetectQuality.enabled = false;
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_AUTO_DETECT_QUALITY, _viewId));
            return;
        }

        internal function onDropDownChange(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc6:*=null;
            var loc7:*=false;
            var loc8:*=null;
            var loc9:*=false;
            var loc10:*=null;
            var loc1:*=net.wg.gui.components.controls.DropdownMenu(arg1.target);
            var loc2:*=arg1.index;
            var loc3:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN);
            var loc4:*="";
            var loc5:*=0;
            if (loc3 != net.wg.gui.lobby.settings.SettingsConfig.SMOOTHING) 
                if (loc3 != net.wg.gui.lobby.settings.SettingsConfig.SIZE) 
                    if (loc3 == net.wg.gui.lobby.settings.SettingsConfig.MONITOR) 
                    {
                        loc4 = this.fullScreenCheckbox.selected ? net.wg.gui.lobby.settings.SettingsConfig.RESOLUTION : net.wg.gui.lobby.settings.SettingsConfig.WINDOW_SIZE;
                        loc5 = loc2;
                        (loc10 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.SIZE])).options = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc4]).options[loc5];
                        this.sizesDropDown.dataProvider = new scaleform.clik.data.DataProvider(loc10.options);
                        this.sizesDropDown.selectedIndex = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc4]).lastVal[loc5];
                        dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc4, this.sizesDropDown.selectedIndex));
                    }
                else 
                {
                    loc3 = (loc9 = this.fullScreenCheckbox.selected) ? net.wg.gui.lobby.settings.SettingsConfig.RESOLUTION : net.wg.gui.lobby.settings.SettingsConfig.WINDOW_SIZE;
                    loc5 = this.monitorDropDown.selectedIndex;
                    net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc3]).lastVal[loc5] = loc2;
                }
            else 
            {
                loc8 = (loc7 = (loc6 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.RENDER_PIPELINE])).options[this.RENDER_PIPELINEDropDown.selectedIndex].data != 0 ? false : true) ? net.wg.gui.lobby.settings.SettingsConfig.CUSTOM_AA : net.wg.gui.lobby.settings.SettingsConfig.MULTISAMPLING;
                net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc8]).lastVal = loc2;
            }
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc3, loc2));
            return;
        }

        internal function onCheckBoxChange(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc1:*=net.wg.gui.components.controls.CheckBox(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX);
            if (loc2 == net.wg.gui.lobby.settings.SettingsConfig.FULL_SCREEN) 
            {
                loc3 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.SIZE]);
                loc4 = loc1.selected ? net.wg.gui.lobby.settings.SettingsConfig.RESOLUTION : net.wg.gui.lobby.settings.SettingsConfig.WINDOW_SIZE;
                loc5 = this.monitorDropDown.selectedIndex;
                this.sizesLabel.text = net.wg.gui.lobby.settings.SettingsConfig.LOCALIZATION + loc4;
                loc3.options = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc4]).options[loc5];
                this.sizesDropDown.dataProvider = new scaleform.clik.data.DataProvider(loc3.options);
                this.sizesDropDown.selectedIndex = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc4]).lastVal[loc5];
                dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc4, this.sizesDropDown.selectedIndex));
                this.aspectRatioDropDown.enabled = loc1.selected;
                this.gammaSlider.enabled = loc1.selected;
            }
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, loc1.selected));
            return;
        }

        internal function onSliderValueChanged(arg1:scaleform.clik.events.SliderEvent):void
        {
            var loc1:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(net.wg.gui.components.controls.Slider(arg1.target).name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER);
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc1, net.wg.gui.components.controls.Slider(arg1.target).value));
            return;
        }

        internal function onGraphicsQualityChangePresset(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=arg1.index;
            var loc2:*=arg1.itemData;
            this.updateGraphicsQualityControlsForPresset(loc1, loc2);
            return;
        }

        internal function onGraphicsDropDownChange(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=arg1.index;
            var loc2:*=arg1.itemData;
            var loc3:*=net.wg.gui.components.controls.DropdownMenu(arg1.target);
            var loc4:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc3.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN);
            var loc5:*=net.wg.gui.lobby.settings.vo.SettingsControlProp(this.graphicsQualityDataProv[loc4]).options[loc1].data;
            if (loc4 == net.wg.gui.lobby.settings.SettingsConfig.RENDER_PIPELINE) 
                if (!Boolean(loc5) != this.useAdvancedGraphic) 
                {
                    this.updateGraphicsQualityDataForAdvanced(!Boolean(loc5));
                    this.updateGraphicsQualityIfChangeAdvanced();
                }
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc4, loc5));
            this.checkForCustomsPreset();
            return;
        }

        internal function onGraphicsCheckBoxChange(arg1:flash.events.Event):void
        {
            var loc1:*=net.wg.gui.components.controls.CheckBox(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX);
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, loc1.selected));
            this.checkForCustomsPreset();
            return;
        }

        public var RENDER_PIPELINEDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var TEXTURE_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var TEXTURE_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var DECALS_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var DECALS_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var SHADOWS_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var SHADOWS_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var TERRAIN_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var TERRAIN_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var WATER_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var WATER_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var LIGHTING_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var LIGHTING_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var SPEEDTREE_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var SPEEDTREE_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var FLORA_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var FLORA_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var smoothingLabel:net.wg.gui.components.controls.LabelControl=null;

        public var EFFECTS_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var POST_PROCESSING_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var POST_PROCESSING_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var FAR_PLANELabel:net.wg.gui.components.controls.LabelControl=null;

        public var FAR_PLANEDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var OBJECT_LODLabel:net.wg.gui.components.controls.LabelControl=null;

        public var OBJECT_LODDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var SNIPER_MODE_EFFECTS_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var SNIPER_MODE_EFFECTS_QUALITYDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var fpsPerfomancerCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var SNIPER_MODE_GRASS_ENABLEDCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var VEHICLE_DUST_ENABLEDCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var VEHICLE_TRACES_ENABLEDCheckbox:net.wg.gui.components.controls.CheckBox=null;

        internal var _presets:Object=null;

        internal var graphicsQualityDataProv:Object=null;

        internal var qualityOrder:Array=null;

        internal var useAdvancedGraphic:Boolean=false;

        internal var allowCheckPresets:Boolean=true;

        public var monitorLabel:net.wg.gui.components.controls.LabelControl=null;

        public var monitorDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var fullScreenCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var sizesLabel:net.wg.gui.components.controls.LabelControl=null;

        public var sizesDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var vertSyncCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var aspectRatioLabel:net.wg.gui.components.controls.LabelControl=null;

        public var aspectRatioDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var smoothingDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var tripleBufferedCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var EFFECTS_QUALITYLabel:net.wg.gui.components.controls.LabelControl=null;

        public var gammaLabel:net.wg.gui.components.controls.LabelControl=null;

        public var gammaSlider:net.wg.gui.components.controls.Slider=null;

        public var sl:net.wg.gui.components.controls.Slider=null;

        public var isColorBlindCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var graphicsQualityLabel:net.wg.gui.components.controls.LabelControl=null;

        public var graphicsQualityDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var autodetectQuality:net.wg.gui.components.controls.SoundButtonEx=null;

        public var graficsFieldSet:net.wg.gui.components.advanced.FieldSet=null;

        public var RENDER_PIPELINELabel:net.wg.gui.components.controls.LabelControl=null;
    }
}
