package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.helpers.*;
    
    public class ToolTipSpecial extends net.wg.gui.components.tooltips.ToolTipBase
    {
        public function ToolTipSpecial()
        {
            super();
            return;
        }

        protected function updatePositions():void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=NaN;
            var loc6:*=null;
            var loc1:*=0;
            if (this.blockResults) 
            {
                loc1 = this.blockResults.length;
                loc2 = 0;
                loc3 = 0;
                loc3 = 0;
                while (loc3 < loc1) 
                {
                    this.blockResults[loc3].leftTextField.width = leftPartMaxW;
                    loc2 = this.blockResults[loc3].elRightList.length;
                    loc4 = 0;
                    while (loc4 < loc2) 
                    {
                        this.blockResults[loc3].elRightList[loc4].x = this.blockResults[loc3].leftTextField.x + leftPartMaxW + net.wg.gui.components.tooltips.helpers.Utils.instance.MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS | 0;
                        ++loc4;
                    }
                    ++loc3;
                }
            }
            if (seaprators) 
            {
                loc1 = seaprators.length;
                loc5 = content.width + contentMargin.right + bgShadowMargin.right;
                loc3 = 0;
                while (loc3 < loc1) 
                {
                    (loc6 = seaprators[loc3]).x = loc5 - loc6.width >> 1;
                    ++loc3;
                }
            }
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (this.blockResults) 
            {
                while (this.blockResults.length > 0) 
                {
                    loc1 = this.blockResults.pop();
                    loc2 = loc1.headerTextField;
                    if (loc2 != null) 
                    {
                        content.removeChild(loc2);
                        loc1.headerTextField = null;
                        loc2 = null;
                    }
                    loc3 = loc1.leftTextField;
                    if (loc3 != null) 
                    {
                        content.removeChild(loc3);
                        loc1.leftTextField = null;
                        loc3 = null;
                    }
                    loc4 = loc1.elRightList;
                    while (loc4.length > 0) 
                    {
                        loc5 = loc4.pop();
                        content.removeChild(loc5);
                        loc5 = null;
                    }
                    loc1 = null;
                }
                this.blockResults = null;
            }
            if (seaprators) 
            {
                while (seaprators.length > 0) 
                {
                    loc6 = seaprators.pop();
                    content.removeChild(loc6);
                    loc6 = null;
                }
                seaprators = null;
            }
            super.dispose();
            return;
        }

        protected override function updateSize():void
        {
            background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
            background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
            return;
        }

        protected var blockResults:__AS3__.vec.Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO>=null;
    }
}
