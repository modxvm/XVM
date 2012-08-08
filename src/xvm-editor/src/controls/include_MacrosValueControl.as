private var _allowedMacros:Array = [];
[Bindable]
public function get allowedMacros():Array
{
    return _allowedMacros;
}
public function set allowedMacros(v:Array):void
{
    _allowedMacros = v;
    allowedValues = [];
    menuData = [];
    for each (var a:Object in v)
    {
        allowedValues.push(a.value);
        menuData.push(a);
    }
}

private var _allowedValues:Array = [];
[Bindable]
public function get allowedValues():Array
{
    return _allowedValues;
}
private function set allowedValues(v:Array):void
{
    _allowedValues = v;
}

private var _menuData:Array = [];
[Bindable]
public function get menuData():Array
{
    return _menuData;
}
public function set menuData(v:Array):void
{
    _menuData = v;
}

public function getLabel(item:Object):String
{
    return resourceManager.getString('components', item.label);
}
