package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ICyberSportMainWindowMeta extends IEventDispatcher
   {
          
      function isBackBtnVisibleS() : Boolean;

      function onAutoMatchS(param1:String, param2:Array) : void;

      function autoSearchApplyS(param1:String) : void;

      function autoSearchCancelS(param1:String) : void;

      function onBrowseUnitsS() : void;

      function onCreateUnitS() : void;

      function onJoinUnitS(param1:Number, param2:Number) : void;

      function onBackClickS() : void;

      function as_autoSearchEnableBtn(param1:Boolean) : void;

      function as_loadView(param1:String, param2:String) : void;

      function as_changeAutoSearchState(param1:Object) : void;

      function as_hideAutoSearch() : void;

      function as_enableWndCloseBtn(param1:Boolean) : void;
   }

}