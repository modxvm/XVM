package net.wg.gui.lobby.customization.renderers
{
    public class InscriptionItemRenderer extends TextureItemRenderer
    {
        
        public function InscriptionItemRenderer()
        {
            super();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            uiLoader.setSourceSize(256,128);
        }
        
        override protected function updateCostPos() : void
        {
            if((data) && ((data.current) || (data.isInHangar)))
            {
                costFrame.x = 1;
                costFrame.width = _costFrameW + _costFrameX - 1;
            }
            else
            {
                costFrame.x = _costFrameX;
                costFrame.width = _costFrameW;
            }
        }
    }
}
