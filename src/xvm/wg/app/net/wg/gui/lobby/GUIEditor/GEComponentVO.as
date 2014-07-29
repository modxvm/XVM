package net.wg.gui.lobby.GUIEditor
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import flash.display.DisplayObject;
    
    public class GEComponentVO extends DAAPIDataClass
    {
        
        public function GEComponentVO(param1:Object)
        {
            super(param1);
        }
        
        public var label:String = "";
        
        public var icon:String = "";
        
        public var instance:DisplayObject = null;
    }
}
