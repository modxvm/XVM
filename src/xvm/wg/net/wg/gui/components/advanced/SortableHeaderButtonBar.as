package net.wg.gui.components.advanced 
{
    import scaleform.clik.controls.*;
    import scaleform.clik.interfaces.*;
    
    public class SortableHeaderButtonBar extends scaleform.clik.controls.ButtonBar
    {
        public function SortableHeaderButtonBar()
        {
            super();
            return;
        }

        public override function get dataProvider():scaleform.clik.interfaces.IDataProvider
        {
            return super.dataProvider;
        }

        public override function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            super.dataProvider = arg1;
            return;
        }

        protected override function updateRenderers():void
        {
            super.updateRenderers();
            return;
        }

        public function getRenderers():Array
        {
            return _renderers;
        }
    }
}
