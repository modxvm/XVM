package net.wg.gui.components.controls
{
    import flash.display.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.interfaces.*;

    public class WgScrollingList extends scaleform.clik.controls.ScrollingList
    {
        public function WgScrollingList()
        {
            super();
            return;
        }

        protected override function populateData(arg1:Array):void
        {
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=null;
            var loc1:*=arg1.length;
            var loc2:*=_renderers.length;
            var loc3:*=0;
            while (loc3 < loc2)
            {
                loc4 = getRendererAt(loc3);
                loc5 = _scrollPosition + loc3;
                loc6 = new scaleform.clik.data.ListData(loc5, itemToLabel(arg1[loc3]), _selectedIndex == loc5);
                loc4.enabled = loc3 >= loc1 ? false : true;
                loc4.setListData(loc6);
                loc4.setData(arg1[loc3]);
                if (!this.showEmptyItems)
                    scaleform.clik.core.UIComponent(loc4).visible = !(arg1[loc3] == null);
                loc4.validateNow();
                ++loc3;
            }
            return;
        }

        public override function dispose():void
        {
            this.disposeRenderers();
            if (_dataProvider)
            {
                _dataProvider.cleanUp();
                _dataProvider = null;
            }
            if (_scrollBar)
                _scrollBar.dispose();
            thumbOffset = null;
            _padding = null;
            super.dispose();
            return;
        }

        public function disposeRenderers():void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=_renderers.length;
            --loc2;
            while (loc2 >= 0)
            {
                loc3 = getRendererAt(loc2);
                if (loc3 != null)
                {
                    cleanUpRenderer(loc3);
                    loc4 = loc3 as net.wg.infrastructure.interfaces.entity.IDisposable;
                    if (loc4)
                        loc4.dispose();
                    loc5 = loc3 as flash.display.DisplayObject;
                    if (container.contains(loc5))
                        container.removeChild(loc5);
                }
                _renderers.splice(loc2, 1);
                --loc2;
            }
            return;
        }

        public var showEmptyItems:Boolean;

        public var bg:flash.display.MovieClip;
    }
}
