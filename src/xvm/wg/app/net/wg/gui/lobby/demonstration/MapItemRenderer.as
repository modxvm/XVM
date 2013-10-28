package net.wg.gui.lobby.demonstration
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.lobby.demonstration.data.MapItemVO;
   import net.wg.data.constants.SoundTypes;


   public class MapItemRenderer extends SoundListItemRenderer
   {
          
      public function MapItemRenderer() {
         super();
         soundType = SoundTypes.RNDR_NORMAL;
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (data))
         {
            textField.text = MapItemVO(data).name;
         }
      }

      override public function setData(param1:Object) : void {
         super.setData(param1);
         invalidate(InvalidationType.DATA);
      }
   }

}