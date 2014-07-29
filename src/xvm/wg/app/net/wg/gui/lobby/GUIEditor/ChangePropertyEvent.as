package net.wg.gui.lobby.GUIEditor
{
    import flash.events.Event;
    import net.wg.gui.lobby.GUIEditor.data.ComponentPropertyVO;
    
    public class ChangePropertyEvent extends Event
    {
        
        public function ChangePropertyEvent(param1:String, param2:ComponentPropertyVO, param3:*)
        {
            super(param1,true,true);
            this._property = param2;
            this._newValue = param3;
        }
        
        public static var CHANGE_PROPERTY:String = "onChangeProperty";
        
        private var _property:ComponentPropertyVO = null;
        
        private var _newValue;
        
        public function get property() : ComponentPropertyVO
        {
            return this._property;
        }
        
        public function get newValue() : *
        {
            return this._newValue;
        }
    }
}
