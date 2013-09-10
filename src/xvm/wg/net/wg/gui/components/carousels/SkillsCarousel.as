package net.wg.gui.components.carousels 
{
    import scaleform.clik.controls.*;
    import scaleform.clik.interfaces.*;
    
    public class SkillsCarousel extends net.wg.gui.components.carousels.CarouselBase
    {
        public function SkillsCarousel()
        {
            super();
            return;
        }

        protected override function updateContainerPosition():void
        {
            super.updateContainerPosition();
            if (_renderers.length <= 0) 
                this.visible = false;
            else if (_renderers.length <= countVisibleSlots) 
            {
                var loc1:*;
                rightArrow.visible = loc1 = false;
                leftArrow.visible = loc1;
                rightArrow.enabled = loc1 = false;
                leftArrow.enabled = loc1;
                rightArrow.mouseEnabled = loc1 = false;
                leftArrow.mouseEnabled = loc1;
            }
            else 
            {
                rightArrow.visible = loc1 = true;
                leftArrow.visible = loc1;
                rightArrow.mouseEnabled = loc1 = true;
                leftArrow.mouseEnabled = loc1;
            }
            updateArrowsState();
            return;
        }

        protected override function updateRenderPosition(arg1:scaleform.clik.interfaces.IListItemRenderer, arg2:uint, arg3:int, arg4:Number):void
        {
            super.updateRenderPosition(arg1, arg2, arg3, arg4);
            if (_renderers.length <= countVisibleSlots) 
            {
                scaleform.clik.controls.Button(arg1).buttonMode = true;
                if (this.isSetListeners) 
                {
                    removeCursorListeners();
                    this.isSetListeners = false;
                }
            }
            else 
                this.setCursorListeners();
            return;
        }

        protected override function setCursorListeners():void
        {
            if (!this.isSetListeners) 
            {
                super.setCursorListeners();
                this.isSetListeners = true;
            }
            return;
        }

        internal var isSetListeners:Boolean=false;
    }
}
