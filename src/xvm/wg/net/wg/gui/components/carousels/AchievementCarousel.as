package net.wg.gui.components.carousels 
{
    import flash.display.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.interfaces.*;
    
    public class AchievementCarousel extends net.wg.gui.components.carousels.CarouselBase
    {
        public function AchievementCarousel()
        {
            super();
            var loc1:*;
            rightArrow.enabled = loc1 = false;
            leftArrow.enabled = loc1;
            rightArrow.visible = loc1 = false;
            leftArrow.visible = loc1;
            this.achievementBG.visible = false;
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
            return;
        }

        protected override function initPosition():void
        {
            super.initPosition();
            if (this.achievementBG) 
            {
                this.achievementBG.x = renderersMask.x;
                this.achievementBG.y = renderersMask.y;
                this.achievementBG.width = renderersMask.width;
                this.achievementBG.height = renderersMask.height;
            }
            return;
        }

        protected override function updateContainerPosition():void
        {
            super.updateContainerPosition();
            if (_renderers.length <= countVisibleSlots) 
            {
                var loc1:*;
                rightArrow.visible = loc1 = false;
                leftArrow.visible = loc1;
                container.x = leftArrow.x + leftArrow.width + padding.left;
            }
            else 
            {
                rightArrow.visible = loc1 = true;
                leftArrow.visible = loc1;
            }
            this.achievementBG.visible = leftArrow.visible;
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
            {
                this.setCursorListeners();
            }
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

        protected override function populateData(arg1:Array):void
        {
            super.populateData(arg1);
            if (_renderers.length > countVisibleSlots) 
            {
                this.initPosition();
            }
            return;
        }

        public var achievementBG:flash.display.MovieClip;

        internal var isSetListeners:Boolean=false;
    }
}
