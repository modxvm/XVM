package net.wg.gui.lobby.profile.components 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.interfaces.*;
    
    public class ResizableTileList extends net.wg.gui.components.controls.TileList
    {
        public function ResizableTileList()
        {
            super();
            return;
        }

        public override function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            super.dataProvider = arg1;
            invalidate();
            return;
        }

        protected override function calculateRendererTotal(arg1:Number, arg2:Number):uint
        {
            var loc3:*=null;
            var loc1:*=isNaN(_rowHeight) && isNaN(_autoRowHeight);
            var loc2:*=isNaN(_columnWidth) && isNaN(_autoColumnWidth);
            if (loc1 || loc2) 
            {
                loc3 = createRenderer(0);
                if (loc1) 
                {
                    _autoRowHeight = loc3.height;
                }
                if (loc2) 
                {
                    _autoColumnWidth = loc3.width;
                }
                cleanUpRenderer(loc3);
            }
            _totalColumns = availableWidth / columnWidth >> 0;
            _totalRenderers = _dataProvider ? _dataProvider.length : 0;
            _totalRows = Math.ceil(_totalRenderers / _totalColumns);
            return _totalRenderers;
        }

        protected override function drawLayout():void
        {
            var loc1:*=null;
            super.drawLayout();
            if (_renderers && _renderers.length > 0) 
            {
                loc1 = getRendererAt((_renderers.length - 1));
                _height = loc1.height + loc1.y + margin + paddingBottom;
            }
            dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE, true));
            return;
        }
    }
}
