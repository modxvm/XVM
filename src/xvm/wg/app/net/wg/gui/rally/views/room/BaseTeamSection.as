package net.wg.gui.rally.views.room
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IDropList;
    import flash.text.TextField;
    import net.wg.gui.rally.controls.ReadyMsg;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.rally.vo.ActionButtonVO;
    import net.wg.gui.rally.vo.VehicleVO;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.rally.BaseRallyMainWindow;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.gui.rally.controls.SlotDropIndicator;
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import net.wg.gui.rally.controls.RallyInvalidationType;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.Values;
    import net.wg.gui.rally.vo.RallySlotVO;
    import net.wg.infrastructure.exceptions.InfrastructureException;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.events.RallyViewsEvent;
    
    public class BaseTeamSection extends UIComponent implements IDropList
    {
        
        public function BaseTeamSection()
        {
            super();
        }
        
        public var lblTeamHeader:TextField;
        
        public var lblTeamMembers:TextField;
        
        public var lblTeamVehicles:TextField;
        
        public var lblStatus:ReadyMsg;
        
        public var btnFight:SoundButtonEx;
        
        public var btnNotReady:SoundButtonEx;
        
        protected var _slotsUi:Array;
        
        private var _indicatorsUI:Array;
        
        private var _rallyData:IRallyVO;
        
        private var _actionButtonData:ActionButtonVO;
        
        private var _isFightBtnInCoolDown:Boolean = false;
        
        private var _vehiclesLabel:String = "";
        
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
            this.updateIndicators(param1);
        }
        
        public function setOfflineStatus(param1:uint, param2:Boolean) : void
        {
            var _loc3_:IRallySlotVO = this.getSlotModel(param1);
            _loc3_.playerObj.isOffline = param2;
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
                this.updateIndicators(_loc3_);
                _loc3_++;
            }
            this.lblTeamMembers.htmlText = BaseRallyMainWindow.getTeamHeader(this.getMembersStr(),this._rallyData);
        }
        
        public function updateVehiclesHeader(param1:int, param2:int) : void
        {
            this.lblTeamVehicles.htmlText = App.utils.locale.makeString(this.getVehiclesStr(),{"current":Utils.instance.htmlWrapper(param1.toString(),Utils.instance.COLOR_NORMAL,13,"$FieldFont"),
            "max":param2.toString()
        });
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
    
    public function highlightSlots(param1:Array) : void
    {
        var _loc2_:* = 0;
        var _loc3_:* = 0;
        var _loc4_:SlotDropIndicator = null;
        if((this._rallyData) && (this._rallyData.isCommander))
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
    
    public function cooldownSlots(param1:Boolean) : void
    {
        var _loc2_:* = 0;
        var _loc3_:* = 0;
        var _loc4_:RallySimpleSlotRenderer = null;
        if((this._rallyData) && (this._rallyData.isCommander))
        {
            _loc3_ = this._slotsUi.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
                _loc4_ = this._slotsUi[_loc2_];
                _loc4_.cooldown(param1);
                _loc2_++;
            }
        }
    }
    
    public function highlightList() : void
    {
        var _loc1_:SlotDropIndicator = null;
        for each(_loc1_ in this._indicatorsUI)
        {
            this.highlightIndicator(_loc1_,true);
        }
    }
    
    public function hideHighLight() : void
    {
        var _loc1_:SlotDropIndicator = null;
        for each(_loc1_ in this._indicatorsUI)
        {
            this.highlightIndicator(_loc1_,false);
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
        this.lblTeamMembers.htmlText = BaseRallyMainWindow.getTeamHeader(this.getMembersStr(),this._rallyData);
        this.lblTeamVehicles.htmlText = this.getVehiclesStaticStr();
        this._slotsUi = this.getSlotsUI();
        this._indicatorsUI = this.getIndicatorsUI();
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
        var _loc1_:RallySimpleSlotRenderer = null;
        var _loc2_:SlotDropIndicator = null;
        this.btnFight.removeEventListener(ButtonEvent.CLICK,this.onReadyToggle);
        this.btnNotReady.removeEventListener(ButtonEvent.CLICK,this.onReadyToggle);
        for each(_loc1_ in this._slotsUi)
        {
            _loc1_.dispose();
        }
        for each(_loc2_ in this._indicatorsUI)
        {
            _loc2_.dispose();
        }
        this._slotsUi.splice();
        this._slotsUi = null;
        this._indicatorsUI.splice();
        this._indicatorsUI = null;
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
    
    protected function getSlotsUI() : Array
    {
        return [];
    }
    
    protected function getIndicatorsUI() : Array
    {
        return [];
    }
    
    protected function updateComponents() : void
    {
        var _loc3_:SlotDropIndicator = null;
        this.assertSlotsEqualsIndicators();
        var _loc1_:Boolean = this._rallyData?this._rallyData.isCommander:false;
        var _loc2_:Array = this._rallyData?this._rallyData.slotsArray:null;
        var _loc4_:RallySimpleSlotRenderer = null;
        var _loc5_:uint = Math.min(this._indicatorsUI.length,_loc2_.length);
        var _loc6_:IRallySlotVO = null;
        var _loc7_:Number = 0;
        while(_loc7_ < _loc5_)
        {
            _loc3_ = SlotDropIndicator(this._indicatorsUI[_loc7_]);
            _loc4_ = RallySimpleSlotRenderer(this._slotsUi[_loc7_]);
            _loc3_.index = _loc7_;
            _loc3_.isCurrentUserCommander = _loc1_;
            if(_loc2_ != null)
            {
                _loc6_ = IRallySlotVO(_loc2_[_loc3_.index]);
                _loc4_.slotData = _loc6_;
                _loc3_.update(_loc6_.player);
                _loc3_.playerStatus = _loc6_.playerStatus;
            }
            else
            {
                _loc4_.slotData = null;
                _loc3_.update(null);
                _loc3_.playerStatus = 0;
            }
            _loc7_++;
        }
    }
    
    private function assertSlotsEqualsIndicators() : void
    {
        var _loc1_:* = "_slotsUi length must be euqals _indicatorsUI length!";
        App.utils.asserter.assert(this._slotsUi.length == this._indicatorsUI.length,_loc1_,InfrastructureException);
    }
    
    protected function updateRenderIcon(param1:SlotDropIndicator) : void
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
    
    private function highlightIndicator(param1:SlotDropIndicator, param2:Boolean) : void
    {
        if((this._rallyData) && (this._rallyData.isCommander))
        {
            param1.setHighlightState(param2);
        }
    }
    
    private function updateIndicators(param1:uint) : void
    {
        var _loc2_:IRallySlotVO = this.getSlotModel(param1);
        SlotDropIndicator(this._indicatorsUI[param1]).update(_loc2_.playerObj);
        SlotDropIndicator(this._indicatorsUI[param1]).playerStatus = _loc2_.playerStatus;
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
}
}
