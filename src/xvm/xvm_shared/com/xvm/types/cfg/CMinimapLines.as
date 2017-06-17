/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimapLines implements ICloneable
    {
        public var vehicle:Array;
        public var camera:Array;
        public var traverseAngle:Array;

        public function get parsedVehicle():Vector.<CMinimapLine>
        {
            var res:Vector.<CMinimapLine> = new Vector.<CMinimapLine>();
            for each (var value:Object in vehicle)
            {
                res.push(ObjectConverter.convertData(value, CMinimapLine));
            }
            return res;
        }

        public function get parsedCamera():Vector.<CMinimapLine>
        {
            var res:Vector.<CMinimapLine> = new Vector.<CMinimapLine>();
            for each (var value:Object in camera)
            {
                res.push(ObjectConverter.convertData(value, CMinimapLine));
            }
            return res;
        }

        public function get parsedTraverseAngle():Vector.<CMinimapLine>
        {
            var res:Vector.<CMinimapLine> = new Vector.<CMinimapLine>();
            for each (var value:Object in traverseAngle)
            {
                res.push(ObjectConverter.convertData(value, CMinimapLine));
            }
            return res;
        }

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            vehicle = parseArray(vehicle);
            camera = parseArray(camera);
            traverseAngle = parseArray(traverseAngle);
        }

        private function parseArray(items:Array):Array
        {
            var a:Array = [];
            if (items && items.length)
            {
                var len:int = items.length;
                for (var i:int = 0; i < len; ++i)
                {
                    var item:CMinimapLine = CMinimapLine.parse(items[i]);
                    item.applyGlobalBattleMacros();
                    a.push(item);
                }
            }
            return a;
        }
    }
}
