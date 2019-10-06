package net.wg.gui.components.tooltips.inblocks.data
{
    import net.wg.gui.components.tooltips.inblocks.interfaces.ITootipBlocksData;

    public class BuildUpBlockVO extends BlocksVO implements ITootipBlocksData
    {

        public var gap:int = 0;

        public var stretchBg:Boolean = false;

        public var layout:String = "";

        public var align:String = "";

        public function BuildUpBlockVO(param1:Object)
        {
            super(param1);
        }

        public function get layoutGap() : int
        {
            return this.gap;
        }

        public function get layoutAlign() : String
        {
            return this.align;
        }

        public function get blocks() : Vector.<BlockDataItemVO>
        {
            return blocksData;
        }
    }
}
