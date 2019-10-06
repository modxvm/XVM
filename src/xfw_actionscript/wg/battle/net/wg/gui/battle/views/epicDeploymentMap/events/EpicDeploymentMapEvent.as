package net.wg.gui.battle.views.epicDeploymentMap.events
{
    import flash.events.Event;

    public class EpicDeploymentMapEvent extends Event
    {

        public static const MAP_CLICKED:String = "mapClicked";

        private var _mouseX:Number = 0;

        private var _mouseY:Number = 0;

        private var _isMouseRightClick:Boolean = true;

        public function EpicDeploymentMapEvent(param1:String, param2:Number, param3:Number, param4:Boolean, param5:Boolean = false, param6:Boolean = false)
        {
            super(param1,param5,param6);
            this._mouseX = param2;
            this._mouseY = param3;
            this._isMouseRightClick = param4;
        }

        override public function clone() : Event
        {
            return new EpicDeploymentMapEvent(type,this._mouseX,this._mouseY,this._isMouseRightClick,bubbles,cancelable);
        }

        public function get mouseX() : Number
        {
            return this._mouseX;
        }

        public function get mouseY() : Number
        {
            return this._mouseY;
        }

        public function get isMouseRightClick() : Boolean
        {
            return this._isMouseRightClick;
        }
    }
}
