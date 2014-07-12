package net.wg.gui.components.controls
{
    import scaleform.clik.controls.ListItemRenderer;
    import net.wg.infrastructure.interfaces.ITextContainer;
    import flash.text.TextFormat;
    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldAutoSize;
    
    public class TextFieldShort extends ListItemRenderer implements ITextContainer
    {
        
        public function TextFieldShort() {
            this.shadowColorList = {
                "White":{
                    "color":16777215,
                    "strange":0.4,
                    "quality":3,
                    "angle":90
                },
            "Black":{
                "color":0,
                "strange":1,
                "quality":2,
                "angle":270
            }
    };
super();
this._textFormat = textField.getTextFormat();
}

private var _textFormat:TextFormat;

private var _textFont:String;

private var _useHtml:Boolean;

private var _textSize:Number = 12;

private var _textAlign:String;

private var _textColor:Number = 16777215;

private var _shadowColor:String = "Black";

private var _showToolTip:Boolean = true;

private var shadowColorList:Object;

protected var _toolTip:String = "";

private var _altToolTip:String = "";

private var widthAtStart:Number = 0;

override protected function initialize() : void {
super.initialize();
this.widthAtStart = _width;
}

public function get showToolTip() : Boolean {
return this._showToolTip;
}

public function set showToolTip(param1:Boolean) : void {
this._showToolTip = param1;
}

override protected function configUI() : void {
super.configUI();
}

override protected function onDispose() : void {
super.onDispose();
}

override protected function handleMouseRollOver(param1:MouseEvent) : void {
super.handleMouseRollOver(param1);
if(this._showToolTip)
{
    if(this._altToolTip)
    {
        App.toolTipMgr.show(this._altToolTip);
    }
    else if(this._toolTip)
    {
        App.toolTipMgr.show(this._toolTip);
    }
    
}
}

override protected function handleMouseRollOut(param1:MouseEvent) : void {
super.handleMouseRollOut(param1);
App.toolTipMgr.hide();
}

override protected function draw() : void {
var _loc1_:DropShadowFilter = null;
var _loc2_:* = NaN;
super.draw();
if((textField) && (InvalidationType.DATA))
{
    textField.wordWrap = true;
    textField.selectable = false;
    if(autoSize != TextFieldAutoSize.NONE)
    {
        if(!preventAutosizing)
        {
            _width = this.widthAtStart;
            setActualSize(_width,_height);
        }
        if(!constraintsDisabled)
        {
            if(constraints)
            {
                constraints.update(_width,_height);
            }
        }
    }
    textField.text = _label;
    this._textFormat.size = this._textSize;
    this._textFormat.font = this._textFont;
    this._textFormat.align = this._textAlign;
    textField.setTextFormat(this._textFormat);
    if(textField.getLineLength(0) < textField.text.length)
    {
        _loc2_ = textField.getLineLength(0);
        if(_loc2_ < 3)
        {
            _loc2_ = textField.getLineLength(1);
        }
        textField.text = textField.text.substring(0,_loc2_ - 2) + "..";
        textField.setTextFormat(this._textFormat);
    }
    textField.textColor = this._textColor;
    _loc1_ = this.getDropShadowFilter(this._shadowColor);
    textField.filters = [_loc1_];
    this._toolTip = _label;
    if(autoSize != TextFieldAutoSize.NONE)
    {
        if(!preventAutosizing)
        {
            alignForAutoSize();
            setActualSize(_width,_height);
        }
        if(!constraintsDisabled)
        {
            if(constraints)
            {
                constraints.update(_width,_height);
            }
        }
    }
}
}

private function getDropShadowFilter(param1:String) : DropShadowFilter {
var _loc2_:DropShadowFilter = new DropShadowFilter();
_loc2_.color = this.shadowColorList[param1].color;
_loc2_.angle = this.shadowColorList[param1].angle;
_loc2_.alpha = 1;
_loc2_.blurX = 0;
_loc2_.blurY = 0;
_loc2_.distance = 1;
_loc2_.strength = this.shadowColorList[param1].strange;
_loc2_.inner = false;
_loc2_.knockout = false;
_loc2_.quality = int(this.shadowColorList[param1].quality);
return _loc2_;
}

public function get textFont() : String {
return this._textFont;
}

public function set textFont(param1:String) : void {
if(this._textFont == param1)
{
    return;
}
this._textFont = param1;
invalidateData();
}

public function get useHtml() : Boolean {
return this._useHtml;
}

public function set useHtml(param1:Boolean) : void {
if(this._useHtml == param1)
{
    return;
}
this._useHtml = param1;
invalidateData();
}

public function get textSize() : Number {
return this._textSize;
}

public function set textSize(param1:Number) : void {
if(this._textSize == param1)
{
    return;
}
this._textSize = param1;
invalidateData();
}

public function get textAlign() : String {
return this._textAlign;
}

public function set textAlign(param1:String) : void {
if(this._textAlign == param1)
{
    return;
}
this._textAlign = param1;
invalidateData();
}

public function get textColor() : Number {
return this._textColor;
}

public function set textColor(param1:Number) : void {
if(this._textColor == param1)
{
    return;
}
this._textColor = param1;
invalidateData();
}

public function get shadowColor() : String {
return this._shadowColor;
}

public function set shadowColor(param1:String) : void {
if(this._shadowColor == param1)
{
    return;
}
this._shadowColor = param1;
invalidateData();
}

public function get toolTip() : String {
return this._toolTip;
}

public function set toolTip(param1:String) : void {
if(this._toolTip == param1)
{
    return;
}
this._toolTip = App.utils.locale.makeString(param1);
}

public function get altToolTip() : String {
return this._altToolTip;
}

public function set altToolTip(param1:String) : void {
if(this._altToolTip == param1)
{
    return;
}
this._altToolTip = App.utils.locale.makeString(param1);
}

override public function toString() : String {
return "[WG TextFieldShort " + name;
}
}
}
