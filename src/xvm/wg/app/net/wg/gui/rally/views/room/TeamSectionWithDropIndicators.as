package net.wg.gui.rally.views.room
{
    import net.wg.gui.interfaces.IDropList;
    import net.wg.gui.rally.interfaces.ITeamSectionWithDropIndicators;
    import flash.text.TextField;
    import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
    import net.wg.gui.rally.controls.SlotDropIndicator;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import flash.events.IEventDispatcher;
    import net.wg.infrastructure.exceptions.InfrastructureException;
    import net.wg.data.constants.Errors;
    
    public class TeamSectionWithDropIndicators extends BaseTeamSection implements IDropList, ITeamSectionWithDropIndicators
    {
        
        public function TeamSectionWithDropIndicators()
        {
            super();
        }
        
        public var lblTeamHeader:TextField;
        
        private var _indicatorsUI:Vector.<ISlotDropIndicator> = null;
        
        override protected function configUI() : void
        {
            var _loc1_:SlotDropIndicator = null;
            super.configUI();
            this._indicatorsUI = this.getIndicatorsUI();
            for each(_loc1_ in this._indicatorsUI)
            {
                _loc1_.doubleClickEnabled = true;
                _loc1_.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick);
            }
        }
        
        private function onDoubleClick(param1:MouseEvent) : void
        {
            var _loc2_:RallySimpleSlotRenderer = RallySimpleSlotRenderer(_slotsUi[SlotDropIndicator(param1.target).index]);
            var _loc3_:IRallySlotVO = _loc2_.slotData;
            if((_loc3_) && (_loc3_.player) && (_loc3_.isCommanderState))
            {
                dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LEAVE_SLOT_REQUEST,_loc3_.player.dbID));
            }
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        override public function setMemberStatus(param1:uint, param2:uint) : void
        {
            super.setMemberStatus(param1,param2);
            this.updateIndicators(param1);
        }
        
        override public function updateMembers(param1:Boolean, param2:Array) : void
        {
            var _loc3_:* = 0;
            super.updateMembers(param1,param2);
            var _loc4_:int = param2.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
                this.updateIndicators(_loc3_);
                _loc3_++;
            }
        }
        
        override protected function updateComponents() : void
        {
            var _loc3_:ISlotDropIndicator = null;
            this.assertSlotsEqualsIndicators();
            this.assertDropIndicatorsNotNull();
            super.updateComponents();
            var _loc1_:Array = rallyData?rallyData.slotsArray:null;
            var _loc2_:Boolean = rallyData?rallyData.isCommander:false;
            var _loc4_:uint = Math.min(this._indicatorsUI.length,_loc1_.length);
            var _loc5_:Number = 0;
            while(_loc5_ < _loc4_)
            {
                _loc3_ = this._indicatorsUI[_loc5_];
                _loc3_.index = _loc5_;
                _loc3_.isCurrentUserCommander = _loc2_;
                _loc3_.update(_loc1_?_loc1_[_loc3_.index].player:null);
                _loc3_.playerStatus = _loc1_?_loc1_[_loc3_.index].playerStatus:0;
                this.updateRenderIcon(_loc3_);
                _loc5_++;
            }
        }
        
        public function updateIndicators(param1:uint) : void
        {
            var _loc2_:IRallySlotVO = getSlotModel(param1);
            var _loc3_:SlotDropIndicator = SlotDropIndicator(this._indicatorsUI[param1]);
            _loc3_.update(_loc2_.player);
            _loc3_.playerStatus = _loc2_.playerStatus;
            this.updateRenderIcon(_loc3_);
        }
        
        override public function highlightSlots(param1:Array) : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:ISlotDropIndicator = null;
            super.highlightSlots(param1);
            if((rallyData) && (rallyData.isCommander))
            {
                _loc3_ = this._indicatorsUI.length;
                _loc2_ = 0;
                while(_loc2_ < _loc3_)
                {
                    _loc4_ = this._indicatorsUI[_loc2_];
                    this.highlightIndicator(_loc4_,_loc2_ > 0 && !(param1.indexOf(_loc2_) == -1));
                    _loc2_++;
                }
            }
        }
        
        public function getIndicatorsUI() : Vector.<ISlotDropIndicator>
        {
            return new Vector.<ISlotDropIndicator>(0);
        }
        
        public function highlightList() : void
        {
            var _loc1_:ISlotDropIndicator = null;
            for each(_loc1_ in this._indicatorsUI)
            {
                this.highlightIndicator(_loc1_,true);
            }
        }
        
        public function hideHighLight() : void
        {
            var _loc1_:ISlotDropIndicator = null;
            for each(_loc1_ in this._indicatorsUI)
            {
                this.highlightIndicator(_loc1_,false);
            }
        }
        
        private function highlightIndicator(param1:ISlotDropIndicator, param2:Boolean) : void
        {
            if((rallyData) && (rallyData.isCommander))
            {
                param1.setHighlightState(param2);
            }
        }
        
        override protected function updateRenderIcon(param1:ISlotDropIndicator) : void
        {
            super.updateRenderIcon(param1);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:ISlotDropIndicator = null;
            this.assertDropIndicatorsNotNull();
            while(this._indicatorsUI.length)
            {
                _loc1_ = this._indicatorsUI.pop();
                IEventDispatcher(_loc1_).removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick);
                _loc1_.dispose();
            }
            this._indicatorsUI = null;
            super.onDispose();
        }
        
        private function assertSlotsEqualsIndicators() : void
        {
            var _loc1_:* = "_slotsUi length must be euqals _indicatorsUI length!";
            App.utils.asserter.assert(_slotsUi.length == this._indicatorsUI.length,_loc1_,InfrastructureException);
        }
        
        private function assertDropIndicatorsNotNull() : void
        {
            App.utils.asserter.assertNotNull(this._indicatorsUI,"_indicatorsUI" + Errors.CANT_NULL);
        }
    }
}
