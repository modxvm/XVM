package net.wg.utils
{
   import org.idmedia.as3commons.util.Map;
   import net.wg.data.constants.KeyProps;
   import flash.text.TextField;
   import __AS3__.vec.Vector;
   import flash.display.Sprite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.IUserProps;
   import flash.events.MouseEvent;


   public interface ICommons
   {
          
      function createMap(param1:Array) : Map;

      function createMappedArray(param1:Array) : Array;

      function keyToString(param1:Number) : KeyProps;

      function cloneObject(param1:Object) : *;

      function addBlankLines(param1:String, param2:TextField, param3:Vector.<TextField>) : void;

      function setSaturation(param1:Sprite, param2:Number) : void;

      function releaseReferences(param1:Object, param2:Boolean=true) : void;

      function cutBitmapFromBitmapData(param1:BitmapData, param2:Rectangle) : Bitmap;

      function getUserProps(param1:String, param2:String=null, param3:String=null, param4:int=0) : IUserProps;

      function formatPlayerName(param1:TextField, param2:IUserProps) : Boolean;

      function getFullPlayerName(param1:IUserProps) : String;

      function isLeftButton(param1:MouseEvent) : Boolean;

      function isRightButton(param1:MouseEvent) : Boolean;
   }

}