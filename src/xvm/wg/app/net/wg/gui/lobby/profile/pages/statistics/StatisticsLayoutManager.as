package net.wg.gui.lobby.profile.pages.statistics 
{
    import flash.display.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.data.*;
    
    public class StatisticsLayoutManager extends net.wg.gui.lobby.profile.data.SectionLayoutManager
    {
        public function StatisticsLayoutManager(arg1:Number, arg2:Number)
        {
            super(arg1, arg2);
            return;
        }

        public override function setDimension(arg1:Number, arg2:Number):void
        {
            super.setDimension(arg1, arg2);
            var loc1:*=store.length;
            this.stepW = net.wg.gui.lobby.profile.ProfileConstants.WINDOW_CENTER_OFFSET / loc1 / (loc1 + 1);
            return;
        }

        protected override function applyDimensionToItem(arg1:int):void
        {
            var loc1:*=null;
            super.applyDimensionToItem(arg1);
            if (!isInitialized) 
            {
                loc1 = store[arg1].item;
                if (loc1 is net.wg.gui.lobby.profile.components.LineDescrIconText) 
                {
                    loc1.x = this.stepW + arg1 * (loc1.width + this.stepW);
                }
            }
            return;
        }

        internal var stepW:int;
    }
}
