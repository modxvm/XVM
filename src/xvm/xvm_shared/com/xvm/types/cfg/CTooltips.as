/**
 * XVM Config
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTooltips extends Object implements ICloneable
    {
        public var combineIcons:*;
        public var hideSimplifiedVehParams:*;
        public var hideBottomText:*;
        public var tooltipsDelay:*;
        public var fontSize:*;
        public var fontName:*;
        public var goldColor:*;
        public var lightTank:Array;
        public var mediumTank:Array;
        public var heavyTank:Array;
        public var TD:Array;
        public var SPG:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
