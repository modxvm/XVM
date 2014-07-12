package net.wg.gui.lobby.messengerBar.carousel.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ChannelListItemVO extends DAAPIDataClass
    {
        
        public function ChannelListItemVO(param1:Object) {
            super(param1);
        }
        
        private static var excluded:Array;
        
        private var _clientID:Number = 0;
        
        private var _label:String = "";
        
        private var _canClose:Boolean = false;
        
        private var _isNotified:Boolean = false;
        
        private var _icon:String = "";
        
        private var _isInProgress:Boolean = false;
        
        public function get clientID() : Number {
            return this._clientID;
        }
        
        public function set clientID(param1:Number) : void {
            this._clientID = param1;
        }
        
        public function get label() : String {
            return this._label;
        }
        
        public function set label(param1:String) : void {
            this._label = param1;
        }
        
        public function get canClose() : Boolean {
            return this._canClose;
        }
        
        public function set canClose(param1:Boolean) : void {
            this._canClose = param1;
        }
        
        public function get isNotified() : Boolean {
            return this._isNotified;
        }
        
        public function set isNotified(param1:Boolean) : void {
            this._isNotified = param1;
        }
        
        public function get icon() : String {
            return this._icon;
        }
        
        public function set icon(param1:String) : void {
            this._icon = param1;
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean {
            if(excluded.indexOf(param1) > -1)
            {
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        public function get isInProgress() : Boolean {
            return this._isInProgress;
        }
        
        public function set isInProgress(param1:Boolean) : void {
            this._isInProgress = param1;
        }
    }
}
