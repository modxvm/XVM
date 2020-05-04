package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.battle.views.minimap.BaseMinimap;
    import net.wg.data.constants.Errors;

    public class EventMinimapMeta extends BaseMinimap
    {

        public var onZoomModeChanged:Function;

        public function EventMinimapMeta()
        {
            super();
        }

        public function onZoomModeChangedS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onZoomModeChanged,"onZoomModeChanged" + Errors.CANT_NULL);
            this.onZoomModeChanged(param1);
        }
    }
}
