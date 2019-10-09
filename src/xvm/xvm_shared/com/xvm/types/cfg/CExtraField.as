/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CExtraField implements ICloneable
    {
        public var align:String;
        public var alpha:*;
        public var antiAliasType:String;
        public var bgColor:String;
        public var bindToIcon:*;
        public var borderColor:String;
        public var enabled:*;
        public var flags:Array;
        public var format:String;
        public var height:*;
        public var highlight:*;
        public var hotKeyCode:*;
        public var layer:String;
        public var mouseEvents:CMouseEvents;
        public var onHold:*;
        public var rotation:*;
        public var scaleX:*;
        public var scaleY:*;
        public var screenHAlign:String;
        public var screenVAlign:String;
        public var shadow:CShadow;
        public var src:String;
        public var textFormat:CTextFormat;
        public var tweens:Array;
        public var tweensIn:Array;
        public var tweensOut:Array;
        public var updateEvent:String;
        public var valign:String;
        public var visibleOnHotKey:*;
        public var width:*;
        public var x:*;
        public var y:*;

        public function clone():*
        {
            var cloned:CExtraField = new CExtraField();
            cloned.align = align;
            cloned.alpha = alpha;
            cloned.antiAliasType = antiAliasType;
            cloned.bgColor = bgColor;
            cloned.bindToIcon = bindToIcon;
            cloned.borderColor = borderColor;
            cloned.enabled = enabled;
            cloned.flags = flags ? flags.concat() : null;
            cloned.format = format;
            cloned.height = height;
            cloned.highlight = highlight;
            cloned.hotKeyCode = hotKeyCode;
            cloned.layer = layer;
            cloned.mouseEvents = mouseEvents ? mouseEvents.clone() : null;
            cloned.onHold = onHold;
            cloned.rotation = rotation;
            cloned.scaleX = scaleX;
            cloned.scaleY = scaleY;
            cloned.screenHAlign = screenHAlign;
            cloned.screenVAlign = screenVAlign;
            cloned.shadow = shadow ? shadow.clone() : null;
            cloned.src = src;
            cloned.textFormat = textFormat ? textFormat.clone() : null;
            cloned.tweens = tweens ? tweens.concat() : null;
            cloned.tweensIn = tweensIn ? tweensIn.concat() : null;
            cloned.tweensOut = tweensOut ? tweensOut.concat() : null;
            cloned.updateEvent = updateEvent;
            cloned.valign = valign;
            cloned.visibleOnHotKey = visibleOnHotKey;
            cloned.width = width;
            cloned.x = x;
            cloned.y = y;
            return cloned;
        }
    }
}
