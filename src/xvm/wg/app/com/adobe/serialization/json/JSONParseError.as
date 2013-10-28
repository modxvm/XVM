package com.adobe.serialization.json
{


   public class JSONParseError extends Error
   {
          
      public function JSONParseError(param1:String=undefined, param2:int=undefined, param3:String=undefined) {
         super(param1);
         name = "JSONParseError";
         this._location = param2;
         this._text = param3;
      }

      private var _location:int;

      private var _text:String;

      public function get location() : int {
         return this._location;
      }

      public function get text() : String {
         return this._text;
      }
   }

}