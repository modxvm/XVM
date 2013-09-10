package net.wg.gui.prebattle.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.gui.prebattle.meta.abstract.*;
    
    public class CompanyWindowMeta extends net.wg.gui.prebattle.meta.abstract.PrebattleWindowAbstract
    {
        public function CompanyWindowMeta()
        {
            super();
            return;
        }

        public function requestToAssignS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.requestToAssign, "requestToAssign" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestToAssign(arg1);
            return;
        }

        public function requestToUnassignS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.requestToUnassign, "requestToUnassign" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestToUnassign(arg1);
            return;
        }

        public function requestToChangeOpenedS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.requestToChangeOpened, "requestToChangeOpened" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestToChangeOpened(arg1);
            return;
        }

        public function requestToChangeCommentS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.requestToChangeComment, "requestToChangeComment" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestToChangeComment(arg1);
            return;
        }

        public function requestToChangeDivisionS(arg1:uint):void
        {
            App.utils.asserter.assertNotNull(this.requestToChangeDivision, "requestToChangeDivision" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestToChangeDivision(arg1);
            return;
        }

        public function getCompanyNameS():String
        {
            App.utils.asserter.assertNotNull(this.getCompanyName, "getCompanyName" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getCompanyName();
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

        public function canMakeOpenedClosedS():Boolean
        {
            App.utils.asserter.assertNotNull(this.canMakeOpenedClosed, "canMakeOpenedClosed" + net.wg.data.constants.Errors.CANT_NULL);
            return this.canMakeOpenedClosed();
        }

        public function canChangeCommentS():Boolean
        {
            App.utils.asserter.assertNotNull(this.canChangeComment, "canChangeComment" + net.wg.data.constants.Errors.CANT_NULL);
            return this.canChangeComment();
        }

        public function canChangeDivisionS():Boolean
        {
            App.utils.asserter.assertNotNull(this.canChangeDivision, "canChangeDivision" + net.wg.data.constants.Errors.CANT_NULL);
            return this.canChangeDivision();
        }

        public var requestToAssign:Function=null;

        public var requestToUnassign:Function=null;

        public var requestToChangeOpened:Function=null;

        public var requestToChangeComment:Function=null;

        public var requestToChangeDivision:Function=null;

        public var getCompanyName:Function=null;

        public var canMoveToAssigned:Function=null;

        public var canMoveToUnassigned:Function=null;

        public var canMakeOpenedClosed:Function=null;

        public var canChangeComment:Function=null;

        public var canChangeDivision:Function=null;
    }
}
