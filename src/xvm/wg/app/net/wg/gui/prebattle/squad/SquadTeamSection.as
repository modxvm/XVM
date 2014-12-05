package net.wg.gui.prebattle.squad
{
    import net.wg.gui.rally.views.room.BaseTeamSection;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
    
    public class SquadTeamSection extends BaseTeamSection
    {
        
        public function SquadTeamSection()
        {
            super();
        }
        
        public var slot0:IRallySimpleSlotRenderer;
        
        public var slot1:IRallySimpleSlotRenderer;
        
        public var slot2:IRallySimpleSlotRenderer;
        
        override protected function configUI() : void
        {
            super.configUI();
            btnFight.tooltip = TOOLTIPS.SQUADWINDOW_BUTTONS_BTNFIGHT;
            btnNotReady.tooltip = TOOLTIPS.SQUADWINDOW_BUTTONS_BTNNOTREADY;
        }
        
        override protected function updateComponents() : void
        {
            var _loc2_:IRallySimpleSlotRenderer = null;
            var _loc1_:Array = rallyData?rallyData.slotsArray:null;
            for each(_loc2_ in _slotsUi)
            {
                _loc2_.slotData = _loc1_?_loc1_[_slotsUi.indexOf(_loc2_)]:null;
                (_loc2_ as SquadSlotRenderer).isCreator = rallyData.isCommander;
            }
        }
        
        override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
        {
            var _loc2_:IRallySimpleSlotRenderer = null;
            var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot0,this.slot1,this.slot2];
            var _loc3_:ISlotRendererHelper = new SquadSlotHelper();
            for each(_loc2_ in _loc1_)
            {
                _loc2_.helper = _loc3_;
            }
            return _loc1_;
        }
        
        override protected function getMembersStr() : String
        {
            return MESSENGER.DIALOGS_SQUADCHANNEL_MEMBERS;
        }
        
        override protected function setVehiclesStr() : void
        {
            vehiclesLabel = MESSENGER.DIALOGS_SQUADCHANNEL_VEHICLES;
        }
    }
}
