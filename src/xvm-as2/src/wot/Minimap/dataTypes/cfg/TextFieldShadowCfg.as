class wot.Minimap.dataTypes.cfg.TextFieldShadowCfg
{
    public var enabled:Boolean;
    public var color;
    public var distance;
    public var angle;
    public var alpha;
    public var blur;
    public var strength;

    public function TextFieldShadowCfg(obj:TextFieldShadowCfg)
    {
        enabled = obj.enabled;
        color = obj.color;
        distance = obj.distance;
        angle = obj.angle;
        alpha = obj.alpha;
        blur = obj.blur;
        strength = obj.strength;
    }
}
