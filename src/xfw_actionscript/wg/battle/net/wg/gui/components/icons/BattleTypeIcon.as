package net.wg.gui.components.icons
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.FrameLabel;

    public class BattleTypeIcon extends UIComponentEx
    {

        private var _type:String = "neutral";

        private var _typeByNumber:uint = 1;

        public function BattleTypeIcon()
        {
            super();
            stop();
        }

        override public function toString() : String
        {
            return "[WG BattleTypeIcon " + name + "]";
        }

        override protected function draw() : void
        {
            super.draw();
            if(currentLabel != this._type)
            {
                gotoAndStop(this._type);
                this._typeByNumber = currentFrame;
            }
        }

        override protected function onDispose() : void
        {
            super.onDispose();
        }

        public function get type() : String
        {
            return this._type;
        }

        public function set type(param1:String) : void
        {
            this._type = param1;
            invalidate();
        }

        public function set typeByNumber(param1:uint) : void
        {
            if(this._typeByNumber == param1)
            {
                return;
            }
            this._typeByNumber = param1;
            this.type = FrameLabel(this.currentLabels[this._typeByNumber - 1]).name;
            invalidate();
        }
    }
}
