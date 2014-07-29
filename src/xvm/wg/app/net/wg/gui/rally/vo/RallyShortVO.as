package net.wg.gui.rally.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.interfaces.IRallyCandidateVO;
    import net.wg.data.VO.ExtendedUserVO;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    
    public class RallyShortVO extends DAAPIDataClass implements IRallyVO
    {
        
        public function RallyShortVO(param1:Object)
        {
            super(param1);
        }
        
        private static var SLOTS_FIELD:String = "slots";
        
        public var isFreezed:Boolean;
        
        private var _hasRestrictions:Boolean;
        
        public var slots:Vector.<RallySlotVO>;
        
        private var _description:String = "";
        
        private var _isCommander:Boolean = false;
        
        private var _statusValue:Boolean;
        
        private var _statusLbl:String = "";
        
        public function get slotsArray() : Array
        {
            var _loc1_:Array = new Array(this.slots.length);
            var _loc2_:int = this.slots.length;
            while(_loc2_--)
            {
                _loc1_[_loc2_] = this.slots[_loc2_];
            }
            return _loc1_;
        }
        
        public function isAvailable() : Boolean
        {
            return !(this.slots == null) && this.slots.length > 0;
        }
        
        public function get commander() : IRallyCandidateVO
        {
            var _loc2_:RallySlotVO = null;
            var _loc1_:IRallyCandidateVO = null;
            if(this.slots)
            {
                _loc2_ = this.slots[0];
                if(_loc2_.player)
                {
                    _loc1_ = _loc2_.player;
                }
            }
            return _loc1_;
        }
        
        public function get commanderVal() : ExtendedUserVO
        {
            return this.commander as ExtendedUserVO;
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:RallySlotVO = null;
            if(param1 == SLOTS_FIELD)
            {
                this.slots = new Vector.<RallySlotVO>();
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = new RallySlotVO(_loc4_);
                    this.slots.push(_loc5_);
                }
                return false;
            }
            return true;
        }
        
        override protected function onDataRead(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:RallySlotVO = null;
            if(param1 == SLOTS_FIELD)
            {
                _loc3_ = [];
                for each(_loc4_ in this.slots)
                {
                    _loc3_.push(_loc4_.toHash());
                }
                param2[param1] = _loc3_;
                return false;
            }
            return true;
        }
        
        public function get description() : String
        {
            return this._description;
        }
        
        public function set description(param1:String) : void
        {
            this._description = param1;
        }
        
        public function get isCommander() : Boolean
        {
            return this._isCommander;
        }
        
        public function set isCommander(param1:Boolean) : void
        {
            this._isCommander = param1;
        }
        
        public function get statusValue() : Boolean
        {
            return this._statusValue;
        }
        
        public function set statusValue(param1:Boolean) : void
        {
            this._statusValue = param1;
        }
        
        public function get statusLbl() : String
        {
            return this._statusLbl;
        }
        
        public function set statusLbl(param1:String) : void
        {
            this._statusLbl = param1;
        }
        
        public function clearSlots() : void
        {
            if(this.slots)
            {
                this.slots.splice(0,this.slots.length);
            }
        }
        
        public function addSlot(param1:IRallySlotVO) : void
        {
            this.slots.push(param1);
        }
        
        public function get hasRestrictions() : Boolean
        {
            var _loc1_:* = false;
            var _loc2_:* = 0;
            var _loc3_:RallySlotVO = null;
            var _loc4_:* = undefined;
            var _loc5_:* = false;
            if(this.slots)
            {
                _loc1_ = false;
                _loc2_ = 1;
                _loc5_ = false;
                while(_loc2_ < this.slots.length)
                {
                    _loc3_ = this.slots[_loc2_];
                    _loc5_ = false;
                    for each(_loc4_ in _loc3_.restrictions)
                    {
                        _loc5_ = (_loc5_) || !(_loc4_ == null);
                    }
                    _loc1_ = (_loc1_) || (_loc5_) && !_loc3_.isClosed;
                    if(_loc1_)
                    {
                        break;
                    }
                    _loc2_++;
                }
            }
            return _loc1_;
        }
        
        public function set hasRestrictions(param1:Boolean) : void
        {
            this._hasRestrictions = param1;
        }
    }
}
