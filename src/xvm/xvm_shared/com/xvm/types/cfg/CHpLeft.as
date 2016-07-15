package com.xvm.types.cfg {
import com.xfw.ICloneable;

public class CHpLeft implements ICloneable {

    public var enabled : Boolean;
    public var header : String;
    public var format : String;


    public function clone():* {
        var result : CHpLeft = new CHpLeft();
        result.enabled = enabled;
        result.header = header;
        result.format = format;

        return result;
    }

    public function toString():String {
        return "CHpLeft string representation: enabled " + enabled + ", header " + header + ", format " + format;
    }
}
}
