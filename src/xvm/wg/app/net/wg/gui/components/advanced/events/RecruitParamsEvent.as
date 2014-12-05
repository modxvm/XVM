package net.wg.gui.components.advanced.events
{
    import flash.events.Event;
    
    public class RecruitParamsEvent extends Event
    {
        
        public function RecruitParamsEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
        
        public static var VEHICLE_TYPE_CHANGED:String = "vTypeChanged";
        
        public static var NATION_CHANGED:String = "nationChanged";
        
        public static var VEHICLE_CLASS_CHANGED:String = "vClassChanged";
        
        public var nation:Number;
        
        public var vclass:String;
        
        public var vtype:Number;
        
        override public function clone() : Event
        {
            var _loc1_:RecruitParamsEvent = new RecruitParamsEvent(type,bubbles,cancelable);
            _loc1_.nation = this.nation;
            _loc1_.vclass = this.vclass;
            _loc1_.vtype = this.vtype;
            return _loc1_;
        }
        
        override public function toString() : String
        {
            return formatToString("RecruitParamsEvent","type","bubbles","cancelable","eventPhase");
        }
    }
}
