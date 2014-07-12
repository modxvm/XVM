package net.wg.data
{
   import net.wg.infrastructure.interfaces.ITweenTypesDuration;
   import net.wg.data.constants.TweenTypes;
   import net.wg.data.constants.TweenConstraints;
   
   public class TweenDataByType extends Object implements ITweenTypesDuration
   {
      
      public function TweenDataByType(param1:Vector.<String>, param2:int) {
         super();
         if(CHANGES_BY_TYPE == null)
         {
            customizeConst();
         }
         this.types = Vector.<String>(param1);
         this.duration = param2;
      }
      
      public static var CHANGES_BY_TYPE:Object = null;
      
      public static const TYPE_ADD:String = "add";
      
      public static const TYPE_SET:String = "set";
      
      public static function getPropertyChanges(param1:String) : Object {
         return CHANGES_BY_TYPE[param1];
      }
      
      private static function customizeConst() : void {
         CHANGES_BY_TYPE = {};
         CHANGES_BY_TYPE[TweenTypes.FADE_IN] = 
            {
               "type":TYPE_SET,
               "propertyName":"alpha",
               "value":TweenConstraints.FADE_ALPHA_MAX
            };
         CHANGES_BY_TYPE[TweenTypes.FADE_OUT] = 
            {
               "type":TYPE_SET,
               "propertyName":"alpha",
               "value":TweenConstraints.FADE_ALPHA_MIN
            };
         CHANGES_BY_TYPE[TweenTypes.MOVE_UP] = 
            {
               "type":TYPE_ADD,
               "propertyName":"y",
               "value":TweenConstraints.TRANSLATION_LENGTH
            };
         CHANGES_BY_TYPE[TweenTypes.MOVE_DOWN] = 
            {
               "type":TYPE_ADD,
               "propertyName":"y",
               "value":TweenConstraints.TRANSLATION_LENGTH
            };
         CHANGES_BY_TYPE[TweenTypes.TURN_HALF] = 
            {
               "type":TYPE_ADD,
               "propertyName":"rotation",
               "value":180
            };
      }
      
      private var _types:Vector.<String> = null;
      
      private var _duration:int;
      
      public function get types() : Vector.<String> {
         return this._types;
      }
      
      public function set types(param1:Vector.<String>) : void {
         this._types = param1;
      }
      
      public function get duration() : int {
         return this._duration;
      }
      
      public function set duration(param1:int) : void {
         this._duration = param1;
      }
   }
}
