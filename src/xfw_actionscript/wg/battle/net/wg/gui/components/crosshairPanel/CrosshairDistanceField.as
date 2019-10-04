package net.wg.gui.components.crosshairPanel
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class CrosshairDistanceField extends MovieClip implements IDisposable
    {

        public var distanceTF:TextField = null;

        private var _distance:String = "";

        public function CrosshairDistanceField()
        {
            super();
        }

        public function dispose() : void
        {
            this.distanceTF = null;
        }

        public function setDistance(param1:String) : void
        {
            if(this._distance != param1)
            {
                this._distance = param1;
                this.distanceTF.text = this._distance;
            }
        }
    }
}
