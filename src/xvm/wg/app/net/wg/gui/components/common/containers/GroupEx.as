package net.wg.gui.components.common.containers
{
    import flash.display.DisplayObject;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.interfaces.IDataProvider;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    
    public class GroupEx extends Group
    {
        
        public function GroupEx()
        {
            super();
        }
        
        private var _dataProvider:Object;
        
        private var _itemRendererClass:Class;
        
        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:DisplayObject = null;
            var _loc3_:Object = null;
            var _loc4_:* = 0;
            var _loc5_:* = undefined;
            if((isInvalid(InvalidationType.DATA)) && (this._itemRendererClass))
            {
                _loc1_ = this.getProviderLength();
                while(_loc1_ < numChildren)
                {
                    _loc2_ = removeChildAt(numChildren - 1);
                    if(_loc2_ is IDisposable)
                    {
                        IDisposable(_loc2_).dispose();
                    }
                }
                _loc4_ = 0;
                while(_loc4_ < _loc1_)
                {
                    _loc3_ = this.getProviderItemAt(_loc4_);
                    if(_loc4_ == numChildren)
                    {
                        _loc5_ = new this._itemRendererClass();
                        addChild(_loc5_);
                    }
                    _loc2_ = getChildAt(_loc4_);
                    if(_loc2_.hasOwnProperty("data"))
                    {
                        _loc2_["data"] = _loc3_;
                    }
                    if(_loc5_)
                    {
                        if(_loc5_ is UIComponent)
                        {
                            _loc5_.validateNow();
                        }
                    }
                    _loc4_++;
                }
            }
            super.draw();
        }
        
        public function getProviderLength() : int
        {
            return this._dataProvider?this._dataProvider.length:0;
        }
        
        public function getProviderItemAt(param1:int) : Object
        {
            var _loc2_:Object = null;
            if(this._dataProvider is Array)
            {
                _loc2_ = this._dataProvider[param1];
            }
            else if(this._dataProvider is IDataProvider)
            {
                _loc2_ = IDataProvider(this._dataProvider).requestItemAt(param1);
            }
            
            return _loc2_;
        }
        
        public function get dataProvider() : Object
        {
            return this._dataProvider;
        }
        
        public function set dataProvider(param1:Object) : void
        {
            if(param1 == null)
            {
                if(!(this._dataProvider == null) && this._dataProvider is IEventDispatcher)
                {
                    IEventDispatcher(this._dataProvider).removeEventListener(Event.CHANGE,this.dataProviderChangeHandler);
                }
            }
            this._dataProvider = param1;
            if((this._dataProvider) && this._dataProvider is IEventDispatcher)
            {
                IEventDispatcher(this._dataProvider).addEventListener(Event.CHANGE,this.dataProviderChangeHandler,false,0,true);
            }
            invalidateData();
        }
        
        private function dataProviderChangeHandler(param1:Event) : void
        {
            invalidateData();
        }
        
        public function get itemRendererClass() : Class
        {
            return this._itemRendererClass;
        }
        
        public function set itemRendererClass(param1:Class) : void
        {
            if(this._itemRendererClass != param1)
            {
                this._itemRendererClass = param1;
                invalidateData();
            }
        }
        
        override protected function onDispose() : void
        {
            if(!(this._dataProvider == null) && this._dataProvider is IEventDispatcher)
            {
                IEventDispatcher(this._dataProvider).removeEventListener(Event.CHANGE,this.dataProviderChangeHandler);
            }
            this._dataProvider = null;
            this._itemRendererClass = null;
            super.onDispose();
        }
    }
}
