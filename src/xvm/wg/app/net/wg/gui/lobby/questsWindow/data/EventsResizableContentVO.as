package net.wg.gui.lobby.questsWindow.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class EventsResizableContentVO extends DAAPIDataClass
    {
        
        public function EventsResizableContentVO(param1:Object)
        {
            this._containerElements = [];
            super(param1);
        }
        
        private var _containerElements:Array;
        
        private var _headerTitle:String = "";
        
        private var _headerHtmlPart:String = "";
        
        private var _headerProgress:Object = null;
        
        private var _isResizable:Boolean = true;
        
        private var _isOpened:Boolean = false;
        
        private var _tablePadding:int = 0;
        
        private var _linkage:String = "";
        
        private var _showDone:Boolean = false;
        
        public function get headerTitle() : String
        {
            return this._headerTitle;
        }
        
        public function set headerTitle(param1:String) : void
        {
            this._headerTitle = param1;
        }
        
        public function get isOpened() : Boolean
        {
            return this._isOpened;
        }
        
        public function set isOpened(param1:Boolean) : void
        {
            this._isOpened = param1;
        }
        
        public function get containerElements() : Array
        {
            return this._containerElements;
        }
        
        public function set containerElements(param1:Array) : void
        {
            this._containerElements = param1;
        }
        
        public function get headerHtmlPart() : String
        {
            return this._headerHtmlPart;
        }
        
        public function set headerHtmlPart(param1:String) : void
        {
            this._headerHtmlPart = param1;
        }
        
        public function get headerProgress() : Object
        {
            return this._headerProgress;
        }
        
        public function set headerProgress(param1:Object) : void
        {
            this._headerProgress = param1;
        }
        
        public function get isResizable() : Boolean
        {
            return this._isResizable;
        }
        
        public function set isResizable(param1:Boolean) : void
        {
            this._isResizable = param1;
        }
        
        public function get tablePadding() : int
        {
            return this._tablePadding;
        }
        
        public function set tablePadding(param1:int) : void
        {
            this._tablePadding = param1;
        }
        
        public function get linkage() : String
        {
            return this._linkage;
        }
        
        public function set linkage(param1:String) : void
        {
            this._linkage = param1;
        }
        
        public function get showDone() : Boolean
        {
            return this._showDone;
        }
        
        public function set showDone(param1:Boolean) : void
        {
            this._showDone = param1;
        }
    }
}
