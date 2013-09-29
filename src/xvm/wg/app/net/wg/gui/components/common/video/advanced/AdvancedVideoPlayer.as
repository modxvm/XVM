package net.wg.gui.components.common.video.advanced 
{
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.components.common.video.*;
    import scaleform.clik.events.*;
    
    public class AdvancedVideoPlayer extends net.wg.gui.components.common.video.SimpleVideoPlayer
    {
        public function AdvancedVideoPlayer()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(PROGRESS_BAR_INVALID)) 
            {
                this.applyProgressBarRefreshing();
            }
            if (isInvalid(this.ANIM_SHOW_INVALID)) 
            {
                this.animationManager.show(this._animationSpeed);
                invalidate(HIDE_DELAY_INVALID);
            }
            if (isInvalid(this.ANIM_HIDE_INVALID)) 
            {
                this.animationManager.hide(this._animationSpeed);
            }
            if (isInvalid(HIDE_DELAY_INVALID)) 
            {
                this.cancelHideDelay();
                if (this._hideDelay > 0) 
                {
                    if (App.utils) 
                    {
                        App.utils.scheduler.scheduleTask(this.hideDelayTimerCompleteHandler, this._hideDelay);
                    }
                }
            }
            return;
        }

        internal function hideDelayTimerCompleteHandler():void
        {
            invalidate(this.ANIM_HIDE_INVALID);
            return;
        }

        protected function applyProgressBarRefreshing():void
        {
            this.disposeProgressBar();
            if (this.progressBarClass) 
            {
                this._progressBar = new this.progressBarClass();
                this.progressBarController = new net.wg.gui.components.common.video.advanced.ProgressBarController(this, this._progressBar);
                addChild(this._progressBar);
            }
            return;
        }

        internal function disposeProgressBar():void
        {
            if (this._progressBar) 
            {
                this._progressBar.dispose();
                if (this._progressBar.parent) 
                {
                    this._progressBar.parent.removeChild(this._progressBar);
                }
                this.progressBarController.dispose();
                this.progressBarController = null;
                this._progressBar = null;
            }
            return;
        }

        public function get progressBarClass():Class
        {
            return this._progressBarClass;
        }

        internal function subtitleChangeHandler(arg1:flash.events.Event):void
        {
            this.messageField.text = currentSubtitle;
            return;
        }

        protected function closeButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(new flash.events.Event(PLAYER_CLOSED));
            return;
        }

        public function get animationSpeed():uint
        {
            return this._animationSpeed;
        }

        public function set animationSpeed(arg1:uint):void
        {
            this._animationSpeed = arg1;
            invalidate(this.ANIM_SHOW_INVALID);
            return;
        }

        public function get hideDelay():uint
        {
            return this._hideDelay;
        }

        public function set hideDelay(arg1:uint):void
        {
            this._hideDelay = arg1;
            invalidate(this.ANIM_SHOW_INVALID);
            return;
        }

        internal function cancelHideDelay():void
        {
            if (App.utils) 
            {
                App.utils.scheduler.cancelTask(this.hideDelayTimerCompleteHandler);
            }
            return;
        }

        public function get progressBar():net.wg.gui.components.common.video.advanced.AbstractPlayerProgressBar
        {
            return this._progressBar;
        }

        public override function dispose():void
        {
            this.disposeProgressBar();
            this.cancelHideDelay();
            this.animationManager.dispose();
            if (this._progressBar) 
            {
                this._progressBar.dispose();
                if (this._progressBar.parent) 
                {
                    this._progressBar.parent.removeChild(this._progressBar);
                }
                this._progressBar = null;
            }
            if (this.progressBarController) 
            {
                this.progressBarController.dispose();
                this.progressBarController = null;
            }
            if (this.controlBarController) 
            {
                this.controlBarController.dispose();
                this.controlBarController = null;
            }
            if (this.keyboardController) 
            {
                this.keyboardController.dispose();
                this.keyboardController = null;
            }
            if (this.titleBar) 
            {
                this.titleBar.closeBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.closeButtonClickHandler);
                this.titleBar.dispose();
                if (this.titleBar.parent) 
                {
                    this.titleBar.parent.removeChild(this.titleBar);
                }
                this.titleBar = null;
            }
            this.removeEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.SUBTITLE_CHANGED, this.subtitleChangeHandler);
            removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
            super.dispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.titleBar.closeBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.closeButtonClickHandler, false, 0, true);
            this.addEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.SUBTITLE_CHANGED, this.subtitleChangeHandler, false, 0, true);
            addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.mouseMoveHandler, false, 0, true);
            this.controlBarController = new net.wg.gui.components.common.video.advanced.ControlBarController(this, this.controlBar);
            this.keyboardController = new net.wg.gui.components.common.video.advanced.KeyboardController(this);
            this.messageField.text = currentSubtitle;
            this.animationManager = new net.wg.gui.components.common.video.advanced.VideoPlayerAnimationManager(this);
            return;
        }

        internal function mouseMoveHandler(arg1:flash.events.MouseEvent):void
        {
            if (App.utils.commons.isLeftButton(arg1)) 
            {
                invalidate(this.ANIM_SHOW_INVALID);
            }
            return;
        }

        public function get progressBarClassName():String
        {
            return this._progressBarClassName;
        }

        public function set progressBarClassName(arg1:String):void
        {
            var loc1:*=null;
            if (arg1 == "" || arg1 == this._progressBarClassName) 
            {
                return;
            }
            if (App.utils) 
            {
                loc1 = App.utils.classFactory.getClass(arg1);
            }
            else 
            {
                loc1 = flash.utils.getDefinitionByName(arg1) as Class;
            }
            if (loc1 == null) 
            {
                trace("Error: " + this + ", The class " + arg1 + " cannot be found in your library. Please ensure it is there.");
            }
            else 
            {
                this.progressBarClass = loc1;
                this._progressBarClassName = arg1;
            }
            return;
        }

        public function set progressBarClass(arg1:Class):void
        {
            if (this._progressBarClass != arg1) 
            {
                this._progressBarClass = arg1;
                invalidate(PROGRESS_BAR_INVALID);
            }
            return;
        }

        internal const ANIM_SHOW_INVALID:String="animShowInv";

        internal const ANIM_HIDE_INVALID:String="animHideInv";

        internal static const PROGRESS_BAR_INVALID:String="prBaeInv";

        internal static const HIDE_DELAY_INVALID:String="hideDelayInv";

        public static const PLAYER_CLOSED:String="playerClosed";

        public var titleBar:net.wg.gui.components.common.video.advanced.VideoPlayerTitleBar;

        public var controlBar:net.wg.gui.components.common.video.advanced.VideoPlayerControlBar;

        public var messageField:flash.text.TextField;

        internal var controlBarController:net.wg.gui.components.common.video.advanced.ControlBarController;

        internal var keyboardController:net.wg.gui.components.common.video.advanced.KeyboardController;

        internal var _progressBar:net.wg.gui.components.common.video.advanced.AbstractPlayerProgressBar;

        internal var _progressBarClassName:String;

        internal var _progressBarClass:Class;

        internal var progressBarController:net.wg.gui.components.common.video.advanced.ProgressBarController;

        internal var _animationSpeed:uint=0;

        internal var _hideDelay:uint=0;

        internal var animationManager:net.wg.gui.components.common.video.advanced.VideoPlayerAnimationManager;
    }
}
