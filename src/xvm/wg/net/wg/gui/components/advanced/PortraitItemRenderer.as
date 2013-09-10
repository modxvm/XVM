package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class PortraitItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer implements net.wg.infrastructure.interfaces.IPersonalCaseItemRenderer
    {
        public function PortraitItemRenderer()
        {
            super();
            useHandCursor = true;
            allowDeselect = false;
            toggle = true;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.loader) 
            {
                this.loader.dispose();
                this.loader = null;
            }
            _data = null;
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
                return;
            super.setData(arg1);
            this.loader.source = "../maps/icons/tankmen/icons/barracks/" + arg1.value;
            return;
        }

        protected override function configUI():void
        {
            if (this.emptyFocusIndicator) 
                focusIndicator = this.emptyFocusIndicator;
            soundType = net.wg.data.constants.SoundTypes.CAROUSEL_BTN;
            soundId = net.wg.data.constants.SoundManagerStates.CAROUSEL_CELL_BTN;
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function handleMouseReleaseEx(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseReleaseEx(arg1);
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            if (this.canSelected) 
                super.handleMouseRelease(arg1);
            return;
        }

        public function set canSelected(arg1:Boolean):void
        {
            this._canSelected = arg1;
            return;
        }

        public function get canSelected():Boolean
        {
            return this._canSelected;
        }

        public var loader:net.wg.gui.components.controls.UILoaderAlt;

        public var emptyFocusIndicator:flash.display.MovieClip;

        internal var _canSelected:Boolean=true;
    }
}
