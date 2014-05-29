package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IFightButtonMeta extends IEventDispatcher
   {
          
      function fightClickS(param1:Number, param2:String) : void;

      function demoClickS() : void;

      function as_disableFightButton(param1:Boolean, param2:String) : void;

      function as_setFightButton(param1:String, param2:String, param3:Array, param4:Boolean) : void;

      function as_setDemonstratorButton(param1:Boolean) : void;

      function as_setCoolDownForReady(param1:uint) : void;
   }

}