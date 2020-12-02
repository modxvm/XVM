package net.wg.gui.prebattle.squads.event
{
    import net.wg.gui.prebattle.squads.SquadView;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import net.wg.data.constants.generated.SQUADTYPES;
    import net.wg.gui.rally.views.room.BaseChatSection;
    import net.wg.gui.rally.views.room.BaseTeamSection;

    public class EventSquadView extends SquadView
    {

        private static const INVITE_BOTTOM_PADDING:int = 117;

        private static const CHAT_BOTTOM_PADDING:int = 18;

        public function EventSquadView()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            EventDispatcher(teamSection).addEventListener(Event.RESIZE,this.onTeamSectionResizeHandler);
        }

        override protected function onDispose() : void
        {
            EventDispatcher(teamSection).removeEventListener(Event.RESIZE,this.onTeamSectionResizeHandler);
            super.onDispose();
        }

        override protected function getSquadType() : String
        {
            return SQUADTYPES.SQUAD_TYPE_EVENT;
        }

        protected function updateSquadLayout() : void
        {
            var _loc3_:* = 0;
            var _loc1_:BaseChatSection = chatSection as BaseChatSection;
            var _loc2_:BaseTeamSection = teamSection as BaseTeamSection;
            if(_loc2_)
            {
                _loc3_ = _loc2_.height;
                if(_loc1_)
                {
                    _loc1_.height = _loc3_ - _loc1_.y - CHAT_BOTTOM_PADDING;
                }
                inviteBtn.y = _loc2_.y + _loc3_ - INVITE_BOTTOM_PADDING;
                height = _loc2_.y + _loc3_;
                dispatchEvent(new Event(Event.RESIZE));
            }
        }

        private function onTeamSectionResizeHandler(param1:Event) : void
        {
            this.updateSquadLayout();
        }
    }
}
