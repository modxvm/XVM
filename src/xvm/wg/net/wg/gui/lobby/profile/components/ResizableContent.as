package net.wg.gui.lobby.profile.components 
{
    import flash.geom.*;
    import scaleform.clik.core.*;
    
    public class ResizableContent extends scaleform.clik.core.UIComponent implements net.wg.gui.lobby.profile.components.IResizableContent
    {
        public function ResizableContent()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(net.wg.gui.lobby.profile.components.ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID) && this.currentDimension) 
                this.applyResizing();
            if (isInvalid(net.wg.gui.lobby.profile.components.ResizableInvalidationTypes.ACTIVE_INVALID)) 
                this.applyActivation();
            return;
        }

        protected function applyActivation():void
        {
            return;
        }

        protected function applyResizing():void
        {
            return;
        }

        public function setViewSize(arg1:Number, arg2:Number):void
        {
            if (!this.currentDimension) 
                this.currentDimension = new flash.geom.Point();
            this.currentDimension.x = arg1;
            this.currentDimension.y = arg2;
            invalidate(net.wg.gui.lobby.profile.components.ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
            return;
        }

        public function set active(arg1:Boolean):void
        {
            this.isActive = arg1;
            invalidate(net.wg.gui.lobby.profile.components.ResizableInvalidationTypes.ACTIVE_INVALID);
            return;
        }

        public function get active():Boolean
        {
            return this.isActive;
        }

        public function set centerOffset(arg1:int):void
        {
            this._centerOffset = arg1;
            invalidate(net.wg.gui.lobby.profile.components.ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
            return;
        }

        public function get centerOffset():int
        {
            return this._centerOffset;
        }

        public function update(arg1:Object):void
        {
            return;
        }

        protected var currentDimension:flash.geom.Point;

        internal var _centerOffset:int;

        internal var isActive:Boolean;
    }
}
