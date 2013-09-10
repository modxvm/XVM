package net.wg.gui.lobby.profile.components.chart.axis 
{
    import __AS3__.vec.*;
    import net.wg.gui.lobby.profile.components.chart.*;
    import net.wg.gui.lobby.profile.components.chart.layout.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.interfaces.*;
    
    public class AxisBase extends scaleform.clik.core.UIComponent implements net.wg.gui.lobby.profile.components.chart.axis.IChartAxis
    {
        public function AxisBase()
        {
            this._points = [];
            super();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=0;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                loc2 = this._data ? this._data.length : 0;
                while (this._points.length > loc2) 
                    this.removePointAt((this._points.length - 1));
                loc4 = 0;
                while (loc4 < loc2) 
                {
                    loc3 = this._data[loc4];
                    if (loc4 != this._points.length) 
                        loc1 = this._points[loc4];
                    else 
                    {
                        loc1 = this.createPoint(loc3);
                        this._points.push(loc1);
                    }
                    this.layoutPoint(loc1, this.renderers[loc4]);
                    loc1.setData(loc3);
                    ++loc4;
                }
                if (loc2 > 0) 
                    this.layoutAll(this.currentLayout);
            }
            return;
        }

        public function setData(arg1:scaleform.clik.interfaces.IDataProvider, arg2:__AS3__.vec.Vector.<net.wg.gui.lobby.profile.components.chart.IChartItem>, arg3:net.wg.gui.lobby.profile.components.chart.layout.IChartLayout):void
        {
            this._data = arg1;
            this.currentLayout = arg3;
            this.renderers = arg2;
            invalidateData();
            return;
        }

        protected function layoutAll(arg1:net.wg.gui.lobby.profile.components.chart.layout.IChartLayout):void
        {
            return;
        }

        protected function layoutPoint(arg1:scaleform.clik.interfaces.IListItemRenderer, arg2:net.wg.gui.lobby.profile.components.chart.IChartItem):void
        {
            return;
        }

        protected function createPoint(arg1:Object):scaleform.clik.interfaces.IListItemRenderer
        {
            throw new Error("this method should be overridden");
        }

        protected function removePointAt(arg1:uint):Object
        {
            var loc1:*=this._points.splice(arg1, 1)[0];
            if (loc1 is net.wg.infrastructure.interfaces.entity.IDisposable) 
                net.wg.infrastructure.interfaces.entity.IDisposable(loc1).dispose();
            return loc1;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            super.dispose();
            this._data = null;
            this.currentLayout = null;
            this.renderers = null;
            while (this._points.length > 0) 
            {
                loc1 = this._points.splice((this._points.length - 1), 1)[0];
                try 
                    loc1.dispose();
                catch (e:Error)
                {
                };
                loc1 = null;
            }
            return;
        }

        public function get pointClass():Class
        {
            return this._pointClass;
        }

        public function set pointClass(arg1:Class):void
        {
            this._pointClass = arg1;
            invalidateData();
            return;
        }

        protected var _points:Array;

        protected var currentLayout:net.wg.gui.lobby.profile.components.chart.layout.IChartLayout;

        protected var renderers:__AS3__.vec.Vector.<net.wg.gui.lobby.profile.components.chart.IChartItem>;

        internal var _data:scaleform.clik.interfaces.IDataProvider;

        protected var _pointClass:Class;
    }
}
