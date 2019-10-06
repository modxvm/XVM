package net.wg.gui.lobby.premiumWindow
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.components.controls.ActionPrice;
    import flash.display.Sprite;
    import net.wg.gui.lobby.premiumWindow.data.PremiumItemRendererVo;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.ComponentState;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.controls.VO.ActionPriceVO;

    public class PremiumItemRenderer extends SoundListItemRenderer
    {

        public var image:UILoaderAlt = null;

        public var durationTf:TextField = null;

        public var actionPrice:ActionPrice = null;

        public var hitMC:Sprite = null;

        public var dataVO:PremiumItemRendererVo = null;

        public var bg:Sprite = null;

        public var border:MovieClip;

        public function PremiumItemRenderer()
        {
            super();
        }

        override public function setData(param1:Object) : void
        {
            if(param1)
            {
                this.dataVO = PremiumItemRendererVo(param1);
                this.visible = false;
                invalidateData();
            }
            super.setData(param1);
        }

        override protected function preInitialize() : void
        {
            constraintsDisabled = true;
            preventAutosizing = true;
            super.preInitialize();
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onRendererMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onRendererMouseOutHandler);
            this.image.dispose();
            this.image = null;
            this.durationTf = null;
            this.actionPrice.removeEventListener(Event.COMPLETE,this.onActionPriceRedrawCompleteHandler);
            this.actionPrice.dispose();
            this.actionPrice = null;
            this.hitMC = null;
            this.dataVO.dispose();
            this.dataVO = null;
            this.bg = null;
            this.border = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.durationTf.autoSize = TextFieldAutoSize.LEFT;
            this.durationTf.mouseEnabled = false;
            mouseChildren = true;
            mouseEnabledOnDisabled = true;
            this.actionPrice.addEventListener(Event.COMPLETE,this.onActionPriceRedrawCompleteHandler);
            this.hitArea = this.hitMC;
            addEventListener(MouseEvent.MOUSE_OVER,this.onRendererMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onRendererMouseOutHandler);
        }

        private function onRendererMouseOutHandler(param1:MouseEvent) : void
        {
            if(param1.target == this.actionPrice)
            {
                return;
            }
            super.handleMouseRollOut(param1);
            if(this.actionPrice != null && this.actionPrice.visible)
            {
                this.actionPrice.hideTooltip();
            }
            if(!param1.buttonDown && enabled)
            {
                setState(ComponentState.OUT);
            }
        }

        private function onRendererMouseOverHandler(param1:MouseEvent) : void
        {
            if(param1.target == this.actionPrice)
            {
                return;
            }
            super.handleMouseRollOver(param1);
            if(this.actionPrice != null && this.actionPrice.visible)
            {
                this.actionPrice.showTooltip();
            }
            if(!param1.buttonDown && enabled)
            {
                setState(ComponentState.OVER);
            }
        }

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            mouseChildren = param1;
        }

        override protected function draw() : void
        {
            if(isInvalid(InvalidationType.DATA) && this.dataVO)
            {
                this.durationTf.htmlText = this.dataVO.duration;
                this.image.source = this.dataVO.image;
                this.updateActionPrice(this.dataVO.actionPrice,this.dataVO.haveMoney);
                this.enabled = selectable = this.dataVO.enabled;
                buttonMode = this.dataVO.enabled;
            }
            super.draw();
        }

        override protected function updateAfterStateChange() : void
        {
            super.updateAfterStateChange();
            this.border.mouseEnabled = false;
        }

        private function updateActionPrice(param1:ActionPriceVO, param2:Boolean) : void
        {
            this.actionPrice.textColorType = param2?ActionPrice.TEXT_COLOR_TYPE_ICON:ActionPrice.TEXT_COLOR_TYPE_ERROR;
            this.actionPrice.setData(param1);
            this.durationTf.x = this.bg.width - this.durationTf.width >> 1;
        }

        override public function set alpha(param1:Number) : void
        {
            if(alpha == param1)
            {
                return;
            }
            super.alpha = param1;
            this.border.alpha = Math.max(1,1 / param1);
        }

        override protected function handleMousePress(param1:MouseEvent) : void
        {
            this.actionPrice.hideTooltip();
            if(!this.hitMC.hitTestPoint(App.stage.mouseX,App.stage.mouseY,true))
            {
                param1.stopImmediatePropagation();
                return;
            }
            super.handleMousePress(param1);
        }

        override protected function handleMouseRelease(param1:MouseEvent) : void
        {
            if(!this.hitMC.hitTestPoint(App.stage.mouseX,App.stage.mouseY,true))
            {
                return;
            }
            super.handleMouseRelease(param1);
        }

        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
        }

        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
        }

        private function onActionPriceRedrawCompleteHandler(param1:Event) : void
        {
            if(!this.actionPrice.visible)
            {
                return;
            }
            this.durationTf.x = this.bg.width - this.durationTf.width - this.actionPrice.hitMc.width >> 1;
            this.actionPrice.x = this.durationTf.x + this.durationTf.width + this.actionPrice.hitMc.width;
        }
    }
}
