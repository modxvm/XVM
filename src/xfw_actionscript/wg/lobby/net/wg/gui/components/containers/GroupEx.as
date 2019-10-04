package net.wg.gui.components.containers
{
    import flash.display.DisplayObject;
    import scaleform.clik.interfaces.IDataProvider;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import scaleform.clik.interfaces.IListItemRenderer;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import flash.display.MovieClip;

    public class GroupEx extends Group implements IGroupEx
    {

        protected var renderers:Vector.<DisplayObject>;

        private var _dataProvider:IDataProvider;

        private var _itemRendererLinkage:String;

        public function GroupEx()
        {
            super();
            this.renderers = new Vector.<DisplayObject>();
        }

        override protected function configUI() : void
        {
            super.configUI();
            App.utils.asserter.assert(numChildren == 0,this.name + ".numChildren must be 0");
        }

        override protected function draw() : void
        {
            this.commitProperties();
            super.draw();
            validateChildren();
        }

        override protected function onDispose() : void
        {
            if(this._dataProvider)
            {
                this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler,false);
                this._dataProvider = null;
            }
            this._itemRendererLinkage = null;
            this.renderers.splice(0,this.renderers.length);
            this.renderers = null;
            super.onDispose();
        }

        public function getProviderLength() : uint
        {
            return this._dataProvider?this._dataProvider.length:0;
        }

        protected function numRenderers() : uint
        {
            return this.renderers.length;
        }

        protected function getRendererAt(param1:int) : DisplayObject
        {
            return this.renderers[param1];
        }

        protected function commitProperties() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:DisplayObject = null;
            var _loc5_:* = 0;
            if(isInvalid(InvalidationType.DATA))
            {
                _loc1_ = StringUtils.isNotEmpty(this._itemRendererLinkage);
                if(_loc1_)
                {
                    _loc2_ = this.getProviderLength();
                    _loc3_ = this.renderers.length;
                    if(_loc2_ < _loc3_)
                    {
                        this.removeRedundantChildren();
                    }
                    else if(_loc2_ > _loc3_)
                    {
                        this.addAdditionalChildren();
                    }
                    _loc5_ = 0;
                    while(_loc5_ < _loc2_)
                    {
                        _loc4_ = this.renderers[_loc5_];
                        if(_loc4_ is IListItemRenderer)
                        {
                            IListItemRenderer(_loc4_).index = _loc5_;
                        }
                        IUpdatable(_loc4_).update(this.getProviderItemAt(_loc5_));
                        _loc5_++;
                    }
                }
            }
        }

        protected function getProviderItemAt(param1:int) : Object
        {
            return this._dataProvider?this._dataProvider.requestItemAt(param1):null;
        }

        private function removeRedundantChildren() : void
        {
            var _loc3_:DisplayObject = null;
            var _loc1_:int = this.getProviderLength();
            var _loc2_:int = this.renderers.length;
            var _loc4_:int = _loc2_;
            while(_loc4_ > _loc1_)
            {
                _loc3_ = this.renderers.pop();
                removeChild(_loc3_);
                _loc4_--;
            }
        }

        private function addAdditionalChildren() : void
        {
            var _loc3_:DisplayObject = null;
            var _loc1_:int = this.getProviderLength();
            var _loc2_:int = this.renderers.length;
            var _loc4_:int = _loc2_;
            while(_loc4_ < _loc1_)
            {
                _loc3_ = App.utils.classFactory.getComponent(this._itemRendererLinkage,IUpdatable);
                this.renderers.push(_loc3_);
                addChild(_loc3_);
                _loc4_++;
            }
        }

        override public function set enabled(param1:Boolean) : void
        {
            if(param1 == super.enabled)
            {
                return;
            }
            super.enabled = param1;
            var _loc2_:int = this.renderers.length;
            var _loc3_:MovieClip = null;
            var _loc4_:* = 0;
            while(_loc4_ < _loc2_)
            {
                _loc3_ = MovieClip(this.getRendererAt(_loc4_));
                if(_loc3_)
                {
                    _loc3_.enabled = param1;
                }
                _loc4_++;
            }
        }

        public function get dataProvider() : IDataProvider
        {
            return this._dataProvider;
        }

        public function set dataProvider(param1:IDataProvider) : void
        {
            if(this._dataProvider == param1)
            {
                return;
            }
            if(this._dataProvider != null)
            {
                this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler,false);
            }
            this._dataProvider = param1;
            if(this._dataProvider == null)
            {
                return;
            }
            this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler,false,0,true);
            invalidateData();
        }

        public function get itemRendererLinkage() : String
        {
            return this._itemRendererLinkage;
        }

        public function set itemRendererLinkage(param1:String) : void
        {
            if(this._itemRendererLinkage != param1)
            {
                this._itemRendererLinkage = param1;
                invalidateData();
            }
        }

        private function onDataProviderChangeHandler(param1:Event) : void
        {
            invalidateData();
        }
    }
}
