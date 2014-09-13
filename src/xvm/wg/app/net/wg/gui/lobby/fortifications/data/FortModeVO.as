package net.wg.gui.lobby.fortifications.data
{
    public class FortModeVO extends Object
    {
        
        public function FortModeVO()
        {
            super();
        }
        
        private var _isEntering:Boolean = false;
        
        private var _isTutorial:Boolean = false;
        
        private var _currentMode:Number = 4;
        
        public function get isEntering() : Boolean
        {
            return this._isEntering;
        }
        
        public function set isEntering(param1:Boolean) : void
        {
            this._isEntering = param1;
        }
        
        public function get isTutorial() : Boolean
        {
            return this._isTutorial;
        }
        
        public function set isTutorial(param1:Boolean) : void
        {
            this._isTutorial = param1;
        }
        
        public function get currentMode() : Number
        {
            return this._currentMode;
        }
        
        public function set currentMode(param1:Number) : void
        {
            this._currentMode = param1;
        }
    }
}
