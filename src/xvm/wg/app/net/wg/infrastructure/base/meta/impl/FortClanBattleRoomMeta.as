package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.rally.views.room.BaseRallyRoomViewWithWaiting;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.FortClanBattleRoomVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
    import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
    
    public class FortClanBattleRoomMeta extends BaseRallyRoomViewWithWaiting
    {
        
        public function FortClanBattleRoomMeta()
        {
            super();
        }
        
        public var onTimerAlert:Function = null;
        
        public function onTimerAlertS() : void
        {
            App.utils.asserter.assertNotNull(this.onTimerAlert,"onTimerAlert" + Errors.CANT_NULL);
            this.onTimerAlert();
        }
        
        public function as_setBattleRoomData(param1:Object) : void
        {
            var _loc2_:FortClanBattleRoomVO = new FortClanBattleRoomVO(param1);
            this.setBattleRoomData(_loc2_);
        }
        
        protected function setBattleRoomData(param1:FortClanBattleRoomVO) : void
        {
            var _loc2_:String = "as_setBattleRoomData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_setTimerDelta(param1:Object) : void
        {
            var _loc2_:ClanBattleTimerVO = new ClanBattleTimerVO(param1);
            this.setTimerDelta(_loc2_);
        }
        
        protected function setTimerDelta(param1:ClanBattleTimerVO) : void
        {
            var _loc2_:String = "as_setTimerDelta" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_updateDirections(param1:Object) : void
        {
            var _loc2_:ConnectedDirectionsVO = new ConnectedDirectionsVO(param1);
            this.updateDirections(_loc2_);
        }
        
        protected function updateDirections(param1:ConnectedDirectionsVO) : void
        {
            var _loc2_:String = "as_updateDirections" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
