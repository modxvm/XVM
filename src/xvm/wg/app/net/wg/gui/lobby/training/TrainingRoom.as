package net.wg.gui.lobby.training
{
   import net.wg.infrastructure.base.meta.impl.TrainingRoomMeta;
   import net.wg.infrastructure.base.meta.ITrainingRoomMeta;
   import scaleform.clik.controls.CoreList;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.data.DataProvider;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.icons.BattleTypeIcon;
   import __AS3__.vec.Vector;
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ILocale;
   import net.wg.utils.IScheduler;
   import net.wg.data.VO.TrainingRoomInfoVO;
   import net.wg.data.VO.UserVO;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import flash.ui.Keyboard;
   import flash.events.KeyboardEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.infrastructure.events.DragDropEvent;
   import net.wg.gui.events.ArenaVoipSettingsEvent;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import net.wg.data.Aliases;
   import scaleform.clik.controls.ListItemRenderer;


   public class TrainingRoom extends TrainingRoomMeta implements ITrainingRoomMeta
   {
          
      public function TrainingRoom() {
         super();
         this._slots = Vector.<InteractiveObject>([this.other,this.team1,this.team2]);
         this.locale = App.utils.locale;
      }

      public static const TRAINING:String = "training";

      private static const SUB_VIEW_MARGIN:Number = 120;

      private static function checkStatus(param1:CoreList, param2:Number, param3:String, param4:String, param5:String, param6:String) : void {
         var _loc8_:TrainingRoomRendererVO = null;
         var _loc7_:IDataProvider = param1.dataProvider;
         for each (_loc8_ in _loc7_)
         {
            if(_loc8_.uid == param2)
            {
               _loc8_.stateString = param3;
               _loc8_.icon = param4;
               _loc8_.vShortName = param5;
               _loc8_.vLevel = param6;
               param1.invalidateData();
               break;
            }
         }
      }

      private static function checkRoster(param1:CoreList, param2:Number, param3:Number) : void {
         var _loc5_:TrainingRoomRendererVO = null;
         var _loc4_:IDataProvider = param1.dataProvider;
         for each (_loc5_ in _loc4_)
         {
            if(_loc5_.uid == param2)
            {
               _loc5_.chatRoster = param3;
               param1.invalidateData();
               break;
            }
         }
      }

      private static function setupDataProvider(param1:Array) : IDataProvider {
         var _loc3_:Object = null;
         var _loc2_:DataProvider = new DataProvider();
         for each (_loc3_ in param1)
         {
            _loc2_.push(new TrainingRoomRendererVO(_loc3_));
         }
         return _loc2_;
      }

      public var team1Label:TextField;

      public var team2Label:TextField;

      public var otherLabel:TextField;

      public var titleField:TextField;

      public var typeField:TextField;

      public var comment:TextField;

      public var map:TextField;

      public var arenaVOIPLabel:TextField;

      public var swapButton:SoundButton;

      public var closeButton:SoundButtonEx;

      public var settingsButton:SoundButtonEx;

      public var startButton:SoundButtonEx;

      public var inviteButton:SoundButtonEx;

      public var minimap:MinimapLobby;

      public var owner:UserNameField;

      public var timeout:TextFieldShort;

      public var maxPlayers:TextFieldShort;

      public var description:TextAreaSimple;

      public var battleIconBig:BattleTypeIcon;

      public var battleIcon:BattleTypeIcon;

      public var team1:DropList;

      public var team2:DropList;

      public var other:DropTileList;

      public var arenaVoipSettings:ArenaVoipSettings;

      private var isCreator:Boolean;

      private var _slots:Vector.<InteractiveObject> = null;

      private var maxPlayersCount:Number = 0;

      private var curPlayersCount:Number = 0;

      private var _dragDropListDelegateCtrlr:IDisposable = null;

      private var _myWidth:Number = 0;

      private var locale:ILocale = null;

      override public function updateStage(param1:Number, param2:Number) : void {
         this.setViewSize(param1,param2);
      }

      override public final function setViewSize(param1:Number, param2:Number) : void {
         this._myWidth = param1;
         invalidateSize();
      }

      public function as_setPlayerStateInTeam1(param1:Number, param2:String, param3:String, param4:String, param5:String) : void {
         checkStatus(this.team1,param1,param2,param3,param4,param5);
      }

      public function as_setPlayerStateInTeam2(param1:Number, param2:String, param3:String, param4:String, param5:String) : void {
         checkStatus(this.team2,param1,param2,param3,param4,param5);
      }

      public function as_setPlayerStateInOther(param1:Number, param2:String, param3:String, param4:String, param5:String) : void {
         checkStatus(this.other,param1,param2,param3,param4,param5);
      }

      public function as_setPlayerChatRosterInTeam1(param1:Number, param2:Number) : void {
         checkRoster(this.team1,param1,param2);
      }

      public function as_setPlayerChatRosterInTeam2(param1:Number, param2:Number) : void {
         checkRoster(this.team2,param1,param2);
      }

      public function as_setPlayerChatRosterInOther(param1:Number, param2:Number) : void {
         checkRoster(this.other,param1,param2);
      }

      public function as_startCoolDownVoiceChat(param1:Number) : void {
         this.arenaVoipSettings.startCoolDownUseCommonVoiceChat(param1);
      }

      public function as_disableControls(param1:Boolean) : void {
         this.disableControls(param1);
      }

      public function as_startCoolDownSetting(param1:Number) : void {
         var _loc2_:IScheduler = App.utils.scheduler;
         _loc2_.cancelTask(this.stopCoolDownSetting);
         this.settingsButton.enabled = false;
         _loc2_.scheduleTask(this.stopCoolDownSetting,param1 * 1000);
      }

      public function as_startCoolDownSwapButton(param1:Number) : void {
         var _loc2_:IScheduler = null;
         _loc2_ = App.utils.scheduler;
         _loc2_.cancelTask(this.stopCoolDownSwapButton);
         this.swapButton.enabled = false;
         _loc2_.scheduleTask(this.stopCoolDownSwapButton,param1 * 1000);
      }

      public function as_disableStartButton(param1:Boolean) : void {
         this.startButton.enabled = !param1;
      }

      public function as_enabledCloseButton(param1:Boolean) : void {
         this.closeButton.enabled = param1;
      }

      public function as_setTeam1(param1:Array) : void {
         this.team1.dataProvider = setupDataProvider(param1);
         this.team1Label.htmlText = this.locale.makeString(MENU.TRAINING_INFO_TEAM1LABEL);
         this.team1Label.htmlText = this.team1Label.htmlText + (" [<font color=\"#FFFFFF\">" + param1.length + "</font>]");
         this.countPlayers();
      }

      public function as_setTeam2(param1:Array) : void {
         this.team2.dataProvider = setupDataProvider(param1);
         this.team2Label.htmlText = this.locale.makeString(MENU.TRAINING_INFO_TEAM2LABEL);
         this.team2Label.htmlText = this.team2Label.htmlText + (" [<font color=\"#FFFFFF\">" + param1.length + "</font>]");
         this.countPlayers();
      }

      public function as_setOther(param1:Array) : void {
         this.other.dataProvider = setupDataProvider(param1);
         this.otherLabel.htmlText = this.locale.makeString(MENU.TRAINING_INFO_OTHERLABEL);
         this.otherLabel.htmlText = this.otherLabel.htmlText + (" [<font color=\"#FFFFFF\">" + param1.length + "</font>]");
         this.countPlayers();
      }

      public function as_setArenaVoipChannels(param1:Number) : void {
         this.arenaVoipSettings.setUseArenaVoip(param1);
      }

      public function as_setInfo(param1:Object) : void {
         var _loc2_:TrainingRoomInfoVO = new TrainingRoomInfoVO(param1);
         if(this.isCreator != _loc2_.isCreator)
         {
            this.isCreator = _loc2_.isCreator;
            if(this.isCreator)
            {
               this.createDragController();
            }
            else
            {
               this._dragDropListDelegateCtrlr.dispose();
               this._dragDropListDelegateCtrlr = null;
            }
         }
         this.comment.text = _loc2_.comment;
         this.timeout.label = _loc2_.roundLenString;
         this.maxPlayersCount = _loc2_.maxPlayersCount;
         this.maxPlayers.label = this.curPlayersCount + "/" + this.maxPlayersCount;
         this.map.htmlText = _loc2_.arenaName;
         this.titleField.htmlText = _loc2_.title;
         this.typeField.htmlText = _loc2_.arenaSubType;
         this.owner.userVO = new UserVO(
            {
               "accID":-1,
               "uid":-1,
               "fullName":_loc2_.creatorFullName,
               "userName":_loc2_.creator,
               "clanAbbrev":_loc2_.creatorClan,
               "region":_loc2_.creatorRegion,
               "igrType":_loc2_.creatorIgrType
            }
         );
         this.minimap.setMapS(_loc2_.arenaTypeID);
         this.description.position = 0;
         this.description.htmlText = _loc2_.description;
         this.arenaVoipSettings.setCanChangeArenaVOIP(_loc2_.canChangeArenaVOIP);
         this.arenaVoipSettings.setUseArenaVoip(_loc2_.arenaVoipChannels);
         invalidate(InvalidationType.STATE);
      }

      private function createDragController() : void {
         var _loc1_:Class = App.utils.classFactory.getClass(Linkages.TRAINING_DRAG_DELEGATE);
         assertNull(this._dragDropListDelegateCtrlr,"_dragDropListDelegateCtrlr");
         this._dragDropListDelegateCtrlr = new TrainingDragController(this._slots,_loc1_,Linkages.PLAYER_ELEMENT_UI);
      }

      public function as_updateComment(param1:String) : void {
         this.comment.text = param1;
      }

      public function as_updateTimeout(param1:String) : void {
         this.timeout.label = param1;
      }

      public function as_updateMap(param1:Number, param2:Number, param3:String, param4:String, param5:String, param6:String) : void {
         this.minimap.setMapS(param1);
         this.maxPlayers.label = this.curPlayersCount + "/" + param2;
         this.map.htmlText = param3;
         this.titleField.htmlText = param4;
         this.typeField.htmlText = param5;
         this.description.position = 0;
         this.description.htmlText = param6;
      }

      override protected function configUI() : void {
         super.configUI();
         this.updateStage(App.appWidth,App.appHeight);
         this.addListeners();
         this.battleIcon.gotoAndStop(TrainingRoom.TRAINING);
         this.battleIconBig.gotoAndStop(TrainingRoom.TRAINING);
         this.description.autoScroll = false;
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
      }

      private function handleEscape(param1:InputEvent) : void {
         onEscapeS();
      }

      private function addListeners() : void {
         this.settingsButton.addEventListener(ButtonEvent.CLICK,this.onSettingsButtonClick);
         this.startButton.addEventListener(ButtonEvent.CLICK,this.onStartButtonClick);
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.closeTraining);
         this.inviteButton.addEventListener(ButtonEvent.CLICK,this.showTrainingInvitations);
         this.swapButton.addEventListener(ButtonEvent.CLICK,this.onSwapBtnClick);
         this.other.addEventListener(DragDropEvent.END_DROP,this.onDrop);
         this.team1.addEventListener(DragDropEvent.END_DROP,this.onDrop);
         this.team2.addEventListener(DragDropEvent.END_DROP,this.onDrop);
         this.arenaVoipSettings.addEventListener(ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT,this.selectCommonVoiceChatHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.startSpeak);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.stoptSpeak);
      }

      override protected function onPopulate() : void {
         var _loc1_:* = false;
         super.onPopulate();
         registerComponent(this.minimap,Aliases.LOBBY_MINIMAP);
         this.setTeamsInfo();
         _loc1_ = App.voiceChatMgr.isYYS();
         this.arenaVoipSettings.visible = (App.voiceChatMgr.isVOIPEnabledS()) || (_loc1_);
         this.arenaVOIPLabel.text = (App.voiceChatMgr.isVOIPEnabledS()) || (_loc1_)?MENU.TRAINING_INFO_VOICECHAT:"";
      }

      override protected function onDispose() : void {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
         this.removeListeners();
         this.disposeComponents();
         this.locale = null;
         if(this._dragDropListDelegateCtrlr)
         {
            this._dragDropListDelegateCtrlr.dispose();
            this._dragDropListDelegateCtrlr = null;
         }
         if(this._slots)
         {
            this._slots.splice(0,this._slots.length);
            this._slots = null;
         }
         App.utils.scheduler.cancelTask(this.stopCoolDownSwapButton);
         App.utils.scheduler.cancelTask(this.stopCoolDownSetting);
         super.onDispose();
      }

      private function disposeComponents() : void {
         this.team1Label = null;
         this.team2Label = null;
         this.otherLabel = null;
         this.titleField = null;
         this.typeField = null;
         this.comment = null;
         this.map = null;
         this.arenaVOIPLabel = null;
         this.swapButton.dispose();
         this.swapButton = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.settingsButton.dispose();
         this.settingsButton = null;
         this.startButton.dispose();
         this.startButton = null;
         this.inviteButton.dispose();
         this.inviteButton = null;
         this.owner.dispose();
         this.owner = null;
         this.timeout.dispose();
         this.timeout = null;
         this.maxPlayers.dispose();
         this.maxPlayers = null;
         this.description.dispose();
         this.description = null;
         this.battleIconBig.dispose();
         this.battleIconBig = null;
         this.battleIcon.dispose();
         this.battleIcon = null;
         this.team1.dispose();
         this.team1 = null;
         this.team2.dispose();
         this.team2 = null;
         this.other.dispose();
         this.other = null;
         this.arenaVoipSettings.dispose();
         this.arenaVoipSettings = null;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            x = this._myWidth - _originalWidth >> 1;
            y = -SUB_VIEW_MARGIN;
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(!this.isCreator)
            {
               this.settingsButton.visible = false;
               this.startButton.visible = false;
               this.closeButton.label = MENU.TRAINING_INFO_EXITBUTTON;
               this.inviteButton.visible = false;
               this.swapButton.visible = false;
            }
         }
      }

      private function removeListeners() : void {
         this.other.removeEventListener(DragDropEvent.END_DROP,this.onDrop);
         this.team1.removeEventListener(DragDropEvent.END_DROP,this.onDrop);
         this.team2.removeEventListener(DragDropEvent.END_DROP,this.onDrop);
         this.settingsButton.removeEventListener(ButtonEvent.CLICK,this.onSettingsButtonClick);
         this.startButton.removeEventListener(ButtonEvent.CLICK,this.onStartButtonClick);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.closeTraining);
         this.inviteButton.removeEventListener(ButtonEvent.CLICK,this.showTrainingInvitations);
         this.swapButton.removeEventListener(ButtonEvent.CLICK,this.onSwapBtnClick);
         this.arenaVoipSettings.removeEventListener(ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT,this.selectCommonVoiceChatHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.startSpeak);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.stoptSpeak);
      }

      private function setSpeaking(param1:Boolean, param2:Number) : void {
         var _loc3_:CoreList = null;
         var _loc4_:IDataProvider = null;
         var _loc5_:TrainingRoomRendererVO = null;
         for each (_loc3_ in this._slots)
         {
            _loc4_ = _loc3_.dataProvider;
            for each (_loc5_ in _loc4_)
            {
               if(_loc5_.uid == param2)
               {
                  _loc5_.isPlayerSpeaking = param1;
                  _loc3_.invalidateData();
               }
            }
         }
      }

      private function disableControls(param1:Boolean) : void {
         this.swapButton.enabled = !param1;
         this.closeButton.enabled = !param1;
         this.settingsButton.enabled = !param1;
         this.startButton.enabled = !param1;
         this.inviteButton.enabled = !param1;
         this.arenaVoipSettings.enabled = !param1;
         if(param1)
         {
            if(this._dragDropListDelegateCtrlr)
            {
               this._dragDropListDelegateCtrlr.dispose();
               this._dragDropListDelegateCtrlr = null;
            }
         }
         else
         {
            if(!this._dragDropListDelegateCtrlr)
            {
               this.createDragController();
            }
         }
      }

      private function stopCoolDownSwapButton() : void {
         this.swapButton.enabled = true;
      }

      private function stopCoolDownSetting() : void {
         this.settingsButton.enabled = true;
      }

      private function setTeamsInfo() : void {
         this.team1Label.htmlText = this.locale.makeString(MENU.TRAINING_INFO_TEAM1LABEL);
         this.team1Label.htmlText = this.team1Label.htmlText + (" [<font color=\"#FFFFFF\">" + 0 + "</font>]");
         this.team2Label.htmlText = this.locale.makeString(MENU.TRAINING_INFO_TEAM2LABEL);
         this.team2Label.htmlText = this.team2Label.htmlText + (" [<font color=\"#FFFFFF\">" + 0 + "</font>]");
         this.otherLabel.htmlText = this.locale.makeString(MENU.TRAINING_INFO_OTHERLABEL);
         this.otherLabel.htmlText = this.otherLabel.htmlText + (" [<font color=\"#FFFFFF\">" + 0 + "</font>]");
      }

      private function countPlayers() : void {
         var _loc1_:CoreList = null;
         this.curPlayersCount = 0;
         for each (_loc1_ in this._slots)
         {
            this.curPlayersCount = this.curPlayersCount + _loc1_.dataProvider.length;
         }
         this.maxPlayers.label = this.curPlayersCount + "/" + this.maxPlayersCount;
         App.toolTipMgr.hide();
         App.contextMenuMgr.hide();
      }

      private function startSpeak(param1:VoiceChatEvent) : void {
         this.setSpeaking(true,param1.getAccountDBID());
      }

      private function stoptSpeak(param1:VoiceChatEvent) : void {
         this.setSpeaking(false,param1.getAccountDBID());
      }

      private function onDrop(param1:DragDropEvent) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         if(param1.sender != param1.receiver)
         {
            _loc2_ = ListItemRenderer(param1.draggedItem).data.accID;
            _loc3_ = this._slots.indexOf(param1.receiver);
            changeTeamS(_loc2_,_loc3_);
         }
      }

      private function selectCommonVoiceChatHandler(param1:ArenaVoipSettingsEvent) : void {
         selectCommonVoiceChatS(param1.index);
      }

      private function onSettingsButtonClick(param1:ButtonEvent) : void {
         showTrainingSettingsS();
      }

      private function onStartButtonClick(param1:ButtonEvent) : void {
         startTrainingS();
      }

      private function closeTraining(param1:ButtonEvent) : void {
         closeTrainingRoomS();
      }

      private function showTrainingInvitations(param1:ButtonEvent) : void {
         showPrebattleInvitationsFormS();
      }

      private function onSwapBtnClick(param1:ButtonEvent) : void {
         swapTeamsS();
      }
   }

}