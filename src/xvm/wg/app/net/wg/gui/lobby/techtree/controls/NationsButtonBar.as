package net.wg.gui.lobby.techtree.controls 
{
    import flash.display.*;
    import net.wg.gui.components.advanced.*;
    import scaleform.clik.controls.*;
    
    public class NationsButtonBar extends net.wg.gui.components.advanced.ButtonBarEx
    {
        public function NationsButtonBar()
        {
            super();
            return;
        }

        public function get tabVAlign():String
        {
            return this._tabVAlign;
        }

        public function set tabVAlign(arg1:String):void
        {
            this._tabVAlign = arg1;
            invalidate();
            return;
        }

        protected override function configUI():void
        {
            if (this.barBG != null) 
            {
                this.barBG.mouseEnabled = false;
            }
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function updateRenderers():void
        {
            var loc1:*=null;
            super.updateRenderers();
            var loc2:*=this.tabVAlign;
            switch (loc2) 
            {
                case CENTER_ALIGN:
                {
                    if (_renderers.length > 0 && _dataProvider.length >= _renderers.length) 
                    {
                        loc1 = _renderers[(_renderers.length - 1)];
                        this.repositionRenderers((actualHeight >> 1) - (loc1.y + loc1.height >> 1));
                    }
                    break;
                }
                case BOTTOM_ALIGN:
                {
                    if (_renderers.length > 0 && _dataProvider.length >= _renderers.length) 
                    {
                        loc1 = _renderers[(_renderers.length - 1)];
                        this.repositionRenderers(actualHeight - (loc1.y + loc1.height));
                    }
                    break;
                }
            }
            return;
        }

        public override function toString():String
        {
            return "[WG NationsButtonBar " + name + "]";
        }

        internal function repositionRenderers(arg1:Number):void
        {
            var loc1:*=null;
            var loc2:*=0;
            while (loc2 < _renderers.length) 
            {
                loc1 = _renderers[loc2];
                loc1.y = arg1;
                arg1 = arg1 + (loc1.height + _spacing);
                ++loc2;
            }
            return;
        }

        public static const TOP_ALIGN:String="top";

        public static const CENTER_ALIGN:String="center";

        public static const BOTTOM_ALIGN:String="bottom";

        internal var _tabVAlign:String;

        public var barBG:flash.display.Sprite;
    }
}
