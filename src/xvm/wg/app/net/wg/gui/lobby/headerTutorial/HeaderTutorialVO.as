package net.wg.gui.lobby.headerTutorial
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class HeaderTutorialVO extends DAAPIDataClass
    {
        
        public function HeaderTutorialVO(param1:Object)
        {
            super(param1);
        }
        
        private var _title:String = "";
        
        private var _windowTitle:String = "";
        
        private var _state:String = "";
        
        private var _text:String = "";
        
        public function get title() : String
        {
            return this._title;
        }
        
        public function set title(param1:String) : void
        {
            this._title = param1;
        }
        
        public function get windowTitle() : String
        {
            return this._windowTitle;
        }
        
        public function set windowTitle(param1:String) : void
        {
            this._windowTitle = param1;
        }
        
        public function get state() : String
        {
            return this._state;
        }
        
        public function set state(param1:String) : void
        {
            this._state = param1;
        }
        
        public function get text() : String
        {
            return this._text;
        }
        
        public function set text(param1:String) : void
        {
            this._text = param1;
        }
    }
}
