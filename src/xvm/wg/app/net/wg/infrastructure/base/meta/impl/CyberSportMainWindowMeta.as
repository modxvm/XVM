package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class CyberSportMainWindowMeta extends AbstractWindowView
   {
          
      public function CyberSportMainWindowMeta() {
         super();
      }

      public var isBackBtnVisible:Function = null;

      public var onAutoMatch:Function = null;

      public var autoSearchApply:Function = null;

      public var autoSearchCancel:Function = null;

      public var onBrowseUnits:Function = null;

      public var onCreateUnit:Function = null;

      public var onJoinUnit:Function = null;

      public var onBackClick:Function = null;

      public function isBackBtnVisibleS() : Boolean {
         App.utils.asserter.assertNotNull(this.isBackBtnVisible,"isBackBtnVisible" + Errors.CANT_NULL);
         return this.isBackBtnVisible();
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

      public function onBrowseUnitsS() : void {
         App.utils.asserter.assertNotNull(this.onBrowseUnits,"onBrowseUnits" + Errors.CANT_NULL);
         this.onBrowseUnits();
      }

      public function onCreateUnitS() : void {
         App.utils.asserter.assertNotNull(this.onCreateUnit,"onCreateUnit" + Errors.CANT_NULL);
         this.onCreateUnit();
      }

      public function onJoinUnitS(param1:Number, param2:Number, param3:Number) : void {
         App.utils.asserter.assertNotNull(this.onJoinUnit,"onJoinUnit" + Errors.CANT_NULL);
         this.onJoinUnit(param1,param2,param3);
      }

      public function onBackClickS() : void {
         App.utils.asserter.assertNotNull(this.onBackClick,"onBackClick" + Errors.CANT_NULL);
         this.onBackClick();
      }
   }

}