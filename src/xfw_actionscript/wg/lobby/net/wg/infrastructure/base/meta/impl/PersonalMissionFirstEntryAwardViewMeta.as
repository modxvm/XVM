package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionsAbstractInfoView;
    import net.wg.data.constants.Errors;

    public class PersonalMissionFirstEntryAwardViewMeta extends PersonalMissionsAbstractInfoView
    {

        public var onEscapePress:Function;

        public function PersonalMissionFirstEntryAwardViewMeta()
        {
            super();
        }

        public function onEscapePressS() : void
        {
            App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
            this.onEscapePress();
        }
    }
}
