/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHitlog implements ICloneable
    {
        public var groupHitsByPlayer:*;
        public var insertOrder:String;
        public var deadMarker:String;
        public var blowupMarker:String;
        public var defaultHeader:String;
        public var formatHeader:String;
        public var formatHistory:String;

        public function clone():*
        {
            var result:CHitlog = new CHitlog();
            result.groupHitsByPlayer = groupHitsByPlayer;
            result.insertOrder = insertOrder;
            result.deadMarker = deadMarker;
            result.blowupMarker = blowupMarker;
            result.defaultHeader = defaultHeader;
            result.formatHeader = formatHeader;
            result.formatHistory = formatHistory;
            return result;
        }
    }
}
