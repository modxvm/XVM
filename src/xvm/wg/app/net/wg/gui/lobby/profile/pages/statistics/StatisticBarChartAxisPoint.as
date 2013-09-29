package net.wg.gui.lobby.profile.pages.statistics 
{
    import flash.events.*;
    import net.wg.gui.lobby.profile.components.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class StatisticBarChartAxisPoint extends net.wg.gui.lobby.profile.components.SimpleLoader implements scaleform.clik.interfaces.IListItemRenderer
    {
        public function StatisticBarChartAxisPoint()
        {
            super();
            return;
        }

        public function get tooltip():String
        {
            return this._tooltip;
        }

        public function set tooltip(arg1:String):void
        {
            this._tooltip = arg1;
            this.disposeHandlers();
            if (this._tooltip) 
            {
                addEventListener(flash.events.MouseEvent.ROLL_OVER, this.mouseRollOverHandler, false, 0, true);
                addEventListener(flash.events.MouseEvent.ROLL_OUT, mouseRollOutHandler, false, 0, true);
            }
            return;
        }

        internal function disposeHandlers():void
        {
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.mouseRollOverHandler);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, mouseRollOutHandler);
            return;
        }

        protected function mouseRollOverHandler(arg1:flash.events.MouseEvent):void
        {
            this.showToolTip();
            return;
        }

        protected function showToolTip():void
        {
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

        public function get displayFocus():Boolean
        {
            return false;
        }

        public function set displayFocus(arg1:Boolean):void
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
            setSource(net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo(this._data).icon);
            return;
        }

        public function get enabled():Boolean
        {
            return false;
        }

        public function set enabled(arg1:Boolean):void
        {
            return;
        }

        public function get focusTarget():scaleform.clik.core.UIComponent
        {
            return null;
        }

        public function set focusTarget(arg1:scaleform.clik.core.UIComponent):void
        {
            return;
        }

        public function validateNow(arg1:flash.events.Event=null):void
        {
            return;
        }

        public function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            return;
        }

        public override function dispose():void
        {
            this.disposeHandlers();
            super.dispose();
            return;
        }

        internal static function mouseRollOutHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        protected var _data:Object;

        internal var _tooltip:String=null;
    }
}
