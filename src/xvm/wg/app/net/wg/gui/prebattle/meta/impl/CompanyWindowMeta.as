package net.wg.gui.prebattle.meta.impl
{
   import net.wg.gui.prebattle.meta.abstract.PrebattleWindowAbstract;
   import net.wg.data.constants.Errors;
   
   public class CompanyWindowMeta extends PrebattleWindowAbstract
   {
      
      public function CompanyWindowMeta() {
         super();
      }
      
      public var requestToAssign:Function = null;
      
      public var requestToUnassign:Function = null;
      
      public var requestToChangeOpened:Function = null;
      
      public var requestToChangeComment:Function = null;
      
      public var requestToChangeDivision:Function = null;
      
      public var getCompanyName:Function = null;
      
      public var canMoveToAssigned:Function = null;
      
      public var canMoveToUnassigned:Function = null;
      
      public var canMakeOpenedClosed:Function = null;
      
      public var canChangeComment:Function = null;
      
      public var canChangeDivision:Function = null;
      
      public function requestToAssignS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.requestToAssign,"requestToAssign" + Errors.CANT_NULL);
         this.requestToAssign(param1);
      }
      
      public function requestToUnassignS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.requestToUnassign,"requestToUnassign" + Errors.CANT_NULL);
         this.requestToUnassign(param1);
      }
      
      public function requestToChangeOpenedS(param1:Boolean) : void {
         App.utils.asserter.assertNotNull(this.requestToChangeOpened,"requestToChangeOpened" + Errors.CANT_NULL);
         this.requestToChangeOpened(param1);
      }
      
      public function requestToChangeCommentS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.requestToChangeComment,"requestToChangeComment" + Errors.CANT_NULL);
         this.requestToChangeComment(param1);
      }
      
      public function requestToChangeDivisionS(param1:uint) : void {
         App.utils.asserter.assertNotNull(this.requestToChangeDivision,"requestToChangeDivision" + Errors.CANT_NULL);
         this.requestToChangeDivision(param1);
      }
      
      public function getCompanyNameS() : String {
         App.utils.asserter.assertNotNull(this.getCompanyName,"getCompanyName" + Errors.CANT_NULL);
         return this.getCompanyName();
      }
      
      public function canMoveToAssignedS() : Boolean {
         App.utils.asserter.assertNotNull(this.canMoveToAssigned,"canMoveToAssigned" + Errors.CANT_NULL);
         return this.canMoveToAssigned();
      }
      
      public function canMoveToUnassignedS() : Boolean {
         App.utils.asserter.assertNotNull(this.canMoveToUnassigned,"canMoveToUnassigned" + Errors.CANT_NULL);
         return this.canMoveToUnassigned();
      }
      
      public function canMakeOpenedClosedS() : Boolean {
         App.utils.asserter.assertNotNull(this.canMakeOpenedClosed,"canMakeOpenedClosed" + Errors.CANT_NULL);
         return this.canMakeOpenedClosed();
      }
      
      public function canChangeCommentS() : Boolean {
         App.utils.asserter.assertNotNull(this.canChangeComment,"canChangeComment" + Errors.CANT_NULL);
         return this.canChangeComment();
      }
      
      public function canChangeDivisionS() : Boolean {
         App.utils.asserter.assertNotNull(this.canChangeDivision,"canChangeDivision" + Errors.CANT_NULL);
         return this.canChangeDivision();
      }
   }
}
