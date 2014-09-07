package net.wg.gui.lobby.header
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UILoaderAlt;
    import scaleform.clik.utils.Constraints;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.controls.events.FancyRendererEvent;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.SoundTypes;
    
    public class FightButtonFancyRenderer extends SoundListItemRenderer
    {
        
        public function FightButtonFancyRenderer()
        {
            super();
            soundType = SoundTypes.RNDR_NORMAL;
            scaleX = scaleY = 1;
            this.newIndicator.visible = false;
            this.newIndicator.mouseChildren = false;
            this.hitArea = this.hitAreaA;
        }
        
        public var newIndicator:MovieClip;
        
        public var hitAreaA:MovieClip;
        
        public var icon:UILoaderAlt;
        
        private var _active:Boolean = false;
        
        override protected function configUI() : void
        {
            super.configUI();
            if(!constraintsDisabled)
            {
                constraints.addElement(this.icon.name,this.icon,Constraints.LEFT | Constraints.TOP);
            }
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,false,0,true);
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMousePress,false,0,true);
            addEventListener(ButtonEvent.CLICK,this.onButtonClick,false,0,true);
        }
        
        override protected function draw() : void
        {
            var _loc1_:BattleSelectDropDownVO = BattleSelectDropDownVO(data);
            if((isInvalid(InvalidationType.DATA)) && (data))
            {
                this.enabled = !_loc1_.disabled;
            }
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (data))
            {
                this.applyData(_loc1_);
            }
        }
        
        private function onButtonClick(param1:ButtonEvent) : void
        {
            dispatchEvent(new FancyRendererEvent(FancyRendererEvent.RENDERER_CLICK,true));
        }
        
        protected function onMouseOver(param1:MouseEvent) : void
        {
            if(data.tooltip)
            {
                App.toolTipMgr.showComplex(this.data.tooltip);
            }
        }
        
        protected function onMouseOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        protected function onMousePress(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            invalidateData();
        }
        
        protected function applyData(param1:BattleSelectDropDownVO) : void
        {
            var _loc2_:* = false;
            this.active = param1.active;
            this.textField.text = param1.label;
            if(this.newIndicator)
            {
                _loc2_ = (param1.isNew) && !param1.disabled;
                if(this.newIndicator.visible != _loc2_)
                {
                    this.newIndicator.visible = _loc2_;
                    this.updateNewAnimation(_loc2_);
                }
            }
            this.icon.visible = (param1.icon) && !(param1.icon == Values.EMPTY_STR);
            this.icon.source = param1.icon;
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this.icon.alpha = param1?1:0.5;
        }
        
        override protected function updateAfterStateChange() : void
        {
            super.updateAfterStateChange();
            if(!constraintsDisabled && (this.icon))
            {
                constraints.updateElement(this.icon.name,this.icon);
            }
        }
        
        private function updateNewAnimation(param1:Boolean) : void
        {
            preventAutosizing = true;
            if(param1)
            {
                this.newIndicator.gotoAndPlay("shine");
            }
            else
            {
                this.newIndicator.gotoAndStop(1);
            }
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMousePress);
            removeEventListener(ButtonEvent.CLICK,this.onButtonClick);
            super.onDispose();
        }
        
        public function get active() : Boolean
        {
            return this._active;
        }
        
        public function set active(param1:Boolean) : void
        {
            this._active = param1;
            selected = param1;
        }
    }
}
