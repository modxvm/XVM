import com.xvm.Components.PingServers.PingFieldBuilder;

/**
 * Manages many columns - TextFields.
 * Returns to view one field for update.
 * 
 * Each column can consist of many rows.
 * Row example: "RU1: 15"
 */
class com.xvm.Components.PingServers.PingFieldProxy
{
    private var cfg:Object;
    private var builder:PingFieldBuilder;
    private var fields:Array = [];
    
    public function PingFieldProxy(cfg:Object, holder:MovieClip) 
    {
        this.cfg = cfg;
        builder = new PingFieldBuilder(cfg, holder);
    }
    
    /**
     * Defines which field is appropriate for data apeend.
     * If there is no such field then create one.
     */
    public function getReceiverField():TextField
    {
        var firstNotFullField:TextField = getFirstNotFullField();
        if (firstNotFullField)
        {
            return firstNotFullField;
        }
        return createNewField();
    }
    
    /**
     * Align colums so they do not overlap each other.
     */
    public function alignFields():Void
    {
        for (var i:Number = 1; i < fields.length; i++)
        {
            var currentField:TextField = fields[i];
            var prevField:TextField = fields[i - 1];
            currentField._x = prevField._x + prevField._width + cfg.columnGap;
        }
    }
    
    /**
     * Each update data is obsolete.
     * Content is erased, but empty fields remain.
     */
    public function clearAllFields():Void
    {
        for (var i in fields)
        {
            var tf:TextField = fields[i];
            tf.htmlText = "";
        }
    }
    
    // -- Private
    
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
    
    private function createNewField():TextField
    {
        var newFieldNum:Number = fields.length + 1;
        var newField:TextField = builder.createField(newFieldNum);
        fields.push(newField);
        return fields[fields.length - 1];
    }
}
