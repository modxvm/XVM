package net.wg.gui.lobby.sellDialog
{
    import scaleform.clik.controls.ListItemRenderer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.data.VO.SellDialogElement;
    import net.wg.infrastructure.interfaces.ISaleItemBlockRenderer;
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.VO.SellDialogItem;
    import net.wg.data.constants.Linkages;
    import flash.display.DisplayObject;
    import scaleform.clik.constants.InvalidationType;
    
    public class SellDialogListItemRenderer extends ListItemRenderer
    {
        
        public function SellDialogListItemRenderer() {
            this.elements = new Vector.<SellDialogElement>();
            this.renderers = new Vector.<ISaleItemBlockRenderer>();
            super();
        }
        
        public var clickArea:MovieClip;
        
        public var header:TextField;
        
        private var elements:Vector.<SellDialogElement>;
        
        private var renderers:Vector.<ISaleItemBlockRenderer>;
        
        private var eventLengs:Number = 0;
        
        protected var _itemRenderer:Class;
        
        public var container:Sprite;
        
        public var rendererBG:MovieClip;
        
        public var scrollingRenderrBg:MovieClip;
        
        override protected function onDispose() : void {
            super.onDispose();
            this.elements.splice(0,this.elements.length);
            var _loc1_:int = this.renderers.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                IDisposable(this.renderers[_loc2_]).dispose();
                _loc2_++;
            }
            this.renderers.splice(0,_loc1_);
        }
        
        override protected function configUI() : void {
            this.buttonMode = false;
            this.clickArea.buttonMode = false;
            this.mouseChildren = true;
            if(!(_focusIndicator == null) && !_focused && _focusIndicator.totalFrames == 1)
            {
                focusIndicator.visible = false;
            }
            if(this.container == null)
            {
                this.container = new Sprite();
                addChild(this.container);
            }
        }
        
        override public function setData(param1:Object) : void {
            if(param1)
            {
                this.header.text = SellDialogItem(param1).header;
                this.elements = SellDialogItem(param1).elements;
                this.data = param1;
                invalidateData();
            }
        }
        
        private function createItemRenderers(param1:Number) : Vector.<ISaleItemBlockRenderer> {
            var _loc2_:Array = [];
            var _loc3_:Number = 0;
            while(_loc3_ < param1)
            {
                _loc2_.push(this.createItemRenderer(_loc3_));
                if(_loc3_ == param1 - 1)
                {
                    _loc2_[_loc3_].hideLine();
                }
                _loc3_++;
            }
            return Vector.<ISaleItemBlockRenderer>(_loc2_);
        }
        
        private function createItemRenderer(param1:Number) : ISaleItemBlockRenderer {
            var _loc2_:ISaleItemBlockRenderer = App.utils.classFactory.getComponent(Linkages.SALE_ITEM_BLOCK_RENDERER,ISaleItemBlockRenderer);
            this.container.addChild(DisplayObject(_loc2_));
            return _loc2_;
        }
        
        public function getRenderers() : Vector.<ISaleItemBlockRenderer> {
            return this.renderers;
        }
        
        private function drawLayout() : void {
            var _loc1_:Number = 41;
            var _loc2_:Number = 27;
            var _loc3_:Number = _loc1_;
            var _loc4_:Number = 0;
            while(_loc4_ < this.renderers.length)
            {
                this.renderers[_loc4_].x = 0;
                this.renderers[_loc4_].y = _loc1_ + _loc2_ * _loc4_;
                this.renderers[_loc4_].setData(this.elements[_loc4_]);
                this.renderers[_loc4_].validateNow();
                _loc4_++;
            }
            if(this.renderers)
            {
                _loc3_ = this.renderers.length * _loc2_ + _loc1_;
            }
            this.height = this.clickArea.height = _loc3_;
        }
        
        override protected function draw() : void {
            if((isInvalid(InvalidationType.DATA)) && (data))
            {
                this.renderers = this.createItemRenderers(this.elements.length);
                this.drawLayout();
            }
        }
        
        override public function setSize(param1:Number, param2:Number) : void {
            this.scrollingRenderrBg.width = param1;
            var _loc3_:uint = 0;
            while(_loc3_ < this.renderers.length)
            {
                this.renderers[_loc3_].setSize(param1,this.renderers[_loc3_].height);
                _loc3_++;
            }
            super.setSize(param1,param2);
        }
    }
}
