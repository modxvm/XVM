package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;
   
   public class BaseRallyMainWindowMeta extends AbstractWindowView
   {
      
      public function BaseRallyMainWindowMeta() {
         super();
      }
      
      public var onBackClick:Function = null;
      
      public var canGoBack:Function = null;
      
      public var onBrowseRallies:Function = null;
      
      public var onCreateRally:Function = null;
      
      public var onJoinRally:Function = null;
      
      public var onAutoMatch:Function = null;
      
      public var autoSearchApply:Function = null;
      
      public var autoSearchCancel:Function = null;
      
      public function onBackClickS() : void {
         App.utils.asserter.assertNotNull(this.onBackClick,"onBackClick" + Errors.CANT_NULL);
         this.onBackClick();
      }
      
      public function canGoBackS() : Boolean {
         App.utils.asserter.assertNotNull(this.canGoBack,"canGoBack" + Errors.CANT_NULL);
         return this.canGoBack();
      }
      
      public function onBrowseRalliesS() : void {
         App.utils.asserter.assertNotNull(this.onBrowseRallies,"onBrowseRallies" + Errors.CANT_NULL);
         this.onBrowseRallies();
      }
      
      public function onCreateRallyS() : void {
         App.utils.asserter.assertNotNull(this.onCreateRally,"onCreateRally" + Errors.CANT_NULL);
         this.onCreateRally();
      }
      
      public function onJoinRallyS(param1:Number, param2:int, param3:Number) : void {
         App.utils.asserter.assertNotNull(this.onJoinRally,"onJoinRally" + Errors.CANT_NULL);
         this.onJoinRally(param1,param2,param3);
      }
      
      public function onAutoMatchS(param1:String, param2:Array) : void {
         App.utils.asserter.assertNotNull(this.onAutoMatch,"onAutoMatch" + Errors.CANT_NULL);
         this.onAutoMatch(param1,param2);
      }
      
      public function autoSearchApplyS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.autoSearchApply,"autoSearchApply" + Errors.CANT_NULL);
         this.autoSearchApply(param1);
      }
      
      public function autoSearchCancelS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.autoSearchCancel,"autoSearchCancel" + Errors.CANT_NULL);
         this.autoSearchCancel(param1);
      }
   }
}
