package net.wg.gui.lobby.profile.components 
{
    import flash.display.*;
    import flash.geom.*;
    
    public class GradientLineButtonBar extends net.wg.gui.lobby.profile.components.LineButtonBar
    {
        public function GradientLineButtonBar()
        {
            super();
            return;
        }

        protected override function drawLine():void
        {
            var loc1:*=1;
            var loc2:*=_renderers[selectedIndex] as flash.display.DisplayObject;
            var loc3:*=line.graphics;
            var loc4:*=loc2.x;
            loc3.clear();
            if (loc4 > 0) 
            {
                loc3.beginFill(color, 1);
                loc3.drawRect(0, 0, loc4, loc1);
                loc3.endFill();
            }
            this.drawGradientLine(loc3, loc4 + loc2.width, 0, width, loc1, [1, 0.1], [color, color]);
            line.y = this.actualHeight - line.height;
            var loc5:*;
            if (loc5 = line.parent) 
            {
                loc5.setChildIndex(line, (loc5.numChildren - 1));
            }
            return;
        }

        internal function drawGradientLine(arg1:flash.display.Graphics, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Array, arg7:Array):void
        {
            var loc1:*=flash.display.GradientType.LINEAR;
            var loc2:*=[125, 255];
            var loc3:*=new flash.geom.Matrix();
            var loc4:*=0;
            loc3.createGradientBox(arg4, arg5, loc4, 0, 0);
            arg1.beginGradientFill(loc1, arg7, arg6, loc2, loc3, flash.display.SpreadMethod.PAD);
            arg1.drawRect(arg2, arg3, arg4, arg5);
            arg1.endFill();
            return;
        }

        
        {
            color = 3749680;
        }

        internal static var color:uint=3749680;
    }
}
