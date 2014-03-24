package net.wg.gui.components.common.cursor.base
{
   import net.wg.infrastructure.base.AbstractView;
   import flash.display.Sprite;
   import scaleform.gfx.MouseCursorEvent;
   import flash.events.MouseEvent;
   import flash.display.MovieClip;


   class BaseCursor extends AbstractView
   {
          
      function BaseCursor() {
         super();
      }

      private var _attachedSprite:Sprite = null;

      private var _lastCursor:String = "arrow";

      public function attachToCursor(param1:Sprite, param2:Number, param3:Number) : void {
         if(this._attachedSprite != null)
         {
            this.detachFromCursor();
         }
         assertNotNull(param1,"sprite");
         this._attachedSprite = param1;
         addChildAt(this._attachedSprite,0);
         this._attachedSprite.x = param2;
         this._attachedSprite.y = param3;
      }

      public function getAttachedSprite() : Sprite {
         return this._attachedSprite;
      }

      public function detachFromCursor() : void {
         assertNotNull(this._attachedSprite,"sprite");
         removeChild(this._attachedSprite);
         this._attachedSprite = null;
      }

      public function resetCursor() : void {
         this.setCursor(this._lastCursor);
      }

      public function setCursor(param1:String) : void {
         this._lastCursor = param1;
         if(this.cursorIsFree())
         {
            this.forceSetCursor(param1);
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         App.utils.scheduler.envokeInNextFrame(this.addServiceListeners);
      }

      override protected function onDispose() : void {
         this.removeServiceListeners();
         if(this._attachedSprite)
         {
            this.detachFromCursor();
         }
         super.onDispose();
      }

      override public function setViewSize(param1:Number, param2:Number) : void {
          
      }

      protected final function forceSetCursor(param1:String) : void {
         gotoAndStop(param1);
      }

      protected final function tryToResetCursor() : void {
         if(this.cursorIsFree())
         {
            this.resetCursor();
         }
      }

      protected function cursorIsFree() : Boolean {
         return true;
      }

      private function addServiceListeners() : void {
         App.stage.addEventListener(MouseCursorEvent.CURSOR_CHANGE,this.onChangeCursorHandler);
         App.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
      }

      private function removeServiceListeners() : void {
         App.stage.removeEventListener(MouseCursorEvent.CURSOR_CHANGE,this.onChangeCursorHandler);
         App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
      }

      private function onChangeCursorHandler(param1:MouseCursorEvent) : void {
         this.setCursor(param1.cursor);
         param1.preventDefault();
      }

      private function onMouseMoveHandler(param1:MouseEvent) : void {
         x = stage.mouseX - MovieClip(App.instance).x;
         y = stage.mouseY - MovieClip(App.instance).y;
      }
   }

}