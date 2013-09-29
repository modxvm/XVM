package net.wg.gui.prebattle.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.gui.prebattle.meta.abstract.*;
    
    public class BattleSessionWindowMeta extends net.wg.gui.prebattle.meta.abstract.PrebattleWindowAbstract
    {
        public function BattleSessionWindowMeta()
        {
            super();
            return;
        }

        public function requestToAssignMemberS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.requestToAssignMember, "requestToAssignMember" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestToAssignMember(arg1);
            return;
        }

        public function requestToUnassignMemberS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.requestToUnassignMember, "requestToUnassignMember" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestToUnassignMember(arg1);
            return;
        }

        public function canMoveToAssignedS():Boolean
        {
            App.utils.asserter.assertNotNull(this.canMoveToAssigned, "canMoveToAssigned" + net.wg.data.constants.Errors.CANT_NULL);
            return this.canMoveToAssigned();
        }

        public function canMoveToUnassignedS():Boolean
        {
            App.utils.asserter.assertNotNull(this.canMoveToUnassigned, "canMoveToUnassigned" + net.wg.data.constants.Errors.CANT_NULL);
            return this.canMoveToUnassigned();
        }

        public var requestToAssignMember:Function=null;

        public var requestToUnassignMember:Function=null;

        public var canMoveToAssigned:Function=null;

        public var canMoveToUnassigned:Function=null;
    }
}
