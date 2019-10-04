package net.wg.infrastructure.managers.counter
{
    import net.wg.utils.ICounterManager;
    import flash.utils.Dictionary;
    import flash.display.DisplayObject;
    import net.wg.gui.components.interfaces.INewCounter;
    import flash.geom.Point;
    import net.wg.utils.ICounterProps;
    import org.idmedia.as3commons.util.StringUtils;

    public class CounterManager extends Object implements ICounterManager
    {

        private static const DEFAULT_CONTAINER_ID:String = "defaultCountersContainer";

        public static const COUNTER_REMOVED:int = 0;

        public static const COUNTER_ADDED:int = 1;

        public static const COUNTER_UPDATED:int = 2;

        public static const COUNTER_EMPTY:String = " ";

        public static const DEF_COUNTER_NO_VIEWED_VALUE:String = "1";

        private var _countersContainers:Object;

        public function CounterManager()
        {
            super();
            this._countersContainers = {};
        }

        private static function getContainerId(param1:String) : String
        {
            return param1?param1:DEFAULT_CONTAINER_ID;
        }

        private static function containsCounter(param1:Dictionary, param2:DisplayObject) : Boolean
        {
            return param2 in param1;
        }

        private static function getCounter(param1:Dictionary, param2:DisplayObject) : INewCounter
        {
            return param1[param2];
        }

        private static function updateCounterOffset(param1:INewCounter, param2:Point) : void
        {
            param1.updatePosition(param2);
        }

        private static function updateCounterHorizontalAlign(param1:INewCounter, param2:String) : void
        {
            param1.updateHorizontalAlign(param2);
        }

        private static function updateCounterValue(param1:INewCounter, param2:String) : void
        {
            param1.setCount(param2);
        }

        public final function dispose() : void
        {
            var _loc2_:String = null;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc1_:Vector.<String> = new Vector.<String>();
            for(_loc2_ in this._countersContainers)
            {
                _loc1_.push(_loc2_);
            }
            _loc3_ = _loc1_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
                this.disposeCountersForContainer(_loc1_[_loc4_]);
                _loc4_++;
            }
            _loc1_.splice(0,_loc3_);
            App.utils.data.cleanupDynamicObject(this._countersContainers);
            this._countersContainers = null;
        }

        public function disposeCountersForContainer(param1:String) : Vector.<DisplayObject>
        {
            var _loc4_:Object = null;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var param1:String = getContainerId(param1);
            var _loc2_:Dictionary = this.getCountersForContainer(param1);
            var _loc3_:Vector.<DisplayObject> = null;
            if(_loc2_)
            {
                _loc3_ = new Vector.<DisplayObject>();
                for(_loc4_ in _loc2_)
                {
                    _loc3_.push(DisplayObject(_loc4_));
                }
                _loc5_ = _loc3_.length;
                _loc6_ = 0;
                while(_loc6_ < _loc5_)
                {
                    this.removeCounter(_loc3_[_loc6_],param1);
                    _loc6_++;
                }
                App.utils.data.cleanupDynamicObject(_loc2_);
                delete this._countersContainers[param1];
            }
            return _loc3_;
        }

        public function removeCounter(param1:DisplayObject, param2:String = null) : void
        {
            var _loc4_:INewCounter = null;
            var param2:String = getContainerId(param2);
            var _loc3_:Dictionary = this.getCountersForContainer(param2);
            if(_loc3_ && containsCounter(_loc3_,param1))
            {
                _loc4_ = getCounter(_loc3_,param1);
                delete _loc3_[param1];
                _loc4_.dispose();
            }
        }

        public function setCounter(param1:DisplayObject, param2:String, param3:String = null, param4:ICounterProps = null) : int
        {
            if(StringUtils.isEmpty(param2))
            {
                this.removeCounter(param1,param3);
                return COUNTER_REMOVED;
            }
            if(param4 == null)
            {
                var param4:ICounterProps = CounterProps.DEFAULT_PROPS;
            }
            var param3:String = getContainerId(param3);
            var _loc5_:Point = new Point(param4.offsetX,param4.offsetY);
            var _loc6_:Dictionary = this.getCountersForContainer(param3,true);
            var _loc7_:INewCounter = null;
            if(!containsCounter(_loc6_,param1))
            {
                _loc7_ = App.utils.classFactory.getComponent(param4.linkage,INewCounter);
                _loc6_[param1] = _loc7_;
                _loc7_.setTarget(param1,param2,_loc5_,param4.horizontalAlign,param4.addToTop,param4.tfPadding);
                return COUNTER_ADDED;
            }
            _loc7_ = getCounter(_loc6_,param1);
            updateCounterOffset(_loc7_,_loc5_);
            updateCounterHorizontalAlign(_loc7_,param4.horizontalAlign);
            updateCounterValue(_loc7_,param2);
            return COUNTER_UPDATED;
        }

        private function getCountersForContainer(param1:String, param2:Boolean = false) : Dictionary
        {
            if(param1 in this._countersContainers)
            {
                return this._countersContainers[param1];
            }
            if(param2)
            {
                this._countersContainers[param1] = new Dictionary();
                return this._countersContainers[param1];
            }
            return null;
        }
    }
}
