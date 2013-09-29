package net.wg.gui.lobby.profile.pages.statistics 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public class TechniqueStatistics extends scaleform.clik.core.UIComponent
    {
        public function TechniqueStatistics()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.typeChart.mainHorizontalAxis.pointClass = net.wg.gui.lobby.profile.pages.statistics.AxisPointTypes;
            this.nationChart.mainHorizontalAxis.pointClass = net.wg.gui.lobby.profile.pages.statistics.AxisPointNations;
            this.levelChart.mainHorizontalAxis.pointClass = net.wg.gui.lobby.profile.pages.statistics.AxisPointLevels;
            addEventListener(flash.events.Event.RESIZE, this.resizeMainHandler, false, 0, true);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            super.draw();
            if (isInvalid(LAYOUT_INV) && this.currentDimension) 
            {
                loc1 = new Vector.<scaleform.clik.core.UIComponent>(0);
                loc1.push(this.typeChart);
                loc1.push(this.nationChart);
                loc1.push(this.levelChart);
                loc2 = loc1.length;
                loc3 = 0;
                var loc8:*=0;
                var loc9:*=loc1;
                for each (loc4 in loc9) 
                {
                    loc3 = loc3 + Math.round(loc4.actualWidth);
                }
                loc6 = loc5 = Math.round((this.currentDimension.x - loc3) / (loc2 + 1));
                loc7 = 0;
                while (loc7 < loc2) 
                {
                    (loc4 = loc1[loc7]).x = loc6;
                    loc6 = loc6 + Math.round(loc4.actualWidth + loc5);
                    ++loc7;
                }
            }
            return;
        }

        internal function resizeMainHandler(arg1:flash.events.Event):void
        {
            arg1.stopImmediatePropagation();
            invalidate(LAYOUT_INV);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(flash.events.Event.RESIZE, this.resizeMainHandler);
            this.typeChart.dispose();
            this.nationChart.dispose();
            this.levelChart.dispose();
            return;
        }

        public function setChartsTitles(arg1:Array):void
        {
            this.typeChart.mainHorizontalAxis.lineText.text = arg1[0];
            this.nationChart.mainHorizontalAxis.lineText.text = arg1[1];
            this.levelChart.mainHorizontalAxis.lineText.text = arg1[2];
            return;
        }

        public function setDossierData(arg1:net.wg.data.gui_items.dossier.AccountDossier):void
        {
            var loc10:*=null;
            var loc1:*=arg1.getBattlesStats();
            var loc2:*=loc1[1];
            var loc3:*;
            var loc4:*=(loc3 = App.utils.nations).getNations();
            var loc5:*=[];
            var loc6:*=loc4.length;
            var loc7:*=0;
            while (loc7 < loc6) 
            {
                loc10 = loc3.getNationID(loc4[loc7]).toString();
                loc5.push(formTypeChartItem(loc2, loc10));
                ++loc7;
            }
            this.nationChart.dataProvider = new scaleform.clik.data.DataProvider(loc5);
            this.levelChart.dataProvider = formChartItemProvider(loc1[2]);
            var loc8:*=[];
            var loc9:*=loc1[0];
            loc8.push(formTypeChartItem(loc9, net.wg.data.constants.VehicleTypes.LIGHT_TANK));
            loc8.push(formTypeChartItem(loc9, net.wg.data.constants.VehicleTypes.MEDIUM_TANK));
            loc8.push(formTypeChartItem(loc9, net.wg.data.constants.VehicleTypes.HEAVY_TANK));
            loc8.push(formTypeChartItem(loc9, net.wg.data.constants.VehicleTypes.AT_SPG));
            loc8.push(formTypeChartItem(loc9, net.wg.data.constants.VehicleTypes.SPG));
            this.typeChart.dataProvider = new scaleform.clik.data.DataProvider(loc8);
            return;
        }

        public function setViewSize(arg1:Number, arg2:Number):void
        {
            if (!this.currentDimension) 
            {
                this.currentDimension = new flash.geom.Point();
            }
            this.currentDimension.x = arg1;
            this.currentDimension.y = arg2;
            invalidate(LAYOUT_INV);
            return;
        }

        internal static function formTypeChartItem(arg1:Object, arg2:String):net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo
        {
            var loc1:*=new net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo();
            loc1.xField = arg2;
            loc1.yField = arg1[arg2];
            return loc1;
        }

        internal static function formChartItemProvider(arg1:Object):scaleform.clik.data.DataProvider
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=[];
            var loc4:*=0;
            var loc5:*=arg1;
            for (loc3 in loc5) 
            {
                loc2 = new net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo();
                loc2.xField = uint(loc3);
                loc2.yField = arg1[loc3];
                loc1.push(loc2);
            }
            if (loc2.hasOwnProperty("xField")) 
            {
                loc1.sortOn("xField", [Array.NUMERIC]);
            }
            else 
            {
                throw new Error("There is no property: \'xField\' in the target Array. Couldn\'t perform sort operation!");
            }
            return new scaleform.clik.data.DataProvider(loc1);
        }

        internal static const LAYOUT_INV:String="layoutInv";

        public var typeChart:net.wg.gui.lobby.profile.pages.statistics.TypesStatisticsChart;

        public var nationChart:net.wg.gui.lobby.profile.pages.statistics.NationsStatisticsChart;

        public var levelChart:net.wg.gui.lobby.profile.pages.statistics.LevelsStatisticChart;

        internal var currentDimension:flash.geom.Point;
    }
}
