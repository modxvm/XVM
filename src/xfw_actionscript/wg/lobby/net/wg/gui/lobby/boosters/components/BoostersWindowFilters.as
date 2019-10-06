package net.wg.gui.lobby.boosters.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.components.ButtonFilters;
    import net.wg.gui.components.containers.HorizontalGroupLayout;
    import net.wg.data.constants.Linkages;
    import flash.text.TextField;
    import net.wg.gui.events.FiltersEvent;
    import flash.events.Event;
    import net.wg.gui.lobby.boosters.data.BoostersWindowFiltersVO;
    import net.wg.utils.ICommons;

    public class BoostersWindowFilters extends UIComponentEx
    {

        private static const FILTERS_BUTTON_GAP:int = 12;

        private static const LABEL_FILTERS_GAP:int = 8;

        private static const FILTERS_GAP:int = 45;

        private static const INVALID_FILTERS_SIZE:String = "invalidFiltersSize";

        public var qualityFiltersLabelTf:TextField;

        public var typeFiltersLabelTf:TextField;

        public var qualityFilters:ButtonFilters;

        public var typeFilters:ButtonFilters;

        public function BoostersWindowFilters()
        {
            super();
            setupFilters(this.qualityFilters);
            setupFilters(this.typeFilters);
            this.qualityFilters.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onFiltersFiltersChangedHandler);
            this.typeFilters.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onFiltersFiltersChangedHandler);
            this.qualityFilters.addEventListener(Event.RESIZE,this.onFiltersResizeHandler);
            this.typeFilters.addEventListener(Event.RESIZE,this.onFiltersResizeHandler);
        }

        private static function layoutFilterGroup(param1:int, param2:DisplayObject, param3:DisplayObject) : int
        {
            param3.visible = true;
            param2.visible = true;
            param3.x = param1;
            var param1:int = param1 + (param3.width + LABEL_FILTERS_GAP);
            param2.x = param1;
            param1 = param1 + (param2.width + FILTERS_GAP);
            return param1;
        }

        private static function setupFilters(param1:ButtonFilters) : void
        {
            param1.layout = new HorizontalGroupLayout(FILTERS_BUTTON_GAP,false);
            param1.buttonLinkage = Linkages.BUTTON_BLACK;
        }

        override protected function onDispose() : void
        {
            this.qualityFilters.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onFiltersFiltersChangedHandler);
            this.typeFilters.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onFiltersFiltersChangedHandler);
            this.qualityFilters.removeEventListener(Event.RESIZE,this.onFiltersResizeHandler);
            this.typeFilters.removeEventListener(Event.RESIZE,this.onFiltersResizeHandler);
            this.qualityFilters.dispose();
            this.qualityFilters = null;
            this.typeFilters.dispose();
            this.typeFilters = null;
            this.qualityFiltersLabelTf = null;
            this.typeFiltersLabelTf = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALID_FILTERS_SIZE))
            {
                this.layoutFilters();
            }
        }

        public function resetFilters(param1:int) : void
        {
            this.qualityFilters.resetFilters(param1);
            this.typeFilters.resetFilters(param1);
        }

        public function setData(param1:BoostersWindowFiltersVO) : void
        {
            this.qualityFiltersLabelTf.htmlText = param1.qualityFiltersLabel;
            this.typeFiltersLabelTf.htmlText = param1.typeFiltersLabel;
            var _loc2_:ICommons = App.utils.commons;
            _loc2_.updateTextFieldSize(this.qualityFiltersLabelTf,true,false);
            _loc2_.updateTextFieldSize(this.typeFiltersLabelTf,true,false);
            this.qualityFilters.setData(param1.qualityFilters);
            this.typeFilters.setData(param1.typeFilters);
            this.qualityFiltersLabelTf.visible = false;
            this.typeFiltersLabelTf.visible = false;
            this.qualityFilters.visible = false;
            this.typeFilters.visible = false;
            invalidate(INVALID_FILTERS_SIZE);
        }

        private function layoutFilters() : void
        {
            var _loc1_:* = 0;
            if(this.qualityFilters.width > 0)
            {
                _loc1_ = layoutFilterGroup(_loc1_,this.qualityFilters,this.qualityFiltersLabelTf);
            }
            if(this.typeFilters.width > 0)
            {
                layoutFilterGroup(_loc1_,this.typeFilters,this.typeFiltersLabelTf);
            }
        }

        private function onFiltersResizeHandler(param1:Event) : void
        {
            invalidate(INVALID_FILTERS_SIZE);
        }

        private function onFiltersFiltersChangedHandler(param1:FiltersEvent) : void
        {
            var _loc2_:* = this.qualityFilters.filtersValue | this.typeFilters.filtersValue;
            dispatchEvent(new FiltersEvent(FiltersEvent.FILTERS_CHANGED,_loc2_));
        }
    }
}
