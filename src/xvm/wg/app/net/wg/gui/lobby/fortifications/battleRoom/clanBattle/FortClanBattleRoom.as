package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
    import net.wg.infrastructure.base.meta.impl.FortClanBattleRoomMeta;
    import net.wg.infrastructure.base.meta.IFortClanBattleRoomMeta;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.ClanEmblem;
    import net.wg.gui.components.advanced.IndicationOfStatus;
    import net.wg.gui.lobby.fortifications.interfaces.IClanBattleTimer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.fortifications.cmp.drctn.impl.ConnectedDirctns;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.FortClanBattleRoomVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
    import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
    import net.wg.gui.lobby.fortifications.events.ClanBattleTimerEvent;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.SortieVO;
    import net.wg.gui.rally.interfaces.IChatSectionWithDescription;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.Tooltips;
    
    public class FortClanBattleRoom extends FortClanBattleRoomMeta implements IFortClanBattleRoomMeta
    {
        
        public function FortClanBattleRoom()
        {
            super();
        }
        
        private static var CHANGE_UNIT_STATE:int = 24;
        
        private static var SET_PLAYER_STATE:int = 6;
        
        private static var INFO_ICON_PADDING:int = 20;
        
        private static function onRollOutInfoIconHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var mineClanName:TextField = null;
        
        public var enemyClanName:TextField = null;
        
        public var mineClanIcon:ClanEmblem = null;
        
        public var enemyClanIcon:ClanEmblem = null;
        
        public var mineReadyStatus:IndicationOfStatus = null;
        
        public var enemyReadyStatus:IndicationOfStatus = null;
        
        public var timer:IClanBattleTimer = null;
        
        public var infoIcon:UILoaderAlt = null;
        
        public var mapName:TextField = null;
        
        public var headerDesrc:TextField = null;
        
        public var connectedDirections:ConnectedDirctns;
        
        private var model:FortClanBattleRoomVO = null;
        
        override protected function setBattleRoomData(param1:FortClanBattleRoomVO) : void
        {
            this.model = param1;
            this.mapName.htmlText = param1.mapName;
            this.headerDesrc.htmlText = param1.headerDescr;
            this.mapName.autoSize = TextFieldAutoSize.RIGHT;
            this.headerDesrc.autoSize = TextFieldAutoSize.RIGHT;
            this.infoIcon.x = Math.round(this.mapName.x - INFO_ICON_PADDING);
            this.mineClanName.htmlText = param1.mineClanName;
            this.enemyClanName.htmlText = param1.enemyClanName;
        }
        
        override protected function setTimerDelta(param1:ClanBattleTimerVO) : void
        {
            this.timer.setData(param1);
        }
        
        override protected function updateDirections(param1:ConnectedDirectionsVO) : void
        {
            this.connectedDirections.setData(param1);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.timer.addEventListener(ClanBattleTimerEvent.ALERT_TICK,this.onTimerAlertHandler);
            this.mapName.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverMapInfoHandler);
            this.mapName.addEventListener(MouseEvent.ROLL_OUT,onRollOutInfoIconHandler);
            this.infoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverMapInfoHandler);
            this.infoIcon.addEventListener(MouseEvent.ROLL_OUT,onRollOutInfoIconHandler);
            this.infoIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_INFORMATIONICON;
            this.connectedDirections.connectionIcon.useOverlay = false;
            this.connectedDirections.leftDirection.alwaysShowLevels = true;
            this.connectedDirections.rightDirection.alwaysShowLevels = true;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            backBtn.label = FORTIFICATIONS.SORTIE_ROOM_LEAVEBTN;
        }
        
        override protected function onDispose() : void
        {
            this.timer.removeEventListener(ClanBattleTimerEvent.ALERT_TICK,this.onTimerAlertHandler);
            this.mapName.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverMapInfoHandler);
            this.mapName.removeEventListener(MouseEvent.ROLL_OUT,onRollOutInfoIconHandler);
            this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverMapInfoHandler);
            this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT,onRollOutInfoIconHandler);
            this.infoIcon.dispose();
            this.infoIcon = null;
            this.mineClanIcon.dispose();
            this.mineClanIcon = null;
            this.enemyClanIcon.dispose();
            this.enemyClanIcon = null;
            this.connectedDirections.dispose();
            this.connectedDirections = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            this.mineReadyStatus.dispose();
            this.mineReadyStatus = null;
            this.enemyReadyStatus.dispose();
            this.enemyReadyStatus = null;
            super.onDispose();
        }
        
        override protected function getRallyViewAlias() : String
        {
            return FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_ROOM_VIEW_UI;
        }
        
        override protected function getTitleStr() : String
        {
            return FORTIFICATIONS.SORTIE_ROOM_TITLE;
        }
        
        override protected function getRallyVO(param1:Object) : IRallyVO
        {
            return new SortieVO(param1);
        }
        
        override protected function coolDownControls(param1:Boolean, param2:int) : void
        {
            if(param2 == CHANGE_UNIT_STATE)
            {
                (chatSection as IChatSectionWithDescription).enableEditCommitButton(param1);
            }
            else if(param2 == SET_PLAYER_STATE)
            {
                teamSection.enableFightButton(param1);
            }
            
            super.coolDownControls(param1,param2);
        }
        
        public function as_setEnemyClanIcon(param1:String) : void
        {
            if((!_baseDisposed) && (this.enemyClanIcon) && (StringUtils.isNotEmpty(param1)))
            {
                this.enemyClanIcon.setImage(param1);
            }
        }
        
        public function as_setMineClanIcon(param1:String) : void
        {
            if((!_baseDisposed) && (this.mineClanIcon) && (StringUtils.isNotEmpty(param1)))
            {
                this.mineClanIcon.setImage(param1);
            }
        }
        
        public function as_updateReadyStatus(param1:Boolean, param2:Boolean) : void
        {
            this.mineReadyStatus.gotoAndStop(param1?IndicationOfStatus.STATUS_READY:IndicationOfStatus.STATUS_NORMAL);
            this.enemyReadyStatus.gotoAndStop(param2?IndicationOfStatus.STATUS_READY:IndicationOfStatus.STATUS_NORMAL);
        }
        
        public function as_updateTeamHeaderText(param1:String) : void
        {
            FortClanBattleTeamSection(teamSection).updateTeamHeaderText(param1);
        }
        
        override protected function onControlRollOver(param1:MouseEvent) : void
        {
            super.onControlRollOver(param1);
            switch(param1.target)
            {
                case backBtn:
                    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_LEAVEBTN);
                    break;
            }
        }
        
        private function onTimerAlertHandler(param1:ClanBattleTimerEvent) : void
        {
            onTimerAlertS();
        }
        
        private function onRollOverMapInfoHandler(param1:MouseEvent) : void
        {
            if((this.model) && !(this.model.mapID == Values.DEFAULT_INT))
            {
                App.toolTipMgr.showSpecial(Tooltips.MAP,null,this.model.mapID);
            }
        }
    }
}
