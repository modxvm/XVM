package net.wg.gui.lobby.profile.components.chart 
{
    import flash.display.*;
    import flash.utils.*;
    import net.wg.gui.lobby.profile.components.chart.axis.*;
    import scaleform.clik.constants.*;
    
    public class AxisChart extends net.wg.gui.lobby.profile.components.chart.ChartBase
    {
        public function AxisChart()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA, LAYOUT_INV)) 
                this.applyAxisUpdate();
            return;
        }

        internal function applyAxisUpdate():void
        {
            if (this._horizontalAxis) 
                this._horizontalAxis.setData(dataProvider, _renderers, currentLayout);
            return;
        }

        public function get horizontalAxis():net.wg.gui.lobby.profile.components.chart.axis.IChartAxis
        {
            return this._horizontalAxis;
        }

        public function set horizontalAxis(arg1:net.wg.gui.lobby.profile.components.chart.axis.IChartAxis):void
        {
            var loc1:*=null;
            if (this._horizontalAxis) 
            {
                loc1 = flash.display.DisplayObject(this._horizontalAxis);
                loc1.parent.removeChild(loc1);
            }
            this._horizontalAxis = arg1;
            addChild(flash.display.DisplayObject(this._horizontalAxis));
            this.applyAxisUpdate();
            return;
        }

        public function get horizontalAxisName():String
        {
            return this._horizontalAxisName;
        }

        public function set horizontalAxisName(arg1:String):void
        {
            var loc1:*=null;
            if (this._horizontalAxisName != arg1) 
            {
                this._horizontalAxisName = arg1;
                if (!(this._horizontalAxisName == null) || !(this._horizontalAxisName == "")) 
                {
                    if (App.utils) 
                        loc1 = net.wg.gui.lobby.profile.components.chart.axis.IChartAxis(App.utils.classFactory.getObject(this._horizontalAxisName));
                    else 
                        loc1 = net.wg.gui.lobby.profile.components.chart.axis.IChartAxis(flash.utils.getDefinitionByName(this._horizontalAxisName));
                    this.horizontalAxis = loc1;
                }
            }
            return;
        }

        public override function dispose():void
        {
            if (this._horizontalAxis) 
            {
                this._horizontalAxis.dispose();
                this._horizontalAxis = null;
            }
            super.dispose();
            return;
        }

        internal var _horizontalAxis:net.wg.gui.lobby.profile.components.chart.axis.IChartAxis;

        internal var _horizontalAxisName:String;
    }
}
