import net.wargaming.ingame.MinimapEntry;

class com.xvm.events.EMinimapEvent
{
    private var _type:String;
    private var _entry:net.wargaming.ingame.MinimapEntry;
    private var _value:Object;

    public function EMinimapEvent(type:String, entry:net.wargaming.ingame.MinimapEntry, value:Object)
    {
        _type = type;
        _entry = entry;
        _value = value;
    }

    public function get type():String
    {
        return _type;
    }

    public function get entry():net.wargaming.ingame.MinimapEntry
    {
        return _entry;
    }

    public function get value():Object
    {
        return _value;
    }
}
