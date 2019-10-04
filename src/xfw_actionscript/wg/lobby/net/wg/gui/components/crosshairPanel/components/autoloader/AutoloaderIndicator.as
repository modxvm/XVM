package net.wg.gui.components.crosshairPanel.components.autoloader
{
    import net.wg.infrastructure.base.SimpleContainer;
    import flash.display.MovieClip;

    public class AutoloaderIndicator extends SimpleContainer
    {

        private static const TOTAL_AMMO:String = "TOTAL_AMMO_INVALID";

        private static const CURRENT_AMMO:String = "QUANTITY_IN_CLIP_INVALID";

        private static const SHOOT_STATE:int = 2;

        public var cassette:AutoloaderShellsCassette = null;

        public var fireMc:MovieClip = null;

        private var _totalAmmo:int = -1;

        private var _currentAmmo:int = -1;

        public function AutoloaderIndicator()
        {
            super();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(TOTAL_AMMO))
            {
                this.cassette.totalAmmo = this._totalAmmo;
            }
            if(isInvalid(CURRENT_AMMO))
            {
                this.cassette.currentAmmo = this._currentAmmo;
            }
        }

        override protected function onDispose() : void
        {
            this.cassette.dispose();
            this.cassette = null;
            this.fireMc = null;
            super.onDispose();
        }

        public function autoloaderShowShot() : void
        {
            this.fireMc.gotoAndPlay(SHOOT_STATE);
        }

        public function autoloaderUpdate(param1:Number, param2:Number, param3:Boolean) : void
        {
            this.cassette.autoloadProgress(param1,param2,param3);
        }

        public function setGunReloadingPercent(param1:Number, param2:Boolean) : void
        {
            this.cassette.reloadingPercent(param1,param2);
        }

        public function updateCritical(param1:Boolean) : void
        {
            this.cassette.updateCritical(param1);
        }

        public function updateCurrentAmmo(param1:int) : void
        {
            if(this._currentAmmo != param1)
            {
                this._currentAmmo = param1;
                invalidate(CURRENT_AMMO);
            }
        }

        public function updateQuantityInClip(param1:int, param2:int) : void
        {
            this.updateCurrentAmmo(param1);
            this.updateTotalAmmo(param2);
        }

        public function updateTotalAmmo(param1:int) : void
        {
            if(this._totalAmmo != param1)
            {
                this._totalAmmo = param1;
                invalidate(TOTAL_AMMO);
            }
        }
    }
}
