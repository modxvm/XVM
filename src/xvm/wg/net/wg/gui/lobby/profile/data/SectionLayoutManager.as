package net.wg.gui.lobby.profile.data 
{
    import __AS3__.vec.*;
    import flash.display.*;
    
    public class SectionLayoutManager extends Object
    {
        public function SectionLayoutManager(arg1:Number, arg2:Number)
        {
            this.store = new Vector.<net.wg.gui.lobby.profile.data.LayoutItemInfo>();
            super();
            this.minH = arg1;
            this.maxH = arg2;
            return;
        }

        public function setDimension(arg1:Number, arg2:Number):void
        {
            arg2 = Math.max(this.minH, Math.min(this.maxH, arg2));
            if (this.currentValue == arg2) 
                return;
            this.currentValue = arg2;
            var loc1:*=this.store.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                this.applyDimensionToItem(loc2);
                ++loc2;
            }
            this.isInitialized = true;
            return;
        }

        protected function applyDimensionToItem(arg1:int):void
        {
            var loc1:*=this.store[arg1];
            loc1.item.y = Math.round(loc1.position * this.currentValue);
            return;
        }

        public function registerComponents(... rest):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=rest.length;
            var loc4:*=0;
            while (loc4 < loc1) 
            {
                loc2 = new net.wg.gui.lobby.profile.data.LayoutItemInfo();
                loc3 = rest[loc4];
                loc2.item = loc3;
                loc2.position = loc3.y / this.minH;
                this.store.push(loc2);
                ++loc4;
            }
            return;
        }

        public function unRegisterComponent(arg1:flash.display.DisplayObject):void
        {
            var loc1:*=this.store.indexOf(arg1);
            if (loc1 != -1) 
                this.store.splice(loc1, 1);
            return;
        }

        public function dispose():void
        {
            this.currentValue = 0;
            while (this.store.length > 0) 
                this.store.splice((this.store.length - 1), 1);
            return;
        }

        internal var minH:uint;

        internal var maxH:uint;

        protected var store:__AS3__.vec.Vector.<net.wg.gui.lobby.profile.data.LayoutItemInfo>;

        internal var currentValue:uint=0;

        protected var isInitialized:Boolean;
    }
}
