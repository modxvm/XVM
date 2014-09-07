package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.MouseEvent;
    import flash.display.Sprite;
    import net.wg.gui.lobby.fortifications.data.BuildingVO;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.utils.ITweenAnimator;
    
    public class BuildingThumbnail extends MovieClip implements IDisposable
    {
        
        public function BuildingThumbnail()
        {
            super();
            this.init();
        }
        
        public static var BUILDING_ALPHA_NORMAL:Number = 1;
        
        public static var BUILDING_ALPHA_DISABLED:Number = 0.5;
        
        private static function onControlOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var buildingMC:MovieClip;
        
        public var levelMC:MovieClip;
        
        public var smoke:Sprite;
        
        private var _showLevel:Boolean = false;
        
        private var _disableLowLevel:Boolean = false;
        
        private var _showSmoke:Boolean = false;
        
        private var _model:BuildingVO;
        
        private var _ttHeader:String;
        
        private var _ttBody:String;
        
        private var _alwaysShowLvl:Boolean = false;
        
        public function get model() : BuildingVO
        {
            return this._model;
        }
        
        public function set model(param1:BuildingVO) : void
        {
            this._model = param1;
            if((this._model) && (this._model.toolTipData) && this._model.toolTipData.length > 0)
            {
                this._ttHeader = this._model.toolTipData[0];
                this._ttBody = this._model.toolTipData.length > 1?this._model.toolTipData[1]:null;
            }
            else
            {
                this._ttHeader = null;
                this._ttBody = null;
            }
            this.updateView();
        }
        
        private function init() : void
        {
            this.levelMC.alpha = 0;
            this.levelMC.visible = false;
            this.showSmoke = false;
            addEventListener(MouseEvent.ROLL_OVER,this.onControlOver);
            addEventListener(MouseEvent.ROLL_OUT,onControlOut);
        }
        
        public function dispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onControlOver);
            removeEventListener(MouseEvent.ROLL_OUT,onControlOut);
            this.animator.removeAnims(this.levelMC);
            this.buildingMC = null;
            this.levelMC = null;
            this.smoke = null;
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
        }
        
        private function updateView() : void
        {
            if(this._model)
            {
                this.levelMC.gotoAndStop(this._model.buildingLevel);
                if(this._model.isInFoundationState)
                {
                    this.buildingMC.gotoAndStop(FORTIFICATION_ALIASES.FORT_FOUNDATION);
                }
                else
                {
                    this.buildingMC.gotoAndStop(this._model.uid);
                }
                if((this._disableLowLevel) && this.model.buildingLevel < FORTIFICATION_ALIASES.CLAN_BATTLE_BUILDING_MIN_LEVEL || !this.model.isAvailable)
                {
                    this.buildingMC.alpha = BUILDING_ALPHA_DISABLED;
                }
                else
                {
                    this.buildingMC.alpha = BUILDING_ALPHA_NORMAL;
                }
                this.showSmoke = this._model.looted;
            }
        }
        
        public function get alwaysShowLvl() : Boolean
        {
            return this._alwaysShowLvl;
        }
        
        public function set alwaysShowLvl(param1:Boolean) : void
        {
            this._alwaysShowLvl = param1;
        }
        
        private function onControlOver(param1:MouseEvent) : void
        {
            var _loc2_:String = new ComplexTooltipHelper().addHeader(this._ttHeader).addBody(this._ttBody).make();
            if(_loc2_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc2_);
            }
        }
        
        public function get showLevel() : Boolean
        {
            return this._showLevel;
        }
        
        public function set showLevel(param1:Boolean) : void
        {
            this._showLevel = param1;
            if((this._showLevel) && !this.levelMC.visible)
            {
                if((stage) && !this.alwaysShowLvl)
                {
                    this.animator.removeAnims(this.levelMC);
                    this.animator.addFadeInAnim(this.levelMC,null);
                }
                else
                {
                    this.levelMC.visible = true;
                    this.levelMC.alpha = 1;
                }
            }
            else if(!this._showLevel && (this.levelMC.visible))
            {
                if(stage)
                {
                    this.animator.removeAnims(this.levelMC);
                    this.animator.addFadeOutAnim(this.levelMC,null);
                }
                else
                {
                    this.levelMC.alpha = 0;
                    this.levelMC.visible = false;
                }
            }
            
        }
        
        private function get animator() : ITweenAnimator
        {
            return App.utils.tweenAnimator;
        }
        
        public function get disableLowLevel() : Boolean
        {
            return this._disableLowLevel;
        }
        
        public function set disableLowLevel(param1:Boolean) : void
        {
            this._disableLowLevel = param1;
            this.updateView();
        }
        
        public function get showSmoke() : Boolean
        {
            return this._showSmoke;
        }
        
        public function set showSmoke(param1:Boolean) : void
        {
            this._showSmoke = param1;
            this.smoke.visible = this._showSmoke;
        }
    }
}
