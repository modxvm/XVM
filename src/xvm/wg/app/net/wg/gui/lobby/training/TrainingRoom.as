package net.wg.gui.lobby.training
{
   import net.wg.infrastructure.base.meta.impl.TrainingRoomMeta;
   import net.wg.infrastructure.base.meta.ITrainingRoomMeta;
   import scaleform.clik.core.UIComponent;
   import net.wg.utils.IScheduler;
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
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ILocale;
   import net.wg.data.VO.TrainingRoomInfoVO;
   import net.wg.data.VO.UserVO;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import flash.ui.Keyboard;
   import flash.events.KeyboardEvent;
   import flash.text.TextFieldAutoSize;
   import flash.events.Event;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.infrastructure.events.DropEvent;
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
      
      private static function startDisableCoolDown(param1:Function, param2:Number, param3:UIComponent) : void {
         var _loc4_:IScheduler = App.utils.scheduler;
         _loc4_.cancelTask(param1);
         param3.enabled = false;
         _loc4_.scheduleTask(param1,param2 * 1000);
      }
      
      private static function checkStatus(param1:CoreList, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:int) : void {
         var _loc9_:TrainingRoomRendererVO = null;
         var _loc8_:IDataProvider = param1.dataProvider;
         for each(_loc9_ in _loc8_)
         {
            if(_loc9_.dbID == param2)
            {
               _loc9_.stateString = param3;
               _loc9_.icon = param4;
               _loc9_.vShortName = param5;
               _loc9_.vLevel = param6;
               _loc9_.igrType = param7;
               param1.invalidateData();
               break;
            }
         }
      }
      
      private static function checkRoster(param1:CoreList, param2:Number, param3:Number) : void {
         var _loc5_:TrainingRoomRendererVO = null;
         var _loc4_:IDataProvider = param1.dataProvider;
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.dbID == param2)
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
         for each(_loc3_ in param1)
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
      
      public var observerButton:ObserverButtonComponent;
      
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
      
      public function as_setPlayerStateInTeam1(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int) : void {
         checkStatus(this.team1,param1,param2,param3,param4,param5,param6);
      }
      
      public function as_setPlayerStateInTeam2(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int) : void {
         checkStatus(this.team2,param1,param2,param3,param4,param5,param6);
      }
      
      public function as_setPlayerStateInOther(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int) : void {
         checkStatus(this.other,param1,param2,param3,param4,param5,param6);
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
         startDisableCoolDown(this.finishDisable_settingsButton_CoolDownHandler,param1,this.settingsButton);
      }
      
      public function as_startCoolDownSwapButton(param1:Number) : void {
         startDisableCoolDown(this.finishDisable_swapButton_CoolDownHandler,param1,this.swapButton);
      }
      
      public function as_startCoolDownObserver(param1:Number) : void {
         startDisableCoolDown(this.finishDisable_observerButton_CoolDownHandler,param1,this.observerButton);
      }
      
      private function finishDisable_settingsButton_CoolDownHandler() : void {
         this.settingsButton.enabled = true;
      }
      
      private function finishDisable_swapButton_CoolDownHandler() : void {
         this.swapButton.enabled = true;
      }
      
      private function finishDisable_observerButton_CoolDownHandler() : void {
         this.observerButton.enabled = true;
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
               "dbID":-1,
               "fullName":_loc2_.creatorFullName,
               "userName":_loc2_.creator,
               "clanAbbrev":_loc2_.creatorClan,
               "region":_loc2_.creatorRegion,
               "igrType":_loc2_.creatorIgrType
            });
         this.minimap.setMapS(_loc2_.arenaTypeID);
         this.description.position = 0;
         this.description.htmlText = _loc2_.description;
         this.arenaVoipSettings.setUseArenaVoip(_loc2_.arenaVoipChannels);
         this.arenaVoipSettings.setCanChangeArenaVOIP(_loc2_.canChangeArenaVOIP);
         invalidate(InvalidationType.STATE);
         this.observerButton.visible = _loc2_.isObserverModeEnabled;
         if(_loc2_.isObserverModeEnabled)
         {
            this.observerButton.addEventListener(ObserverButtonComponent.SELECTED,this.observerChangedHandler,false,0,true);
         }
      }
      
      private function createDragController() : void {
         var _loc1_:Class = App.utils.classFactory.getClass(Linkages.TRAINING_DRAG_DELEGATE);
         assertNull(this._dragDropListDelegateCtrlr,"_dragDropListDelegateCtrlr");
         this._dragDropListDelegateCtrlr = new TrainingDragController(this._slots,_loc1_,Linkages.PLAYER_ELEMENT_UI,this.isSlotDroppable);
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
         this.timeout.buttonMode = false;
         this.timeout.autoSize = this.maxPlayers.autoSize = TextFieldAutoSize.LEFT;
         this.maxPlayers.buttonMode = false;
      }
      
      private function observerChangedHandler(param1:Event) : void {
         selectObserverS(this.observerButton.selected);
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
         this.other.addEventListener(DropEvent.END_DROP,this.onDrop);
         this.team1.addEventListener(DropEvent.END_DROP,this.onDrop);
         this.team2.addEventListener(DropEvent.END_DROP,this.onDrop);
         this.arenaVoipSettings.addEventListener(ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT,this.selectCommonVoiceChatHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.startSpeak);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.stoptSpeak);
      }
      
      override protected function onPopulate() : void {
         super.onPopulate();
         if((canAssignToTeamS(1)) || (canAssignToTeamS(2)) || (canChangePlayerTeamS()))
         {
            this.createDragController();
         }
         else if(this._dragDropListDelegateCtrlr)
         {
            this._dragDropListDelegateCtrlr.dispose();
            this._dragDropListDelegateCtrlr = null;
         }
         
         registerComponent(this.minimap,Aliases.LOBBY_MINIMAP);
         this.setTeamsInfo();
         var _loc1_:Boolean = App.voiceChatMgr.isYYS();
         this.arenaVoipSettings.visible = (App.voiceChatMgr.isVOIPEnabledS()) || (_loc1_);
         this.arenaVOIPLabel.text = (App.voiceChatMgr.isVOIPEnabledS()) || (_loc1_)?MENU.TRAINING_INFO_VOICECHAT:"";
      }
      
      override protected function onDispose() : void {
         this.observerButton.removeEventListener(ObserverButtonComponent.SELECTED,this.observerChangedHandler);
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
         App.utils.scheduler.cancelTask(this.finishDisable_swapButton_CoolDownHandler);
         App.utils.scheduler.cancelTask(this.finishDisable_settingsButton_CoolDownHandler);
         App.utils.scheduler.cancelTask(this.finishDisable_observerButton_CoolDownHandler);
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
         this.observerButton.dispose();
         this.observerButton = null;
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
            this.inviteButton.visible = canSendInviteS();
            this.swapButton.visible = canChangePlayerTeamS();
            this.settingsButton.visible = canChangeSettingS();
            this.startButton.visible = canStartBattleS();
            if(!canDestroyRoomS())
            {
               this.closeButton.label = MENU.TRAINING_INFO_EXITBUTTON;
            }
         }
      }
      
      private function removeListeners() : void {
         this.other.removeEventListener(DropEvent.END_DROP,this.onDrop);
         this.team1.removeEventListener(DropEvent.END_DROP,this.onDrop);
         this.team2.removeEventListener(DropEvent.END_DROP,this.onDrop);
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
         for each(_loc3_ in this._slots)
         {
            _loc4_ = _loc3_.dataProvider;
            for each(_loc5_ in _loc4_)
            {
               if(_loc5_.dbID == param2)
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
         this.observerButton.enabled = !param1;
         if(param1)
         {
            if(this._dragDropListDelegateCtrlr)
            {
               this._dragDropListDelegateCtrlr.dispose();
               this._dragDropListDelegateCtrlr = null;
            }
         }
         else if(!this._dragDropListDelegateCtrlr && ((canAssignToTeamS(1)) || (canAssignToTeamS(2)) || (canChangePlayerTeamS())))
         {
            this.createDragController();
         }
         
      }
      
      private function isSlotDroppable(param1:uint, param2:uint) : Boolean {
         var _loc3_:uint = getPlayerTeamS(param1);
         if(_loc3_ == param2)
         {
            return true;
         }
         if(param2 == 0 && (canAssignToTeamS(_loc3_)))
         {
            return true;
         }
         if(!(param2 == 0) && (canChangePlayerTeamS()))
         {
            return true;
         }
         return false;
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
         for each(_loc1_ in this._slots)
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
      
      private function onDrop(param1:DropEvent) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         if(param1.sender != param1.receiver)
         {
            _loc2_ = ListItemRenderer(param1.draggedItem).data.accID;
            _loc3_ = this._slots.indexOf(param1.receiver);
            if(this.isSlotDroppable(_loc2_,_loc3_))
            {
               changeTeamS(_loc2_,_loc3_);
            }
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
      
      public function as_setObserver(param1:Boolean) : void {
         this.observerButton.selected = param1;
      }
   }
}
