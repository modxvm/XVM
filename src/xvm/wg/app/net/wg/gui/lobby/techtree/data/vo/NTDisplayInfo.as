package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import flash.geom.Point;
   import net.wg.utils.ILocale;
   
   public class NTDisplayInfo extends Object implements IValueObject
   {
      
      public function NTDisplayInfo(param1:int = -1, param2:int = -1, param3:Point = null, param4:Array = null) {
         super();
         this._row = param1;
         this._column = param2;
         this._position = param3;
         this._lines = param4;
      }
      
      private var _row:int;
      
      private var _column:int;
      
      private var _position:Point;
      
      private var _lines:Array;
      
      public function get row() : int {
         return this._row;
      }
      
      public function get column() : int {
         return this._column;
      }
      
      public function get position() : Point {
         return this._position;
      }
      
      public function get lines() : Array {
         return this._lines;
      }
      
      public function fromArray(param1:Array, param2:ILocale) : void {
         var _loc3_:Array = null;
         if(param1.length > 3)
         {
            this._row = int(param1[0]);
            this._column = int(param1[1]);
            _loc3_ = param1[2];
            this._position = new Point(_loc3_[0],_loc3_[1]);
            this._lines = param1[3];
         }
      }
      
      public function fromObject(param1:Object, param2:ILocale) : void {
         var _loc3_:Array = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.row != null)
         {
            this._row = int(param1.row);
         }
         if(param1.column != null)
         {
            this._column = int(param1.column);
         }
         if(param1.position != null)
         {
            _loc3_ = param1.position;
            this._position = new Point(_loc3_[0],_loc3_[1]);
         }
         if(param1.lines != null)
         {
            this._lines = param1.lines;
         }
      }
      
      public function clearUp() : void {
         this._row = -1;
         this._column = -1;
         this._position = null;
         if(this._lines != null)
         {
            this._lines.splice(0,this._lines.length);
         }
      }
      
      public function toString() : String {
         return "[NTDisplayInfo: row = " + this._row + ", column = " + this._column + ", position = " + this._position + ", lines = " + this._lines + " ]";
      }
   }
}
