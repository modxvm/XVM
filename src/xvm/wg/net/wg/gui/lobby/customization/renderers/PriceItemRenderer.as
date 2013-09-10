package net.wg.gui.lobby.customization.renderers 
{
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.customization.*;
    import scaleform.clik.constants.*;
    
    public class PriceItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function PriceItemRenderer()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.RNDR_NORMAL;
            soundId = net.wg.data.constants.SoundTypes.PRICE_RENDERER;
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            invalidateData();
            return;
        }

        public function get lock():Boolean
        {
            return this._lock;
        }

        public function set lock(arg1:Boolean):void
        {
            if (this._lock == arg1) 
                return;
            this._lock = arg1;
            this.enabled = !arg1;
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (this.lock) 
                return;
            super.enabled = arg1;
            invalidateData();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                if (data) 
                {
                    visible = true;
                    this.populateData();
                }
                else 
                    visible = false;
            return;
        }

        protected override function handleClick(arg1:uint=0):void
        {
            if (toggle) 
                selected = !_selected;
            this.checkBox.selected = !this.checkBox.selected;
            data.selected = this.checkBox.selected;
            dispatchEvent(new net.wg.gui.lobby.customization.CustomizationEvent(net.wg.gui.lobby.customization.CustomizationEvent.PRICE_ITEM_CLICK));
            return;
        }

        internal function populateData():void
        {
            var loc1:*=null;
            this.checkBox.enabled = enabled;
            this.checkBox.mouseEnabled = enabled;
            if (data.label != null) 
                this.checkBox.label = data.label;
            if (data.selected != null) 
                this.checkBox.selected = data.selected;
            this.checkBox.validateNow();
            if (!(this.costField == null) && !(data.price == null)) 
            {
                loc1 = data.price;
                if (loc1.isGold) 
                {
                    this.costField.text = App.utils.locale.gold(loc1.cost);
                    this.costField.icon = net.wg.gui.components.controls.IconText.GOLD;
                }
                else 
                {
                    this.costField.text = App.utils.locale.integer(loc1.cost);
                    this.costField.icon = net.wg.gui.components.controls.IconText.CREDITS;
                }
                this.costField.validateNow();
            }
            return;
        }

        public var checkBox:net.wg.gui.components.controls.CheckBox;

        public var costField:net.wg.gui.components.controls.IconText;

        internal var _lock:Boolean=false;
    }
}
