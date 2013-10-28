package net.wg.gui.lobby.customization.renderers
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.RadioButton;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.SoundTypes;


   public class SectionItemRenderer extends SoundListItemRenderer
   {
          
      public function SectionItemRenderer() {
         super();
         soundType = SoundTypes.RNDR_NORMAL;
         soundId = SoundTypes.SECTION_RENDERER;
      }

      public var newMarker:MovieClip;

      public var rbtn:RadioButton;

      override public function setData(param1:Object) : void {
         super.data = param1;
         invalidateData();
      }

      override public function set selected(param1:Boolean) : void {
         super.selected = param1;
         this.rbtn.selected = param1;
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         this.rbtn.enabled = param1;
      }

      override public function set label(param1:String) : void {
         super.label = param1;
         this.rbtn.label = param1;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = !(data == null);
         }
      }

      override protected function updateAfterStateChange() : void {
         super.updateAfterStateChange();
         if(!initialized || data == null)
         {
            return;
         }
         if(this.newMarker != null)
         {
            this.newMarker.visible = data.hasNew;
         }
      }
   }

}