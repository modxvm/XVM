package net.wg.gui.battle.views.epicRespawnView.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.FightButton;
    import net.wg.gui.battle.views.epicRespawnView.events.EpicRespawnEvent;
    import flash.text.TextField;

    public class EpicRespawnDeployButtonGroup extends MovieClip implements IDisposable
    {

        private static const RESET_STATE:int = 1;

        private static const INTRO_STATE:String = "intro";

        private static const HIGHLIGHT_STATE:String = "higlight";

        public var deployButton:FightButton = null;

        public var buttonAnimation:MovieClip = null;

        public var deployNotification:MovieClip = null;

        private var _highlightAnimationActive:Boolean = false;

        private var _introAnimationActive:Boolean = false;

        public function EpicRespawnDeployButtonGroup()
        {
            super();
            mouseEnabled = false;
            this.buttonAnimation.mouseEnabled = false;
            this.buttonAnimation.mouseChildren = false;
            this.deployNotification.mouseChildren = false;
            this.deployNotification.mouseEnabled = false;
        }

        public final function dispose() : void
        {
            this.deployButton.dispose();
            this.deployButton = null;
            this.buttonAnimation.stop();
            this.buttonAnimation = null;
            this.deployNotification = null;
        }

        public function playHighlightState() : void
        {
            if(!this._highlightAnimationActive)
            {
                this.buttonAnimation.gotoAndPlay(HIGHLIGHT_STATE);
                this._highlightAnimationActive = true;
            }
        }

        public function reset() : void
        {
            this._introAnimationActive = false;
            this._highlightAnimationActive = false;
            this.buttonAnimation.gotoAndStop(RESET_STATE);
        }

        public function updateAutoTimer(param1:Boolean, param2:String) : void
        {
            if(!param1 && !this.deployNotification.cooldownToDeployTF.visible)
            {
                this.playHighlightState();
                this.updateDeployNotification(this.deployNotification.timerToAutoDeployTF,true,param2);
            }
            else if(param1)
            {
                this.setDeployButtonState(false);
            }
            else
            {
                this.updateDeployNotification(this.deployNotification.timerToAutoDeployTF,false);
            }
        }

        public function updateTimer(param1:Boolean, param2:String) : void
        {
            this.setDeployButtonState(param1);
            if(param1)
            {
                this.updateDeployNotification(this.deployNotification.cooldownToDeployTF,false);
            }
            else
            {
                this.updateDeployNotification(this.deployNotification.timerToAutoDeployTF,false);
                this.updateDeployNotification(this.deployNotification.cooldownToDeployTF,true,param2);
            }
        }

        private function setDeployButtonState(param1:Boolean) : void
        {
            if(param1 && !this._introAnimationActive && !this.deployButton.enabled)
            {
                this.buttonAnimation.gotoAndPlay(INTRO_STATE);
                this._introAnimationActive = true;
                dispatchEvent(new EpicRespawnEvent(EpicRespawnEvent.DEPLOYMENT_BUTTON_READY));
            }
            this.deployButton.enabled = param1;
        }

        private function updateDeployNotification(param1:TextField, param2:Boolean, param3:String = "") : void
        {
            param1.visible = param2;
            param1.text = param3;
        }
    }
}
