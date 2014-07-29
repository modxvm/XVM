package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import net.wg.data.managers.impl.ToolTipParams;
    import net.wg.utils.ILocale;
    
    public class BuildingDirection extends SoundButtonEx implements IDisposable
    {
        
        public function BuildingDirection()
        {
            var _loc1_:ILocale = null;
            super();
            enabled = false;
            _stateMap[noneState] = [""];
            if(dirNamesArr == null)
            {
                _loc1_ = App.utils.locale;
                dirNamesArr = [_loc1_.makeString(FORTIFICATIONS.BUILDINGDIRECTION_LABEL1),_loc1_.makeString(FORTIFICATIONS.BUILDINGDIRECTION_LABEL2),_loc1_.makeString(FORTIFICATIONS.BUILDINGDIRECTION_LABEL3),_loc1_.makeString(FORTIFICATIONS.BUILDINGDIRECTION_LABEL4)];
            }
            _tooltip = FORTIFICATIONS.BUILDINGDIRECTION_TOOLTIP;
        }
        
        private static var noneState:String = "none";
        
        private static var dirNamesArr:Array;
        
        private static var ALPHA_DISABLED:Number = 0.33;
        
        private static var ALPHA_ENABLED:Number = 1;
        
        private var _uid:int = -1;
        
        private var _isOpen:Boolean;
        
        private var _isActive:Boolean;
        
        private var _disabled:Boolean;
        
        public var title:TextField;
        
        override protected function configUI() : void
        {
            super.configUI();
            hitMc.alpha = 0;
            toggle = false;
            this.updateState();
        }
        
        public function get disabled() : Boolean
        {
            return this._disabled;
        }
        
        public function set disabled(param1:Boolean) : void
        {
            this._disabled = param1;
            alpha = this._disabled?ALPHA_DISABLED:ALPHA_ENABLED;
        }
        
        public function get isOpen() : Boolean
        {
            return this._isOpen;
        }
        
        public function set isOpen(param1:Boolean) : void
        {
            this._isOpen = param1;
            this.updateState();
        }
        
        private function updateState() : void
        {
            this.setState(_state || "up");
        }
        
        public function get isActive() : Boolean
        {
            return this._isActive;
        }
        
        public function set isActive(param1:Boolean) : void
        {
            this._isActive = param1;
            enabled = this._isActive;
            this.updateState();
        }
        
        override protected function setState(param1:String) : void
        {
            var _loc2_:String = param1;
            if(!this._isActive)
            {
                _loc2_ = noneState;
            }
            super.setState(_loc2_);
            _state = param1;
        }
        
        override protected function getStatePrefixes() : Vector.<String>
        {
            if(this._isActive)
            {
                return statesDefault;
            }
            if(this._isOpen)
            {
                return Vector.<String>(["opened"]);
            }
            return Vector.<String>(["closed"]);
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
        }
        
        override public function showTooltip(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            if((tooltip) && (this._isActive))
            {
                _loc2_ = this.getTitle();
                App.toolTipMgr.showComplexWithParams(tooltip,new ToolTipParams({"value":_loc2_},{"value":_loc2_}));
            }
        }
        
        public function get uid() : int
        {
            return this._uid;
        }
        
        public function set uid(param1:int) : void
        {
            this._uid = param1;
            this.title.text = this.getTitle();
        }
        
        override protected function updateAfterStateChange() : void
        {
            super.updateAfterStateChange();
            this.title.text = this.getTitle();
        }
        
        private function getTitle() : String
        {
            var _loc1_:int = this._uid - 1;
            return _loc1_ > -1?dirNamesArr[_loc1_]:"";
        }
    }
}
