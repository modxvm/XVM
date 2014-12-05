package net.wg.gui.lobby.settings
{
    import net.wg.gui.components.advanced.FieldSet;
    import net.wg.gui.components.controls.CheckBox;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Slider;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.controls.LabelControl;
    import net.wg.gui.components.controls.InfoIcon;
    
    public class GameSettingsBase extends SettingsBaseView
    {
        
        public function GameSettingsBase()
        {
            super();
        }
        
        public var fieldSetChat:FieldSet = null;
        
        public var fieldSetBattlePanel:FieldSet = null;
        
        public var fieldSetBattleTypes:FieldSet = null;
        
        public var enableOlFilterCheckbox:CheckBox = null;
        
        public var enableSpamFilterCheckbox:CheckBox = null;
        
        public var showDateMessageCheckbox:CheckBox = null;
        
        public var showTimeMessageCheckbox:CheckBox = null;
        
        public var invitesFromFriendsOnlyCheckbox:CheckBox = null;
        
        public var enableStoreCwsCheckbox:CheckBox = null;
        
        public var enableStoreMwsCheckbox:CheckBox = null;
        
        public var storeReceiverInBattleCheckbox:CheckBox = null;
        
        public var disableBattleChatCheckbox:CheckBox = null;
        
        public var ppShowLevelsCheckbox:CheckBox = null;
        
        public var gameplay_ctfCheckbox:CheckBox = null;
        
        public var gameplay_dominationCheckbox:CheckBox = null;
        
        public var gameplay_assaultCheckbox:CheckBox = null;
        
        public var minimapAlphaSliderLabel:TextField = null;
        
        public var minimapAlphaSlider:Slider = null;
        
        public var enableOpticalSnpEffectCheckbox:CheckBox = null;
        
        public var enablePostMortemEffectCheckbox:CheckBox = null;
        
        public var enablePostMortemDelayCheckbox:CheckBox = null;
        
        public var dynamicCameraCheckbox:CheckBox = null;
        
        public var horStabilizationSnpCheckbox:CheckBox = null;
        
        public var replayEnabledLabel:TextField = null;
        
        public var replayEnabledDropDown:DropdownMenu = null;
        
        public var useServerAimCheckbox:CheckBox = null;
        
        public var showVehiclesCounterCheckbox:CheckBox = null;
        
        public var showMarksOnGunCheckbox:CheckBox = null;
        
        public var showVectorOnMapCheckbox:CheckBox = null;
        
        public var showSectorOnMapCheckbox:CheckBox = null;
        
        public var showVehModelsOnMapLabel:LabelControl = null;
        
        public var showVehModelsOnMapDropDown:DropdownMenu = null;
        
        override protected function configUI() : void
        {
            this.fieldSetChat.label = SETTINGS.GAME_FIELDSET_HEADERCHAT;
            this.fieldSetBattlePanel.label = SETTINGS.GAME_BATTLEPANELSETTINGS;
            this.fieldSetBattleTypes.label = SETTINGS.GAME_FIELDSET_HEADERGAMEPLAY;
            this.enableOlFilterCheckbox.label = SETTINGS.CHAT_CENSORSHIPMESSAGES;
            this.enableSpamFilterCheckbox.label = SETTINGS.CHAT_REMOVESPAM;
            this.showDateMessageCheckbox.label = SETTINGS.CHAT_SHOWDATEMESSAGE;
            this.showTimeMessageCheckbox.label = SETTINGS.CHAT_SHOWTIMEMESSAGE;
            this.invitesFromFriendsOnlyCheckbox.label = SETTINGS.CHAT_INVITESFROMFRIENDSONLY;
            this.enableStoreCwsCheckbox.label = SETTINGS.CHAT_ENABLESTORECHANNELSWINDOWS;
            this.enableStoreMwsCheckbox.label = SETTINGS.CHAT_ENABLESTOREMANAGEMENTWINDOWS;
            this.storeReceiverInBattleCheckbox.label = SETTINGS.CHAT_STORERECEIVERINBATTLE;
            this.disableBattleChatCheckbox.label = SETTINGS.CHAT_DISABLEBATTLECHAT;
            this.disableBattleChatCheckbox.toolTip = TOOLTIPS.TURNOFFCOMBATCHAT;
            this.disableBattleChatCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
            this.ppShowLevelsCheckbox.label = SETTINGS.GAME_PPSHOWLEVELS;
            this.gameplay_ctfCheckbox.label = SETTINGS.GAMEPLAY_CTF;
            this.gameplay_dominationCheckbox.label = SETTINGS.GAMEPLAY_DOMINATION;
            this.gameplay_assaultCheckbox.label = SETTINGS.GAMEPLAY_ASSAULT;
            this.minimapAlphaSliderLabel.text = SETTINGS.MINIMAP_LABELS_ALPHA;
            this.enableOpticalSnpEffectCheckbox.label = SETTINGS.GAME_ENABLEOPTICALSNPEFFECT;
            this.enablePostMortemEffectCheckbox.label = SETTINGS.GAME_ENABLEMORTALPOSTEFFECT;
            this.enablePostMortemDelayCheckbox.label = SETTINGS.GAME_ENABLEDELAYPOSTEFFECT;
            this.dynamicCameraCheckbox.label = SETTINGS.GAME_DYNAMICCAMERA;
            this.horStabilizationSnpCheckbox.label = SETTINGS.GAME_HORSTABILIZATIONSNP;
            this.replayEnabledLabel.text = SETTINGS.GAME_REPLAYENABLED;
            this.useServerAimCheckbox.label = SETTINGS.CURSOR_SERVERAIM;
            this.showVehiclesCounterCheckbox.label = SETTINGS.GAME_SHOWVEHICLESCOUNTER;
            this.showMarksOnGunCheckbox.label = SETTINGS.GAME_SHOWMARKSONGUN;
            this.showMarksOnGunCheckbox.toolTip = TOOLTIPS.SHOWMARKSONGUN;
            this.showMarksOnGunCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
            this.showVectorOnMapCheckbox.label = SETTINGS.GAME_SHOWVECTORONMAP;
            this.showVectorOnMapCheckbox.toolTip = TOOLTIPS.SHOWVECTORONMAP;
            this.showVectorOnMapCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
            this.showSectorOnMapCheckbox.label = SETTINGS.GAME_SHOWSECTORONMAP;
            this.showSectorOnMapCheckbox.toolTip = TOOLTIPS.SHOWSECTORONMAP;
            this.showSectorOnMapCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
            this.showVehModelsOnMapLabel.text = SETTINGS.GAME_SHOWVEHMODELSONMAP;
            this.showVehModelsOnMapLabel.toolTip = TOOLTIPS.SHOWVEHMODELSONMAP;
            this.showVehModelsOnMapLabel.infoIcoType = InfoIcon.TYPE_INFO;
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            this.fieldSetChat.dispose();
            this.fieldSetChat = null;
            this.fieldSetBattlePanel.dispose();
            this.fieldSetBattlePanel = null;
            this.fieldSetBattleTypes.dispose();
            this.fieldSetBattleTypes = null;
            this.enableOlFilterCheckbox.dispose();
            this.enableOlFilterCheckbox = null;
            this.enableSpamFilterCheckbox.dispose();
            this.enableSpamFilterCheckbox = null;
            this.showDateMessageCheckbox.dispose();
            this.showDateMessageCheckbox = null;
            this.showTimeMessageCheckbox.dispose();
            this.showTimeMessageCheckbox = null;
            this.invitesFromFriendsOnlyCheckbox.dispose();
            this.invitesFromFriendsOnlyCheckbox = null;
            this.enableStoreCwsCheckbox.dispose();
            this.enableStoreCwsCheckbox = null;
            this.enableStoreMwsCheckbox.dispose();
            this.enableStoreMwsCheckbox = null;
            this.storeReceiverInBattleCheckbox.dispose();
            this.storeReceiverInBattleCheckbox = null;
            this.disableBattleChatCheckbox.dispose();
            this.disableBattleChatCheckbox = null;
            this.ppShowLevelsCheckbox.dispose();
            this.ppShowLevelsCheckbox = null;
            this.gameplay_ctfCheckbox.dispose();
            this.gameplay_ctfCheckbox = null;
            this.gameplay_dominationCheckbox.dispose();
            this.gameplay_dominationCheckbox = null;
            this.gameplay_assaultCheckbox.dispose();
            this.gameplay_assaultCheckbox = null;
            this.minimapAlphaSliderLabel = null;
            this.minimapAlphaSlider.dispose();
            this.minimapAlphaSlider = null;
            this.enableOpticalSnpEffectCheckbox.dispose();
            this.enableOpticalSnpEffectCheckbox = null;
            this.enablePostMortemEffectCheckbox.dispose();
            this.enablePostMortemEffectCheckbox = null;
            this.enablePostMortemDelayCheckbox.dispose();
            this.enablePostMortemDelayCheckbox = null;
            this.dynamicCameraCheckbox.dispose();
            this.dynamicCameraCheckbox = null;
            this.horStabilizationSnpCheckbox.dispose();
            this.horStabilizationSnpCheckbox = null;
            this.replayEnabledLabel = null;
            this.replayEnabledDropDown.dispose();
            this.replayEnabledDropDown = null;
            this.useServerAimCheckbox.dispose();
            this.useServerAimCheckbox = null;
            this.showVehiclesCounterCheckbox.dispose();
            this.showVehiclesCounterCheckbox = null;
            this.showMarksOnGunCheckbox.dispose();
            this.showMarksOnGunCheckbox = null;
            this.showVectorOnMapCheckbox.dispose();
            this.showVectorOnMapCheckbox = null;
            this.showSectorOnMapCheckbox.dispose();
            this.showSectorOnMapCheckbox = null;
            this.showVehModelsOnMapLabel.dispose();
            this.showVehModelsOnMapLabel = null;
            this.showVehModelsOnMapDropDown.dispose();
            this.showVehModelsOnMapDropDown = null;
            super.onDispose();
        }
    }
}
