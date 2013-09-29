package net.wg.data 
{
    import scaleform.clik.data.*;
    
    public dynamic class InspectableDataProvider extends scaleform.clik.data.DataProvider
    {
        public function InspectableDataProvider()
        {
            super();
            return;
        }

        public function addItem(arg1:Object):void
        {
            push(arg1);
            return;
        }

        public function addItemAt(arg1:Object, arg2:uint):void
        {
            splice(arg2, 0, arg1);
            return;
        }

        public function getItemAt(arg1:uint):Object
        {
            return this[arg1];
        }

        public function getItemIndex(arg1:Object):int
        {
            return indexOf(arg1);
        }

        public function removeItem(arg1:Object):Object
        {
            var loc1:*=indexOf(arg1);
            return splice(loc1, 1);
        }

        public function removeItemAt(arg1:uint):Object
        {
            return splice(arg1, 1);
        }

        public override function requestItemAt(arg1:uint, arg2:Function=null):Object
        {
            var loc1:*=this[arg1];
            if (arg2 != null) 
            {
                arg2(loc1);
            }
            return loc1;
        }
    }
}
