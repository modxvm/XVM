package net.wg.gui.lobby.profile.components 
{
    import flash.display.*;
    import flash.geom.*;
    import net.wg.gui.components.advanced.*;
    
    public class ResizableViewStack extends net.wg.gui.components.advanced.ViewStack
    {
        public function ResizableViewStack()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(AVAILABLE_SIZE_INV)) 
                if (this.availableSize && currentView) 
                    net.wg.gui.lobby.profile.components.IResizableContent(currentView).setViewSize(this.availableSize.x, this.availableSize.y);
            if (isInvalid(AVAILABLE_SIZE_INV)) 
                if (currentView) 
                    net.wg.gui.lobby.profile.components.IResizableContent(currentView).centerOffset = this._centerOffset;
            if (isInvalid(DATA_INV) && this._dataForUpdate) 
                this.applyData();
            return;
        }

        protected function applyData():void
        {
            if (currentView) 
                currentView.update(this._dataForUpdate);
            return;
        }

        public function updateData(arg1:Object):void
        {
            this._dataForUpdate = arg1;
            invalidate(DATA_INV);
            return;
        }

        public override function show(arg1:String):flash.display.MovieClip
        {
            var loc1:*=super.show(arg1);
            var loc2:*=currentView as net.wg.gui.lobby.profile.components.IResizableContent;
            if (loc2) 
                loc2.active = false;
            loc2 = net.wg.gui.lobby.profile.components.IResizableContent(loc1);
            loc2.active = true;
            if (this.availableSize) 
                loc2.setViewSize(this.availableSize.x, this.availableSize.y);
            loc2.centerOffset = this._centerOffset;
            loc2.update(this._dataForUpdate);
            return loc1;
        }

        public override function dispose():void
        {
            this._dataForUpdate = null;
            super.dispose();
            return;
        }

        public function setAvailableSize(arg1:Number, arg2:Number):void
        {
            if (!this.availableSize) 
                this.availableSize = new flash.geom.Point();
            this.availableSize.x = arg1;
            this.availableSize.y = arg2;
            invalidate(AVAILABLE_SIZE_INV);
            return;
        }

        public function set centerOffset(arg1:int):void
        {
            this._centerOffset = arg1;
            invalidate(OFFSET_INVALID);
            return;
        }

        internal static const OFFSET_INVALID:String="layoutInv";

        internal static const AVAILABLE_SIZE_INV:String="availSizeInv";

        internal static const DATA_INV:String="dataForUpdInv";

        internal var availableSize:flash.geom.Point;

        internal var _centerOffset:int=0;

        internal var _dataForUpdate:Object;
    }
}
