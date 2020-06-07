package net.wg.gui.components.carousels.controls
{
    import net.wg.gui.components.controls.SimpleTileList;
    import scaleform.clik.interfaces.IListItemRenderer;

    public class VehicleRolesTileList extends SimpleTileList
    {

        public function VehicleRolesTileList()
        {
            super();
        }

        override public function invalidateLayout() : void
        {
            invalidate(INVALIDATE_LAYOUT);
        }

        override protected function isRenderStatic(param1:IListItemRenderer) : Boolean
        {
            return !param1.visible;
        }
    }
}
