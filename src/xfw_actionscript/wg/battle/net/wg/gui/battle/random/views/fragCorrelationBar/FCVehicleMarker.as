package net.wg.gui.battle.random.views.fragCorrelationBar
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Sprite;
    import net.wg.infrastructure.managers.IAtlasManager;
    import net.wg.data.constants.VehicleStatus;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;

    public class FCVehicleMarker extends MovieClip implements IDisposable
    {

        private static const LAST_ANIM_FRAME:int = 12;

        private static const NORMAL_IMAGE_POSTFIX:String = "Normal";

        private static const DESTROYED_IMAGE_POSTFIX:String = "Destroyed";

        private static const NORMAL_FRAME_NAME:String = "normal";

        private static const DESTROY_FRAME_NAME:String = "destroy";

        private static const DESTROYED_FRAME_NAME:String = "destroyed";

        public var vehicleID:int = -1;

        public var normalMarker:Sprite = null;

        public var destroyedMarker:Sprite = null;

        private var _vehicleStatus:int = -1;

        private var _vehicleType:String = "";

        private var _color:String = "";

        private var _atlasManager:IAtlasManager;

        private var _vehicleMarkerAnimFinishedHandler:IVehicleMarkerAnimFinishedHandler = null;

        private var _isDisposed:Boolean = false;

        public function FCVehicleMarker()
        {
            this._atlasManager = App.atlasMgr;
            super();
        }

        public function update(param1:String, param2:int, param3:String) : void
        {
            var _loc4_:* = false;
            if(this._vehicleType != param1)
            {
                _loc4_ = true;
                this._vehicleType = param1;
            }
            if(this._color != param3)
            {
                _loc4_ = true;
                this._color = param3;
            }
            if(_loc4_)
            {
                this.redraw();
            }
            if(this._vehicleStatus != param2)
            {
                this._vehicleStatus = param2;
                if(!(this._vehicleStatus & VehicleStatus.IS_ALIVE) > 0)
                {
                    gotoAndStop(DESTROYED_FRAME_NAME);
                    this.normalMarker.visible = false;
                    this.destroyedMarker.visible = true;
                }
                else
                {
                    gotoAndStop(NORMAL_FRAME_NAME);
                    this.destroyedMarker.visible = false;
                }
            }
        }

        public function init(param1:int, param2:String, param3:int, param4:String, param5:IVehicleMarkerAnimFinishedHandler) : void
        {
            this.vehicleID = param1;
            this.update(param2,param3,param4);
            addFrameScript(LAST_ANIM_FRAME,this.updateVehicleIDs);
            this._vehicleMarkerAnimFinishedHandler = param5;
        }

        private function playDestroyAnim() : void
        {
            this.destroyedMarker.visible = true;
            gotoAndPlay(DESTROY_FRAME_NAME);
        }

        private function updateVehicleIDs() : void
        {
            this._vehicleStatus = this._vehicleStatus ^ VehicleStatus.IS_ALIVE;
            this.normalMarker.visible = false;
            stop();
            this._vehicleMarkerAnimFinishedHandler.sort();
        }

        private function redraw() : void
        {
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,this._color + this._vehicleType + NORMAL_IMAGE_POSTFIX,this.normalMarker.graphics);
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,this._color + this._vehicleType + DESTROYED_IMAGE_POSTFIX,this.destroyedMarker.graphics);
        }

        public function updateVehicleStatus(param1:uint) : void
        {
            this._vehicleStatus = param1;
            if(!(this._vehicleStatus & VehicleStatus.IS_ALIVE) > 0)
            {
                this.playDestroyAnim();
            }
        }

        public function set color(param1:String) : void
        {
            this._color = param1;
            this.redraw();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        protected function onDispose() : void
        {
            App.utils.asserter.assert(!this._isDisposed,"FCVehicleMarker is already disposed!");
            this._isDisposed = true;
            this.normalMarker = null;
            this.destroyedMarker = null;
            this._atlasManager = null;
            this._vehicleMarkerAnimFinishedHandler = null;
        }
    }
}
