package net.wg.gui.components.common.cursor.base 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.infrastructure.base.*;
    import scaleform.gfx.*;
    
    internal class BaseCursor extends net.wg.infrastructure.base.AbstractView
    {
        public function BaseCursor()
        {
            super();
            return;
        }

        public function attachToCursor(arg1:flash.display.Sprite, arg2:Number, arg3:Number):void
        {
            if (this._attachedSprite != null) 
            {
                this.detachFromCursor();
            }
            assertNotNull(arg1, "sprite");
            this._attachedSprite = arg1;
            addChildAt(this._attachedSprite, 0);
            this._attachedSprite.x = arg2;
            this._attachedSprite.y = arg3;
            return;
        }

        public function getAttachedSprite():flash.display.Sprite
        {
            return this._attachedSprite;
        }

        public function detachFromCursor():void
        {
            assertNotNull(this._attachedSprite, "sprite");
            removeChild(this._attachedSprite);
            this._attachedSprite = null;
            return;
        }

        public function resetCursor():void
        {
            this.setCursor(this._lastCursor);
            return;
        }

        public function setCursor(arg1:String):void
        {
            this._lastCursor = arg1;
            if (this.cursorIsFree()) 
            {
                this.forceSetCursor(arg1);
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            App.utils.scheduler.envokeInNextFrame(this.addServiceListeners);
            return;
        }

        protected override function onDispose():void
        {
            this.removeServiceListeners();
            if (this._attachedSprite) 
            {
                this.detachFromCursor();
            }
            super.onDispose();
            return;
        }

        public override function setViewSize(arg1:Number, arg2:Number):void
        {
            return;
        }

        protected final function forceSetCursor(arg1:String):void
        {
            gotoAndStop(arg1);
            return;
        }

        protected final function tryToResetCursor():void
        {
            if (this.cursorIsFree()) 
            {
                this.resetCursor();
            }
            return;
        }

        protected function cursorIsFree():Boolean
        {
            return true;
        }

        internal function addServiceListeners():void
        {
            App.stage.addEventListener(scaleform.gfx.MouseCursorEvent.CURSOR_CHANGE, this.onChangeCursorHandler);
            App.stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
            return;
        }

        internal function removeServiceListeners():void
        {
            App.stage.removeEventListener(scaleform.gfx.MouseCursorEvent.CURSOR_CHANGE, this.onChangeCursorHandler);
            App.stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onMouseMoveHandler);
            return;
        }

        internal function onChangeCursorHandler(arg1:scaleform.gfx.MouseCursorEvent):void
        {
            this.setCursor(arg1.cursor);
            arg1.preventDefault();
            return;
        }

        internal function onMouseMoveHandler(arg1:flash.events.MouseEvent):void
        {
            x = stage.mouseX;
            y = stage.mouseY;
            return;
        }

        internal var _attachedSprite:flash.display.Sprite=null;

        internal var _lastCursor:String="arrow";
    }
}
