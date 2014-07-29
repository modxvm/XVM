package net.wg.gui.lobby.header
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.ScrollingListEx;
    import flash.display.MovieClip;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.clik.utils.Padding;
    import scaleform.clik.constants.InvalidationType;
    
    public class FightButtonFancySelect extends UIComponent
    {
        
        public function FightButtonFancySelect()
        {
            super();
        }
        
        private static var LIST_VS_BG:int = 138;
        
        private static var HIT_AREA_PADDING_TOP:int = 4;
        
        private static var HIT_AREA_PADDING_BOTTOM:int = 11;
        
        public var list:ScrollingListEx;
        
        public var bg:MovieClip;
        
        public var additionalhitArea:MovieClip;
        
        private var _itemRenderer:Class;
        
        private var _scrollBar:Class;
        
        private var _selectedIndex:int = -1;
        
        private var _dataProvider:IDataProvider;
        
        private var _padding:Padding;
        
        private var _wrapping:String;
        
        private var _margin:Number;
        
        private var _thumbOffset:Number;
        
        private var _rowCount:int;
        
        private var _labelField:String;
        
        private var _labelFunction:Function;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.bg.mouseEnabled = false;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.list.itemRenderer = this.itemRenderer;
                this.list.scrollBar = this.scrollBar;
                this.list.dataProvider = this.dataProvider;
                this.list.selectedIndex = this.selectedIndex;
                this.list.padding = this.padding;
                this.list.wrapping = this.wrapping;
                this.list.margin = this.margin;
                this.list.thumbOffset = this.thumbOffset;
                this.list.rowCount = this.rowCount;
                this.list.labelField = this.labelField;
                this.list.labelFunction = this.labelFunction;
                this.list.focusTarget = focusTarget;
                this.bg.height = this.list.height + LIST_VS_BG;
                this.additionalhitArea.y = this.list.y - HIT_AREA_PADDING_TOP;
                this.additionalhitArea.height = this.list.height + HIT_AREA_PADDING_BOTTOM;
                this.hitArea = this.additionalhitArea;
            }
        }
        
        public function get itemRenderer() : Class
        {
            return this._itemRenderer;
        }
        
        public function set itemRenderer(param1:Class) : void
        {
            this._itemRenderer = param1;
            invalidateData();
        }
        
        public function get scrollBar() : Class
        {
            return this._scrollBar;
        }
        
        public function set scrollBar(param1:Class) : void
        {
            this._scrollBar = param1;
            invalidateData();
        }
        
        public function get selectedIndex() : int
        {
            return this._selectedIndex;
        }
        
        public function set selectedIndex(param1:int) : void
        {
            this._selectedIndex = param1;
            invalidateData();
        }
        
        public function get dataProvider() : IDataProvider
        {
            return this._dataProvider;
        }
        
        public function set dataProvider(param1:IDataProvider) : void
        {
            this._dataProvider = param1;
            invalidateData();
        }
        
        public function get padding() : Padding
        {
            return this._padding;
        }
        
        public function set padding(param1:Padding) : void
        {
            this._padding = param1;
            invalidateData();
        }
        
        public function get wrapping() : String
        {
            return this._wrapping;
        }
        
        public function set wrapping(param1:String) : void
        {
            this._wrapping = param1;
            invalidateData();
        }
        
        public function get margin() : Number
        {
            return this._margin;
        }
        
        public function set margin(param1:Number) : void
        {
            this._margin = param1;
            invalidateData();
        }
        
        public function get thumbOffset() : Number
        {
            return this._thumbOffset;
        }
        
        public function set thumbOffset(param1:Number) : void
        {
            this._thumbOffset = param1;
            invalidateData();
        }
        
        public function get rowCount() : int
        {
            return this._rowCount;
        }
        
        public function set rowCount(param1:int) : void
        {
            this._rowCount = param1;
            invalidateData();
        }
        
        public function get labelField() : String
        {
            return this._labelField;
        }
        
        public function set labelField(param1:String) : void
        {
            this._labelField = param1;
            invalidateData();
        }
        
        public function get labelFunction() : Function
        {
            return this._labelFunction;
        }
        
        public function set labelFunction(param1:Function) : void
        {
            this._labelFunction = param1;
            invalidateData();
        }
    }
}
