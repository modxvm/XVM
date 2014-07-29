package net.wg.gui.lobby.GUIEditor.events
{
    import flash.events.Event;
    import flash.display.DisplayObject;
    
    public class InspectorViewEvent extends Event
    {
        
        public function InspectorViewEvent(param1:String, param2:DisplayObject, param3:Boolean = true, param4:Boolean = false)
        {
            super(param1,param3,param4);
            this.selectedElement = param2;
        }
        
        public static var ELEMENT_SELECTED:String = "elementSelected";
        
        public var selectedElement:DisplayObject = null;
    }
}
