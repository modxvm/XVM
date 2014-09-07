package net.wg.gui.lobby.fortifications.cmp.build.impl.animationImpl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.gui.lobby.fortifications.events.FortBuildingAnimationEvent;
    
    public class BuildingsAnimationController extends MovieClip implements IDisposable
    {
        
        public function BuildingsAnimationController()
        {
            super();
            mouseEnabled = mouseChildren = false;
            this.animationPresets = Vector.<MovieClip>([this.buildFoundation,this.demountBuilding,this.modernizationBuilding]);
            this.setCodeToFrame();
        }
        
        private static var START_ANIMATION_LABEL:String = "startAnimation";
        
        public var buildFoundation:FortBuildingAnimationBase;
        
        public var demountBuilding:DemountBuildingsAnimation;
        
        public var modernizationBuilding:FortBuildingAnimationBase;
        
        public var isPlayingAnimation:Boolean = false;
        
        private var _currentState:int = -1;
        
        private var animationPresets:Vector.<MovieClip> = null;
        
        public function setAnimationType(param1:int, param2:String = null) : void
        {
            var _loc3_:String = null;
            if(this._currentState == param1 || param1 == FORTIFICATION_ALIASES.WITHOUT_ANIMATION)
            {
                return;
            }
            this.isPlayingAnimation = true;
            this._currentState = param1;
            if(this._currentState == FORTIFICATION_ALIASES.BUILD_FOUNDATION_ANIMATION)
            {
                this.buildFoundation.visible = true;
                this.buildFoundation.gotoAndPlay(START_ANIMATION_LABEL);
            }
            else if(this._currentState == FORTIFICATION_ALIASES.DEMOUNT_BUILDING_ANIMATION)
            {
                this.demountBuilding.visible = true;
                if(this.demountBuilding.getBuildingTexture())
                {
                    _loc3_ = param2 == FORTIFICATION_ALIASES.FORT_UNKNOWN?FORTIFICATION_ALIASES.FORT_FOUNDATION:param2;
                    this.demountBuilding.getBuildingTexture().setState(_loc3_);
                }
                this.demountBuilding.gotoAndPlay(START_ANIMATION_LABEL);
            }
            else if(this._currentState == FORTIFICATION_ALIASES.UPGRADE_BUILDING_ANIMATION)
            {
                this.modernizationBuilding.visible = true;
                this.modernizationBuilding.gotoAndPlay(START_ANIMATION_LABEL);
            }
            
            
        }
        
        public function resetAnimationType() : void
        {
            var _loc1_:MovieClip = null;
            for each(_loc1_ in this.animationPresets)
            {
                _loc1_.gotoAndStop(0);
                _loc1_.visible = false;
            }
            this._currentState = FORTIFICATION_ALIASES.WITHOUT_ANIMATION;
            this.isPlayingAnimation = false;
        }
        
        public function dispose() : void
        {
            var _loc1_:IDisposable = null;
            for each(_loc1_ in this.animationPresets)
            {
                _loc1_.dispose();
            }
            this.animationPresets.splice(0,this.animationPresets.length);
            this.animationPresets = null;
            this.buildFoundation = null;
            this.demountBuilding = null;
            this.modernizationBuilding = null;
        }
        
        private function setCodeToFrame() : void
        {
            var _loc1_:MovieClip = null;
            var _loc2_:* = 0;
            for each(_loc1_ in this.animationPresets)
            {
                _loc2_ = _loc1_.totalFrames - 1;
                _loc1_.visible = false;
                _loc1_.addFrameScript(_loc2_,this.andAnimationHandler);
            }
        }
        
        private function andAnimationHandler() : void
        {
            dispatchEvent(new FortBuildingAnimationEvent(FortBuildingAnimationEvent.END_ANIMATION));
        }
    }
}
