package net.wg.gui.prebattle.meta.impl
{
   import net.wg.gui.prebattle.meta.abstract.PrebattleWindowAbstract;
   import net.wg.data.constants.Errors;


   public class BattleSessionWindowMeta extends PrebattleWindowAbstract
   {
          
      public function BattleSessionWindowMeta() {
         super();
      }

      public var requestToAssignMember:Function = null;

      public var requestToUnassignMember:Function = null;

      public var canMoveToAssigned:Function = null;

      public var canMoveToUnassigned:Function = null;

      public function requestToAssignMemberS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.requestToAssignMember,"requestToAssignMember" + Errors.CANT_NULL);
         this.requestToAssignMember(param1);
      }

      public function requestToUnassignMemberS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.requestToUnassignMember,"requestToUnassignMember" + Errors.CANT_NULL);
         this.requestToUnassignMember(param1);
      }

      public function canMoveToAssignedS() : Boolean {
         App.utils.asserter.assertNotNull(this.canMoveToAssigned,"canMoveToAssigned" + Errors.CANT_NULL);
         return this.canMoveToAssigned();
      }

      public function canMoveToUnassignedS() : Boolean {
         App.utils.asserter.assertNotNull(this.canMoveToUnassigned,"canMoveToUnassigned" + Errors.CANT_NULL);
         return this.canMoveToUnassigned();
      }
   }

}