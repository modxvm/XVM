package net.wg.gui.lobby.profile.components.chart 
{
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public class ChartItemBase extends scaleform.clik.core.UIComponent implements net.wg.gui.lobby.profile.components.chart.IChartItem
    {
        public function ChartItemBase()
        {
            super();
            return;
        }

        public function get index():uint
        {
            return 0;
        }

        public function set index(arg1:uint):void
        {
            return;
        }

        public function get owner():scaleform.clik.core.UIComponent
        {
            return null;
        }

        public function set owner(arg1:scaleform.clik.core.UIComponent):void
        {
            return;
        }

        public function get selectable():Boolean
        {
            return false;
        }

        public function set selectable(arg1:Boolean):void
        {
            return;
        }

        public function get selected():Boolean
        {
            return false;
        }

        public function set selected(arg1:Boolean):void
        {
            return;
        }

        public function setListData(arg1:scaleform.clik.data.ListData):void
        {
            return;
        }

        public function setData(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            return;
        }

        protected var _data:Object;
    }
}
