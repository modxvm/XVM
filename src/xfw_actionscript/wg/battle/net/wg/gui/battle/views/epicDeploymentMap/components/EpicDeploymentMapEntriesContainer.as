package net.wg.gui.battle.views.epicDeploymentMap.components
{
    import net.wg.gui.battle.views.minimap.containers.MinimapEntriesContainer;
    import flash.display.Sprite;

    public class EpicDeploymentMapEntriesContainer extends MinimapEntriesContainer
    {

        public var zones:Sprite = null;

        public var landingZone:Sprite = null;

        public var hqs:Sprite = null;

        public function EpicDeploymentMapEntriesContainer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.zones = null;
            this.hqs = null;
            this.landingZone = null;
            super.onDispose();
        }
    }
}
