/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimapCircles implements ICloneable
    {
        public var artillery:CMinimapCirclesRange;
        public var shell:CMinimapCirclesRange;
        public var special:Array;
        public var view:Array;
        // internal
        public var _internal:CMinimapCirclesInternal;

        private var _view:Vector.<CMinimapCircle> = null;
        public function get parsedView():Vector.<CMinimapCircle>
        {
            if (!_view)
            {
                _view = new Vector.<CMinimapLine>();
                for each (var value:Object in view)
                {
                    _view.push(ObjectConverter.convertData(value, CMinimapLine));
                }
            }
            return _view;
        }

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            if (artillery)
            {
                artillery.applyGlobalBattleMacros();
            }
            if (shell)
            {
                shell.applyGlobalBattleMacros();
            }
            // parse "special"
            if (special)
            {
                var len:int = special.length;
                for (var i:int = 0; i < len; ++i)
                {
                    var items:Object = special[i];
                    for (var key:String in items)
                    {
                        var item:CMinimapCircle = ObjectConverter.convertData(items[key], CMinimapCircle);
                        item.applyGlobalBattleMacros();
                        items[key] = item;
                    }
                }
            }
            applyGlobalBattleMacrosVector(parsedView);
        }

        private function applyGlobalBattleMacrosVector(items:Vector.<CMinimapCircle>):void
        {
            if (items)
            {
                var len:int = items.length;
                for (var i:int = 0; i < len; ++i)
                {
                    items[i].applyGlobalBattleMacros();
                }
            }
        }
    }
}
