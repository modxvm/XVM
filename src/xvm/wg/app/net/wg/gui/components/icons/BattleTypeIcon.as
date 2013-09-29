package net.wg.gui.components.icons 
{
    import flash.display.*;
    import scaleform.clik.core.*;
    
    public class BattleTypeIcon extends scaleform.clik.core.UIComponent
    {
        public function BattleTypeIcon()
        {
            super();
            stop();
            this._allTypes = this.currentLabels;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (currentLabel != this._type) 
            {
                gotoAndStop(this._type);
                this._typeByNumber = currentFrame;
            }
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            invalidate();
            return;
        }

        public function set typeByNumber(arg1:uint):void
        {
            if (this._typeByNumber == arg1) 
            {
                return;
            }
            this._typeByNumber = arg1;
            this.type = flash.display.FrameLabel(this.currentLabels[(this._typeByNumber - 1)]).name;
            invalidate();
            return;
        }

        public function get typeByNumber():uint
        {
            return this._typeByNumber;
        }

        public override function toString():String
        {
            return "[WG BattleTypeIcon " + name + "]";
        }

        public override function dispose():void
        {
            if (this._allTypes) 
            {
                this._allTypes.splice(0, this._allTypes.length);
            }
            this._allTypes = null;
            super.dispose();
            return;
        }

        internal var _type:String="neutral";

        internal var _allTypes:Array;

        internal var _typeByNumber:uint=1;
    }
}
