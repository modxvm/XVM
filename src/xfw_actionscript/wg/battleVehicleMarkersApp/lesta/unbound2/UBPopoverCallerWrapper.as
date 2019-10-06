package lesta.unbound2
{
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    import flash.display.DisplayObject;

    public class UBPopoverCallerWrapper extends Object implements IPopOverCaller
    {

        private var _target:DisplayObject;

        public function UBPopoverCallerWrapper(param1:DisplayObject)
        {
            super();
            this._target = param1;
        }

        public function getHitArea() : DisplayObject
        {
            return this._target;
        }

        public function getTargetButton() : DisplayObject
        {
            return this._target;
        }
    }
}
