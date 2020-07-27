package net.wg.gui.components.battleRoyale.data
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.geom.Point;

    public class ArrowDrawCommand extends Object implements IDisposable
    {

        public var fromPoint:Point = null;

        public var toPoint:Point = null;

        public var countPotentialLinks:int = -1;

        public var isActive:Boolean = false;

        public var isWithArrow:Boolean = true;

        public function ArrowDrawCommand(param1:Point, param2:Point, param3:int, param4:Boolean = false, param5:Boolean = true)
        {
            super();
            this.fromPoint = param1;
            this.toPoint = param2;
            this.countPotentialLinks = param3;
            this.isActive = param4;
            this.isWithArrow = param5;
        }

        public final function dispose() : void
        {
            this.fromPoint = null;
            this.toPoint = null;
        }
    }
}
