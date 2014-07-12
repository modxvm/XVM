package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.CheckBox;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Slider;
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
      
      override protected function configUI() : void {
         this.fieldSetChat.label = SETTINGS.GAME_FIELDSET_HEADERCHAT;
         this.fieldSetInstructionPanel.label = SETTINGS.GAME_PLAYERPANELSETTINGS;
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
         super.configUI();
      }
   }
}
