package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.rally.views.list.BaseRallyListView;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleListVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortClanBattleListMeta extends BaseRallyListView
    {
        
        public function FortClanBattleListMeta()
        {
            super();
        }
        
        public function as_setClanBattleData(param1:Object) : void
        {
            var _loc2_:ClanBattleListVO = new ClanBattleListVO(param1);
            this.setClanBattleData(_loc2_);
        }
        
        protected function setClanBattleData(param1:ClanBattleListVO) : void
        {
            var _loc2_:String = "as_setClanBattleData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
