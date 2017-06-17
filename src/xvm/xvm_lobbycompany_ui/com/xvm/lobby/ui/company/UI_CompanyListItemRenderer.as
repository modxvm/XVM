/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.lobby.ui.company
{
    import com.xvm.lobby.ui.company.renderers.*;
    import flash.events.*;

    public dynamic class UI_CompanyListItemRenderer extends CompanyListItemRendererUI
    {
        private var worker:CompanyOwnerItemRenderer;

        public function UI_CompanyListItemRenderer()
        {
            super();
            worker = new CompanyOwnerItemRenderer(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            worker.configUI();
        }

        override public function setData(data:Object):void
        {
            super.setData(data);
            worker.setData(data);
        }

        override protected function handleMouseRollOver(e:MouseEvent):void
        {
            super.handleMouseRollOver(e);
            worker.handleMouseRollOver(e);
        }
    }
}
