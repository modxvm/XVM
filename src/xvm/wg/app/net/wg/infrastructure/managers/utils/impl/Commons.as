package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.Map;
   import org.idmedia.as3commons.util.HashMap;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.DisplayObjectContainer;
   import flash.utils.getQualifiedClassName;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.KeysMap;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import flash.text.TextField;
   import __AS3__.vec.Vector;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.NullPointerException;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import flash.events.MouseEvent;
   import scaleform.gfx.MouseEventEx;
   import net.wg.infrastructure.interfaces.IColorScheme;


   public class Commons extends Object implements ICommons
   {
          
      public function Commons() {
         super();
      }

      private static var s_found:Array;

      public function createMap(param1:Array) : Map {
         this.assertEvenArray(param1);
         var _loc2_:Map = new HashMap();
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ % 2 == 1 && _loc3_ > 0)
            {
               _loc2_.put(param1[_loc3_-1],param1[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }

      public function createMappedArray(param1:Array) : Array {
         var _loc4_:Object = null;
         this.assertEvenArray(param1);
         var _loc2_:Array = [];
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ % 2 == 1 && _loc3_ > 0)
            {
               _loc4_ = {};
               _loc4_[param1[_loc3_-1]] = param1[_loc3_];
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }

      public function releaseReferences(param1:Object, param2:Boolean=true) : void {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:DisplayObject = null;
         if(param1 == null)
         {
            param1 = App.stage;
         }
         if(s_found.indexOf(param1) == -1)
         {
            s_found.push(param1);
            for (_loc3_ in param1)
            {
               _loc4_ = param1[_loc3_];
               if(this.canToDestroying(_loc4_))
               {
                  this.releaseReferences(_loc4_,false);
                  if(_loc4_  is  IDisposable)
                  {
                     IDisposable(_loc4_).dispose();
                  }
                  delete param1[[_loc3_]];
               }
            }
            if(param1  is  DisplayObjectContainer)
            {
               while(DisplayObjectContainer(param1).numChildren > 0)
               {
                  _loc5_ = DisplayObjectContainer(param1).getChildAt(0);
                  if(this.canToDestroying(_loc5_))
                  {
                     this.releaseReferences(_loc5_,false);
                     if(_loc4_  is  IDisposable)
                     {
                        IDisposable(_loc4_).dispose();
                     }
                  }
                  DisplayObjectContainer(param1).removeChild(_loc5_);
               }
            }
         }
         if(param2)
         {
            if(s_found.length > 1)
            {
               DebugUtils.LOG_DEBUG("try to release: " + param1 + " " + getQualifiedClassName(param1) + " has been released. Collected: " + s_found.length + " objects.");
            }
            s_found.splice(0);
         }
      }

      public function keyToString(param1:Number) : KeyProps {
         var _loc2_:KeyProps = new KeyProps();
         if(KeysMap.mapping.hasOwnProperty(param1.toString()))
         {
            if(KeysMap.mapping[param1].hasOwnProperty("to_show"))
            {
               _loc2_.keyName = KeysMap.mapping[param1].to_show;
            }
            else
            {
               _loc2_.keyName = String.fromCharCode(param1).toUpperCase();
            }
            if(KeysMap.mapping[param1].hasOwnProperty("command"))
            {
               _loc2_.keyCommand = KeysMap.mapping[param1].command;
            }
            else
            {
               _loc2_.keyCommand = String.fromCharCode(param1).toUpperCase();
            }
         }
         else
         {
            _loc2_.keyName = String.fromCharCode(param1).toUpperCase();
            _loc2_.keyCommand = String.fromCharCode(param1).toUpperCase();
         }
         return _loc2_;
      }

      public function cutBitmapFromBitmapData(param1:BitmapData, param2:Rectangle) : Bitmap {
         var _loc3_:BitmapData = new BitmapData(param2.width,param2.height,true,13421772);
         _loc3_.copyPixels(param1,new Rectangle(param2.x,param2.y,param2.width,param2.height),new Point(0,0));
         var _loc4_:Bitmap = new Bitmap(_loc3_,"auto",true);
         return _loc4_;
      }

      public function cloneObject(param1:Object) : * {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         if(param1  is  Object)
         {
            _loc2_ = param1  is  Array?[]:{};
            for (_loc3_ in param1)
            {
               _loc2_[_loc3_] = param1[_loc3_]  is  Object && !(param1[_loc3_]  is  Number) && !(param1[_loc3_]  is  Boolean) && !(param1[_loc3_]  is  String)?this.cloneObject(param1[_loc3_]):param1[_loc3_];
            }
            return _loc2_;
         }
         return undefined;
      }

      public function addBlankLines(param1:String, param2:TextField, param3:Vector.<TextField>) : void {
         var _loc6_:TextField = null;
         var _loc7_:* = 0;
         var _loc4_:String = param2.htmlText;
         param2.htmlText = param1;
         var _loc5_:int = Math.round(param2.textHeight / param2.getLineMetrics(0).height);
         for each (_loc6_ in param3)
         {
            _loc7_ = 1;
            while(_loc7_ < _loc5_)
            {
               _loc6_.htmlText = _loc6_.htmlText + "\n";
               _loc7_++;
            }
         }
         param2.htmlText = _loc4_;
      }

      public function setSaturation(param1:Sprite, param2:Number) : void {
         var object:Sprite = param1;
         var amount:Number = param2;
         var interpolateArrays:Function = function(param1:Array, param2:Array, param3:Number):Object
         {
            var _loc4_:Array = param1.length >= param2.length?param1.slice():param2.slice();
            var _loc5_:uint = _loc4_.length;
            while(_loc5_--)
            {
               _loc4_[_loc5_] = param1[_loc5_] + (param2[_loc5_] - param1[_loc5_]) * param3;
            }
            return _loc4_;
         };
         amount = amount / 100;
         var colorFilter:ColorMatrixFilter = new ColorMatrixFilter();
         var redIdentity:Array = [1,0,0,0,0];
         var greenIdentity:Array = [0,1,0,0,0];
         var blueIdentity:Array = [0,0,1,0,0];
         var alphaIdentity:Array = [0,0,0,1,0];
         var grayluma:Array = [0.3,0.59,0.11,0,0];
         var colmatrix:Array = new Array();
         colmatrix = colmatrix.concat(interpolateArrays(grayluma,redIdentity,amount));
         colmatrix = colmatrix.concat(interpolateArrays(grayluma,greenIdentity,amount));
         colmatrix = colmatrix.concat(interpolateArrays(grayluma,blueIdentity,amount));
         colmatrix = colmatrix.concat(alphaIdentity);
         colorFilter.matrix = colmatrix;
         object.filters = [colorFilter];
      }

      private function canToDestroying(param1:Object) : Boolean {
         if(param1)
         {
            return param1  is  IDAAPIModule && !IDAAPIModule(param1).disposed || !(param1  is  IDAAPIModule);
         }
         return false;
      }

      private function assertEvenArray(param1:Array) : void {
         var _loc2_:* = "pureHash must be have even quantity of elements";
         var _loc3_:IAssertable = App.utils.asserter;
         _loc3_.assertNotNull(param1,"pureHash" + Errors.CANT_NULL,NullPointerException);
         _loc3_.assert(param1.length % 2 == 0,_loc2_,ArgumentException);
         _loc3_.assert(param1.length > 0,"pureHash can`t be empty",ArgumentException);
      }

      public function isLeftButton(param1:MouseEvent) : Boolean {
         if(param1  is  MouseEventEx)
         {
            return MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON;
         }
         return true;
      }

      public function isRightButton(param1:MouseEvent) : Boolean {
         if(param1  is  MouseEventEx)
         {
            return MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON;
         }
         return false;
      }

      public function formatPlayerName(param1:TextField, param2:String, param3:String=null, param4:String=null, param5:Boolean=false, param6:IColorScheme=null, param7:int=-4) : String {
         var _loc10_:* = 0;
         var _loc8_:* = "<IMG SRC=\"img://gui/maps/icons/library/igr_32x13.png\" width=\"32\" height=\"13\" vspace=\"" + param7 + "\"/>";
         var _loc9_:String = param2 + (param3?"[" + param3 + "]":"") + (param4?" " + param4:"") + (param5?" " + _loc8_:"");
         param1.htmlText = _loc9_;
         if(param1.width < param1.textWidth)
         {
            _loc9_ = param2 + (param3?"..":"") + (param4?" " + param4:"") + (param5?" " + _loc8_:"");
            param1.htmlText = _loc9_;
            _loc10_ = param2.length-1;
            while(param1.width < param1.textWidth && _loc10_ > 0)
            {
               _loc9_ = param2.substr(0,_loc10_) + ".." + (param4?" " + param4:"") + (param5?" " + _loc8_:"");
               param1.htmlText = _loc9_;
               _loc10_--;
            }
         }
         if(param6)
         {
            param1.textColor = param6.rgb;
         }
         return param1.htmlText;
      }
   }

}