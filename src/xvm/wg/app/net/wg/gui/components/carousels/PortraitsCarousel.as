package net.wg.gui.components.carousels 
{
    import flash.display.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.interfaces.*;
    
    public class PortraitsCarousel extends net.wg.gui.components.carousels.CarouselBase
    {
        public function PortraitsCarousel()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.buttonGroup = scaleform.clik.controls.ButtonGroup.getGroup("portraitGroup", this);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function initPosition():void
        {
            super.initPosition();
            if (this.carouselBG) 
            {
                this.carouselBG.x = renderersMask.x;
                this.carouselBG.y = renderersMask.y;
                this.carouselBG.width = renderersMask.width;
                this.carouselBG.height = renderersMask.height + 1;
            }
            return;
        }

        protected override function updateRenderPosition(arg1:scaleform.clik.interfaces.IListItemRenderer, arg2:uint, arg3:int, arg4:Number):void
        {
            super.updateRenderPosition(arg1, arg2, arg3, arg4);
            if (!this.buttonGroup.hasButton(scaleform.clik.controls.Button(arg1))) 
            {
                this.buttonGroup.addButton(scaleform.clik.controls.Button(arg1));
            }
            return;
        }

        internal static const CORRECTED_POSITION:uint=2;

        public var carouselBG:flash.display.MovieClip;

        internal var buttonGroup:scaleform.clik.controls.ButtonGroup;
    }
}
