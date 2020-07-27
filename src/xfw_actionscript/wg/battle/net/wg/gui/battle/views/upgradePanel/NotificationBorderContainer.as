package net.wg.gui.battle.views.upgradePanel
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;

    public class NotificationBorderContainer extends Sprite implements IDisposable
    {

        public var notificationBorder:MovieClip = null;

        private var _width:Number;

        private var _height:Number;

        public function NotificationBorderContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.notificationBorder = null;
        }

        override public function get width() : Number
        {
            return this._width;
        }

        override public function set width(param1:Number) : void
        {
            this.notificationBorder.width = param1;
            this._width = param1;
        }

        override public function get height() : Number
        {
            return this._height;
        }

        override public function set height(param1:Number) : void
        {
            this.notificationBorder.height = param1;
            this._height = param1;
        }
    }
}
