package net.wg.gui.lobby.customization.data 
{
    import flash.events.*;
    import net.wg.data.daapi.base.*;
    import scaleform.clik.data.*;
    
    public class DAAPIItemsDataProvider extends net.wg.data.daapi.base.DAAPIDataProvider
    {
        public function DAAPIItemsDataProvider(arg1:Array)
        {
            super();
            this.items = new scaleform.clik.data.DataProvider(arg1);
            return;
        }

        public function invalidateRemote(arg1:Boolean):void
        {
            this.items = new scaleform.clik.data.DataProvider(this.onRequestList(this.groupName));
            var loc1:*=new flash.events.Event(flash.events.Event.CHANGE);
            dispatchEvent(loc1);
            return;
        }

        public override function get length():uint
        {
            return this.items.length;
        }

        public override function requestItemAt(arg1:uint, arg2:Function=null):Object
        {
            return this.items.requestItemAt(arg1, arg2);
        }

        public override function requestItemRange(arg1:int, arg2:int, arg3:Function=null):Array
        {
            return this.items.requestItemRange(arg1, arg2, arg3);
        }

        public override function indexOf(arg1:Object, arg2:Function=null):int
        {
            return items::DataProvider.indexOf(arg1, arg2);
        }

        public override function cleanUp():void
        {
            this.items.cleanUp();
            return;
        }

        public override function invalidate(arg1:uint=0):void
        {
            this.items.invalidate(arg1);
            return;
        }

        public override function as_populate():void
        {
            return;
        }

        public override function as_dispose():void
        {
            this.cleanUp();
            this.groupName = null;
            this.items = null;
            return;
        }

        public static function getEmptyItem():Object
        {
            return {"id":null, "texturePath":null, "description":"", "price":{"cost":0, "isGold":false}, "current":false};
        }

        public var onRequestList:Function;

        public var groupName:String="";

        internal var items:scaleform.clik.data.DataProvider;
    }
}
