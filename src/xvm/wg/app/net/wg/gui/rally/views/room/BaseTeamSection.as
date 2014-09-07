package net.wg.gui.rally.views.room
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.rally.interfaces.IBaseTeamSection;
    import flash.text.TextField;
    import net.wg.gui.rally.controls.ReadyMsg;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.rally.vo.ActionButtonVO;
    import net.wg.gui.rally.vo.VehicleVO;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.rally.BaseRallyMainWindow;
    import net.wg.gui.rally.controls.RallyInvalidationType;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.Values;
    import net.wg.gui.rally.vo.RallySlotVO;
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.data.constants.Errors;
    
    public class BaseTeamSection extends UIComponent implements IBaseTeamSection
    {
        
        public function BaseTeamSection()
        {
            super();
        }
        
        public var lblTeamMembers:TextField;
        
        public var lblTeamVehicles:TextField;
        
        public var lblStatus:ReadyMsg;
        
        public var btnFight:SoundButtonEx;
        
        public var btnNotReady:SoundButtonEx;
        
        protected var _slotsUi:Vector.<IRallySimpleSlotRenderer>;
        
        private var _rallyData:IRallyVO;
        
        private var _actionButtonData:ActionButtonVO;
        
        private var _isFightBtnInCoolDown:Boolean = false;
        
        private var _vehiclesLabel:String = "";
        
        private var _teamLabel:String = "";
        
        public function setMemberVehicle(param1:uint, param2:uint, param3:VehicleVO) : void
        {
            var _loc4_:IRallySlotVO = this.getSlotModel(param1);
            _loc4_.selectedVehicle = param3;
            _loc4_.selectedVehicleLevel = param2;
            this.setSlotModel(param1,_loc4_);
        }
        
        public function setMemberStatus(param1:uint, param2:uint) : void
        {
            var _loc3_:IRallySlotVO = this.getSlotModel(param1);
            _loc3_.playerStatus = param2;
            this.setSlotModel(param1,_loc3_);
        }
        
        public function setOfflineStatus(param1:uint, param2:Boolean) : void
        {
            var _loc3_:IRallySlotVO = this.getSlotModel(param1);
            _loc3_.player.isOffline = param2;
            this.setSlotModel(param1,_loc3_);
        }
        
        public function updateMembers(param1:Boolean, param2:Array) : void
        {
            var _loc3_:* = 0;
            var _loc5_:IRallySlotVO = null;
            var _loc4_:int = param2.length;
            this._rallyData.clearSlots();
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
                _loc5_ = this.getSlotVO(param2[_loc3_]);
                this._rallyData.addSlot(_loc5_);
                _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
                this.setSlotModel(_loc3_,this._rallyData.slotsArray[_loc3_] as IRallySlotVO);
                _loc3_++;
            }
            this.lblTeamMembers.htmlText = BaseRallyMainWindow.getTeamHeader(this.getMembersStr(),this._rallyData);
        }
        
        public function enableFightButton(param1:Boolean) : void
        {
            this._isFightBtnInCoolDown = !param1;
            if(this.btnFight)
            {
                this.btnFight.enabled = (param1) && (this._actionButtonData?this._actionButtonData.isEnabled:true);
            }
            if(this.btnNotReady)
            {
                this.btnNotReady.enabled = (param1) && (this._actionButtonData?this._actionButtonData.isEnabled:true);
            }
        }
        
        public function get actionButtonData() : ActionButtonVO
        {
            return this._actionButtonData;
        }
        
        public function set actionButtonData(param1:ActionButtonVO) : void
        {
            this._actionButtonData = param1;
            invalidate(RallyInvalidationType.ACTION_BUTTON_DATA);
        }
        
        public function set teamLabel(param1:String) : void
        {
            this._teamLabel = param1;
            invalidate(RallyInvalidationType.TEAM_LABEL);
        }
        
        public function set vehiclesLabel(param1:String) : void
        {
            this._vehiclesLabel = param1;
            invalidate(RallyInvalidationType.VEHICLE_LABEL);
        }
        
        public function get selectable() : Boolean
        {
            return false;
        }
        
        public function set selectable(param1:Boolean) : void
        {
        }
        
        public function get rallyData() : IRallyVO
        {
            return this._rallyData;
        }
        
        public function set rallyData(param1:IRallyVO) : void
        {
            this._rallyData = param1;
            invalidate(RallyInvalidationType.RALLY_DATA);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.teamLabel = BaseRallyMainWindow.getTeamHeader(this.getMembersStr(),this._rallyData);
            this.vehiclesLabel = this.getVehiclesStaticStr();
            this._slotsUi = this.getSlotsUI();
            this.btnFight.addEventListener(ButtonEvent.CLICK,this.onReadyToggle);
            this.btnNotReady.addEventListener(ButtonEvent.CLICK,this.onReadyToggle);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(RallyInvalidationType.VEHICLE_LABEL))
            {
                this.lblTeamVehicles.htmlText = this._vehiclesLabel;
            }
            if(isInvalid(RallyInvalidationType.TEAM_LABEL))
            {
                this.lblTeamMembers.htmlText = this._teamLabel;
            }
            if((isInvalid(RallyInvalidationType.RALLY_DATA)) && (this._rallyData))
            {
                this.updateComponents();
            }
            if(isInvalid(RallyInvalidationType.ACTION_BUTTON_DATA))
            {
                if(this._actionButtonData)
                {
                    this.lblStatus.setMessage(this._actionButtonData.stateString,this._actionButtonData.isEnabled?"gray":"red");
                    this.btnFight.enabled = (this._actionButtonData.isEnabled) && !this._isFightBtnInCoolDown;
                    this.btnFight.label = this._actionButtonData.label;
                    this.btnFight.visible = !this._actionButtonData.isReady;
                    this.btnNotReady.enabled = (this._actionButtonData.isEnabled) && !this._isFightBtnInCoolDown;
                    this.btnNotReady.label = this._actionButtonData.label;
                    this.btnNotReady.visible = this._actionButtonData.isReady;
                }
                else
                {
                    this.lblStatus.setMessage(Values.EMPTY_STR,"gray");
                    this.btnFight.enabled = false;
                    this.btnFight.label = Values.EMPTY_STR;
                    this.btnNotReady.enabled = false;
                    this.btnNotReady.label = Values.EMPTY_STR;
                }
            }
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:IRallySimpleSlotRenderer = null;
            this.btnFight.removeEventListener(ButtonEvent.CLICK,this.onReadyToggle);
            this.btnFight.dispose();
            this.btnFight = null;
            this.btnNotReady.removeEventListener(ButtonEvent.CLICK,this.onReadyToggle);
            this.btnNotReady.dispose();
            this.btnNotReady = null;
            this.assertSlotsNotNull();
            while(this._slotsUi.length)
            {
                _loc1_ = this._slotsUi.pop();
                _loc1_.dispose();
            }
            this._slotsUi = null;
            super.onDispose();
        }
        
        protected function getSlotVO(param1:Object) : IRallySlotVO
        {
            return new RallySlotVO(param1);
        }
        
        protected function getMembersStr() : String
        {
            return null;
        }
        
        protected function getVehiclesStr() : String
        {
            return null;
        }
        
        protected function getVehiclesStaticStr() : String
        {
            return null;
        }
        
        protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
        {
            return new Vector.<IRallySimpleSlotRenderer>();
        }
        
        protected function updateComponents() : void
        {
            var _loc5_:* = NaN;
            var _loc1_:Array = this._rallyData?this._rallyData.slotsArray:null;
            var _loc2_:RallySimpleSlotRenderer = null;
            var _loc3_:IRallySlotVO = null;
            this.assertSlotsNotNull();
            var _loc4_:Number = 0;
            while(_loc4_ < _loc1_.length)
            {
                _loc2_ = RallySimpleSlotRenderer(this._slotsUi[_loc4_]);
                _loc5_ = this._slotsUi.indexOf(_loc2_);
                if(_loc1_ != null)
                {
                    _loc3_ = IRallySlotVO(_loc1_[_loc5_]);
                }
                _loc2_.slotData = _loc3_;
                _loc4_++;
            }
        }
        
        protected function updateRenderIcon(param1:ISlotDropIndicator) : void
        {
        }
        
        protected function tooltipSubscribe(param1:Array, param2:Boolean = true) : void
        {
            var _loc3_:DisplayObject = null;
            for each(_loc3_ in param1)
            {
                if(param2)
                {
                    _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
                    _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
                }
                else
                {
                    _loc3_.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
                    _loc3_.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
                }
            }
        }
        
        protected function getSlotModel(param1:uint) : IRallySlotVO
        {
            return IRallySlotVO(this._rallyData.slotsArray[param1]);
        }
        
        protected function setSlotModel(param1:uint, param2:IRallySlotVO) : void
        {
            RallySimpleSlotRenderer(this._slotsUi[param1]).slotData = param2;
        }
        
        private function onReadyToggle(param1:ButtonEvent) : void
        {
            var _loc2_:Object = {"uiid":param1.target.UIID,
            "arg":(this._rallyData.isCommander?0:1)
        };
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.TOGGLE_READY_STATE_REQUEST,_loc2_));
    }
    
    protected function onControlRollOver(param1:MouseEvent) : void
    {
    }
    
    protected function onControlRollOut(param1:MouseEvent) : void
    {
        App.toolTipMgr.hide();
    }
    
    public function highlightSlots(param1:Array) : void
    {
    }
    
    public function cooldownSlots(param1:Boolean) : void
    {
    }
    
    private function assertSlotsNotNull() : void
    {
        App.utils.asserter.assertNotNull(this._slotsUi,"_slotsUi" + Errors.CANT_NULL);
    }
}
}
