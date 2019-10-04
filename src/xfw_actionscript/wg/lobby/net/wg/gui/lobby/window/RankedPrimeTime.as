package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.RankedPrimeTimeMeta;
    import net.wg.infrastructure.base.meta.IRankedPrimeTimeMeta;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeader;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
    import net.wg.utils.StageSizeBoundaries;

    public class RankedPrimeTime extends RankedPrimeTimeMeta implements IRankedPrimeTimeMeta, IStageSizeDependComponent
    {

        private static const HEADER_OFFSET_Y:int = 40;

        public var header:RankedBattlesPageHeader = null;

        private const SERVER_LABEL_FIELD:String = "shortname";

        public function RankedPrimeTime()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            serversDD.labelField = this.SERVER_LABEL_FIELD;
            setBackground(RES_ICONS.MAPS_ICONS_RANKEDBATTLES_BG_MAIN);
            App.stageSizeMgr.register(this);
        }

        override protected function onDispose() : void
        {
            this.header.dispose();
            this.header = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.header.y = HEADER_OFFSET_Y;
                this.header.x = width - this.header.width >> 1;
            }
        }

        override protected function setHeaderData(param1:RankedBattlesPageHeaderVO) : void
        {
            this.header.setData(param1);
            invalidateSize();
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            var _loc3_:Boolean = param1 < StageSizeBoundaries.WIDTH_1366 || param2 < StageSizeBoundaries.HEIGHT_900;
            this.header.setScreenSize(_loc3_);
        }
    }
}
