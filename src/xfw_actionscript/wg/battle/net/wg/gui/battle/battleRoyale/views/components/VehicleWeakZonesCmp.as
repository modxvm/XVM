package net.wg.gui.battle.battleRoyale.views.components
{
    import net.wg.gui.components.battleRoyale.VehicleWeakZonesBase;
    import net.wg.infrastructure.interfaces.IReusable;
    import flash.text.TextFieldAutoSize;

    public class VehicleWeakZonesCmp extends VehicleWeakZonesBase implements IReusable
    {

        public function VehicleWeakZonesCmp()
        {
            super();
            engineTf.autoSize = TextFieldAutoSize.LEFT;
            ammunitionTf.autoSize = TextFieldAutoSize.RIGHT;
        }

        public function cleanUp() : void
        {
            engineTf.text = ammunitionTf.text = weakZones.source = null;
        }
    }
}
