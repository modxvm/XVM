package net.wg.gui.lobby.training 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import net.wg.data.*;
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.icons.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class TrainingRoom extends net.wg.infrastructure.base.meta.impl.TrainingRoomMeta implements net.wg.infrastructure.base.meta.ITrainingRoomMeta
    {
        public function TrainingRoom()
        {
            super();
            this._slots = Vector.<flash.display.InteractiveObject>([this.other, this.team1, this.team2]);
            this.locale = App.utils.locale;
            return;
        }

        public function as_setArenaVoipChannels(arg1:Number):void
        {
            this.arenaVoipSettings.setUseArenaVoip(arg1);
            return;
        }

        public function as_setInfo(arg1:Object):void
        {
            var loc2:*=null;
            var loc1:*=new net.wg.data.VO.TrainingRoomInfoVO(arg1);
            if (this.isCreator != loc1.isCreator) 
            {
                this.isCreator = loc1.isCreator;
                loc2 = App.utils.classFactory.getClass(net.wg.data.constants.Linkages.TRAINING_DRAG_DELEGATE);
                if (this.isCreator) 
                {
                    assertNull(this._dragDropListDelegateCtrlr, "_dragDropListDelegateCtrlr");
                    this._dragDropListDelegateCtrlr = new net.wg.gui.lobby.training.TrainingDragController(this._slots, loc2, net.wg.data.constants.Linkages.PLAYER_ELEMENT_UI);
                }
                else 
                {
                    this._dragDropListDelegateCtrlr.dispose();
                    this._dragDropListDelegateCtrlr = null;
                }
            }
            this.comment.text = loc1.comment;
            this.timeout.label = loc1.roundLenString;
            this.maxPlayersCount = loc1.maxPlayersCount;
            this.maxPlayers.label = this.curPlayersCount + "/" + this.maxPlayersCount;
            this.map.htmlText = loc1.arenaName;
            this.titleField.htmlText = loc1.title;
            this.typeField.htmlText = loc1.arenaSubType;
            this.owner.label = loc1.creator;
            this.minimap.setMapS(loc1.arenaTypeID);
            this.description.position = 0;
            this.description.htmlText = loc1.description;
            this.arenaVoipSettings.setCanChangeArenaVOIP(loc1.canChangeArenaVOIP);
            this.arenaVoipSettings.setUseArenaVoip(loc1.arenaVoipChannels);
            invalidate(scaleform.clik.constants.InvalidationType.STATE);
            return;
        }

        public function as_updateComment(arg1:String):void
        {
            this.comment.text = arg1;
            return;
        }

        public function as_updateMap(arg1:Number, arg2:Number, arg3:String, arg4:String, arg5:String, arg6:String):void
        {
            this.minimap.setMapS(arg1);
            this.maxPlayers.label = this.curPlayersCount + "/" + arg2;
            this.map.htmlText = arg3;
            this.titleField.htmlText = arg4;
            this.typeField.htmlText = arg5;
            this.description.position = 0;
            this.description.htmlText = arg6;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.updateStage(App.appWidth, App.appHeight);
            this.addListeners();
            this.battleIcon.gotoAndStop(net.wg.gui.lobby.training.TrainingRoom.TRAINING);
            this.battleIconBig.gotoAndStop(net.wg.gui.lobby.training.TrainingRoom.TRAINING);
            this.description.autoScroll = false;
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN, this.handleEscape, true);
            return;
        }

        internal function handleEscape(arg1:scaleform.clik.events.InputEvent):void
        {
            onEscapeS();
            return;
        }

        internal function addListeners():void
        {
            this.settingsButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSettingsButtonClick);
            this.startButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onStartButtonClick);
            this.closeButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.closeTraining);
            this.inviteButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.showTrainingInvitations);
            this.swapButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSwapBtnClick);
            this.other.addEventListener(net.wg.infrastructure.events.DragDropEvent.END_DROP, this.onDrop);
            this.team1.addEventListener(net.wg.infrastructure.events.DragDropEvent.END_DROP, this.onDrop);
            this.team2.addEventListener(net.wg.infrastructure.events.DragDropEvent.END_DROP, this.onDrop);
            this.arenaVoipSettings.addEventListener(net.wg.gui.events.ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT, this.selectCommonVoiceChatHandler);
            App.voiceChatMgr.addEventListener(net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING, this.startSpeak);
            App.voiceChatMgr.addEventListener(net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING, this.stoptSpeak);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerComponent(this.minimap, net.wg.data.Aliases.LOBBY_MINIMAP);
            this.setTeamsInfo();
            var loc1:*=App.voiceChatMgr.isYYS();
            this.arenaVoipSettings.visible = App.voiceChatMgr.isVOIPEnabledS() || loc1;
            this.arenaVOIPLabel.text = App.voiceChatMgr.isVOIPEnabledS() || loc1 ? MENU.TRAINING_INFO_VOICECHAT : "";
            return;
        }

        protected override function onDispose():void
        {
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN);
            this.removeListeners();
            this.disposeComponents();
            this.locale = null;
            if (this._dragDropListDelegateCtrlr) 
            {
                this._dragDropListDelegateCtrlr.dispose();
                this._dragDropListDelegateCtrlr = null;
            }
            if (this._slots) 
            {
                this._slots.splice(0, this._slots.length);
                this._slots = null;
            }
            App.utils.scheduler.cancelTask(this.stopCoolDownSwapButton);
            App.utils.scheduler.cancelTask(this.stopCoolDownSetting);
            super.onDispose();
            return;
        }

        public function as_updateTimeout(arg1:String):void
        {
            this.timeout.label = arg1;
            return;
        }

        internal function disposeComponents():void
        {
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
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                x = this._myWidth - _originalWidth >> 1;
                y = -SUB_VIEW_MARGIN;
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
                if (!this.isCreator) 
                {
                    this.settingsButton.visible = false;
                    this.startButton.visible = false;
                    this.closeButton.label = MENU.TRAINING_INFO_EXITBUTTON;
                    this.inviteButton.visible = false;
                    this.swapButton.visible = false;
                }
            return;
        }

        internal function removeListeners():void
        {
            this.other.removeEventListener(net.wg.infrastructure.events.DragDropEvent.END_DROP, this.onDrop);
            this.team1.removeEventListener(net.wg.infrastructure.events.DragDropEvent.END_DROP, this.onDrop);
            this.team2.removeEventListener(net.wg.infrastructure.events.DragDropEvent.END_DROP, this.onDrop);
            this.settingsButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSettingsButtonClick);
            this.startButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onStartButtonClick);
            this.closeButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.closeTraining);
            this.inviteButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.showTrainingInvitations);
            this.swapButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSwapBtnClick);
            this.arenaVoipSettings.removeEventListener(net.wg.gui.events.ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT, this.selectCommonVoiceChatHandler);
            App.voiceChatMgr.removeEventListener(net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING, this.startSpeak);
            App.voiceChatMgr.removeEventListener(net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING, this.stoptSpeak);
            return;
        }

        internal function setSpeaking(arg1:Boolean, arg2:Number):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=this._slots;
            for each (loc1 in loc5) 
            {
                loc2 = loc1.dataProvider;
                var loc6:*=0;
                var loc7:*=loc2;
                for each (loc3 in loc7) 
                {
                    if (loc3.uid != arg2) 
                        continue;
                    loc3.isPlayerSpeaking = arg1;
                    loc1.invalidateData();
                }
            }
            return;
        }

        internal function disableControls():void
        {
            this.swapButton.enabled = false;
            this.closeButton.enabled = false;
            this.settingsButton.enabled = false;
            this.startButton.enabled = false;
            this.inviteButton.enabled = false;
            this.arenaVoipSettings.enabled = false;
            if (this._dragDropListDelegateCtrlr) 
            {
                this._dragDropListDelegateCtrlr.dispose();
                this._dragDropListDelegateCtrlr = null;
            }
            return;
        }

        internal function stopCoolDownSwapButton():void
        {
            this.swapButton.enabled = true;
            return;
        }

        internal function stopCoolDownSetting():void
        {
            this.settingsButton.enabled = true;
            return;
        }

        internal function setTeamsInfo():void
        {
            this.team1Label.htmlText = this.locale.makeString(MENU.TRAINING_INFO_TEAM1LABEL);
            this.team1Label.htmlText = this.team1Label.htmlText + (" [<font color=\"#FFFFFF\">" + 0 + "</font>]");
            this.team2Label.htmlText = this.locale.makeString(MENU.TRAINING_INFO_TEAM2LABEL);
            this.team2Label.htmlText = this.team2Label.htmlText + (" [<font color=\"#FFFFFF\">" + 0 + "</font>]");
            this.otherLabel.htmlText = this.locale.makeString(MENU.TRAINING_INFO_OTHERLABEL);
            this.otherLabel.htmlText = this.otherLabel.htmlText + (" [<font color=\"#FFFFFF\">" + 0 + "</font>]");
            return;
        }

        internal function countPlayers():void
        {
            var loc1:*=null;
            this.curPlayersCount = 0;
            var loc2:*=0;
            var loc3:*=this._slots;
            for each (loc1 in loc3) 
                this.curPlayersCount = this.curPlayersCount + loc1.dataProvider.length;
            this.maxPlayers.label = this.curPlayersCount + "/" + this.maxPlayersCount;
            App.toolTipMgr.hide();
            App.contextMenuMgr.hide();
            return;
        }

        internal function startSpeak(arg1:net.wg.infrastructure.events.VoiceChatEvent):void
        {
            this.setSpeaking(true, arg1.getAccountDBID());
            return;
        }

        internal function stoptSpeak(arg1:net.wg.infrastructure.events.VoiceChatEvent):void
        {
            this.setSpeaking(false, arg1.getAccountDBID());
            return;
        }

        internal function onDrop(arg1:net.wg.infrastructure.events.DragDropEvent):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (arg1.sender != arg1.receiver) 
            {
                loc1 = scaleform.clik.controls.ListItemRenderer(arg1.draggedItem).data.accID;
                loc2 = this._slots.indexOf(arg1.receiver);
                changeTeamS(loc1, loc2);
            }
            return;
        }

        internal function onSettingsButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            showTrainingSettingsS();
            return;
        }

        internal function onStartButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            startTrainingS();
            this.disableControls();
            return;
        }

        internal function closeTraining(arg1:scaleform.clik.events.ButtonEvent):void
        {
            closeTrainingRoomS();
            return;
        }

        internal function showTrainingInvitations(arg1:scaleform.clik.events.ButtonEvent):void
        {
            showPrebattleInvitationsFormS();
            return;
        }

        internal function onSwapBtnClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            swapTeamsS();
            return;
        }

        internal static function checkStatus(arg1:scaleform.clik.controls.CoreList, arg2:Number, arg3:String, arg4:String, arg5:String, arg6:String):void
        {
            var loc2:*=null;
            var loc1:*=arg1.dataProvider;
            var loc3:*=0;
            var loc4:*=loc1;
            for each (loc2 in loc4) 
            {
                if (loc2.uid != arg2) 
                    continue;
                loc2.stateString = arg3;
                loc2.icon = arg4;
                loc2.vShortName = arg5;
                loc2.vLevel = arg6;
                arg1.invalidateData();
                break;
            }
            return;
        }

        internal static function checkRoster(arg1:scaleform.clik.controls.CoreList, arg2:Number, arg3:Number):void
        {
            var loc2:*=null;
            var loc1:*=arg1.dataProvider;
            var loc3:*=0;
            var loc4:*=loc1;
            for each (loc2 in loc4) 
            {
                if (loc2.uid != arg2) 
                    continue;
                loc2.chatRoster = arg3;
                arg1.invalidateData();
                break;
            }
            return;
        }

        public function as_startCoolDownVoiceChat(arg1:Number):void
        {
            this.arenaVoipSettings.startCoolDownUseCommonVoiceChat(arg1);
            return;
        }

        internal static function setupDataProvider(arg1:Array):scaleform.clik.interfaces.IDataProvider
        {
            var loc2:*=null;
            var loc1:*=new scaleform.clik.data.DataProvider();
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc2 in loc4) 
                loc1.push(new net.wg.data.VO.TrainingRoomRendererVO(loc2));
            return loc1;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            this.setViewSize(arg1, arg2);
            return;
        }

        public final override function setViewSize(arg1:Number, arg2:Number):void
        {
            this._myWidth = arg1;
            invalidateSize();
            return;
        }

        public function as_setPlayerStateInTeam1(arg1:Number, arg2:String, arg3:String, arg4:String, arg5:String):void
        {
            checkStatus(this.team1, arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function as_setPlayerStateInTeam2(arg1:Number, arg2:String, arg3:String, arg4:String, arg5:String):void
        {
            checkStatus(this.team2, arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function as_setPlayerStateInOther(arg1:Number, arg2:String, arg3:String, arg4:String, arg5:String):void
        {
            checkStatus(this.other, arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function as_setPlayerChatRosterInTeam1(arg1:Number, arg2:Number):void
        {
            checkRoster(this.team1, arg1, arg2);
            return;
        }

        public function as_setPlayerChatRosterInTeam2(arg1:Number, arg2:Number):void
        {
            checkRoster(this.team2, arg1, arg2);
            return;
        }

        public function as_setPlayerChatRosterInOther(arg1:Number, arg2:Number):void
        {
            checkRoster(this.other, arg1, arg2);
            return;
        }

        internal function selectCommonVoiceChatHandler(arg1:net.wg.gui.events.ArenaVoipSettingsEvent):void
        {
            selectCommonVoiceChatS(arg1.index);
            return;
        }

        public function as_startCoolDownSetting(arg1:Number):void
        {
            var loc1:*=App.utils.scheduler;
            loc1.cancelTask(this.stopCoolDownSetting);
            this.settingsButton.enabled = false;
            loc1.scheduleTask(this.stopCoolDownSetting, arg1 * 1000);
            return;
        }

        public function as_startCoolDownSwapButton(arg1:Number):void
        {
            var loc1:*=null;
            loc1 = App.utils.scheduler;
            loc1.cancelTask(this.stopCoolDownSwapButton);
            this.swapButton.enabled = false;
            loc1.scheduleTask(this.stopCoolDownSwapButton, arg1 * 1000);
            return;
        }

        public function as_disableStartButton(arg1:Boolean):void
        {
            this.startButton.enabled = !arg1;
            return;
        }

        public function as_setTeam1(arg1:Array):void
        {
            this.team1.dataProvider = setupDataProvider(arg1);
            this.team1Label.htmlText = this.locale.makeString(MENU.TRAINING_INFO_TEAM1LABEL);
            this.team1Label.htmlText = this.team1Label.htmlText + (" [<font color=\"#FFFFFF\">" + arg1.length + "</font>]");
            this.countPlayers();
            return;
        }

        public function as_setTeam2(arg1:Array):void
        {
            this.team2.dataProvider = setupDataProvider(arg1);
            this.team2Label.htmlText = this.locale.makeString(MENU.TRAINING_INFO_TEAM2LABEL);
            this.team2Label.htmlText = this.team2Label.htmlText + (" [<font color=\"#FFFFFF\">" + arg1.length + "</font>]");
            this.countPlayers();
            return;
        }

        public function as_setOther(arg1:Array):void
        {
            this.other.dataProvider = setupDataProvider(arg1);
            this.otherLabel.htmlText = this.locale.makeString(MENU.TRAINING_INFO_OTHERLABEL);
            this.otherLabel.htmlText = this.otherLabel.htmlText + (" [<font color=\"#FFFFFF\">" + arg1.length + "</font>]");
            this.countPlayers();
            return;
        }

        public static const TRAINING:String="training";

        internal static const SUB_VIEW_MARGIN:Number=120;

        public var otherLabel:flash.text.TextField;

        public var titleField:flash.text.TextField;

        public var typeField:flash.text.TextField;

        public var comment:flash.text.TextField;

        public var map:flash.text.TextField;

        public var arenaVOIPLabel:flash.text.TextField;

        public var swapButton:net.wg.gui.components.controls.SoundButton;

        public var settingsButton:net.wg.gui.components.controls.SoundButtonEx;

        public var startButton:net.wg.gui.components.controls.SoundButtonEx;

        public var inviteButton:net.wg.gui.components.controls.SoundButtonEx;

        public var minimap:net.wg.gui.lobby.training.MinimapLobby;

        public var owner:net.wg.gui.components.controls.TextFieldShort;

        public var timeout:net.wg.gui.components.controls.TextFieldShort;

        public var maxPlayers:net.wg.gui.components.controls.TextFieldShort;

        public var team1Label:flash.text.TextField;

        public var battleIconBig:net.wg.gui.components.icons.BattleTypeIcon;

        public var battleIcon:net.wg.gui.components.icons.BattleTypeIcon;

        public var team1:net.wg.gui.lobby.training.DropList;

        public var team2:net.wg.gui.lobby.training.DropList;

        public var other:net.wg.gui.lobby.training.DropTileList;

        public var arenaVoipSettings:net.wg.gui.lobby.training.ArenaVoipSettings;

        internal var isCreator:Boolean;

        internal var _slots:__AS3__.vec.Vector.<flash.display.InteractiveObject>=null;

        internal var maxPlayersCount:Number=0;

        internal var curPlayersCount:Number=0;

        internal var _dragDropListDelegateCtrlr:net.wg.infrastructure.interfaces.entity.IDisposable=null;

        internal var locale:net.wg.utils.ILocale=null;

        public var team2Label:flash.text.TextField;

        public var closeButton:net.wg.gui.components.controls.SoundButtonEx;

        internal var _myWidth:Number=0;

        public var description:net.wg.gui.components.advanced.TextAreaSimple;
    }
}
