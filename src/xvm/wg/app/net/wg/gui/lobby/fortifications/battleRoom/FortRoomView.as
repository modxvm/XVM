package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.infrastructure.base.meta.impl.FortRoomMeta;
    import net.wg.infrastructure.base.meta.IFortRoomMeta;
    import net.wg.gui.components.controls.SoundButton;
    import net.wg.gui.components.controls.InfoIcon;
    import flash.text.TextField;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.gui.rally.interfaces.IChatSectionWithDescription;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.controls.RallyInvalidationType;
    import net.wg.gui.lobby.fortifications.data.battleRoom.SortieVO;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
    import net.wg.infrastructure.interfaces.entity.IIdentifiable;
    import net.wg.data.constants.Tooltips;
    
    public class FortRoomView extends FortRoomMeta implements IFortRoomMeta
    {
        
        public function FortRoomView()
        {
            super();
            this.tooltipMessage.htmlText = FORTIFICATIONS.FORTBATTLEROOM_LEGIONARIESTOOLTIPMSG;
            this.tooltipMessage.visible = false;
            this.legionariesCount.visible = false;
            backBtn.UIID = 51;
        }
        
        private static var CHANGE_UNIT_STATE:int = 24;
        
        private static var SET_PLAYER_STATE:int = 6;
        
        public var changeDivisionBtn:SoundButton = null;
        
        public var filterInfo:InfoIcon = null;
        
        public var divisionInfoText:TextField = null;
        
        public var tooltipMessage:TextField = null;
        
        public var legionariesCount:TextField = null;
        
        public function as_showLegionariesCount(param1:Boolean, param2:String) : void
        {
            this.legionariesCount.visible = param1;
            this.legionariesCount.htmlText = param2;
        }
        
        public function as_showLegionariesToolTip(param1:Boolean) : void
        {
            if(this.tooltipMessage.visible != param1)
            {
                this.tooltipMessage.visible = param1;
            }
        }
        
        override protected function getRallyVO(param1:Object) : IRallyVO
        {
            return new LegionariesSortieVO(param1);
        }
        
        override protected function getTitleStr() : String
        {
            return FORTIFICATIONS.SORTIE_ROOM_TITLE;
        }
        
        override protected function getRallyViewAlias() : String
        {
            return FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_VIEW_UI;
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
        
        override protected function configUI() : void
        {
            super.configUI();
            this.changeDivisionBtn.visible = false;
            titleLbl.text = FORTIFICATIONS.SORTIE_ROOM_TITLE;
            descrLbl.text = FORTIFICATIONS.SORTIE_ROOM_DESCRIPTION;
            backBtn.label = FORTIFICATIONS.SORTIE_ROOM_LEAVEBTN;
            this.changeDivisionBtn.label = FORTIFICATIONS.SORTIE_ROOM_CHANGEDIVISION;
            this.changeDivisionBtn.addEventListener(ButtonEvent.CLICK,this.changeDivisionHandler);
            this.changeDivisionBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.changeDivisionBtn.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.filterInfo.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.filterInfo.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
        }
        
        override protected function onDispose() : void
        {
            this.changeDivisionBtn.removeEventListener(ButtonEvent.CLICK,this.changeDivisionHandler);
            this.changeDivisionBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.changeDivisionBtn.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.changeDivisionBtn.dispose();
            this.changeDivisionBtn = null;
            this.filterInfo.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.filterInfo.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.filterInfo.dispose();
            this.filterInfo = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(RallyInvalidationType.RALLY_DATA)) && (rallyData))
            {
                this.divisionInfoText.htmlText = SortieVO(rallyData).divisionLbl;
                this.changeDivisionBtn.visible = false;
            }
        }
        
        override protected function onToggleReadyStateRequest(param1:RallyViewsEvent) : void
        {
            App.eventLogManager.logSubSystem(EVENT_LOG_CONSTANTS.SST_UI_FORT,EVENT_LOG_CONSTANTS.EVENT_TYPE_CLICK,param1.data.uiid,param1.data.arg);
            super.onToggleReadyStateRequest(param1);
        }
        
        override protected function onChooseVehicleRequest(param1:RallyViewsEvent) : void
        {
            App.eventLogManager.logUIElement(IIdentifiable(param1.target.vehicleBtn),EVENT_LOG_CONSTANTS.EVENT_TYPE_CLICK,0);
            super.onChooseVehicleRequest(param1);
        }
        
        override protected function onBackClickHandler(param1:ButtonEvent) : void
        {
            super.onBackClickHandler(param1);
            App.eventLogManager.logUIEvent(param1,0);
        }
        
        override protected function onControlRollOver(param1:MouseEvent) : void
        {
            super.onControlRollOver(param1);
            switch(param1.target)
            {
                case backBtn:
                    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_LEAVEBTN);
                    break;
                case this.changeDivisionBtn:
                    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_CHANGEDIVISION);
                    break;
                case this.filterInfo:
                    App.toolTipMgr.showSpecial(Tooltips.SORTIE_DIVISION,null);
                    break;
            }
        }
        
        private function changeDivisionHandler(param1:ButtonEvent) : void
        {
            showChangeDivisionWindowS();
        }
    }
}
