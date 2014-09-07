package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.gui.lobby.fortifications.cmp.base.impl.FortBuildingBase;
    import net.wg.gui.lobby.fortifications.cmp.build.IBuildingTexture;
    import flash.display.MovieClip;
    
    public class FortBuildingBtn extends FortBuildingBase
    {
        
        public function FortBuildingBtn()
        {
            super();
            this.blinkingButton.gotoAndStop(0);
            this.blinkingButton.alpha = 0;
            this.blinkingButton.visible = false;
            this.setLevelUpState(false);
        }
        
        private static var START_ANIMATION:String = "startAnimation";
        
        public var building:IBuildingTexture;
        
        public var blendingEffect:MovieClip;
        
        public var blinkingButton:BuildingBlinkingBtn;
        
        private var _levelUp:Boolean = false;
        
        private var _currentState:String = "";
        
        override public function dispose() : void
        {
            this.building.dispose();
            this.building = null;
            this.blendingEffect = null;
            this.blinkingButton.dispose();
            this.blinkingButton = null;
            super.dispose();
        }
        
        public function getBuildingShape() : MovieClip
        {
            return this.building.getBuildingShape();
        }
        
        public function handleMousePress() : void
        {
            this.setLevelUpState(false);
            App.contextMenuMgr.hide();
        }
        
        public function setCurrentState(param1:String) : void
        {
            this.updateStates(param1);
        }
        
        public function currentState() : String
        {
            return this._currentState;
        }
        
        public function setLevelUpState(param1:Boolean) : void
        {
            if(this._levelUp == param1)
            {
                return;
            }
            this._levelUp = param1;
            this.building.alpha = this.getAlpha(!param1);
            if((param1) && !this.blinkingButton.visible)
            {
                this.blinkingButton.visible = true;
            }
            this.blinkingButton.alpha = this.getAlpha(param1);
            if(param1)
            {
                this.blinkingButton.gotoAndPlay(START_ANIMATION);
            }
            else
            {
                this.blinkingButton.gotoAndStop(0);
            }
        }
        
        public function getAlpha(param1:Boolean) : int
        {
            return param1?1:0;
        }
        
        private function updateStates(param1:String) : void
        {
            if(this._currentState == param1)
            {
                return;
            }
            this._currentState = param1;
            this.building.setState(param1);
            this.blendingEffect.gotoAndStop(param1);
            this.blinkingButton.setState(param1);
        }
    }
}
