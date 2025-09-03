/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimapCircles implements ICloneable
    {
        public var artillery:CMinimapCircle;
        public var shell:CMinimapCirclesRange;
        public var special:Array;
        public var view:Array;
        // internal
        public var _internal:CMinimapCirclesInternal;

        private var _view:Vector.<CMinimapCircle> = null;
        public function get parsedView():Vector.<CMinimapCircle>
        {
            if (view)
            {
                _view = new Vector.<CMinimapCircle>();
                for each (var value:Object in view)
                {
                    _view.push(ObjectConverter.convertData(value, CMinimapCircle));
                }
                view = null;
            }
            return _view;
        }

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            if (artillery)
            {
                artillery.applyGlobalMacros();
            }
            if (shell)
            {
                shell.applyGlobalMacros();
            }
            // parse "special"
            if (special)
            {
                var i:int = special.length;
                while (--i > -1)
                {
                    var items:Object = special[i];
                    var keys:Array = [];
                    var key:String;
                    for (key in items)
                    {
                        keys.push(key);
                    }
                    for each (key in keys)
                    {
                        var item:CMinimapCircle = ObjectConverter.convertData(items[key], CMinimapCircle);
                        item.applyGlobalMacros();
                        items[key] = item;
                    }
                }
            }
            applyGlobalMacrosVector(parsedView);
        }

        private function applyGlobalMacrosVector(items:Vector.<CMinimapCircle>):void
        {
            if (items)
            {
                var i:int = items.length;
                while (--i > -1)
                {
                    items[i].applyGlobalMacros();
                }
            }
        }
    }
}
