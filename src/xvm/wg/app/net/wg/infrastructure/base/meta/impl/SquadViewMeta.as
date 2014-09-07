package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.rally.views.room.BaseRallyRoomView;
    import net.wg.data.constants.Errors;
    
    public class SquadViewMeta extends BaseRallyRoomView
    {
        
        public function SquadViewMeta()
        {
            super();
        }
        
        public var leaveSquad:Function = null;
        
        public function leaveSquadS() : void
        {
            App.utils.asserter.assertNotNull(this.leaveSquad,"leaveSquad" + Errors.CANT_NULL);
            this.leaveSquad();
        }
    }
}
