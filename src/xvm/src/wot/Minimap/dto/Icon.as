import flash.geom.Point;

class wot.Minimap.dto.Icon
{
    public var uid:Number;
    public var pos:Point;

    public function Icon(uid, x, y)
    {
        this.uid = uid;
        pos = new Point(x, y);
    }
}
