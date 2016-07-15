/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public class CHitlog implements ICloneable
    {
        public var enabled : Boolean;
        public var hpLeft : CHpLeft;
        public var x : Number;
        public var y : Number;
        public var w : Number;
        public var h : Number;
        public var lines : Number;
        public var direction : String;
        public var groupHitsByPlayer : Boolean;
        public var insertOrder : String;
        public var deadMarker : String;
        public var blowupMarker : String;
        public var defaultHeader : String;
        public var formatHeader : String;
        public var formatHistory : String;
        public var shadow : CShadow;

        public function clone():*
        {
            var result : CHitlog = new CHitlog();
            result.enabled = enabled;
            result.hpLeft = hpLeft.clone();
            result.x = x;
            result.y = y;
            result.w = w;
            result.h = h;
            result.lines = lines;
            result.direction = direction;
            result.groupHitsByPlayer = groupHitsByPlayer;
            result.insertOrder = insertOrder;
            result.deadMarker = deadMarker;
            result.blowupMarker = blowupMarker;
            result.defaultHeader = defaultHeader;
            result.formatHeader = formatHeader;
            result.formatHistory = formatHistory;
            result.shadow = shadow.clone();

            return result;
        }

        public function toString():String {
            return "CHitlog string representation: enabled " + enabled + ", hpLeft " + hpLeft + ", x " + x + ", y " + y + ", w " + w + ", h " +
                    h + ", lines " + lines + ", direction " + direction + ", groupHitsByPlayer " + groupHitsByPlayer + ", insertOrder " + insertOrder + ", deadMarker " + deadMarker + ", blowupMarker " +
                    blowupMarker + ", defaultHeader " + defaultHeader + ", formatHeader " + formatHeader + ", formatHistory " + formatHistory + ", shadow " + shadow;
        }
    }
}
