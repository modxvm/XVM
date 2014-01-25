package net.wg.gui.components.advanced
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.infrastructure.interfaces.IPersonalCaseItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.MovieClip;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.SoundManagerStates;
   import flash.events.MouseEvent;


   public class PortraitItemRenderer extends SoundListItemRenderer implements IPersonalCaseItemRenderer
   {
          
      public function PortraitItemRenderer() {
         super();
         useHandCursor = true;
         allowDeselect = false;
         toggle = true;
      }

      public var loader:UILoaderAlt;

      public var emptyFocusIndicator:MovieClip;

      override protected function onDispose() : void {
         super.onDispose();
         if(this.loader)
         {
            this.loader.dispose();
            this.loader = null;
         }
         this.emptyFocusIndicator = null;
         _data = null;
      }

      override public function setData(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         super.setData(param1);
         this.loader.source = "../maps/icons/tankmen/icons/barracks/" + param1.value;
      }

      override protected function configUI() : void {
         if(this.emptyFocusIndicator)
         {
            focusIndicator = this.emptyFocusIndicator;
         }
         soundType = SoundTypes.CAROUSEL_BTN;
         soundId = SoundManagerStates.CAROUSEL_CELL_BTN;
         super.configUI();
      }

      override protected function draw() : void {
         super.draw();
      }

      override protected function handleMouseReleaseEx(param1:MouseEvent) : void {
         super.handleMouseReleaseEx(param1);
      }

      private var _canSelected:Boolean = true;

      override protected function handleMouseRelease(param1:MouseEvent) : void {
         if(this.canSelected)
         {
            super.handleMouseRelease(param1);
         }
      }

      public function set canSelected(param1:Boolean) : void {
         this._canSelected = param1;
      }

      public function get canSelected() : Boolean {
         return this._canSelected;
      }
   }

}