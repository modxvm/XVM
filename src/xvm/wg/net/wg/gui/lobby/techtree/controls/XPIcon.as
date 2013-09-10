package net.wg.gui.lobby.techtree.controls 
{
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class XPIcon extends scaleform.clik.core.UIComponent
    {
        public function XPIcon()
        {
            super();
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            if (this._type == arg1) 
                return;
            this._type = arg1;
            if (this._type != currentFrameLabel) 
                invalidateData();
            return;
        }

        protected override function configUI():void
        {
            var loc1:*;
            focusable = loc1 = false;
            mouseChildren = loc1 = loc1;
            mouseEnabled = loc1;
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                this.updateIcon();
            super.draw();
            return;
        }

        internal function updateIcon():void
        {
            if (_labelHash[this._type] && !(this._type == currentFrameLabel)) 
                gotoAndStop(this._type);
            return;
        }

        internal var _type:String=null;
    }
}
