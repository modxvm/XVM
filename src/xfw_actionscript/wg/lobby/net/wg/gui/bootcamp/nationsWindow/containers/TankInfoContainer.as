package net.wg.gui.bootcamp.nationsWindow.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class TankInfoContainer extends MovieClip implements IDisposable
    {

        private static var ICON_OFFSET_X:int = 20;

        public var iconTank:MovieClip = null;

        public var txtName:TextField = null;

        public var txtDescription:TextField = null;

        public function TankInfoContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.iconTank = null;
            this.txtName = null;
            this.txtDescription = null;
        }

        public function setTankIfo(param1:String, param2:String, param3:String) : void
        {
            this.iconTank.gotoAndStop(param1);
            this.txtName.text = param2;
            this.txtDescription.text = param3;
            this.iconTank.x = -(this.txtName.textWidth >> 1) - ICON_OFFSET_X;
        }
    }
}
