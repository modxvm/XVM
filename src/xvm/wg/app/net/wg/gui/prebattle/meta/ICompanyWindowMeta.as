package net.wg.gui.prebattle.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICompanyWindowMeta extends IEventDispatcher
   {
      
      function requestToAssignS(param1:Number) : void;
      
      function requestToUnassignS(param1:Number) : void;
      
      function requestToChangeOpenedS(param1:Boolean) : void;
      
      function requestToChangeCommentS(param1:String) : void;
      
      function requestToChangeDivisionS(param1:uint) : void;
      
      function getCompanyNameS() : String;
      
      function canMoveToAssignedS() : Boolean;
      
      function canMoveToUnassignedS() : Boolean;
      
      function canMakeOpenedClosedS() : Boolean;
      
      function canChangeCommentS() : Boolean;
      
      function canChangeDivisionS() : Boolean;
      
      function as_setDivisionsList(param1:Array, param2:uint) : void;
      
      function as_setOpened(param1:Boolean) : void;
      
      function as_setComment(param1:String) : void;
      
      function as_setDivision(param1:uint) : void;
      
      function as_setTotalLimitLabels(param1:String, param2:String) : void;
      
      function as_setMaxCountLimitLabel(param1:String) : void;
      
      function as_setClassesLimits(param1:Array) : void;
      
      function as_setInvalidVehicles(param1:Array) : void;
      
      function as_setChangeSettingCoolDown(param1:uint) : void;
   }
}
