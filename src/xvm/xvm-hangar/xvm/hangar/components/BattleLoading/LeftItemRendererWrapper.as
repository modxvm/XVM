package xvm.hangar.components.BattleLoading
{
    import com.xvm.*;

    public class LeftItemRendererWrapper extends LeftItemRendererUI
    {
        private var worker:BattleLoadingItemRenderer;

        public function LeftItemRendererWrapper()
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
