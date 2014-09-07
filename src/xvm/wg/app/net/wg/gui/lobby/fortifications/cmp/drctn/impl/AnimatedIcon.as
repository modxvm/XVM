package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.utils.animation.ITweenConstruction;
    import flash.display.BlendMode;
    import net.wg.utils.ITweenAnimator;
    import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
    import net.wg.infrastructure.interfaces.ITween;
    import net.wg.data.constants.DelayTypes;
    
    public class AnimatedIcon extends UIComponent
    {
        
        public function AnimatedIcon()
        {
            super();
        }
        
        private static var INVALID_FADE_IN:String = "invalidFadeIn";
        
        private static var ICON_FADE_IN_DELAY:Number = 200;
        
        private static var OVERLAY_FADE_IN_DELAY:Number = 200;
        
        private static var OVERLAY_FADE_OUT_DURATION:Number = 500;
        
        private static var OVERLAY_FADE_OUT_ALPHA:Number = 0.25;
        
        public var icon:UILoaderAlt;
        
        public var iconOverlay:UILoaderAlt;
        
        private var _iconSource:String = null;
        
        private var _useOverlay:Boolean = true;
        
        private var iconFadeIn:ITweenConstruction;
        
        private var overlayFadeIn:ITweenConstruction;
        
        private var needToPlayFadeIn:Boolean = false;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.iconOverlay.blendMode = BlendMode.ADD;
            this.initAnimations();
        }
        
        override protected function onDispose() : void
        {
            this.icon.dispose();
            this.icon = null;
            this.iconOverlay.dispose();
            this.iconOverlay = null;
            if(this.iconFadeIn)
            {
                this.iconFadeIn.dispose();
                this.iconFadeIn = null;
            }
            if(this.overlayFadeIn)
            {
                this.overlayFadeIn.dispose();
                this.overlayFadeIn = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(INVALID_FADE_IN)) && (this.needToPlayFadeIn))
            {
                this.startFadeIn();
                this.needToPlayFadeIn = false;
            }
        }
        
        private function initAnimations() : void
        {
            var _loc1_:ITweenAnimator = App.utils.tweenAnimator;
            this.iconFadeIn = App.utils.animBuilder.addFadeIn(this.icon,null,ICON_FADE_IN_DELAY);
            var _loc2_:ITweenPropertiesVO = _loc1_.createPropsForAlpha(this.iconOverlay,OVERLAY_FADE_OUT_DURATION,OVERLAY_FADE_OUT_ALPHA,0);
            var _loc3_:ITween = App.tweenMgr.createNewTween(_loc2_);
            this.overlayFadeIn = App.utils.animBuilder.addFadeIn(this.iconOverlay,null,OVERLAY_FADE_IN_DELAY);
            this.overlayFadeIn.addTween(_loc3_,0,DelayTypes.LOCAL);
        }
        
        private function startFadeIn() : void
        {
            this.icon.alpha = 0;
            this.iconFadeIn.start();
            if(this._useOverlay)
            {
                this.iconOverlay.alpha = 0;
                this.overlayFadeIn.start();
            }
        }
        
        public function playFadeIn(param1:Boolean = true) : void
        {
            if(param1)
            {
                if(initialized)
                {
                    this.startFadeIn();
                }
                else
                {
                    this.needToPlayFadeIn = true;
                    invalidate(INVALID_FADE_IN);
                }
            }
            else
            {
                this.icon.alpha = 1;
                this.iconOverlay.alpha = OVERLAY_FADE_OUT_ALPHA;
            }
        }
        
        public function get iconSource() : String
        {
            return this._iconSource;
        }
        
        public function set iconSource(param1:String) : void
        {
            this._iconSource = param1;
            this.icon.source = this._iconSource;
            this.iconOverlay.source = this._iconSource;
        }
        
        public function get useOverlay() : Boolean
        {
            return this._useOverlay;
        }
        
        public function set useOverlay(param1:Boolean) : void
        {
            this._useOverlay = param1;
            this.iconOverlay.visible = param1;
        }
    }
}
