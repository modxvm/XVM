package net.wg.gui.battle.views.epicMissionsPanel.components
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterIcon;
    import net.wg.gui.battle.views.staticMarkers.epic.sectorWaypoint.SectorWaypointIcon;
    import net.wg.gui.battle.views.staticMarkers.epic.sectorbase.SectorBaseIcon;
    import net.wg.data.constants.generated.EPIC_CONSTS;

    public class EpicMissionsAnimatedMarker extends BattleUIComponent
    {

        public var hqMarker:HeadquarterIcon = null;

        public var waypointMarker:SectorWaypointIcon = null;

        public var baseMarker:SectorBaseIcon = null;

        public function EpicMissionsAnimatedMarker()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.hqMarker.dispose();
            this.hqMarker = null;
            this.waypointMarker.dispose();
            this.waypointMarker = null;
            this.baseMarker.dispose();
            this.baseMarker = null;
            super.onDispose();
        }

        public function setHeadquarterID(param1:int) : void
        {
            this.hqMarker.setHeadquarterId(param1);
        }

        public function setState(param1:int, param2:Boolean, param3:int) : void
        {
            this.hqMarker.visible = false;
            this.waypointMarker.visible = false;
            this.baseMarker.visible = false;
            if(param1 == EPIC_CONSTS.PRIMARY_BASE_MISSION)
            {
                this.baseMarker.visible = true;
                this.baseMarker.setOwningTeam(!param2);
                if(param1)
                {
                    this.baseMarker.setBaseId(param3);
                }
            }
            else if(param1 == EPIC_CONSTS.PRIMARY_HQ_MISSION)
            {
                this.hqMarker.visible = true;
                this.hqMarker.setOwningTeam(!param2);
            }
            else if(param1 == EPIC_CONSTS.PRIMARY_WAYPOINT_MISSION)
            {
                this.waypointMarker.visible = true;
                this.waypointMarker.isAttacker(param2);
            }
        }
    }
}
