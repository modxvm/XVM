package net.wg.gui.lobby.profile.pages.statistics 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.components.chart.*;
    import net.wg.gui.lobby.profile.components.chart.axis.*;
    import net.wg.gui.lobby.profile.components.chart.layout.*;
    import scaleform.clik.interfaces.*;
    
    public class StatisticsBarChartAxis extends net.wg.gui.lobby.profile.components.chart.axis.AxisBase
    {
        public function StatisticsBarChartAxis()
        {
            super();
            return;
        }

        protected override function createPoint(arg1:Object):scaleform.clik.interfaces.IListItemRenderer
        {
            var loc1:*=new _pointClass();
            loc1.addEventListener(net.wg.gui.lobby.profile.components.SimpleLoader.LOADED, this.iconLoadingCompleteHandler, false, 0, true);
            addChild(loc1);
            return loc1;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(LAYOUT_INV)) 
            {
                this.layoutAll(currentLayout);
            }
            return;
        }

        internal function iconLoadingCompleteHandler(arg1:flash.events.Event):void
        {
            invalidate(LAYOUT_INV);
            return;
        }

        protected override function layoutPoint(arg1:scaleform.clik.interfaces.IListItemRenderer, arg2:net.wg.gui.lobby.profile.components.chart.IChartItem):void
        {
            var loc1:*=net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartItem(arg2);
            var loc2:*=loc1.getThumbDimensions();
            arg1.y = paddingTop;
            arg1.x = Math.round(loc1.x + (loc2.x - arg1.width >> 1));
            return;
        }

        protected override function layoutAll(arg1:net.wg.gui.lobby.profile.components.chart.layout.IChartLayout):void
        {
            var loc1:*=null;
            super.layoutAll(arg1);
            if (!renderers) 
            {
                return;
            }
            var loc2:*=0;
            while (loc2 < renderers.length) 
            {
                loc1 = net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartItem(renderers[loc2]);
                this.layoutPoint(_points[loc2], loc1);
                ++loc2;
            }
            if (loc1) 
            {
                var loc3:*;
                this.background.width = loc3 = loc1.x + loc1.getThumbDimensions().x + arg1.paddingRight;
                this.lineText.width = loc3;
                dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE, true));
            }
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            while (_points.length > 0) 
            {
                loc1 = _points.splice((_points.length - 1), 1)[0];
                try 
                {
                    loc1.dispose();
                    loc1.removeEventListener(net.wg.gui.lobby.profile.components.SimpleLoader.LOADED, this.iconLoadingCompleteHandler);
                }
                catch (e:Error)
                {
                };
                loc1 = null;
            }
            return;
        }

        internal static const paddingTop:int=112;

        internal static const LAYOUT_INV:String="layoutInv";

        public var background:flash.display.MovieClip;

        public var lineText:net.wg.gui.lobby.profile.components.LineTextComponent;
    }
}
