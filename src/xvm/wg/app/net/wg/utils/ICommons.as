package net.wg.utils 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.*;
    
    public interface ICommons
    {
        function createMap(arg1:Array):org.idmedia.as3commons.util.Map;

        function createMappedArray(arg1:Array):Array;

        function keyToString(arg1:Number):net.wg.data.constants.KeyProps;

        function cloneObject(arg1:Object):*;

        function addBlankLines(arg1:String, arg2:flash.text.TextField, arg3:__AS3__.vec.Vector.<flash.text.TextField>):void;

        function isLeftButton(arg1:flash.events.MouseEvent):Boolean;

        function isRightButton(arg1:flash.events.MouseEvent):Boolean;

        function setSaturation(arg1:flash.display.Sprite, arg2:Number):void;

        function releaseReferences(arg1:Object, arg2:Boolean=true):void;

        function cutBitmapFromBitmapData(arg1:flash.display.BitmapData, arg2:flash.geom.Rectangle):flash.display.Bitmap;

        function formatPlayerName(arg1:flash.text.TextField, arg2:String, arg3:String=null, arg4:String=null, arg5:Boolean=false, arg6:net.wg.infrastructure.interfaces.IColorScheme=null, arg7:int=-4):String;
    }
}
