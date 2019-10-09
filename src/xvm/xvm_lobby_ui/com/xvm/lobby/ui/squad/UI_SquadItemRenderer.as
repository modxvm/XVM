/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.squad
{
    public class UI_SquadItemRenderer extends squadItemRendererUI
    {
        private var worker:SquadItemRenderer;

        public function UI_SquadItemRenderer():void
        {
            super();
            worker = new SquadItemRenderer(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            worker.configUI();
        }

        override protected function afterSetData():void
        {
            super.afterSetData();
            worker.afterSetData();
        }

        override protected function getToolTipData():String
        {
            var data:String = worker.getToolTipData();
            return (data != null ? data : super.getToolTipData());
        }

        override protected function draw():void
        {
            super.draw();
            worker.draw();
        }
    }

}
