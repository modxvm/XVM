package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.rally.views.room.BaseRallyRoomView;
    import net.wg.gui.prebattle.squads.simple.SquadViewHeaderVO;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadTeamSectionVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class SquadViewMeta extends BaseRallyRoomView
    {

        public var leaveSquad:Function;

        private var _squadViewHeaderVO:SquadViewHeaderVO;

        private var _simpleSquadTeamSectionVO:SimpleSquadTeamSectionVO;

        public function SquadViewMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._squadViewHeaderVO)
            {
                this._squadViewHeaderVO.dispose();
                this._squadViewHeaderVO = null;
            }
            if(this._simpleSquadTeamSectionVO)
            {
                this._simpleSquadTeamSectionVO.dispose();
                this._simpleSquadTeamSectionVO = null;
            }
            super.onDispose();
        }

        public function leaveSquadS() : void
        {
            App.utils.asserter.assertNotNull(this.leaveSquad,"leaveSquad" + Errors.CANT_NULL);
            this.leaveSquad();
        }

        public final function as_updateBattleType(param1:Object) : void
        {
            var _loc2_:SquadViewHeaderVO = this._squadViewHeaderVO;
            this._squadViewHeaderVO = new SquadViewHeaderVO(param1);
            this.updateBattleType(this._squadViewHeaderVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setSimpleTeamSectionData(param1:Object) : void
        {
            var _loc2_:SimpleSquadTeamSectionVO = this._simpleSquadTeamSectionVO;
            this._simpleSquadTeamSectionVO = new SimpleSquadTeamSectionVO(param1);
            this.setSimpleTeamSectionData(this._simpleSquadTeamSectionVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function updateBattleType(param1:SquadViewHeaderVO) : void
        {
            var _loc2_:String = "as_updateBattleType" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setSimpleTeamSectionData(param1:SimpleSquadTeamSectionVO) : void
        {
            var _loc2_:String = "as_setSimpleTeamSectionData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
