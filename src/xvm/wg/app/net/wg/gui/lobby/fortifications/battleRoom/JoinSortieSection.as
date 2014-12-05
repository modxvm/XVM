package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.gui.rally.views.list.BaseRallyDetailsSection;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSimpleSlot;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.data.constants.Values;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.rally.BaseRallyMainWindow;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    
    public class JoinSortieSection extends BaseRallyDetailsSection
    {
        
        public function JoinSortieSection()
        {
            super();
            this.joinSortieButton.UIID = 49;
            joinButton = this.joinSortieButton;
        }
        
        protected static function takePlaceBtnOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_JOINBTN);
        }
        
        private var helper:SortieSlotHelper;
        
        public var joinSortieButton:SoundButtonEx;
        
        public var slot0:SortieSimpleSlot;
        
        public var slot1:SortieSimpleSlot;
        
        public var slot2:SortieSimpleSlot;
        
        public var slot3:SortieSimpleSlot;
        
        public var slot4:SortieSimpleSlot;
        
        public var slot5:SortieSimpleSlot;
        
        public var slot6:SortieSimpleSlot;
        
        public var slot7:SortieSimpleSlot;
        
        public var slot8:SortieSimpleSlot;
        
        public var slot9:SortieSimpleSlot;
        
        public var slot10:SortieSimpleSlot;
        
        public var slot11:SortieSimpleSlot;
        
        public var slot12:SortieSimpleSlot;
        
        public var slot13:SortieSimpleSlot;
        
        public var slot14:SortieSimpleSlot;
        
        override protected function setChangedVisibilityItems() : void
        {
            super.setChangedVisibilityItems();
        }
        
        override protected function getSlots() : Array
        {
            var _loc2_:SortieSimpleSlot = null;
            var _loc1_:Array = [this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6,this.slot7,this.slot8,this.slot9,this.slot10,this.slot11,this.slot12,this.slot13,this.slot14];
            this.helper = new SortieSlotHelper();
            var _loc3_:* = 0;
            for each(_loc2_ in _loc1_)
            {
                _loc2_.takePlaceFirstTimeBtn.UIID = 34 + _loc3_;
                _loc2_.helper = this.helper;
                _loc2_.index = _loc3_++;
            }
            return _loc1_;
        }
        
        override protected function updateTitle(param1:IRallyVO) : void
        {
            if((param1) && (param1.commanderVal))
            {
                App.utils.commons.formatPlayerName(headerTF,App.utils.commons.getUserProps(param1.commanderVal.userName,param1.commanderVal.clanAbbrev,param1.commanderVal.region,param1.commanderVal.igrType));
            }
            else
            {
                headerTF.text = Values.EMPTY_STR;
            }
        }
        
        private function addSlotsListeners() : void
        {
            var _loc1_:SortieSimpleSlot = null;
            for each(_loc1_ in slots)
            {
                _loc1_.takePlaceFirstTimeBtn.addEventListener(ButtonEvent.CLICK,this.buttonClickHandler);
                _loc1_.takePlaceBtn.addEventListener(MouseEvent.MOUSE_OVER,takePlaceBtnOverHandler);
            }
        }
        
        private function removeSlotsListeners() : void
        {
            var _loc1_:SortieSimpleSlot = null;
            for each(_loc1_ in slots)
            {
                _loc1_.takePlaceFirstTimeBtn.removeEventListener(ButtonEvent.CLICK,this.buttonClickHandler);
                _loc1_.takePlaceBtn.removeEventListener(MouseEvent.MOUSE_OVER,takePlaceBtnOverHandler);
            }
        }
        
        override protected function configUI() : void
        {
            joinButton = this.joinSortieButton;
            super.configUI();
            headerTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_SELECTEDTEAM;
            rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(FORTIFICATIONS.SORTIE_LISTVIEW_TEAMMEMBERS,model);
            vehiclesInfoTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_TEAMVEHICLESSTUB;
            this.joinSortieButton.label = FORTIFICATIONS.SORTIE_LISTVIEW_ENTERBTN;
            joinInfoTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_ENTERTEXT;
            this.addSlotsListeners();
        }
        
        override protected function onJoinClick(param1:ButtonEvent) : void
        {
            super.onJoinClick(param1);
            App.eventLogManager.logUIEvent(param1,0);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (model))
            {
                this.updateRallyInfoTF();
            }
        }
        
        protected function updateRallyInfoTF() : void
        {
            rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS,model);
        }
        
        override protected function onControlRollOver(param1:MouseEvent) : void
        {
            switch(param1.currentTarget)
            {
                case joinButton:
                    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_SINGINBTN);
                    break;
                case headerTF:
                    App.toolTipMgr.show(model.commanderVal.getToolTip());
                    break;
                case descriptionTF:
                    App.toolTipMgr.show(model.description);
                    break;
            }
        }
        
        override protected function updateSlots(param1:IRallyVO) : void
        {
            var _loc3_:IRallySlotVO = null;
            var _loc4_:SortieSimpleSlot = null;
            var _loc2_:Array = param1.slotsArray;
            var _loc5_:uint = Math.min(slots.length,_loc2_.length);
            var _loc6_:Number = 0;
            while(_loc6_ < _loc5_)
            {
                _loc4_ = slots[_loc6_];
                _loc3_ = _loc2_[_loc6_];
                _loc4_.slotData = _loc3_;
                _loc6_++;
            }
            while(_loc6_ < slots.length)
            {
                _loc4_ = slots[_loc6_];
                _loc4_.slotData = null;
                _loc6_++;
            }
        }
        
        override protected function onDispose() : void
        {
            this.removeSlotsListeners();
            super.onDispose();
        }
        
        private function buttonClickHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
        }
    }
}
