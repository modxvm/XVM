package net.wg.gui.lobby.profile.components 
{
    import flash.display.*;
    import net.wg.gui.components.advanced.*;
    
    public class LineButtonBar extends net.wg.gui.components.advanced.ButtonBarEx
    {
        public function LineButtonBar()
        {
            this.line = new flash.display.Sprite();
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this.mcBG) 
                this.mcBG.visible = false;
            addChild(this.line);
            return;
        }

        public override function set selectedIndex(arg1:int):void
        {
            if (arg1 == _selectedIndex) 
                return;
            super.selectedIndex = arg1;
            var loc1:*=_renderers[_selectedIndex];
            if (loc1) 
                loc1.parent.setChildIndex(loc1, (loc1.parent.numChildren - 1));
            invalidate(LINE_INVALID);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(LINE_INVALID)) 
                this.drawLine();
            return;
        }

        protected function drawLine():void
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc1:*=this.line.graphics;
            loc1.clear();
            if (!(selectedIndex == -1) && _renderers && _renderers.length > 0) 
            {
                loc1.lineStyle(1, this.lineColor);
                loc3 = _renderers[selectedIndex] as flash.display.DisplayObject;
                loc4 = loc3.x;
                loc1.moveTo(0, 0);
                if (loc4 > 0) 
                    loc1.lineTo(loc4, 0);
                loc1.moveTo(loc4 + loc3.width, 0);
                loc1.lineTo(width, 0);
            }
            this.line.y = this.height - this.line.height - 2;
            var loc2:*=this.line.parent;
            if (loc2) 
                loc2.setChildIndex(this.line, (loc2.numChildren - 1));
            return;
        }

        protected override function updateRenderers():void
        {
            super.updateRenderers();
            this.drawLine();
            return;
        }

        protected static const LINE_INVALID:String="lineInv";

        protected var line:flash.display.Sprite;

        public var mcBG:flash.display.Sprite;

        protected var lineColor:int=6710617;
    }
}
