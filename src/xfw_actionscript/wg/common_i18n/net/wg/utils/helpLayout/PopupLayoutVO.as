package net.wg.utils.helpLayout
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObjectContainer;

    public class PopupLayoutVO extends Object implements IDisposable
    {

        public var width:int;

        public var height:int;

        public var x:int;

        public var y:int;

        public var scope:DisplayObjectContainer;

        public function PopupLayoutVO()
        {
            super();
        }

        public function dispose() : void
        {
            this.scope = null;
        }
    }
}
