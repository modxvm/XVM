package net.wg.gui.components.controls 
{
    import flash.display.*;
    import net.wg.gui.events.*;
    
    public class ListItemRedererImageText extends net.wg.gui.components.controls.DropDownListItemRendererSound
    {
        public function ListItemRedererImageText()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            this.ico_border.visible = false;
            super.configUI();
            if (this.data) 
                this.setup();
            return;
        }

        public override function setData(arg1:Object):void
        {
            this.data = arg1;
            invalidate("data");
            return;
        }

        internal function setup():void
        {
            if (data) 
            {
                this.textField.text = data.label;
                this.icon.visible = true;
                this.icon.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.completeLoadA);
                this.icon.source = data.icon;
            }
            return;
        }

        protected function completeLoadA(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.ico_border.visible = true;
            if (this.icon.hasEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE)) 
                this.icon.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.completeLoadA);
            return;
        }

        protected override function draw():void
        {
            if (isInvalid("data")) 
                this.setup();
            super.draw();
            return;
        }

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var ico_border:flash.display.MovieClip;
    }
}
