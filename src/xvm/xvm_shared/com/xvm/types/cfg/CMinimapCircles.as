/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMinimapCircles extends Object implements ICloneable
    {
        public var view:Array;
        public var artillery:CMinimapCirclesRange;
        public var shell:CMinimapCirclesRange;
        public var special:Array;
        public var _internal:CMinimapCirclesInternal;

        public function get parsedView():Vector.<CMinimapCircle>
        {
            return Vector.<CMinimapCircle>(view);
        }

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            view = parseArray(view);

            if (artillery)
            {
                artillery.applyGlobalBattleMacros();
            }

            if (shell)
            {
                shell.applyGlobalBattleMacros();
            }

            // parse "special"
            if (special && special.length)
            {
                var len:int = special.length;
                for (var i:int = 0; i < len; ++i)
                {
                    var items:Object = special[i];
                    for (var key:String in items)
                    {
                        var item:CMinimapCircle = CMinimapCircle.parse(items[key]);
                        item.applyGlobalBattleMacros();
                        items[key] = item;
                    }
                }
            }
        }

        private function parseArray(items:Array):Array
        {
            var a:Array = [];
            if (items && items.length)
            {
                var len:int = items.length;
                for (var i:int = 0; i < len; ++i)
                {
                    var item:CMinimapCircle = CMinimapCircle.parse(items[i]);
                    item.applyGlobalBattleMacros();
                    a.push(item);
                }
            }
            return a;
        }
    }
}
