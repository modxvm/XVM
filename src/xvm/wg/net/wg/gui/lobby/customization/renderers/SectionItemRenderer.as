package net.wg.gui.lobby.customization.renderers 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    
    public class SectionItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function SectionItemRenderer()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.RNDR_NORMAL;
            soundId = net.wg.data.constants.SoundTypes.SECTION_RENDERER;
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.data = arg1;
            invalidateData();
            return;
        }

        public override function set selected(arg1:Boolean):void
        {
            super.selected = arg1;
            this.rbtn.selected = arg1;
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            this.rbtn.enabled = arg1;
            return;
        }

        public override function set label(arg1:String):void
        {
            super.label = arg1;
            this.rbtn.label = arg1;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                visible = !(data == null);
            return;
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            if (!initialized || data == null) 
                return;
            if (this.newMarker != null) 
                this.newMarker.visible = data.hasNew;
            return;
        }

        public var newMarker:flash.display.MovieClip;

        public var rbtn:net.wg.gui.components.controls.RadioButton;
    }
}
