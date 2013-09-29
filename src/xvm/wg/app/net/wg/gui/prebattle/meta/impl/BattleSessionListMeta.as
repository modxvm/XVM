package net.wg.gui.prebattle.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class BattleSessionListMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function BattleSessionListMeta()
        {
            super();
            return;
        }

        public function requestToJoinTeamS(arg1:Number, arg2:Number):void
        {
            App.utils.asserter.assertNotNull(this.requestToJoinTeam, "requestToJoinTeam" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestToJoinTeam(arg1, arg2);
            return;
        }

        public function getClientIDS():Number
        {
            App.utils.asserter.assertNotNull(this.getClientID, "getClientID" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getClientID();
        }

        public var requestToJoinTeam:Function=null;

        public var getClientID:Function=null;
    }
}
