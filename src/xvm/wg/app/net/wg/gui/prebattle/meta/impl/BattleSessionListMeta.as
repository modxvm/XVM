package net.wg.gui.prebattle.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class BattleSessionListMeta extends AbstractWindowView
    {
        
        public function BattleSessionListMeta()
        {
            super();
        }
        
        public var requestToJoinTeam:Function = null;
        
        public var getClientID:Function = null;
        
        public function requestToJoinTeamS(param1:Number, param2:Number) : void
        {
            App.utils.asserter.assertNotNull(this.requestToJoinTeam,"requestToJoinTeam" + Errors.CANT_NULL);
            this.requestToJoinTeam(param1,param2);
        }
        
        public function getClientIDS() : Number
        {
            App.utils.asserter.assertNotNull(this.getClientID,"getClientID" + Errors.CANT_NULL);
            return this.getClientID();
        }
    }
}
