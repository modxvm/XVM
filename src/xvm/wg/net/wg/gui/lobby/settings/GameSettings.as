package net.wg.gui.lobby.settings 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.settings.evnts.*;
    import net.wg.gui.lobby.settings.vo.*;
    import scaleform.clik.events.*;
    
    public class GameSettings extends net.wg.gui.lobby.settings.SettingsBaseView
    {
        public function GameSettings()
        {
            super();
            return;
        }

        public override function toString():String
        {
            return "[WG GameSettings " + name + "]";
        }

        protected override function setData(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc4:*=null;
            var loc5:*=false;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=false;
            this.vibroContolsList = [];
            var loc10:*=0;
            var loc11:*=_data;
            for (loc1 in loc11) 
            {
                loc4 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc1]);
                if (this[loc1 + loc4.type]) 
                {
                    loc5 = !(loc4.current == null || loc4.readOnly);
                    var loc12:*=loc4.type;
                    switch (loc12) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                            (loc6 = net.wg.gui.components.controls.CheckBox(this[loc1 + loc4.type])).selected = loc4.current;
                            loc6.enabled = loc5;
                            loc6.addEventListener(flash.events.Event.SELECT, this.onCheckBoxSelected);
                            break;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                            (loc7 = net.wg.gui.components.controls.Slider(this[loc1 + loc4.type])).value = loc4.current;
                            loc7.enabled = loc5;
                            loc7.addEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                            if (loc4.hasValue && this[loc1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]) 
                                (loc8 = this[loc1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]).text = loc4.current;
                            break;
                    }
                    if (loc4.isDependOn) 
                    {
                        if (loc4.isDependOn == net.wg.gui.lobby.settings.SettingsConfig.VIBRO_IS_CONNECTED) 
                            this.vibroContolsList.push(loc1);
                        loc9 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc4.isDependOn]).current;
                        this.showHideControl(loc1, loc4, loc9);
                    }
                    continue;
                }
                if (loc4.readOnly) 
                    continue;
                DebugUtils.LOG_WARNING("ERROR in" + this + " control " + (loc1 + loc4.type) + " can not find");
            }
            loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data.vibroIsConnected).current;
            this.vibroDeviceConnectionStateField.text = loc2 ? SETTINGS.VIBRO_DEVICE_STATE_CONNECTED : SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
            this.vibroDeviceConnectionStateField.visible = loc2;
            this.fieldSetVibro.visible = loc2;
            var loc3:*=net.wg.gui.lobby.settings.vo.SettingsControlProp(net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.GRAPHIC_SETTINGS].POST_PROCESSING_QUALITY).current;
            this.enablePostMortemEffectCheckbox.enabled = !(loc3 == 4);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.fieldSetChat.label = SETTINGS.GAME_FIELDSET_HEADERCHAT;
            this.fieldSetInstructionPanel.label = SETTINGS.GAME_PLAYERPANELSETTINGS;
            this.fieldSetBattleTypes.label = SETTINGS.GAME_FIELDSET_HEADERGAMEPLAY;
            this.fieldSetVibro.label = SETTINGS.VIBRO_FIELDSET_HEADER;
            this.enableOlFilterCheckbox.label = SETTINGS.CHAT_CENSORSHIPMESSAGES;
            this.enableSpamFilterCheckbox.label = SETTINGS.CHAT_REMOVESPAM;
            this.showDateMessageCheckbox.label = SETTINGS.CHAT_SHOWDATEMESSAGE;
            this.showTimeMessageCheckbox.label = SETTINGS.CHAT_SHOWTIMEMESSAGE;
            this.invitesFromFriendsOnlyCheckbox.label = SETTINGS.CHAT_INVITESFROMFRIENDSONLY;
            this.enableStoreCwsCheckbox.label = SETTINGS.CHAT_ENABLESTORECHANNELSWINDOWS;
            this.enableStoreMwsCheckbox.label = SETTINGS.CHAT_ENABLESTOREMANAGEMENTWINDOWS;
            this.storeReceiverInBattleCheckbox.label = SETTINGS.CHAT_STORERECEIVERINBATTLE;
            this.ppShowLevelsCheckbox.label = SETTINGS.GAME_PPSHOWLEVELS;
            this.gameplay_ctfCheckbox.label = SETTINGS.GAMEPLAY_CTF;
            this.gameplay_dominationCheckbox.label = SETTINGS.GAMEPLAY_DOMINATION;
            this.gameplay_assaultCheckbox.label = SETTINGS.GAMEPLAY_ASSAULT;
            this.vibroDeviceConnectionStateField.text = SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
            this.vibroGainLabel.text = SETTINGS.VIBRO_LABELS_GAIN;
            this.vibroEngineLabel.text = SETTINGS.VIBRO_LABELS_ENGINE;
            this.vibroAccelerationLabel.text = SETTINGS.VIBRO_LABELS_ACCELERATION;
            this.vibroShotsLabel.text = SETTINGS.VIBRO_LABELS_SHOTS;
            this.vibroHitsLabel.text = SETTINGS.VIBRO_LABELS_HITS;
            this.vibroCollisionsLabel.text = SETTINGS.VIBRO_LABELS_COLLISIONS;
            this.vibroDamageLabel.text = SETTINGS.VIBRO_LABELS_DAMAGE;
            this.vibroGUILabel.text = SETTINGS.VIBRO_LABELS_GUI;
            this.minimapAlphaSliderLabel.text = SETTINGS.MINIMAP_LABELS_ALPHA;
            this.enablePostMortemEffectCheckbox.label = SETTINGS.GAME_ENABLEMORTALPOSTEFFECT;
            this.dynamicCameraCheckbox.label = SETTINGS.GAME_DYNAMICCAMERA;
            this.replayEnabledCheckbox.label = SETTINGS.GAME_REPLAYENABLED;
            this.useServerAimCheckbox.label = SETTINGS.CURSOR_SERVERAIM;
            this.showVehiclesCounterCheckbox.label = SETTINGS.GAME_SHOWVEHICLESCOUNTER;
            super.configUI();
            return;
        }

        public override function update(arg1:Object):void
        {
            super.update(arg1);
            return;
        }

        internal function showHideControl(arg1:String, arg2:net.wg.gui.lobby.settings.vo.SettingsControlProp, arg3:Boolean):void
        {
            if (this[arg1 + arg2.type]) 
                this[arg1 + arg2.type].visible = arg3;
            if (arg2.hasLabel && this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_LABEL]) 
                this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_LABEL].visible = arg3;
            if (arg2.hasValue && this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]) 
                this[arg1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE].visible = arg3;
            return;
        }

        internal function onSliderValueChanged(arg1:scaleform.clik.events.SliderEvent):void
        {
            var loc4:*=null;
            var loc1:*=net.wg.gui.components.controls.Slider(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER);
            var loc3:*;
            if ((loc3 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc2])).hasValue && this[loc2 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]) 
                (loc4 = net.wg.gui.components.controls.LabelControl(this[loc2 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE])).text = loc1.value.toString();
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, loc1.value));
            return;
        }

        internal function onCheckBoxSelected(arg1:flash.events.Event):void
        {
            var loc1:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(net.wg.gui.components.controls.CheckBox(arg1.target).name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX);
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc1, net.wg.gui.components.controls.CheckBox(arg1.target).selected));
            return;
        }

        public function onVibroManagerConnect():void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=net.wg.gui.lobby.settings.vo.SettingsControlProp(net.wg.gui.lobby.settings.SettingsConfig.settingsData[net.wg.gui.lobby.settings.SettingsConfig.GAME_SETTINGS].vibroIsConnected).current;
            if (this.vibroContolsList) 
            {
                loc2 = this.vibroContolsList.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc4 = this.vibroContolsList[loc3];
                    loc5 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc4]);
                    this.showHideControl(loc4, loc5, loc1);
                    ++loc3;
                }
            }
            this.vibroDeviceConnectionStateField.text = loc1 ? SETTINGS.VIBRO_DEVICE_STATE_CONNECTED : SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
            this.vibroDeviceConnectionStateField.visible = loc1;
            this.fieldSetVibro.visible = loc1;
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (_data) 
            {
                var loc5:*=0;
                var loc6:*=_data;
                label236: for (loc1 in loc6) 
                {
                    if (!this[loc1 + _data[loc1].type]) 
                        continue;
                    loc2 = _data[loc1];
                    var loc7:*=loc2.type;
                    switch (loc7) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                            loc3 = this[loc1 + loc2.type];
                            loc3.removeEventListener(flash.events.Event.SELECT, this.onCheckBoxSelected);
                            continue label236;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                            (loc4 = this[loc1 + loc2.type]).removeEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                            continue label236;
                    }
                }
            }
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            return;
        }

        public var enableStoreCwsCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var enableStoreMwsCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var storeReceiverInBattleCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var ppShowLevelsCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var gameplay_ctfCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var gameplay_dominationCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var gameplay_assaultCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var vibroDeviceConnectionStateField:flash.text.TextField=null;

        public var vibroGainLabel:flash.text.TextField=null;

        public var vibroGainSlider:net.wg.gui.components.controls.Slider=null;

        public var vibroGainValue:net.wg.gui.components.controls.LabelControl=null;

        public var vibroEngineLabel:flash.text.TextField=null;

        public var vibroEngineSlider:net.wg.gui.components.controls.Slider=null;

        public var vibroEngineValue:net.wg.gui.components.controls.LabelControl=null;

        public var vibroAccelerationLabel:flash.text.TextField=null;

        public var vibroAccelerationSlider:net.wg.gui.components.controls.Slider=null;

        public var vibroAccelerationValue:net.wg.gui.components.controls.LabelControl=null;

        public var vibroShotsLabel:flash.text.TextField=null;

        public var vibroShotsSlider:net.wg.gui.components.controls.Slider=null;

        public var enableSpamFilterCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var vibroHitsLabel:flash.text.TextField=null;

        public var vibroHitsSlider:net.wg.gui.components.controls.Slider=null;

        public var vibroHitsValue:net.wg.gui.components.controls.LabelControl=null;

        public var vibroCollisionsLabel:flash.text.TextField=null;

        public var vibroCollisionsSlider:net.wg.gui.components.controls.Slider=null;

        public var vibroCollisionsValue:net.wg.gui.components.controls.LabelControl=null;

        public var vibroDamageLabel:flash.text.TextField=null;

        public var vibroDamageSlider:net.wg.gui.components.controls.Slider=null;

        public var vibroDamageValue:net.wg.gui.components.controls.LabelControl=null;

        public var vibroGUILabel:flash.text.TextField=null;

        public var vibroGUISlider:net.wg.gui.components.controls.Slider=null;

        public var vibroGUIValue:net.wg.gui.components.controls.LabelControl=null;

        public var minimapAlphaSliderLabel:flash.text.TextField=null;

        public var minimapAlphaSlider:net.wg.gui.components.controls.Slider=null;

        public var enablePostMortemEffectCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var bgFrom:flash.display.Sprite=null;

        public var replayEnabledCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var useServerAimCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var showVehiclesCounterCheckbox:net.wg.gui.components.controls.CheckBox=null;

        internal var vibroContolsList:Array=null;

        public var fieldSetChat:net.wg.gui.components.advanced.FieldSet=null;

        public var fieldSetInstructionPanel:net.wg.gui.components.advanced.FieldSet=null;

        public var vibroShotsValue:net.wg.gui.components.controls.LabelControl=null;

        public var fieldSetBattleTypes:net.wg.gui.components.advanced.FieldSet=null;

        public var fieldSetVibro:net.wg.gui.components.advanced.FieldSet=null;

        public var enableOlFilterCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var showDateMessageCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var showTimeMessageCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var invitesFromFriendsOnlyCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var dynamicCameraCheckbox:net.wg.gui.components.controls.CheckBox=null;
    }
}
