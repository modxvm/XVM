package net.wg.gui.components.advanced 
{
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    
    public class ScalableIconButton extends net.wg.gui.components.controls.SoundButtonEx
    {
        public function ScalableIconButton()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.loader.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.iconLoadingCompleteHandler);
            return;
        }

        internal function iconLoadingCompleteHandler(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.inv = true;
            invalidate();
            this.loader.x = (_width - this.loader.width) / 2;
            this.loader.y = (_height - this.loader.height) / 2;
            return;
        }

        protected override function draw():void
        {
            if (this.isIconSourceChanged) 
            {
                this.isIconSourceChanged = false;
                this.loader.source = this._iconSource;
                invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            }
            super.draw();
            return;
        }

        public function get iconSource():String
        {
            return this._iconSource;
        }

        public function set iconSource(arg1:String):void
        {
            if (this._iconSource != arg1) 
            {
                this._iconSource = arg1;
                this.isIconSourceChanged = true;
                invalidate();
            }
            return;
        }

        public static const ICON_LOADER_CONSTRAINT_NAME:String="mcLoader";

        public var loader:net.wg.gui.components.controls.UILoaderAlt;

        internal var _iconSource:String;

        internal var isIconSourceChanged:Boolean;

        internal var inv:Boolean;
    }
}
