import flash.geom.Point;

class wot.Minimap.dataTypes.Icon
{
    public var uid:Number;
    public var pos:Point;
    public var vehicleClass:String;

    public function Icon(uid, x, y, vehicleClass)
    {
        this.uid = uid;
        pos = new Point(x, y);
        this.vehicleClass = vehicleClass;
    }
}
