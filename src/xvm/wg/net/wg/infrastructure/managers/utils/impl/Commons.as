package net.wg.infrastructure.managers.utils.impl 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import org.idmedia.as3commons.util.*;
    import scaleform.gfx.*;
    
    public class Commons extends Object implements net.wg.utils.ICommons
    {
        public function Commons()
        {
            super();
            return;
        }

        public function createMap(arg1:Array):org.idmedia.as3commons.util.Map
        {
            this.assertEvenArray(arg1);
            var loc1:*=new org.idmedia.as3commons.util.HashMap();
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                if (loc2 % 2 == 1 && loc2 > 0) 
                    loc1.put(arg1[(loc2 - 1)], arg1[loc2]);
                ++loc2;
            }
            return loc1;
        }

        public function createMappedArray(arg1:Array):Array
        {
            var loc3:*=null;
            this.assertEvenArray(arg1);
            var loc1:*=[];
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                if (loc2 % 2 == 1 && loc2 > 0) 
                {
                    (loc3 = {})[arg1[(loc2 - 1)]] = arg1[loc2];
                    loc1.push(loc3);
                }
                ++loc2;
            }
            return loc1;
        }

        public function releaseReferences(arg1:Object, arg2:Boolean=true):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1 == null) 
                arg1 = App.stage;
            if (s_found.indexOf(arg1) == -1) 
            {
                s_found.push(arg1);
                var loc4:*=0;
                var loc5:*=arg1;
                for (loc1 in loc5) 
                {
                    loc2 = arg1[loc1];
                    if (!this.canToDestroying(loc2)) 
                        continue;
                    this.releaseReferences(loc2, false);
                    if (loc2 is net.wg.infrastructure.interfaces.entity.IDisposable) 
                        net.wg.infrastructure.interfaces.entity.IDisposable(loc2).dispose();
                    delete arg1[loc1];
                }
                if (arg1 is flash.display.DisplayObjectContainer) 
                    while (flash.display.DisplayObjectContainer(arg1).numChildren > 0) 
                    {
                        loc3 = flash.display.DisplayObjectContainer(arg1).getChildAt(0);
                        if (this.canToDestroying(loc3)) 
                        {
                            this.releaseReferences(loc3, false);
                            if (loc2 is net.wg.infrastructure.interfaces.entity.IDisposable) 
                                net.wg.infrastructure.interfaces.entity.IDisposable(loc2).dispose();
                        }
                        flash.display.DisplayObjectContainer(arg1).removeChild(loc3);
                    }
            }
            if (arg2) 
            {
                if (s_found.length > 1) 
                    DebugUtils.LOG_DEBUG("try to release: " + arg1 + " " + flash.utils.getQualifiedClassName(arg1) + " has been released. Collected: " + s_found.length + " objects.");
                s_found.splice(0);
            }
            return;
        }

        public function keyToString(arg1:Number):net.wg.data.constants.KeyProps
        {
            var loc1:*=new net.wg.data.constants.KeyProps();
            if (net.wg.data.constants.KeysMap.mapping.hasOwnProperty(arg1.toString())) 
            {
                if (net.wg.data.constants.KeysMap.mapping[arg1].hasOwnProperty("to_show")) 
                    loc1.keyName = net.wg.data.constants.KeysMap.mapping[arg1].to_show;
                else 
                    loc1.keyName = String.fromCharCode(arg1).toUpperCase();
                if (net.wg.data.constants.KeysMap.mapping[arg1].hasOwnProperty("command")) 
                    loc1.keyCommand = net.wg.data.constants.KeysMap.mapping[arg1].command;
                else 
                    loc1.keyCommand = String.fromCharCode(arg1).toUpperCase();
            }
            else 
            {
                loc1.keyName = String.fromCharCode(arg1).toUpperCase();
                loc1.keyCommand = String.fromCharCode(arg1).toUpperCase();
            }
            return loc1;
        }

        public function cutBitmapFromBitmapData(arg1:flash.display.BitmapData, arg2:flash.geom.Rectangle):flash.display.Bitmap
        {
            var loc1:*=new flash.display.BitmapData(arg2.width, arg2.height, true, 13421772);
            loc1.copyPixels(arg1, new flash.geom.Rectangle(arg2.x, arg2.y, arg2.width, arg2.height), new flash.geom.Point(0, 0));
            var loc2:*;
            return loc2 = new flash.display.Bitmap(loc1, "auto", true);
        }

        public function cloneObject(arg1:Object):*
        {
            var loc1:*=undefined;
            var loc2:*=null;
            if (arg1 is Object) 
            {
                loc1 = arg1 is Array ? [] : {};
                var loc3:*=0;
                var loc4:*=arg1;
                for (loc2 in loc4) 
                    loc1[loc2] = arg1[loc2] is Object && !(arg1[loc2] is Number) && !(arg1[loc2] is Boolean) && !(arg1[loc2] is String) ? this.cloneObject(arg1[loc2]) : arg1[loc2];
                return loc1;
            }
            return undefined;
        }

        public function addBlankLines(arg1:String, arg2:flash.text.TextField, arg3:__AS3__.vec.Vector.<flash.text.TextField>):void
        {
            var loc3:*=null;
            var loc1:*=arg2.htmlText;
            arg2.htmlText = arg1;
            var loc2:*;
            if ((loc2 = arg2.numLines) > 2) 
            {
                var loc4:*=0;
                var loc5:*=arg3;
                for each (loc3 in loc5) 
                    loc3.htmlText = loc3.htmlText + "\n";
            }
            arg2.htmlText = loc1;
            return;
        }

        public function setSaturation(arg1:flash.display.Sprite, arg2:Number):void
        {
            var object:flash.display.Sprite;
            var amount:Number;
            var colorFilter:flash.filters.ColorMatrixFilter;
            var redIdentity:Array;
            var greenIdentity:Array;
            var blueIdentity:Array;
            var alphaIdentity:Array;
            var grayluma:Array;
            var colmatrix:Array;
            var interpolateArrays:Function;

            var loc1:*;
            object = arg1;
            amount = arg2;
            interpolateArrays = function (arg1:Array, arg2:Array, arg3:Number):Object
            {
                var loc1:*;
                var loc2:*=(loc1 = arg1.length >= arg2.length ? arg1.slice() : arg2.slice()).length;
                while (loc2--) 
                    loc1[loc2] = arg1[loc2] + (arg2[loc2] - arg1[loc2]) * arg3;
                return loc1;
            }
            amount = amount / 100;
            colorFilter = new flash.filters.ColorMatrixFilter();
            redIdentity = [1, 0, 0, 0, 0];
            greenIdentity = [0, 1, 0, 0, 0];
            blueIdentity = [0, 0, 1, 0, 0];
            alphaIdentity = [0, 0, 0, 1, 0];
            grayluma = [0.3, 0.59, 0.11, 0, 0];
            colmatrix = new Array();
            colmatrix = colmatrix.concat(interpolateArrays(grayluma, redIdentity, amount));
            colmatrix = colmatrix.concat(interpolateArrays(grayluma, greenIdentity, amount));
            colmatrix = colmatrix.concat(interpolateArrays(grayluma, blueIdentity, amount));
            colmatrix = colmatrix.concat(alphaIdentity);
            colorFilter.matrix = colmatrix;
            object.filters = [colorFilter];
            return;
        }

        internal function canToDestroying(arg1:Object):Boolean
        {
            if (arg1) 
                return arg1 is net.wg.infrastructure.interfaces.IDAAPIModule && !net.wg.infrastructure.interfaces.IDAAPIModule(arg1).disposed || !(arg1 is net.wg.infrastructure.interfaces.IDAAPIModule);
            return false;
        }

        internal function assertEvenArray(arg1:Array):void
        {
            var loc1:*="pureHash must be have even quantity of elements";
            var loc2:*=App.utils.asserter;
            loc2.assertNotNull(arg1, "pureHash" + net.wg.data.constants.Errors.CANT_NULL, net.wg.infrastructure.exceptions.NullPointerException);
            loc2.assert(arg1.length % 2 == 0, loc1, net.wg.infrastructure.exceptions.ArgumentException);
            loc2.assert(arg1.length > 0, "pureHash can`t be empty", net.wg.infrastructure.exceptions.ArgumentException);
            return;
        }

        public function isLeftButton(arg1:flash.events.MouseEvent):Boolean
        {
            if (arg1 is scaleform.gfx.MouseEventEx) 
                return scaleform.gfx.MouseEventEx(arg1).buttonIdx == scaleform.gfx.MouseEventEx.LEFT_BUTTON;
            return true;
        }

        public function isRightButton(arg1:flash.events.MouseEvent):Boolean
        {
            if (arg1 is scaleform.gfx.MouseEventEx) 
                return scaleform.gfx.MouseEventEx(arg1).buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON;
            return false;
        }

        public function formatPlayerName(arg1:flash.text.TextField, arg2:String, arg3:String=null, arg4:String=null, arg5:Boolean=false, arg6:net.wg.infrastructure.interfaces.IColorScheme=null, arg7:int=-4):String
        {
            var loc3:*=0;
            var loc1:*="<IMG SRC=\"img://gui/maps/icons/library/igr_32x13.png\" width=\"32\" height=\"13\" vspace=\"" + arg7 + "\"/>";
            var loc2:*=arg2 + (arg3 ? "[" + arg3 + "]" : "") + (arg4 ? " " + arg4 : "") + (arg5 ? " " + loc1 : "");
            arg1.htmlText = loc2;
            if (arg1.width < arg1.textWidth) 
            {
                loc2 = arg2 + (arg3 ? ".." : "") + (arg4 ? " " + arg4 : "") + (arg5 ? " " + loc1 : "");
                arg1.htmlText = loc2;
                loc3 = (arg2.length - 1);
                while (arg1.width < arg1.textWidth && loc3 > 0) 
                {
                    loc2 = arg2.substr(0, loc3) + ".." + (arg4 ? " " + arg4 : "") + (arg5 ? " " + loc1 : "");
                    arg1.htmlText = loc2;
                    --loc3;
                }
            }
            if (arg6) 
                arg1.textColor = arg6.rgb;
            return arg1.htmlText;
        }

        
        {
            s_found = [];
        }

        internal static var s_found:Array;
    }
}
