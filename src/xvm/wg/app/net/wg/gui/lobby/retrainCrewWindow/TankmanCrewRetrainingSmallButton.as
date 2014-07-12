package net.wg.gui.lobby.retrainCrewWindow
{
    import net.wg.gui.components.controls.TankmanTrainingSmallButton;
    import flash.text.TextFormat;
    
    public class TankmanCrewRetrainingSmallButton extends TankmanTrainingSmallButton
    {
        
        public function TankmanCrewRetrainingSmallButton() {
            super();
        }
        
        private static var SMALL_TEXT_VAL:uint = 24;
        
        private static var BIG_TEXT_VAL:uint = 30;
        
        private var _crewInfo:Array;
        
        private var _currentVehicleType:String;
        
        private var _currentVehicleIntCD:int;
        
        override public function set level(param1:Number) : void {
            _level = param1;
            this.updateLevelLabel();
        }
        
        override protected function setEnabled() : void {
            var _loc1_:* = false;
            var _loc2_:RetrainTankmanVO = null;
            var _loc3_:* = 0;
            while(_loc3_ < this._crewInfo.length)
            {
                _loc2_ = this._crewInfo[_loc3_];
                if(_loc2_.nativeVehicleIntCD == this._currentVehicleIntCD)
                {
                    _loc1_ = _loc2_.realRoleLevel < level && (hasMoney);
                }
                else
                {
                    _loc1_ = hasMoney;
                }
                if(_loc1_)
                {
                    break;
                }
                _loc3_++;
            }
            enabled = _loc1_;
        }
        
        private function updateLevelLabel() : void {
            var _loc3_:* = 0;
            var _loc4_:RetrainTankmanVO = null;
            var _loc6_:uint = 0;
            var _loc7_:String = null;
            var _loc1_:* = 30000000;
            var _loc2_:* = 0;
            var _loc5_:* = 0;
            while(_loc5_ < this._crewInfo.length)
            {
                _loc4_ = this._crewInfo[_loc5_];
                _loc3_ = calculateCurrentLevel(this._currentVehicleType == _loc4_.nativeVehicleType,_loc4_.roleLevel,model.baseRoleLoss,model.classChangeRoleLoss,model.roleLevel);
                _loc1_ = _loc3_ < _loc1_?_loc3_:_loc1_;
                _loc2_ = _loc3_ > _loc2_?_loc3_:_loc2_;
                _loc5_++;
            }
            if(_loc2_ == _loc1_)
            {
                _loc6_ = BIG_TEXT_VAL;
                _loc7_ = _loc2_.toString();
            }
            else
            {
                _loc6_ = SMALL_TEXT_VAL;
                _loc7_ = _loc1_.toString() + "-" + _loc2_.toString();
            }
            var _loc8_:TextFormat = levelLabel.getTextFormat();
            _loc8_.size = _loc6_;
            levelLabel.setTextFormat(_loc8_);
            levelLabel.text = _loc7_ + "%";
        }
        
        public function set currentVehicleType(param1:String) : void {
            this._currentVehicleType = param1;
        }
        
        public function set crewInfo(param1:Array) : void {
            this._crewInfo = param1;
        }
        
        public function set currentVehicleIntCD(param1:int) : void {
            this._currentVehicleIntCD = param1;
        }
    }
}
