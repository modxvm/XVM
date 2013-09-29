package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import scaleform.clik.core.*;
    
    public class BitmapFill extends scaleform.clik.core.UIComponent
    {
        public function BitmapFill()
        {
            super();
            if (!this.pos) 
            {
                this.createPos();
                this.pos.x = 0;
                this.pos.y = 0;
                this.pos.width = this.tempBg.width * this.scaleX;
                this.pos.height = this.tempBg.height * this.scaleY;
            }
            if (this.tempBg) 
            {
                this.tempBg.visible = false;
            }
            return;
        }

        public override function dispose():void
        {
            this.tempBg = null;
            this.myBitmapData = null;
            this.pos = null;
            super.dispose();
            return;
        }

        internal function createPos():void
        {
            if (!this.pos) 
            {
                this.pos = new flash.geom.Rectangle(0, 0, 0, 0);
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            this.graphics.clear();
            if (!this.myBitmapData) 
            {
                return;
            }
            this.graphics.beginFill(13762560);
            this.graphics.beginBitmapFill(this.myBitmapData);
            var loc1:*=this.pos.x;
            var loc2:*=this.pos.y;
            var loc3:*=this.pos.width;
            var loc4:*=this.pos.height;
            var loc5:*=this.repeat;
            switch (loc5) 
            {
                case "none":
                {
                    loc3 = this.myBitmapData.width;
                    loc4 = this.myBitmapData.height;
                    break;
                }
                case "horizontal":
                {
                    loc3 = this.pos.width;
                    loc4 = this.myBitmapData.height;
                    break;
                }
                case "vertical":
                {
                    loc3 = this.myBitmapData.width;
                    loc4 = this.pos.height;
                    break;
                }
                case "all":
                {
                    loc3 = this.pos.width;
                    loc4 = this.pos.height;
                    break;
                }
            }
            loc5 = this.startPos;
            switch (loc5) 
            {
                case "TL":
                {
                    loc1 = 0;
                    loc2 = 0;
                    break;
                }
                case "TR":
                {
                    loc1 = -loc3;
                    loc2 = 0;
                    break;
                }
                case "TC":
                {
                    loc1 = -Math.round(loc3 / 2);
                    loc2 = 0;
                    break;
                }
                case "BL":
                {
                    loc1 = 0;
                    loc2 = -loc4;
                    break;
                }
                case "BR":
                {
                    loc1 = -loc3;
                    loc2 = -loc4;
                    break;
                }
                case "BC":
                {
                    loc1 = -Math.round(loc3 / 2);
                    loc2 = -loc4;
                    break;
                }
                case "CL":
                {
                    loc1 = 0;
                    loc2 = -Math.round(loc4 / 2);
                    break;
                }
                case "CR":
                {
                    loc1 = -loc3;
                    loc2 = -Math.round(loc4 / 2);
                    break;
                }
                case "CC":
                {
                    loc1 = -Math.round(loc3 / 2);
                    loc2 = -Math.round(loc4 / 2);
                    break;
                }
            }
            this.graphics.lineTo(loc1, loc2);
            this.graphics.lineTo(loc1 + loc3, loc2);
            this.graphics.lineTo(loc1 + loc3, loc2 + loc4);
            this.graphics.lineTo(loc1, loc2 + loc4);
            this.graphics.lineTo(loc1, loc2);
            this.graphics.endFill();
            return;
        }

        public function get source():String
        {
            return this._src;
        }

        public function set source(arg1:String):void
        {
            var loc1:*=null;
            this._src = arg1;
            if (this._src != "") 
            {
                loc1 = flash.utils.getDefinitionByName(this._src) as Class;
                this.myBitmapData = new loc1() as flash.display.BitmapData;
                invalidate();
            }
            return;
        }

        public function set setBitmap(arg1:flash.display.BitmapData):void
        {
            this.myBitmapData = arg1;
            invalidate();
            return;
        }

        public function get setBitmap():flash.display.BitmapData
        {
            return this.myBitmapData;
        }

        public function set widthFill(arg1:Number):void
        {
            this.setSize(arg1, this.pos.height);
            return;
        }

        public function get widthFill():Number
        {
            return this.pos.width;
        }

        public function set heightFill(arg1:Number):void
        {
            this.setSize(this.pos.width, arg1);
            return;
        }

        public function get heightFill():Number
        {
            return this.pos.height;
        }

        public override function setSize(arg1:Number, arg2:Number):void
        {
            this.createPos();
            this.pos.width = arg1;
            this.pos.height = arg2;
            this.draw();
            return;
        }

        public var tempBg:flash.display.MovieClip;

        internal var myBitmapData:flash.display.BitmapData;

        internal var _src:String="";

        public var pos:flash.geom.Rectangle;

        public var repeat:String="none";

        public var startPos:String="TL";
    }
}
