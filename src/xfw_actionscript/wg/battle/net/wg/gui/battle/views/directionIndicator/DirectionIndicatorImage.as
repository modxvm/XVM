package net.wg.gui.battle.views.directionIndicator
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;

    public class DirectionIndicatorImage extends Sprite implements IDisposable
    {

        public var green:DisplayObject;

        public var red:DisplayObject;

        public var purple:DisplayObject;

        public var yellow:DisplayObject;

        public var eventAmmo:DisplayObject;

        public var eventWhite:DisplayObject;

        public function DirectionIndicatorImage()
        {
            super();
            this.green.visible = false;
            this.red.visible = false;
            this.purple.visible = false;
            this.yellow.visible = false;
            this.eventAmmo.visible = false;
        }

        public final function dispose() : void
        {
            this.green = null;
            this.red = null;
            this.purple = null;
            this.yellow = null;
            this.eventAmmo = null;
            this.eventWhite = null;
        }

        public function setShape(param1:String) : void
        {
            this.green.visible = param1 == DirectionIndicatorShape.SHAPE_GREEN;
            this.red.visible = param1 == DirectionIndicatorShape.SHAPE_RED;
            this.purple.visible = param1 == DirectionIndicatorShape.SHAPE_PURPLE;
            this.yellow.visible = param1 == DirectionIndicatorShape.SHAPE_YELLOW;
            this.eventWhite.visible = param1 == DirectionIndicatorShape.SHAPE_EVENT_KILL || param1 == DirectionIndicatorShape.SHAPE_EVENT_CAPTUREBASE || param1 == DirectionIndicatorShape.SHAPE_EVENT_OURBASE;
            this.eventAmmo.visible = param1 == DirectionIndicatorShape.SHAPE_EVENT_CAPTUREA || param1 == DirectionIndicatorShape.SHAPE_EVENT_CAPTUREB || param1 == DirectionIndicatorShape.SHAPE_EVENT_CAPTUREC || param1 == DirectionIndicatorShape.SHAPE_EVENT_ATTACK || param1 == DirectionIndicatorShape.SHAPE_EVENT_ATTACK_RED || param1 == DirectionIndicatorShape.SHAPE_EVENT_ATTACK_RECTANGLE;
        }

        public function setArrowPositionY(param1:int) : void
        {
            this.eventAmmo.y = this.green.y = this.red.y = this.purple.y = param1;
            this.yellow = null;
        }
    }
}
