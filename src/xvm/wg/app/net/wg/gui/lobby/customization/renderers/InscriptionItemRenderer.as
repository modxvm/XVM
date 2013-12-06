package net.wg.gui.lobby.customization.renderers
{


   public class InscriptionItemRenderer extends TextureItemRenderer
   {
          
      public function InscriptionItemRenderer() {
         super();
      }

      override protected function configUI() : void {
         super.configUI();
         uiLoader.setSourceSize(256,128);
      }
   }

}