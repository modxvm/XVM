package net.wg.gui.lobby.techtree.data.state
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class StateProperties extends Object implements IDisposable
    {

        public var id:uint;

        public var state:String;

        public var action:String;

        public var enough:uint;

        public var visible:Boolean;

        public var animation:AnimationProperties;

        public var cmpAlpha:Number;

        public function StateProperties(param1:uint, param2:String, param3:String = "", param4:uint = 0, param5:Boolean = false, param6:AnimationProperties = null, param7:Number = 1)
        {
            super();
            this.id = param1;
            this.state = param2;
            this.action = param3;
            this.enough = param4;
            this.visible = param5;
            this.animation = param6;
            this.cmpAlpha = param7;
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        protected function onDispose() : void
        {
            this.animation = null;
        }
    }
}
