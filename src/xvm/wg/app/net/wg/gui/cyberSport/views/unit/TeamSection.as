package net.wg.gui.cyberSport.views.unit
{
    import net.wg.gui.rally.views.room.TeamSectionWithDropIndicators;
    import net.wg.gui.components.advanced.ToggleButton;
    import net.wg.gui.components.advanced.ButtonDnmIcon;
    import flash.text.TextField;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.controls.SlotDropIndicator;
    import net.wg.gui.cyberSport.controls.SettingsIcons;
    import net.wg.gui.rally.vo.RallySlotVO;
    import net.wg.gui.rally.BaseRallyMainWindow;
    import net.wg.gui.rally.vo.RallyVO;
    import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
    import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.cyberSport.CSInvalidationType;
    import net.wg.gui.rally.controls.RallyInvalidationType;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
    
    public class TeamSection extends TeamSectionWithDropIndicators
    {
        
        public function TeamSection()
        {
            super();
            this.btnFreeze.externalSource = true;
        }
        
        private static var LABEL_ICON_GAP:Number = 20;
        
        public var btnFreeze:ToggleButton;
        
        public var btnConfigure:ButtonDnmIcon;
        
        public var lblTeamPoints:TextField;
        
        public var slot0:IRallySimpleSlotRenderer;
        
        public var slot1:IRallySimpleSlotRenderer;
        
        public var slot2:IRallySimpleSlotRenderer;
        
        public var slot3:IRallySimpleSlotRenderer;
        
        public var slot4:IRallySimpleSlotRenderer;
        
        public var slot5:IRallySimpleSlotRenderer;
        
        public var slot6:IRallySimpleSlotRenderer;
        
        public var dropTargerIndicator0:SlotDropIndicator;
        
        public var dropTargerIndicator1:SlotDropIndicator;
        
        public var dropTargerIndicator2:SlotDropIndicator;
        
        public var dropTargerIndicator3:SlotDropIndicator;
        
        public var dropTargerIndicator4:SlotDropIndicator;
        
        public var dropTargerIndicator5:SlotDropIndicator;
        
        public var dropTargerIndicator6:SlotDropIndicator;
        
        public var settingsIcons:SettingsIcons;
        
        override public function updateMembers(param1:Boolean, param2:Array) : void
        {
            super.updateMembers(param1,param2);
            this.unitData.hasRestrictions = param1;
            this.updateSettingsIcon();
        }
        
        public function enableFreezeButton(param1:Boolean) : void
        {
            if(this.btnFreeze)
            {
                this.btnFreeze.enabled = param1;
            }
        }
        
        public function updateLockedUnit(param1:Boolean, param2:Array) : void
        {
            var _loc5_:RallySlotVO = null;
            var _loc3_:int = this.unitData.slots.length;
            this.unitData.isFreezed = param1;
            this.updateSettingsIcon();
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                _loc5_ = getSlotModel(_loc4_) as RallySlotVO;
                _loc5_.isFreezed = param1;
                _loc5_.slotLabel = param2[_loc4_];
                setSlotModel(_loc4_,_loc5_);
                _loc4_++;
            }
        }
        
        public function closeSlot(param1:uint, param2:Boolean, param3:uint, param4:String, param5:Boolean, param6:int) : void
        {
            var _loc7_:RallySlotVO = getSlotModel(param1) as RallySlotVO;
            _loc7_.selectedVehicleLevel = param3;
            _loc7_.compatibleVehiclesCount = param6;
            _loc7_.isClosed = param5;
            _loc7_.slotLabel = param4;
            _loc7_.playerStatus = 0;
            _loc7_.canBeTaken = param2;
            setSlotModel(param1,_loc7_);
            lblTeamMembers.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS,rallyData);
            this.updateSettingsIcon();
        }
        
        public function updateTotalLabel(param1:Boolean, param2:String, param3:int) : void
        {
            this.updateLevelLabels(param2);
            this.unitData.sumLevelsError = param1;
            this.unitData.sumLevelsInt = param3;
        }
        
        public function get unitData() : RallyVO
        {
            return rallyData as RallyVO;
        }
        
        override protected function getMembersStr() : String
        {
            return CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS;
        }
        
        override protected function getVehiclesStr() : String
        {
            return CYBERSPORT.WINDOW_UNIT_TEAMVEHICLES;
        }
        
        override protected function getVehiclesStaticStr() : String
        {
            return CYBERSPORT.WINDOW_UNIT_TEAMVEHICLESSTUB;
        }
        
        override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
        {
            var _loc2_:IRallySimpleSlotRenderer = null;
            var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6];
            var _loc3_:ISlotRendererHelper = new UnitSlotHelper();
            for each(_loc2_ in _loc1_)
            {
                _loc2_.helper = _loc3_;
            }
            return _loc1_;
        }
        
        override public function getIndicatorsUI() : Vector.<ISlotDropIndicator>
        {
            return new <ISlotDropIndicator>[this.dropTargerIndicator0,this.dropTargerIndicator1,this.dropTargerIndicator2,this.dropTargerIndicator3,this.dropTargerIndicator4,this.dropTargerIndicator5,this.dropTargerIndicator6];
        }
        
        override protected function onDispose() : void
        {
            this.settingsIcons.dispose();
            this.btnFreeze.removeEventListener(ButtonEvent.CLICK,this.onStatusToggle);
            tooltipSubscribe([this.btnFreeze,this.btnConfigure,this.lblTeamPoints],false);
            super.onDispose();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.btnConfigure.addEventListener(ButtonEvent.CLICK,this.onConfigureClick);
            lblTeamHeader.text = CYBERSPORT.WINDOW_UNIT_TEAM;
            this.lblTeamPoints.text = CYBERSPORT.WINDOW_UNIT_TEAMPOINTS;
            this.btnConfigure.x = lblTeamVehicles.x + lblTeamVehicles.textWidth + LABEL_ICON_GAP;
            this.settingsIcons.x = lblTeamHeader.x + lblTeamHeader.textWidth + LABEL_ICON_GAP;
            this.btnFreeze.addEventListener(ButtonEvent.CLICK,this.onStatusToggle);
            tooltipSubscribe([this.btnFreeze,this.btnConfigure,this.lblTeamPoints]);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(CSInvalidationType.VEHICLE_LABEL))
            {
                this.btnConfigure.x = lblTeamVehicles.x + lblTeamVehicles.textWidth + LABEL_ICON_GAP;
            }
            if(isInvalid(RallyInvalidationType.VEHICLE_LABEL))
            {
                this.btnFreeze.x = lblTeamMembers.x + lblTeamMembers.textWidth + LABEL_ICON_GAP;
            }
        }
        
        override protected function updateComponents() : void
        {
            super.updateComponents();
            var _loc1_:Boolean = this.unitData?this.unitData.isCommander:false;
            this.btnConfigure.visible = this.btnFreeze.visible = _loc1_;
            this.btnFreeze.selected = this.unitData.isFreezed;
            this.updateSettingsIcon();
            this.updateLevelLabels(this.unitData.sumLevels);
        }
        
        override protected function onControlRollOver(param1:MouseEvent) : void
        {
            var _loc2_:* = "";
            var _loc3_:* = "";
            switch(param1.currentTarget)
            {
                case this.btnFreeze:
                    _loc2_ = TOOLTIPS.CYBERSPORT_UNIT_FREEZE_HEADER;
                    _loc3_ = (rallyData) && (this.unitData.isFreezed)?TOOLTIPS.CYBERSPORT_UNIT_FREEZE_BODYON:TOOLTIPS.CYBERSPORT_UNIT_FREEZE_BODYOFF;
                    this.showTooltip(_loc2_,_loc3_);
                    break;
                case this.btnConfigure:
                    App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_CONFIGURE);
                    break;
                case this.lblTeamPoints:
                    App.toolTipMgr.showSpecial(Tooltips.CYBER_SPORT_UNIT_LEVEL,null,this.unitData.sumLevelsInt);
                    break;
            }
        }
        
        private function updateLevelLabels(param1:String) : void
        {
            this.lblTeamPoints.htmlText = param1;
        }
        
        private function updateSettingsIcon() : void
        {
            if((this.unitData) && !this.unitData.isCommander)
            {
                this.settingsIcons.visible = true;
                this.settingsIcons.flakeVisible = this.unitData?this.unitData.isFreezed:false;
                this.settingsIcons.gearVisible = this.unitData?this.unitData.hasRestrictions:false;
            }
            else
            {
                this.settingsIcons.visible = false;
            }
        }
        
        private function showTooltip(param1:String, param2:String) : void
        {
            var _loc3_:String = new ComplexTooltipHelper().addHeader(param1,true).addBody(param2,true).make();
            if(_loc3_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc3_);
            }
        }
        
        private function onStatusToggle(param1:ButtonEvent) : void
        {
            dispatchEvent(new CSComponentEvent(CSComponentEvent.TOGGLE_FREEZE_REQUEST));
        }
        
        private function onConfigureClick(param1:ButtonEvent) : void
        {
            dispatchEvent(new CSComponentEvent(CSComponentEvent.CLICK_CONFIGURE_BUTTON));
        }
        
        override public function cooldownSlots(param1:Boolean) : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:IRallySimpleSlotRenderer = null;
            super.cooldownSlots(param1);
            if((rallyData) && (rallyData.isCommander))
            {
                _loc3_ = _slotsUi.length;
                _loc2_ = 0;
                while(_loc2_ < _loc3_)
                {
                    _loc4_ = _slotsUi[_loc2_];
                    _loc4_.cooldown(param1);
                    _loc2_++;
                }
            }
        }
    }
}
