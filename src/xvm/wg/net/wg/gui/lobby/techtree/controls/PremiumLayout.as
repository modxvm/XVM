package net.wg.gui.lobby.techtree.controls 
{
    import flash.display.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.sub.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class PremiumLayout extends scaleform.clik.core.UIComponent
    {
        public function PremiumLayout()
        {
            super();
            return;
        }

        public function get context():net.wg.gui.lobby.techtree.sub.ResearchItems
        {
            return this._context;
        }

        public function set context(arg1:net.wg.gui.lobby.techtree.sub.ResearchItems):void
        {
            if (this._context == arg1) 
                return;
            this._context = arg1;
            invalidate(net.wg.gui.lobby.techtree.constants.TTInvalidationType.NATION, net.wg.gui.lobby.techtree.constants.TTInvalidationType.DESCRIPTION);
            return;
        }

        public override function dispose():void
        {
            this._context = null;
            super.dispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            super.draw();
            if (this._context == null) 
                return;
            if (isInvalid(net.wg.gui.lobby.techtree.constants.TTInvalidationType.NATION)) 
                if (this.flags != null) 
                    this.flags.gotoAndStop(this._context.dataProvider.nation);
            if (isInvalid(net.wg.gui.lobby.techtree.constants.TTInvalidationType.DESCRIPTION)) 
                if (this.description != null) 
                {
                    this.description.setData(this._context.dataProvider.getGlobalStats().extraInfo);
                    this.description.validateNow();
                    invalidateSize();
                }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                loc1 = this._context.rGraphics == null ? 0 : this._context.rGraphics.y;
                loc2 = this._context.rootRenderer == null ? _height >> 1 : this._context.rootRenderer.getY();
                if (this.background != null) 
                    this.background.height = _height;
                if (this.flags != null) 
                    this.flags.y = loc1 - (this.flags.height >> 1);
                if (this.description != null) 
                    this.description.y = loc1 + loc2 - (this.description.actualHeight >> 1);
            }
            return;
        }

        public static function show(arg1:net.wg.gui.lobby.techtree.sub.ResearchItems):net.wg.gui.lobby.techtree.controls.PremiumLayout
        {
            var loc1:*=App.utils.classFactory.getComponent(PREMIUM_LAYOUT_SOURCE, net.wg.gui.lobby.techtree.controls.PremiumLayout);
            if (loc1 != null) 
            {
                arg1.addChild(loc1);
                arg1.swapChildren(arg1.background, loc1);
                arg1.removeChild(arg1.background);
                loc1.context = arg1;
                loc1.height = arg1.height;
                loc1.validateNow();
            }
            return loc1;
        }

        public static const PREMIUM_LAYOUT_SOURCE:String="PremiumLayoutSkinned";

        internal var _context:net.wg.gui.lobby.techtree.sub.ResearchItems=null;

        public var flags:flash.display.MovieClip;

        public var description:net.wg.gui.lobby.techtree.controls.PremiumDescription;

        public var background:flash.display.Sprite;
    }
}
