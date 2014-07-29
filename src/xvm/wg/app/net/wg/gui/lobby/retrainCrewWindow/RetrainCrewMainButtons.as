package net.wg.gui.lobby.retrainCrewWindow
{
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.controls.ButtonGroup;
    import net.wg.gui.components.controls.TankmanTrainingSmallButton;
    import flash.events.Event;
    import net.wg.data.constants.SoundTypes;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.IndexEvent;
    
    public class RetrainCrewMainButtons extends UIComponent
    {
        
        public function RetrainCrewMainButtons()
        {
            super();
        }
        
        private static var GROUP_NAME:String = "crewRetrainingGroup";
        
        private var btnGroup:ButtonGroup;
        
        public var academyBtn:TankmanTrainingSmallButton;
        
        public var schoolBtn:TankmanCrewRetrainingSmallButton;
        
        public var freeBtn:TankmanCrewRetrainingSmallButton;
        
        private var _crewInfo:Array;
        
        private var _operationData:RetrainCrewOperationVO;
        
        private var _selectedId:int = 0;
        
        private var _currentVehicleType:String;
        
        private var _currentVehicleIntCD:int;
        
        override protected function configUI() : void
        {
            var _loc2_:TankmanTrainingSmallButton = null;
            super.configUI();
            this.btnGroup = new ButtonGroup(GROUP_NAME,this);
            this.btnGroup.addButton(this.freeBtn);
            this.btnGroup.addButton(this.schoolBtn);
            this.btnGroup.addButton(this.academyBtn);
            this.btnGroup.addEventListener(Event.CHANGE,this.groupChangeHandler,false,0,true);
            var _loc1_:Array = [this.freeBtn,this.schoolBtn,this.academyBtn];
            var _loc3_:int = _loc1_.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                _loc2_ = TankmanTrainingSmallButton(_loc1_[_loc4_]);
                _loc2_.retraining = true;
                _loc2_.groupName = GROUP_NAME;
                _loc2_.toggle = true;
                _loc2_.soundType = SoundTypes.RNDR_NORMAL;
                _loc2_.allowDeselect = false;
                _loc4_++;
            }
        }
        
        override protected function draw() : void
        {
            var _loc1_:Array = null;
            var _loc2_:uint = 0;
            var _loc3_:RetrainTankmanVO = null;
            var _loc4_:uint = 0;
            var _loc5_:* = 0;
            var _loc6_:TankmanTrainingSmallButton = null;
            var _loc7_:TankmanCrewRetrainingSmallButton = null;
            var _loc8_:* = 0;
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this._operationData))
            {
                _loc1_ = [this.freeBtn,this.schoolBtn,this.academyBtn];
                _loc2_ = 0;
                _loc4_ = this._crewInfo.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    _loc3_ = this._crewInfo[_loc5_];
                    if(_loc2_ <= _loc3_.roleLevel)
                    {
                        _loc2_ = _loc3_.roleLevel;
                    }
                    _loc5_++;
                }
                _loc4_ = _loc1_.length;
                _loc8_ = 0;
                while(_loc8_ < _loc4_)
                {
                    _loc6_ = TankmanTrainingSmallButton(_loc1_[_loc8_]);
                    _loc7_ = _loc6_ as TankmanCrewRetrainingSmallButton;
                    if(_loc7_)
                    {
                        _loc7_.crewInfo = this._crewInfo;
                        _loc7_.currentVehicleType = this._currentVehicleType;
                        _loc7_.currentVehicleIntCD = this._currentVehicleIntCD;
                    }
                    _loc6_.setData(this._operationData.tankmanCost[_loc8_],this._operationData.gold,this._operationData.credits,_loc2_,false,false,_loc3_.nationID,this._operationData.actionPrc[_loc8_]);
                    _loc8_++;
                }
                this.autoSelectRetrainingButtons();
                this.groupChangeHandler();
            }
        }
        
        private function autoSelectRetrainingButtons() : void
        {
            var _loc3_:TankmanTrainingSmallButton = null;
            var _loc1_:Array = [this.freeBtn,this.schoolBtn,this.academyBtn];
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_.length)
            {
                _loc3_ = _loc1_[_loc2_] as TankmanTrainingSmallButton;
                if(_loc3_.enabled == true)
                {
                    _loc3_.selected = true;
                    return;
                }
                _loc2_++;
            }
        }
        
        private function groupChangeHandler(param1:Event = null) : void
        {
            this._selectedId = this.btnGroup.selectedIndex;
            dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,false,true,this._selectedId));
        }
        
        public function set crewInfo(param1:Array) : void
        {
            this._crewInfo = param1;
        }
        
        public function set operationData(param1:RetrainCrewOperationVO) : void
        {
            this._operationData = param1;
            invalidateData();
        }
        
        public function get operationData() : RetrainCrewOperationVO
        {
            return this._operationData;
        }
        
        override protected function onDispose() : void
        {
            this.btnGroup.removeEventListener(Event.CHANGE,this.groupChangeHandler);
            this.btnGroup.dispose();
            this._crewInfo = null;
            this._operationData = null;
            super.onDispose();
        }
        
        public function get selectedId() : int
        {
            return this._selectedId;
        }
        
        public function set currentVehicleType(param1:String) : void
        {
            this._currentVehicleType = param1;
        }
        
        public function set currentVehicleIntCD(param1:int) : void
        {
            this._currentVehicleIntCD = param1;
        }
    }
}
