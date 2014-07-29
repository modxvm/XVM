package net.wg.gui.lobby.techtree.controls
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.techtree.sub.ResearchItems;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.lobby.techtree.constants.TTInvalidationType;
    import scaleform.clik.constants.InvalidationType;
    
    public class PremiumLayout extends UIComponent
    {
        
        public function PremiumLayout()
        {
            super();
        }
        
        public static var PREMIUM_LAYOUT_SOURCE:String = "PremiumLayoutSkinned";
        
        public static function show(param1:ResearchItems) : PremiumLayout
        {
            var _loc2_:PremiumLayout = App.utils.classFactory.getComponent(PREMIUM_LAYOUT_SOURCE,PremiumLayout);
            if(_loc2_ != null)
            {
                param1.addChild(_loc2_);
                param1.swapChildren(param1.background,_loc2_);
                param1.removeChild(param1.background);
                _loc2_.context = param1;
                _loc2_.height = param1.height;
                _loc2_.validateNow();
            }
            return _loc2_;
        }
        
        private var _context:ResearchItems = null;
        
        public var flags:MovieClip;
        
        public var description:PremiumDescription;
        
        public var background:Sprite;
        
        public function get context() : ResearchItems
        {
            return this._context;
        }
        
        public function set context(param1:ResearchItems) : void
        {
            if(this._context == param1)
            {
                return;
            }
            this._context = param1;
            invalidate(TTInvalidationType.NATION,TTInvalidationType.DESCRIPTION);
        }
        
        override protected function onDispose() : void
        {
            this._context = null;
            super.onDispose();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            super.draw();
            if(this._context == null)
            {
                return;
            }
            if(isInvalid(TTInvalidationType.NATION))
            {
                if(this.flags != null)
                {
                    this.flags.gotoAndStop(this._context.dataProvider.nation);
                }
            }
            if(isInvalid(TTInvalidationType.DESCRIPTION))
            {
                if(this.description != null)
                {
                    this.description.setData(this._context.dataProvider.getGlobalStats().extraInfo);
                    this.description.validateNow();
                    invalidateSize();
                }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = this._context.rGraphics != null?this._context.rGraphics.y:0;
                _loc2_ = this._context.rootRenderer != null?this._context.rootRenderer.getY():_height >> 1;
                if(this.background != null)
                {
                    this.background.height = _height;
                }
                if(this.flags != null)
                {
                    this.flags.y = _loc1_ - (this.flags.height >> 1);
                }
                if(this.description != null)
                {
                    this.description.y = _loc1_ + _loc2_ - (this.description.actualHeight >> 1);
                }
            }
        }
    }
}
