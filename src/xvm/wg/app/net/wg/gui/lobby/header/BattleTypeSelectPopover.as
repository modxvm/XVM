package net.wg.gui.lobby.header
{
    import net.wg.infrastructure.base.meta.impl.BattleTypeSelectPopoverMeta;
    import net.wg.infrastructure.base.meta.IBattleTypeSelectPopoverMeta;
    import net.wg.gui.historicalBattles.controls.SimpleVehicleList;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.header.events.BattleTypeSelectorEvent;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.components.controls.events.FancyRendererEvent;
    import net.wg.gui.components.popOvers.PopOverConst;
    import flash.display.Graphics;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.interfaces.entity.IIdentifiable;
    import flash.events.MouseEvent;
    
    public class BattleTypeSelectPopover extends BattleTypeSelectPopoverMeta implements IBattleTypeSelectPopoverMeta
    {
        
        public function BattleTypeSelectPopover()
        {
            this.hitSprite = new MovieClip();
            super();
            UIID = 97;
        }
        
        private static var LIPS_PADDING:Number = 10;
        
        private static var LIST_TOP_PADDING:Number = -8;
        
        private static var LIST_LEFT_PADDING:Number = -6;
        
        private static var LIST_RIGHT_PADDING:Number = -6;
        
        public var list:SimpleVehicleList;
        
        public var demonstrationItem:BattleTypeSelectPopoverDemonstrator = null;
        
        public var topLip:MovieClip;
        
        public var bottomLip:MovieClip;
        
        private var _items:Array;
        
        private var _isShowDemonstrator:Boolean = false;
        
        private var PREBATTLE_ACTION_NAME_SORTIE:String = "sortie";
        
        private var hitSprite:MovieClip;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.demonstrationItem.visible = false;
            this.demonstrationItem.addEventListener(BattleTypeSelectorEvent.BATTLE_TYPE_ITEM_EVENT,this.onDemoClick);
            this.topLip.mouseChildren = this.bottomLip.mouseChildren = false;
            this.topLip.mouseEnabled = this.bottomLip.mouseEnabled = false;
            this.list.y = LIST_TOP_PADDING + LIPS_PADDING;
            this.list.x = LIST_LEFT_PADDING;
            this.demonstrationItem.y = LIPS_PADDING;
            addChildAt(this.hitSprite,getChildIndex(this.list));
            hitArea = this.hitSprite;
            if(!hasEventListener(ListEvent.INDEX_CHANGE))
            {
                addEventListener(FancyRendererEvent.RENDERER_CLICK,this.onFightSelect,false,0,true);
            }
        }
        
        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
            super.initLayout();
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
                this.demonstrationItem.visible = this._isShowDemonstrator;
                this.list.y = this._isShowDemonstrator?this.demonstrationItem.y + this.demonstrationItem.height + LIST_TOP_PADDING:LIPS_PADDING + LIST_TOP_PADDING;
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
                this.topLip.y = this._isShowDemonstrator?this.demonstrationItem.y - this.topLip.height:this.list.y - this.topLip.height - LIST_TOP_PADDING;
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
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.list);
        }
        
        private function onFightSelect(param1:FancyRendererEvent) : void
        {
            param1.stopImmediatePropagation();
            var _loc2_:String = BattleSelectDropDownVO(param1.target.data).data;
            if(_loc2_ == this.PREBATTLE_ACTION_NAME_SORTIE)
            {
                App.eventLogManager.logUIElement(IIdentifiable(this),MouseEvent.CLICK,0);
            }
            selectFightS(BattleSelectDropDownVO(param1.target.data).data);
            App.popoverMgr.hide();
        }
        
        public function as_update(param1:Array, param2:Boolean, param3:Boolean) : void
        {
            this.as_setDemonstrationEnabled(param3);
            this._items = param1;
            this._isShowDemonstrator = param2;
            invalidateData();
        }
        
        override protected function onDispose() : void
        {
            if(this._items)
            {
                this._items.splice(0,this._items.length);
            }
            this._items = null;
            this.demonstrationItem.removeEventListener(BattleTypeSelectorEvent.BATTLE_TYPE_ITEM_EVENT,this.onDemoClick);
            this.demonstrationItem.dispose();
            removeEventListener(FancyRendererEvent.RENDERER_CLICK,this.onFightSelect);
            super.onDispose();
        }
        
        public function as_setDemonstrationEnabled(param1:Boolean) : void
        {
            this.demonstrationItem.enabled = param1;
        }
        
        private function onDemoClick(param1:BattleTypeSelectorEvent) : void
        {
            demoClickS();
        }
    }
}
