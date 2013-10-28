package net.wg.gui.components.controls
{
   import scaleform.clik.controls.ScrollBar;
   import flash.events.Event;
   import scaleform.gfx.MouseEventEx;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;


   public class ScrollBar extends scaleform.clik.controls.ScrollBar
   {
          
      public function ScrollBar() {
         super();
      }

      public var upArrowWg:SoundButton;

      public var downArrowWg:SoundButton;

      public var thumbWg:SoundButton;

      override protected function initialize() : void {
         upArrow = this.upArrowWg;
         downArrow = this.downArrowWg;
         thumb = this.thumbWg;
         super.initialize();
      }

      override public function dispose() : void {
         super.dispose();
      }

      override protected function handleThumbPress(param1:Event) : void {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
         if(_loc3_ != 0)
         {
            return;
         }
         super.handleThumbPress(param1);
      }

      override protected function handleTrackPress(param1:MouseEvent) : void {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
         if(_loc3_ != 0)
         {
            return;
         }
         super.handleTrackPress(param1);
      }

      override protected function handleTrackClick(param1:ButtonEvent) : void {
         if(param1.buttonIdx != 0)
         {
            return;
         }
         super.handleTrackClick(param1);
      }
   }

}