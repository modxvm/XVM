package net.wg.gui.lobby.hangar.eventEntryPoint.gfWrapper
{
    import net.wg.infrastructure.base.meta.impl.BOBEventEntryPointMeta;
    import net.wg.gui.lobby.hangar.eventEntryPoint.IEventEntryPoint;
    import net.wg.infrastructure.base.meta.IBOBEventEntryPointMeta;
    import flash.geom.Rectangle;
    import net.wg.gui.lobby.hangar.eventEntryPoint.EntryPointSize;

    public class BobEntryPoint extends BOBEventEntryPointMeta implements IEventEntryPoint, IBOBEventEntryPointMeta
    {

        private static const SHADOW_OFFSET:int = 8;

        private static const WIDTH:int = 270 + 2 * SHADOW_OFFSET;

        private static const HEIGHT:int = 164 + 2 * SHADOW_OFFSET;

        private static const MARGIN:Rectangle = new Rectangle(8 - SHADOW_OFFSET,10 - SHADOW_OFFSET,10 - SHADOW_OFFSET,10 - SHADOW_OFFSET);

        public function BobEntryPoint()
        {
            super();
        }

        override protected function configUI() : void
        {
            setSize(WIDTH,HEIGHT);
        }

        public function get size() : int
        {
            return EntryPointSize.SMALL;
        }

        public function set size(param1:int) : void
        {
        }

        public function get margin() : Rectangle
        {
            return MARGIN;
        }
    }
}
