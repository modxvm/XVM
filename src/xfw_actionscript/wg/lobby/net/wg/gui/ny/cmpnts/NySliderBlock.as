package net.wg.gui.ny.cmpnts
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.Sprite;
    import scaleform.clik.events.IndexEvent;
    import net.wg.gui.ny.ev.NYSliderEv;
    import net.wg.data.constants.Values;

    public class NySliderBlock extends UIComponentEx
    {

        private static const SELECTED_INDEX_INVALIDATE:String = "selectedIndexInvalidate";

        private static const TOOLTIPS_INVALIDATE:String = "tooltipsInvalidate";

        private static const LINE_SELECTED_INDEX_INVALIDATE:String = "lineSelectedIndexInvalidate";

        private static const ENABLED_INVALIDATE:String = "enabled_invalidate";

        public var slider:NYSliderBase = null;

        protected var tabs:NYButtonBarGroup;

        protected var lines:Vector.<Sprite>;

        private var _selectedIndex:int = -1;

        private var _tabTooltips:Array = null;

        private var _selectedLineIndex:int = -1;

        private var _snappingValue:int = -1;

        public function NySliderBlock()
        {
            this.lines = new Vector.<Sprite>();
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.tabs = new NYButtonBarGroup();
            this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonsIndexChangeHandler);
            this.slider.addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonsIndexChangeHandler);
            this.slider.addEventListener(NYSliderEv.SNAP_VALUE_CHANGE,this.onSnapValueChangeHandler);
            this.slider.addEventListener(NYSliderEv.DRAGGING_CHANGE,this.onSliderDraggingChangeHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:Sprite = null;
            super.draw();
            if(this._selectedIndex != Values.DEFAULT_INT && isInvalid(SELECTED_INDEX_INVALIDATE))
            {
                this.slider.setIndex(this._selectedIndex);
                this.tabs.setIndex(this._selectedIndex);
            }
            if(this._tabTooltips != null && isInvalid(TOOLTIPS_INVALIDATE))
            {
                this.tabs.setData(this._tabTooltips);
            }
            if(this._selectedLineIndex != Values.DEFAULT_INT && isInvalid(LINE_SELECTED_INDEX_INVALIDATE))
            {
                for each(_loc1_ in this.lines)
                {
                    _loc1_.visible = false;
                }
                this.lines[this._selectedLineIndex].visible = true;
            }
            if(isInvalid(ENABLED_INVALIDATE))
            {
                this.tabs.enabled = enabled;
                this.slider.enabled = enabled;
            }
        }

        override protected function onBeforeDispose() : void
        {
            this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onButtonsIndexChangeHandler);
            this.slider.removeEventListener(IndexEvent.INDEX_CHANGE,this.onButtonsIndexChangeHandler);
            this.slider.removeEventListener(NYSliderEv.SNAP_VALUE_CHANGE,this.onSnapValueChangeHandler);
            this.slider.removeEventListener(NYSliderEv.DRAGGING_CHANGE,this.onSliderDraggingChangeHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.slider.dispose();
            this.slider = null;
            this.tabs.dispose();
            this.tabs = null;
            this.lines.splice(0,this.lines.length);
            this.lines = null;
            super.onDispose();
        }

        public function buttonTooltips(param1:Array) : void
        {
            this._tabTooltips = param1;
            invalidate(TOOLTIPS_INVALIDATE);
        }

        public function initSlider(param1:Number, param2:Number, param3:Number) : void
        {
            this.slider.initSlider(param1,param2,param3);
        }

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            invalidate(ENABLED_INVALIDATE);
        }

        public function set selectedIndex(param1:int) : void
        {
            if(this._selectedIndex != param1)
            {
                this._selectedIndex = param1;
                invalidate(SELECTED_INDEX_INVALIDATE);
            }
        }

        public function set lineSelectedIndex(param1:int) : void
        {
            if(this._selectedLineIndex != param1)
            {
                this._selectedLineIndex = param1;
                invalidate(LINE_SELECTED_INDEX_INVALIDATE);
            }
        }

        private function onButtonsIndexChangeHandler(param1:IndexEvent) : void
        {
            this.slider.setIndex(param1.index);
            this.tabs.setIndex(param1.index);
            dispatchEvent(new NYSliderEv(NYSliderEv.VALUE_CHANGE,param1.index,true,true));
        }

        private function onSnapValueChangeHandler(param1:NYSliderEv) : void
        {
            if(this._snappingValue == param1.index)
            {
                return;
            }
            this._snappingValue = param1.index;
            this.tabs.selectSnapValue(param1.index);
        }

        private function onSliderDraggingChangeHandler(param1:NYSliderEv) : void
        {
            if(this.slider.isDragging)
            {
                this._snappingValue = param1.index;
            }
            this.tabs.isSliderDragging = this.slider.isDragging;
        }
    }
}
