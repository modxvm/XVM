/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanelMode extends Object implements ICloneable
    {
        public var enabled:*;
        public var standardFields:Array;
        public var expandAreaWidth:*;
        public var removeSquadIcon:*;
        public var vehicleLevelAlpha:*;
        public var fragsWidth:*;
        public var fragsFormatLeft:String;
        public var fragsFormatRight:String;
        public var nickMinWidth:*;
        public var nickMaxWidth:*;
        public var nickFormatLeft:String;
        public var nickFormatRight:String;
        public var vehicleWidth:*;
        public var vehicleFormatLeft:String;
        public var vehicleFormatRight:String;
        public var extraFieldsLeft:Array;
        public var extraFieldsRight:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
