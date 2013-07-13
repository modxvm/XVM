/**
 * Label control
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Utils;
import com.xvm.Controls.IControl;
import com.xvm.Controls.ControlBase;

class com.xvm.Controls.Label extends ControlBase
{
    public static function Create(parent:MovieClip, name:String, x:Number, y:Number, w:Number, h:Number, color:Number, alpha:Number,
        fontName:String, fontSize:Number, text:String):Label
    {
        var mc:MovieClip = ControlBase.Create(parent, name, x, y, w, h, 0, 0);
        return new Label(mc, color, alpha, fontName, fontSize, text);
    }

    private var textField:TextField;
    public function get TextField():TextField
    {
        return textField;
    }
    
    private var grid_mc:MovieClip;
    
    public function Label(mc:MovieClip, color:Number, alpha:Number, fontName:String, fontSize:Number, text:String)
    {
        super(mc);

        textField = mc.createTextField("textField", 0, 0, 0, mc.width, mc.height);
        textField.autoSize = true;
        textField.multiline = true;
        textField.wordWrap = true;
        textField.antiAliasType = "advanced";
        textField.html = true;
        textField.selectable = false;
        textField.styleSheet = Utils.createStyleSheet(Utils.createCSS("tf", color, fontName, fontSize));
        textField._alpha = alpha;
        SetText(text);
    }
    
    public function SetText(text:String)
    {
        textField.htmlText = text != null && text != "" ? "<span class='tf'>" + text + "</span>" : "";
    }
}