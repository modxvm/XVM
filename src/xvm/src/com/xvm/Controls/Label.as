/**
 * Label control
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import gfx.core.UIComponent;
import com.xvm.Logger;
import com.xvm.Utils;
import com.xvm.Controls.IControl;
import com.xvm.Controls.ControlBase;

class com.xvm.Controls.Label extends ControlBase
{
    /////////////////////////////////////////////////////////////////
    // CLASS REGISTRATION
    
    private static var CLASS_NAME = "__Packages.com.xvm.Controls.Label";
    private static var CLASS_LINKED = Object.registerClass(CLASS_NAME, Label);

    /////////////////////////////////////////////////////////////////
    // PUBLIC STATIC
    
    public static function Create(context:MovieClip, name:String, x:Number, y:Number, w:Number, h:Number, color:Number, alpha:Number,
        fontName:String, fontSize:Number, text:String, multiline:Boolean, align:String):Label
    {
        return UIComponent.createInstance(context, CLASS_NAME, name, context.getNextHighestDepth(),
        {
            _x: x,
            _y: y,
            __width: w,
            __height: h,
            _color: color,
            __alpha: alpha,
            fontName: fontName,
            fontSize: fontSize,
            text: text,
            multiline: multiline || false,
            align: align || "left"
        });
    }

    /////////////////////////////////////////////////////////////////
    // PUBLIC PROPERTIES

    private var _textField:TextField;
    public function get textField():TextField
    {
        return textField;
    }

    private var _fontSize:Number;
    public function get fontSize():Number
    {
        return _fontSize;
    }

    public function set fontSize(value:Number)
    {
        _fontSize = value;
        invalidate();
    }

    private var _text:String;
    public function get text():String
    {
        return _text;
    }

    public function set text(value:String)
    {
        value = value != null && value != "" ? "<span class='tf'>" + value + "</span>" : "";
        if (_text == value)
            return;
        _text = value;
        invalidate();
    }
    
    /////////////////////////////////////////////////////////////////
    // PRIVATE VARS

    private var fontName:String;
    private var multiline:Boolean;
    private var align:Boolean;

    /////////////////////////////////////////////////////////////////
    // OVERRIDES

    // override
    public function configUI()
    {
        //Logger.add("Label.configUI()");

        super.configUI();

        if (textField == null)
        {
            textField = createTextField("textField", 0, 0, 0, width, height);
            textField.autoSize = align;
            textField.multiline = multiline;
            textField.wordWrap = multiline;
            textField.antiAliasType = "advanced";
            textField.html = true;
            textField.selectable = false;
            textField.styleSheet = Utils.createStyleSheet(Utils.createCSS("tf", color, fontName, fontSize));
            textField._alpha = alpha;
        }
    }

    // override
    public function setSize(width:Number, height:Number)
    {
        super.setSize(width, height);
        
        textField._width = width;
        textField._height = height;
    }

    // override
    public function draw()
    {
        textField.htmlText = text;
    }
}
