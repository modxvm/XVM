package net.wg.gui.components.damageIndicator
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Shape;
    import flash.display.DisplayObjectContainer;
    import net.wg.gui.utils.RootSWFAtlasManager;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import flash.utils.Dictionary;
    import net.wg.infrastructure.events.AtlasEvent;
    import net.wg.data.constants.generated.DAMAGEINDICATOR;

    public class StandardStateContainer extends MovieClip implements IDisposable
    {

        private static const BLOCK_Y_OFFSET:int = -592;

        private static const DAMAGE_Y_OFFSET:int = -565;

        private static const POWER_HIGH:String = "high";

        private static const POWER_MEDIUM:String = "medium";

        private static const POWER_LOW:String = "low";

        private static const BG_STR_DELIM:String = ":";

        protected var statesBG:Dictionary = null;

        protected var currentState:Shape = null;

        protected var currentBGStr:String;

        protected var offsetY:int = 0;

        private var _powerAlpha:Dictionary;

        public function StandardStateContainer()
        {
            this._powerAlpha = new Dictionary();
            super();
            this._powerAlpha[POWER_HIGH] = 1;
            this._powerAlpha[POWER_MEDIUM] = 0.6;
            this._powerAlpha[POWER_LOW] = 0.3;
        }

        protected static function createIndicatorAtlasShape(param1:String, param2:DisplayObjectContainer) : Shape
        {
            var _loc3_:Shape = new Shape();
            RootSWFAtlasManager.instance.drawWithCenterAlign(ATLAS_CONSTANTS.DAMAGE_INDICATOR,param1,_loc3_.graphics,true,true);
            param2.addChildAt(_loc3_,0);
            _loc3_.visible = false;
            return _loc3_;
        }

        protected static function createItemsFromAtlas(param1:Vector.<String>, param2:DisplayObjectContainer, param3:Dictionary) : Dictionary
        {
            var _loc6_:Shape = null;
            var _loc7_:String = null;
            var _loc4_:Dictionary = param3;
            if(param3 == null)
            {
                _loc4_ = new Dictionary();
            }
            var _loc5_:int = param1.length;
            var _loc8_:* = 0;
            while(_loc8_ < _loc5_)
            {
                _loc7_ = param1[_loc8_];
                _loc6_ = createIndicatorAtlasShape(param1[_loc8_],param2);
                _loc4_[_loc7_] = _loc6_;
                _loc8_++;
            }
            return _loc4_;
        }

        public function dispose() : void
        {
            RootSWFAtlasManager.instance.removeEventListener(AtlasEvent.ATLAS_INITIALIZED,this.onAtlasInitializedHandler);
            this.cleanupDynamicObject(this.statesBG);
            this.cleanupDynamicObject(this._powerAlpha);
            this.statesBG = null;
            this.currentState = null;
            this._powerAlpha = null;
        }

        public function init() : void
        {
            this.statesBG = createItemsFromAtlas(this.stateNames,this,null);
            RootSWFAtlasManager.instance.addEventListener(AtlasEvent.ATLAS_INITIALIZED,this.onAtlasInitializedHandler);
            this.currentState = this.statesBG[DAMAGEINDICATOR.DAMAGE_STANDARD];
        }

        public function rotateInfo(param1:Number) : void
        {
        }

        public function setYOffset(param1:int) : void
        {
            this.offsetY = param1;
            this.updatePosition();
        }

        public function updateBGState(param1:String) : void
        {
            var _loc4_:String = null;
            var _loc2_:Array = param1.split(BG_STR_DELIM);
            var _loc3_:Number = 1;
            if(_loc2_.length == 2)
            {
                _loc4_ = _loc2_[1];
                if(this._powerAlpha[_loc4_] != null)
                {
                    _loc3_ = this._powerAlpha[_loc4_];
                    var param1:String = _loc2_[0];
                }
            }
            if(this.currentBGStr != param1)
            {
                this.currentBGStr = param1;
                this.currentState.visible = false;
                this.currentState = this.statesBG[param1];
                this.currentState.visible = true;
            }
            this.currentState.alpha = _loc3_;
        }

        protected function cleanupDynamicObject(param1:Object) : Object
        {
            var _loc3_:* = undefined;
            var _loc2_:Array = [];
            for(_loc3_ in param1)
            {
                _loc2_.push(_loc3_);
            }
            for each(_loc3_ in _loc2_)
            {
                delete param1[_loc3_];
            }
            _loc2_.splice(0,_loc2_.length);
            return null;
        }

        protected function updatePosition() : void
        {
            this.statesBG[DAMAGEINDICATOR.BLOCKED_STANDARD].y = BLOCK_Y_OFFSET + this.offsetY;
            var _loc1_:int = DAMAGE_Y_OFFSET + this.offsetY;
            this.statesBG[DAMAGEINDICATOR.DAMAGE_STANDARD].y = _loc1_;
            this.statesBG[DAMAGEINDICATOR.DAMAGE_STANDARD_BLIND].y = _loc1_;
        }

        protected function get stateNames() : Vector.<String>
        {
            return new <String>[DAMAGEINDICATOR.DAMAGE_STANDARD,DAMAGEINDICATOR.DAMAGE_STANDARD_BLIND,DAMAGEINDICATOR.BLOCKED_STANDARD];
        }

        private function onAtlasInitializedHandler(param1:AtlasEvent) : void
        {
            this.updatePosition();
        }
    }
}
