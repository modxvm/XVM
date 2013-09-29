package net.wg.gui.lobby.profile.components.chart 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.lobby.profile.components.chart.layout.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.interfaces.*;
    
    public class ChartBase extends scaleform.clik.core.UIComponent
    {
        public function ChartBase()
        {
            this._renderers = new Vector.<net.wg.gui.lobby.profile.components.chart.IChartItem>();
            super();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            super.draw();
            if (isInvalid(RENDERER_CLASS_INV)) 
            {
                while (this._renderers.length > 0) 
                {
                    this.removeRendererAt((this._renderers.length - 1));
                }
                invalidateData();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.updateRenderers();
            }
            if (isInvalid(LAYOUT_INV) && this._currentLayout) 
            {
                loc1 = 0;
                while (loc1 < this._renderers.length) 
                {
                    this._currentLayout.layout(loc1, this._renderers[loc1]);
                    ++loc1;
                }
                dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE, true));
            }
            return;
        }

        protected function updateRenderers():void
        {
            var loc1:*=null;
            var loc3:*=null;
            while (this._renderers.length > this.getDataProviderLength()) 
            {
                this.removeRendererAt((this._renderers.length - 1));
            }
            var loc2:*=this.getDataProviderLength();
            var loc4:*=0;
            while (loc4 < loc2) 
            {
                loc3 = this._dataProvider[loc4];
                if (loc4 != this._renderers.length) 
                {
                    loc1 = this._renderers[loc4];
                }
                else if (this._itemRenderer) 
                {
                    loc1 = this.createRenderer();
                    invalidate(LAYOUT_INV);
                }
                else 
                {
                    trace("Class of item renderer in Chart has not been defined! Please Define it!");
                    return;
                }
                loc1.setData(loc3);
                ++loc4;
            }
            return;
        }

        internal function removeRendererAt(arg1:uint):void
        {
            var loc1:*=this._renderers.splice(arg1, 1)[0];
            var loc2:*=flash.display.DisplayObject(loc1);
            loc2.parent.removeChild(loc2);
            if (loc1 is net.wg.infrastructure.interfaces.entity.IDisposable) 
            {
                net.wg.infrastructure.interfaces.entity.IDisposable(loc1).dispose();
            }
            loc1 = null;
            return;
        }

        internal function createRenderer():net.wg.gui.lobby.profile.components.chart.IChartItem
        {
            var loc1:*=new this._itemRenderer();
            this._renderers.push(loc1);
            addChild(flash.display.DisplayObject(loc1));
            return loc1;
        }

        internal function getDataProviderLength():int
        {
            if (this._dataProvider) 
            {
                return this._dataProvider.length;
            }
            return 0;
        }

        public function get itemRenderer():Class
        {
            return this._itemRenderer;
        }

        public function set itemRenderer(arg1:Class):void
        {
            this._itemRenderer = arg1;
            invalidate(RENDERER_CLASS_INV);
            return;
        }

        public function get itemRendererName():String
        {
            return this._itemRendererName;
        }

        public function set itemRendererName(arg1:String):void
        {
            var loc1:*=null;
            if (_inspector && arg1 == "" || arg1 == "") 
            {
                return;
            }
            this._itemRendererName = arg1;
            if (App.utils) 
            {
                loc1 = App.utils.classFactory.getClass(arg1);
            }
            else 
            {
                loc1 = flash.utils.getDefinitionByName(arg1) as Class;
            }
            if (loc1 == null) 
            {
                trace("Error: " + this + ", The class " + arg1 + " cannot be found in your library. Please ensure it is there.");
            }
            else 
            {
                this.itemRenderer = loc1;
            }
            return;
        }

        public function get dataProvider():scaleform.clik.interfaces.IDataProvider
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            if (this._dataProvider == arg1) 
            {
                return;
            }
            if (this._dataProvider != null) 
            {
                this._dataProvider.removeEventListener(flash.events.Event.CHANGE, this.handleDataChange, false);
            }
            this._dataProvider = arg1;
            if (this._dataProvider == null) 
            {
                return;
            }
            this._dataProvider.addEventListener(flash.events.Event.CHANGE, this.handleDataChange, false, 0, true);
            invalidateData();
            return;
        }

        protected function handleDataChange(arg1:flash.events.Event):void
        {
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        public function get currentLayout():net.wg.gui.lobby.profile.components.chart.layout.IChartLayout
        {
            return this._currentLayout;
        }

        public function set currentLayout(arg1:net.wg.gui.lobby.profile.components.chart.layout.IChartLayout):void
        {
            this._currentLayout = arg1;
            invalidate(LAYOUT_INV);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            super.dispose();
            while (this._renderers.length > 0) 
            {
                loc1 = this._renderers.splice((this._renderers.length - 1), 1)[0];
                try 
                {
                    loc1.dispose();
                }
                catch (e:Error)
                {
                };
                loc1 = null;
            }
            if (this._dataProvider) 
            {
                this._dataProvider = null;
            }
            return;
        }

        internal static const RENDERER_CLASS_INV:String="rendererClassInvalid";

        protected static const LAYOUT_INV:String="layoutInvalid";

        internal var _itemRenderer:Class;

        protected var _itemRendererName:String="";

        internal var _dataProvider:scaleform.clik.interfaces.IDataProvider;

        protected var _renderers:__AS3__.vec.Vector.<net.wg.gui.lobby.profile.components.chart.IChartItem>;

        internal var _currentLayout:net.wg.gui.lobby.profile.components.chart.layout.IChartLayout;
    }
}
