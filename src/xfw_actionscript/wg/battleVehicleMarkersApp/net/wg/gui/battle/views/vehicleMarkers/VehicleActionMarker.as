package net.wg.gui.battle.views.vehicleMarkers
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import scaleform.clik.motion.Tween;
    import net.wg.data.constants.Values;
    import flash.utils.getDefinitionByName;
    import net.wg.data.constants.Errors;

    public class VehicleActionMarker extends Sprite implements IDisposable
    {

        private static const BASE_HEIGHT:int = 20;

        private static const HIDE_DURATION:int = 1000;

        private static const ALLY_ACTION_RENDERER_MAP:Object = {
            "reloading_gun":VehicleMarkersLinkages.ACTION_RELOADING,
            "reloading_gunSPG":VehicleMarkersLinkages.ACTION_RELOADING,
            "help_me":VehicleMarkersLinkages.ACTION_HELP_ME,
            "help_meSPG":VehicleMarkersLinkages.ACTION_HELP_ME,
            "follow_me":VehicleMarkersLinkages.ACTION_FOLLOW_ME,
            "follow_meSPG":VehicleMarkersLinkages.ACTION_FOLLOW_ME,
            "attackSender":VehicleMarkersLinkages.ACTION_ATTACK_SENDER,
            "attackSenderSPG":VehicleMarkersLinkages.ACTION_ATTACK_SENDER,
            "negative":VehicleMarkersLinkages.ACTION_NEGATIVE,
            "negativeSPG":VehicleMarkersLinkages.ACTION_NEGATIVE,
            "positive":VehicleMarkersLinkages.ACTION_POSITIVE,
            "positiveSPG":VehicleMarkersLinkages.ACTION_POSITIVE,
            "stop":VehicleMarkersLinkages.ACTION_STOP,
            "stopSPG":VehicleMarkersLinkages.ACTION_STOP,
            "help_me_ex":VehicleMarkersLinkages.ACTION_HELP_ME_EX,
            "help_me_exSPG":VehicleMarkersLinkages.ACTION_HELP_ME_EX,
            "turn_back":VehicleMarkersLinkages.ACTION_TURN_BACK,
            "turn_backSPG":VehicleMarkersLinkages.ACTION_TURN_BACK
        };

        private static const ENEMY_ACTION_RENDERER_MAP:Object = {
            "attack":VehicleMarkersLinkages.ACTION_ATTACK,
            "attackSPG":VehicleMarkersLinkages.ACTION_ATTACK_SPG
        };

        private var _isVisible:Boolean = false;

        private var _currentRenderer:MovieClip = null;

        private var _hideTween:Tween = null;

        private var _entityName:String = "enemy";

        public function VehicleActionMarker()
        {
            super();
        }

        public final function dispose() : void
        {
            this.removeActionRenderer();
            if(this._hideTween)
            {
                this._hideTween.dispose();
            }
            this._hideTween = null;
            this._currentRenderer = null;
        }

        public function showAction(param1:String) : void
        {
            if(param1 == Values.EMPTY_STR)
            {
                return;
            }
            var _loc2_:String = Values.EMPTY_STR;
            if(this._entityName == VehicleMarkersConstants.ENTITY_NAME_ENEMY)
            {
                _loc2_ = ENEMY_ACTION_RENDERER_MAP[param1];
            }
            else
            {
                _loc2_ = ALLY_ACTION_RENDERER_MAP[param1];
            }
            if(_loc2_ != Values.EMPTY_STR)
            {
                this._isVisible = true;
                this._currentRenderer = this.createActionRenderer(_loc2_);
            }
        }

        public function stopAction() : void
        {
            if(this._currentRenderer)
            {
                this._hideTween = new Tween(HIDE_DURATION,this._currentRenderer,{"alpha":0.0});
                this._isVisible = false;
            }
        }

        private function removeActionRenderer() : void
        {
            if(!this._currentRenderer)
            {
                return;
            }
            removeChild(this._currentRenderer);
            this._currentRenderer = null;
        }

        private function createActionRenderer(param1:String) : MovieClip
        {
            var rendererClass:Class = null;
            var rendererLinkage:String = param1;
            this.removeActionRenderer();
            var renderer:MovieClip = null;
            try
            {
                rendererClass = getDefinitionByName(rendererLinkage) as Class;
                renderer = new rendererClass();
                if(renderer)
                {
                    addChild(renderer);
                }
            }
            catch(error:ReferenceError)
            {
                DebugUtils.LOG_ERROR(Errors.BAD_LINKAGE + rendererLinkage);
            }
            return renderer;
        }

        public function get entityName() : String
        {
            return this._entityName;
        }

        public function set entityName(param1:String) : void
        {
            this._entityName = param1;
        }

        public function isVisible() : Boolean
        {
            return this._isVisible;
        }

        override public function get height() : Number
        {
            return BASE_HEIGHT;
        }
    }
}
