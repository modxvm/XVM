package net.wg.gui.lobby.header
{
    import net.wg.infrastructure.base.meta.impl.SquadTypeSelectPopoverMeta;
    import net.wg.infrastructure.base.meta.ISquadTypeSelectPopoverMeta;
    import net.wg.gui.historicalBattles.controls.SimpleVehicleList;
    import flash.display.MovieClip;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.components.controls.events.FancyRendererEvent;
    import flash.display.Graphics;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.popOvers.PopOverConst;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.Values;
    
    public class SquadTypeSelectPopover extends SquadTypeSelectPopoverMeta implements ISquadTypeSelectPopoverMeta
    {
        
        public function SquadTypeSelectPopover()
        {
            this.hitSprite = new MovieClip();
            super();
            UIID = 98;
        }
        
        private static var LIPS_PADDING:Number = 10;
        
        private static var LIST_TOP_PADDING:Number = -8;
        
        private static var LIST_LEFT_PADDING:Number = -6;
        
        private static var LIST_RIGHT_PADDING:Number = -6;
        
        public var list:SimpleVehicleList;
        
        public var topLip:MovieClip;
        
        public var bottomLip:MovieClip;
        
        private var _items:Array;
        
        private var hitSprite:MovieClip;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.topLip.mouseChildren = this.bottomLip.mouseChildren = false;
            this.topLip.mouseEnabled = this.bottomLip.mouseEnabled = false;
            this.list.x = LIST_LEFT_PADDING;
            this.list.y = LIST_TOP_PADDING + LIPS_PADDING;
            addChildAt(this.hitSprite,getChildIndex(this.list));
            hitArea = this.hitSprite;
            if(!hasEventListener(ListEvent.INDEX_CHANGE))
            {
                addEventListener(FancyRendererEvent.RENDERER_CLICK,this.onFightSelect,false,0,true);
                addEventListener(FancyRendererEvent.RENDERER_OVER,this.onFightItemOver,false,0,true);
            }
        }
        
        override protected function draw() : void
        {
            var _loc1_:Array = null;
            var _loc2_:* = 0;
            var _loc3_:Graphics = null;
            if(_baseDisposed)
            {
                return;
            }
            if((isInvalid(InvalidationType.DATA)) && (this._items))
            {
                this.list.rowCount = this._items.length;
                _loc1_ = [];
                _loc2_ = 0;
                while(_loc2_ < this._items.length)
                {
                    _loc1_.push(new BattleSelectDropDownVO(this._items[_loc2_]));
                    _loc2_++;
                }
                this.list.dataProvider = new DataProvider(_loc1_);
                this.updateSelectedItem();
                this.list.validateNow();
                this.topLip.y = this.list.y - this.topLip.height - LIST_TOP_PADDING;
                this.bottomLip.y = this.list.y + this.list.height + this.bottomLip.height - LIST_TOP_PADDING;
                _loc3_ = this.hitSprite.graphics;
                _loc3_.clear();
                _loc3_.beginFill(0,0);
                _loc3_.drawRect(0,0,this.list.width + LIST_RIGHT_PADDING + LIST_LEFT_PADDING,this.list.y + this.list.height + this.list._gap + LIST_TOP_PADDING + LIPS_PADDING);
                _loc3_.endFill();
                setSize(this.hitSprite.width,this.hitSprite.height);
            }
            super.draw();
        }
        
        private function updateSelectedItem() : void
        {
            if(this.list.selectedIndex == -1)
            {
                this.list.selectedIndex = this.list.getFirstSelectablePosition(0,true);
            }
            else if(this.list.selectedIndex < this.list.getFirstSelectablePosition(this.list.dataProvider.length - 1,false))
            {
                this.list.selectedIndex = this.list.getFirstSelectablePosition(this.list.selectedIndex,true);
            }
            else
            {
                this.list.selectedIndex = this.list.getFirstSelectablePosition(0,true);
            }
            
        }
        
        override protected function onDispose() : void
        {
            if(this._items)
            {
                this._items.splice(0,this._items.length);
            }
            this._items = null;
            removeEventListener(FancyRendererEvent.RENDERER_CLICK,this.onFightSelect);
            removeEventListener(FancyRendererEvent.RENDERER_OVER,this.onFightItemOver);
            super.onDispose();
        }
        
        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
            super.initLayout();
        }
        
        public function as_update(param1:Array) : void
        {
            this._items = param1;
            invalidateData();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.list);
        }
        
        private function onFightItemOver(param1:FancyRendererEvent) : void
        {
            var _loc2_:String = getTooltipData(param1.itemData);
            if((_loc2_) && !(_loc2_ == Values.EMPTY_STR))
            {
                App.toolTipMgr.showComplex(_loc2_);
            }
        }
        
        private function onFightSelect(param1:FancyRendererEvent) : void
        {
            param1.stopImmediatePropagation();
            var _loc2_:String = BattleSelectDropDownVO(param1.target.data).data;
            selectFightS(_loc2_);
            App.popoverMgr.hide();
        }
    }
}
