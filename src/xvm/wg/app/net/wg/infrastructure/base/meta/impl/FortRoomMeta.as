package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.rally.views.room.BaseRallyRoomViewWithWaiting;
    import net.wg.data.constants.Errors;
    
    public class FortRoomMeta extends BaseRallyRoomViewWithWaiting
    {
        
        public function FortRoomMeta()
        {
            super();
        }
        
        public var showChangeDivisionWindow:Function = null;
        
        public function showChangeDivisionWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.showChangeDivisionWindow,"showChangeDivisionWindow" + Errors.CANT_NULL);
            this.showChangeDivisionWindow();
        }
    }
}
