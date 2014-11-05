package net.wg.gui.components.common.video.advanced
{
    import net.wg.gui.components.common.video.SimpleVideoPlayer;
    import flash.text.TextField;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.components.common.video.VideoPlayerEvent;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import flash.events.Event;
    
    public class AdvancedVideoPlayer extends SimpleVideoPlayer
    {
        
        public function AdvancedVideoPlayer()
        {
            super();
        }
        
        private static var PROGRESS_BAR_INVALID:String = "prBaeInv";
        
        private static var HIDE_DELAY_INVALID:String = "hideDelayInv";
        
        public static var PLAYER_CLOSED:String = "playerClosed";
        
        public var titleBar:VideoPlayerTitleBar;
        
        public var controlBar:VideoPlayerControlBar;
        
        public var messageField:TextField;
        
        private var controlBarController:ControlBarController;
        
        private var keyboardController:KeyboardController;
        
        private var _progressBar:AbstractPlayerProgressBar;
        
        private var _progressBarClassName:String;
        
        private var _progressBarClass:Class;
        
        private var progressBarController:ProgressBarController;
        
        private var _animationSpeed:uint = 0;
        
        private var _hideDelay:uint = 0;
        
        private var ANIM_SHOW_INVALID:String = "animShowInv";
        
        private var ANIM_HIDE_INVALID:String = "animHideInv";
        
        private var animationManager:VideoPlayerAnimationManager;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.titleBar.closeBtn.addEventListener(ButtonEvent.CLICK,this.closeButtonClickHandler,false,0,true);
            this.addEventListener(VideoPlayerEvent.SUBTITLE_CHANGED,this.subtitleChangeHandler,false,0,true);
            addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,false,0,true);
            this.controlBarController = new ControlBarController(this,this.controlBar);
            this.keyboardController = new KeyboardController(this);
            this.messageField.text = currentSubtitle;
            this.animationManager = new VideoPlayerAnimationManager(this);
        }
        
        private function mouseMoveHandler(param1:MouseEvent) : void
        {
            if(App.utils.commons.isLeftButton(param1))
            {
                invalidate(this.ANIM_SHOW_INVALID);
            }
        }
        
        public function get progressBarClassName() : String
        {
            return this._progressBarClassName;
        }
        
        public function set progressBarClassName(param1:String) : void
        {
            var _loc2_:Class = null;
            if(param1 == "" || param1 == this._progressBarClassName)
            {
                return;
            }
            if(App.utils)
            {
                _loc2_ = App.utils.classFactory.getClass(param1);
            }
            else
            {
                _loc2_ = getDefinitionByName(param1) as Class;
            }
            if(_loc2_ != null)
            {
                this.progressBarClass = _loc2_;
                this._progressBarClassName = param1;
            }
            else
            {
                trace("Error: " + this + ", The class " + param1 + " cannot be found in your library. Please ensure it is there.");
            }
        }
        
        public function set progressBarClass(param1:Class) : void
        {
            if(this._progressBarClass != param1)
            {
                this._progressBarClass = param1;
                invalidate(PROGRESS_BAR_INVALID);
            }
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(PROGRESS_BAR_INVALID))
            {
                this.applyProgressBarRefreshing();
            }
            if(isInvalid(this.ANIM_SHOW_INVALID))
            {
                this.animationManager.show(this._animationSpeed);
                invalidate(HIDE_DELAY_INVALID);
            }
            if(isInvalid(this.ANIM_HIDE_INVALID))
            {
                this.animationManager.hide(this._animationSpeed);
            }
            if(isInvalid(HIDE_DELAY_INVALID))
            {
                this.cancelHideDelay();
                if(this._hideDelay > 0)
                {
                    if(App.utils)
                    {
                        App.utils.scheduler.scheduleTask(this.hideDelayTimerCompleteHandler,this._hideDelay);
                    }
                }
            }
        }
        
        private function hideDelayTimerCompleteHandler() : void
        {
            invalidate(this.ANIM_HIDE_INVALID);
        }
        
        protected function applyProgressBarRefreshing() : void
        {
            this.disposeProgressBar();
            if(this.progressBarClass)
            {
                this._progressBar = new this.progressBarClass();
                this.progressBarController = new ProgressBarController(this,this._progressBar);
                addChild(this._progressBar);
            }
        }
        
        private function disposeProgressBar() : void
        {
            if(this._progressBar)
            {
                this._progressBar.dispose();
                if(this._progressBar.parent)
                {
                    this._progressBar.parent.removeChild(this._progressBar);
                }
                this.progressBarController.dispose();
                this.progressBarController = null;
                this._progressBar = null;
            }
        }
        
        public function get progressBarClass() : Class
        {
            return this._progressBarClass;
        }
        
        private function subtitleChangeHandler(param1:Event) : void
        {
            this.messageField.text = currentSubtitle;
        }
        
        protected function closeButtonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new Event(PLAYER_CLOSED));
        }
        
        public function get animationSpeed() : uint
        {
            return this._animationSpeed;
        }
        
        public function set animationSpeed(param1:uint) : void
        {
            this._animationSpeed = param1;
            invalidate(this.ANIM_SHOW_INVALID);
        }
        
        public function get hideDelay() : uint
        {
            return this._hideDelay;
        }
        
        public function set hideDelay(param1:uint) : void
        {
            this._hideDelay = param1;
            invalidate(this.ANIM_SHOW_INVALID);
        }
        
        private function cancelHideDelay() : void
        {
            if(App.utils)
            {
                App.utils.scheduler.cancelTask(this.hideDelayTimerCompleteHandler);
            }
        }
        
        public function get progressBar() : AbstractPlayerProgressBar
        {
            return this._progressBar;
        }
        
        override protected function onDispose() : void
        {
            this.disposeProgressBar();
            this.cancelHideDelay();
            this.animationManager.dispose();
            if(this._progressBar)
            {
                this._progressBar.dispose();
                if(this._progressBar.parent)
                {
                    this._progressBar.parent.removeChild(this._progressBar);
                }
                this._progressBar = null;
            }
            if(this.progressBarController)
            {
                this.progressBarController.dispose();
                this.progressBarController = null;
            }
            if(this.controlBarController)
            {
                this.controlBarController.dispose();
                this.controlBarController = null;
            }
            if(this.keyboardController)
            {
                this.keyboardController.dispose();
                this.keyboardController = null;
            }
            if(this.titleBar)
            {
                this.titleBar.closeBtn.removeEventListener(ButtonEvent.CLICK,this.closeButtonClickHandler);
                this.titleBar.dispose();
                if(this.titleBar.parent)
                {
                    this.titleBar.parent.removeChild(this.titleBar);
                }
                this.titleBar = null;
            }
            this.removeEventListener(VideoPlayerEvent.SUBTITLE_CHANGED,this.subtitleChangeHandler);
            removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
            super.onDispose();
        }
    }
}
