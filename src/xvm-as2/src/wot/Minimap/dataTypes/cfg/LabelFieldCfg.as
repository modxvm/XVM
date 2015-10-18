import wot.Minimap.dataTypes.cfg.TextFieldShadowCfg;

class wot.Minimap.dataTypes.cfg.LabelFieldCfg
{
    public var flags:Array;
    public var format:String;
    public var shadow:TextFieldShadowCfg;
    public var alpha;
    public var x;
    public var y;
    public var width;
    public var height;
    public var align:String;
    public var valign:String;
    public var antiAliasType:String;
    public var bgColor;
    public var borderColor;

    public function LabelFieldCfg(obj:LabelFieldCfg)
    {
        flags = obj.flags;
        format = obj.format;
        shadow = new TextFieldShadowCfg(obj.shadow);
        alpha = obj.alpha;
        x = obj.x;
        y = obj.y;
        width = obj.width;
        height = obj.height;
        align = obj.align;
        valign = obj.valign;
        antiAliasType = obj.antiAliasType;
        bgColor = obj.bgColor;
        borderColor = obj.borderColor;
    }
}
