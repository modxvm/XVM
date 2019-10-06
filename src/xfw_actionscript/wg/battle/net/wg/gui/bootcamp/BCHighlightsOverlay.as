package net.wg.gui.bootcamp
{
    import net.wg.infrastructure.base.meta.IBCHighlightsMeta;
    import flash.display.DisplayObject;
    import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;

    public class BCHighlightsOverlay extends BCHighlightsBase implements IBCHighlightsMeta
    {

        public function BCHighlightsOverlay()
        {
            super();
        }

        override protected function getContextRenderer(param1:DisplayObject, param2:String, param3:Object) : DisplayObject
        {
            var _loc5_:ConsumablesPanel = null;
            var _loc4_:DisplayObject = super.getContextRenderer(param1,param2,param3);
            if(_loc4_ != null)
            {
                return _loc4_;
            }
            if(param1 is ConsumablesPanel)
            {
                _loc5_ = ConsumablesPanel(param1);
                if(_loc5_.numChildren)
                {
                    return _loc5_.getRendererBySlotIdx(int(param3)) as DisplayObject;
                }
            }
            return null;
        }
    }
}
