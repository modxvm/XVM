package net.wg.gui.lobby.customization.renderers
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.controls.IconText;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.customization.CustomizationEvent;
    import net.wg.data.constants.IconsTypes;
    import net.wg.data.constants.SoundTypes;
    
    public class PriceItemRenderer extends SoundListItemRenderer
    {
        
        public function PriceItemRenderer() {
            super();
            soundType = SoundTypes.RNDR_NORMAL;
            soundId = SoundTypes.PRICE_RENDERER;
        }
        
        public var checkBox:CheckBox;
        
        public var costField:IconText;
        
        private var _lock:Boolean = false;
        
        override public function setData(param1:Object) : void {
            super.setData(param1);
            invalidateData();
        }
        
        override public function set enabled(param1:Boolean) : void {
            if(this.lock)
            {
                return;
            }
            super.enabled = param1;
            invalidateData();
        }
        
        public function get lock() : Boolean {
            return this._lock;
        }
        
        public function set lock(param1:Boolean) : void {
            if(this._lock == param1)
            {
                return;
            }
            this._lock = param1;
            this.enabled = !param1;
        }
        
        override protected function configUI() : void {
            super.configUI();
        }
        
        override protected function draw() : void {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(data)
                {
                    visible = true;
                    this.populateData();
                }
                else
                {
                    visible = false;
                }
            }
        }
        
        override protected function handleClick(param1:uint = 0) : void {
            if(toggle)
            {
                selected = !_selected;
            }
            this.checkBox.selected = !this.checkBox.selected;
            data.selected = this.checkBox.selected;
            dispatchEvent(new CustomizationEvent(CustomizationEvent.PRICE_ITEM_CLICK));
        }
        
        private function populateData() : void {
            var _loc1_:Object = null;
            this.checkBox.enabled = enabled;
            this.checkBox.mouseEnabled = enabled;
            if(data.label != null)
            {
                this.checkBox.label = data.label;
            }
            if(data.selected != null)
            {
                this.checkBox.selected = data.selected;
            }
            this.checkBox.validateNow();
            if(!(this.costField == null) && (!(data.price == null) || !(data.priceOverride == null)))
            {
                _loc1_ = data.priceOverride?data.priceOverride:data.price;
                if(_loc1_.isGold)
                {
                    this.costField.text = App.utils.locale.gold(_loc1_.cost);
                    this.costField.icon = IconsTypes.GOLD;
                }
                else
                {
                    this.costField.text = App.utils.locale.integer(_loc1_.cost);
                    this.costField.icon = IconsTypes.CREDITS;
                }
                this.costField.validateNow();
            }
        }
    }
}
