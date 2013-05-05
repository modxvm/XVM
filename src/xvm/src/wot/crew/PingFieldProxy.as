import com.xvm.Logger;
import wot.crew.PingFieldBuilder;

class wot.crew.PingFieldProxy
{
    private var cfg:Object;
    private var builder:PingFieldBuilder;
    private var fields:Array = [];
    
    public function PingFieldProxy(cfg:Object) 
    {
        this.cfg = cfg;
        builder = new PingFieldBuilder(cfg);
    }
    
    public function getReceiverField():TextField
    {
        var firstNotFullField:TextField = getFirstNotFullField();
        if (firstNotFullField)
        {
            return firstNotFullField;
        }
        return createNewField();
    }
    
    private function getFirstNotFullField()
    {
        for (var i:Number = 0; i < fields.length; i++)
        {
            var field:TextField = fields[i];
            if (field.htmlText == "" || field.bottomScroll < cfg.maxRows)
            {
                return field;
            }
        }
        
        return null;
    }
    
    public function alignFields():Void
    {
        for (var i:Number = 1; i < fields.length; i++)
        {
            var currentField:TextField = fields[i];
            var prevField:TextField = fields[i - 1];
            currentField._x = prevField._x + prevField._width + cfg.columnGap;
        }
    }
    
    public function clearAllFields():Void
    {
        for (var i in fields)
        {
            var tf:TextField = fields[i];
            tf.htmlText = "";
        }
    }
    
    // -- Private
    
    private function createNewField():TextField
    {
        var newFieldNum:Number = fields.length + 1;
        var newField:TextField = builder.createField(newFieldNum);
        fields.push(newField);
        return fields[fields.length - 1];
    }
}
