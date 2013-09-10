package net.wg.data.VO 
{
    import fl.motion.*;
    import flash.filters.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class ColorScheme extends net.wg.data.daapi.base.DAAPIDataClass implements net.wg.infrastructure.interfaces.IColorScheme
    {
        public function ColorScheme(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get aliasColor():String
        {
            return this._aliasColor;
        }

        public function set aliasColor(arg1:String):void
        {
            this._aliasColor = arg1;
            return;
        }

        public function get rgb():Number
        {
            return this._rgb;
        }

        public function set rgb(arg1:Number):void
        {
            this._rgb = arg1;
            return;
        }

        public function get schemeName():String
        {
            return this._schemeName;
        }

        public function set schemeName(arg1:String):void
        {
            this._schemeName = arg1;
            return;
        }

        public function get transform():Object
        {
            return this._transform;
        }

        public function set transform(arg1:Object):void
        {
            this._transform = arg1;
            var loc1:*=arg1["mult"];
            var loc2:*=arg1["offset"];
            this.assertNotNull(loc1, "mult");
            this.assertNotNull(loc2, "offset");
            this._colorTransform = new flash.geom.ColorTransform(loc1[0], loc1[1], loc1[2], loc1[3], loc2[0], loc2[1], loc2[2], loc2[3]);
            return;
        }

        public function get colorTransform():flash.geom.ColorTransform
        {
            return this._colorTransform;
        }

        public function get adjust():Object
        {
            return this._adjust;
        }

        public function set adjust(arg1:Object):void
        {
            this._adjust = arg1;
            var loc1:*=arg1["offset"];
            this.assertNotNull(loc1, "offset");
            var loc2:*=new fl.motion.AdjustColor();
            loc2.brightness = loc1[0];
            loc2.contrast = loc1[1];
            loc2.saturation = loc1[2];
            loc2.hue = loc1[3];
            this._adjustOffset = new flash.filters.ColorMatrixFilter(loc2.CalculateFinalFlatArray());
            return;
        }

        public function get adjustOffset():flash.filters.BitmapFilter
        {
            return this._adjustOffset;
        }

        internal function assertNotNull(arg1:Object, arg2:String):void
        {
            App.utils.asserter.assertNotNull(arg1, arg2 + net.wg.data.constants.Errors.CANT_NULL, net.wg.infrastructure.exceptions.NullPointerException);
            return;
        }

        internal var _aliasColor:String="";

        internal var _rgb:Number=0;

        internal var _schemeName:String="";

        internal var _transform:Object=null;

        internal var _colorTransform:flash.geom.ColorTransform=null;

        internal var _adjust:Object=null;

        internal var _adjustOffset:flash.filters.BitmapFilter=null;
    }
}
