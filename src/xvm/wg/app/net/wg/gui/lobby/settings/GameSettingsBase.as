package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.CheckBox;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.InfoIcon;


   public class GameSettingsBase extends SettingsBaseView
   {
          
      public function GameSettingsBase() {
         super();
      }

      public var fieldSetChat:FieldSet = null;

      public var fieldSetInstructionPanel:FieldSet = null;

      public var fieldSetBattleTypes:FieldSet = null;

      public var fieldSetVibro:FieldSet = null;

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

      public var gameplay_nationsCheckbox:CheckBox = null;

      public var vibroDeviceConnectionStateField:TextField = null;

      public var vibroGainLabel:TextField = null;

      public var vibroGainSlider:Slider = null;

      public var vibroGainValue:LabelControl = null;

      public var vibroEngineLabel:TextField = null;

      public var vibroEngineSlider:Slider = null;

      public var vibroEngineValue:LabelControl = null;

      public var vibroAccelerationLabel:TextField = null;

      public var vibroAccelerationSlider:Slider = null;

      public var vibroAccelerationValue:LabelControl = null;

      public var vibroShotsLabel:TextField = null;

      public var vibroShotsSlider:Slider = null;

      public var vibroShotsValue:LabelControl = null;

      public var vibroHitsLabel:TextField = null;

      public var vibroHitsSlider:Slider = null;

      public var vibroHitsValue:LabelControl = null;

      public var vibroCollisionsLabel:TextField = null;

      public var vibroCollisionsSlider:Slider = null;

      public var vibroCollisionsValue:LabelControl = null;

      public var vibroDamageLabel:TextField = null;

      public var vibroDamageSlider:Slider = null;

      public var vibroDamageValue:LabelControl = null;

      public var vibroGUILabel:TextField = null;

      public var vibroGUISlider:Slider = null;

      public var vibroGUIValue:LabelControl = null;

      public var minimapAlphaSliderLabel:TextField = null;

      public var minimapAlphaSlider:Slider = null;

      public var enablePostMortemEffectCheckbox:CheckBox = null;

      public var enablePostMortemDelayCheckbox:CheckBox = null;

      public var dynamicCameraCheckbox:CheckBox = null;

      public var horStabilizationSnpCheckbox:CheckBox = null;

      public var replayEnabledLabel:TextField = null;

      public var replayEnabledDropDown:DropdownMenu = null;

      public var useServerAimCheckbox:CheckBox = null;

      public var showVehiclesCounterCheckbox:CheckBox = null;

      override protected function configUI() : void {
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
         this.disableBattleChatCheckbox.label = SETTINGS.CHAT_DISABLEBATTLECHAT;
         this.disableBattleChatCheckbox.toolTip = TOOLTIPS.TURNOFFCOMBATCHAT;
         this.disableBattleChatCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.ppShowLevelsCheckbox.label = SETTINGS.GAME_PPSHOWLEVELS;
         this.gameplay_ctfCheckbox.label = SETTINGS.GAMEPLAY_CTF;
         this.gameplay_dominationCheckbox.label = SETTINGS.GAMEPLAY_DOMINATION;
         this.gameplay_assaultCheckbox.label = SETTINGS.GAMEPLAY_ASSAULT;
         this.gameplay_nationsCheckbox.label = SETTINGS.GAMEPLAY_NATIONS;
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
         this.enablePostMortemDelayCheckbox.label = SETTINGS.GAME_ENABLEDELAYPOSTEFFECT;
         this.dynamicCameraCheckbox.label = SETTINGS.GAME_DYNAMICCAMERA;
         this.horStabilizationSnpCheckbox.label = SETTINGS.GAME_HORSTABILIZATIONSNP;
         this.replayEnabledLabel.text = SETTINGS.GAME_REPLAYENABLED;
         this.useServerAimCheckbox.label = SETTINGS.CURSOR_SERVERAIM;
         this.showVehiclesCounterCheckbox.label = SETTINGS.GAME_SHOWVEHICLESCOUNTER;
         super.configUI();
      }
   }

}