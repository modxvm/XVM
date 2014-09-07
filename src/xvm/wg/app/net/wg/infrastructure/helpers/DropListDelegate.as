package net.wg.infrastructure.helpers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.helpers.interfaces.IDropListDelegate;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.entity.IDropItem;
    import net.wg.infrastructure.events.DropEvent;
    import flash.display.Sprite;
    
    public class DropListDelegate extends MovieClip implements IDropListDelegate
    {
        
        public function DropListDelegate(param1:InteractiveObject, param2:String)
        {
            super();
            this._hitArea = param1;
            this._dropElementLinkage = param2;
        }
        
        private var _pairedScrollLists:Vector.<InteractiveObject> = null;
        
        private var _hitArea:InteractiveObject = null;
        
        private var _dropElementLinkage:String = null;
        
        public final function dispose() : void
        {
            this.onDispose();
        }
        
        protected function onDispose() : void
        {
            if(App.cursor.getAttachedSprite() != null)
            {
                if(App.cursor.getAttachedSprite() is IDisposable)
                {
                    IDisposable(App.cursor.getAttachedSprite()).dispose();
                }
                App.cursor.detachFromCursor();
            }
            this._pairedScrollLists.splice(0,this._pairedScrollLists.length);
            this._pairedScrollLists = null;
            this._hitArea = null;
            this._dropElementLinkage = null;
        }
        
        public function onBeforeDrop(param1:InteractiveObject, param2:InteractiveObject) : Boolean
        {
            if(param2 as IDropItem != null)
            {
                this.dispatchDropEvent(DropEvent.BEFORE_DROP,param1,null,param2);
                return true;
            }
            return false;
        }
        
        public function onAfterDrop(param1:InteractiveObject, param2:InteractiveObject) : void
        {
            this.dispatchDropEvent(DropEvent.AFTER_DROP,param1,null,param2);
            if(App.cursor.getAttachedSprite() != null)
            {
                if(App.cursor.getAttachedSprite() is IDisposable)
                {
                    IDisposable(App.cursor.getAttachedSprite()).dispose();
                }
                App.cursor.detachFromCursor();
            }
        }
        
        public function onStartDrop(param1:InteractiveObject, param2:InteractiveObject, param3:Number, param4:Number) : Boolean
        {
            var _loc5_:Sprite = null;
            if(App.instance)
            {
                _loc5_ = App.utils.classFactory.getComponent(this._dropElementLinkage,Sprite);
                App.cursor.attachToCursor(_loc5_,-param3,-param4);
            }
            this.dispatchDropEvent(DropEvent.START_DROP,param1,null,param2);
            return true;
        }
        
        public function onEndDrop(param1:InteractiveObject, param2:InteractiveObject, param3:InteractiveObject, param4:InteractiveObject) : void
        {
            this.dispatchDropEvent(DropEvent.END_DROP,param1,param2,param3);
        }
        
        public function getDropGroup() : Vector.<InteractiveObject>
        {
            return Vector.<InteractiveObject>(this._pairedScrollLists);
        }
        
        public function getHitArea() : InteractiveObject
        {
            return this._hitArea;
        }
        
        public function setPairedDropLists(param1:Vector.<InteractiveObject>) : void
        {
            this._pairedScrollLists = param1;
        }
        
        private function dispatchDropEvent(param1:String, param2:InteractiveObject, param3:InteractiveObject, param4:InteractiveObject) : void
        {
            this._hitArea.dispatchEvent(new DropEvent(param1,param2,param3,param4));
        }
    }
}
