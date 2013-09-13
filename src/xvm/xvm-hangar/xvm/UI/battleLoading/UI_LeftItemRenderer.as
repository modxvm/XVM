package xvm.UI.battleLoading
{
    import com.xvm.*;
    import xvm.hangar.components.BattleLoading.*;

    public class UI_LeftItemRenderer extends LeftItemRendererUI
    {
        private var worker:BattleLoadingItemRenderer;

        public function UI_LeftItemRenderer()
        {
            super();
            worker = new BattleLoadingItemRenderer(this);
        }

        override public function setData(data:Object):void
        {
            super.setData(data);
            worker.setData(data);
        }

        override protected function draw():void
        {
            super.draw();
            worker.draw();
        }
    }
}
