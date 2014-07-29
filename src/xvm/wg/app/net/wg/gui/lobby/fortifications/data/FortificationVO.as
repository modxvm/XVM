package net.wg.gui.lobby.fortifications.data
{
    import net.wg.gui.lobby.fortifications.data.base.BaseFortificationVO;
    
    public class FortificationVO extends BaseFortificationVO
    {
        
        public function FortificationVO(param1:Object)
        {
            super(param1);
        }
        
        private var _clanIconId:String = "";
        
        private var _clanName:String = "";
        
        private var _defResText:String = "";
        
        private var _levelTitle:String = "";
        
        private var _disabledTransporting:Boolean = false;
        
        public function get defResText() : String
        {
            return this._defResText;
        }
        
        public function set defResText(param1:String) : void
        {
            this._defResText = param1;
        }
        
        public function get levelTitle() : String
        {
            return this._levelTitle;
        }
        
        public function set levelTitle(param1:String) : void
        {
            this._levelTitle = param1;
        }
        
        public function get clanIconId() : String
        {
            return this._clanIconId;
        }
        
        public function set clanIconId(param1:String) : void
        {
            this._clanIconId = param1;
        }
        
        public function get clanName() : String
        {
            return this._clanName;
        }
        
        public function set clanName(param1:String) : void
        {
            this._clanName = param1;
        }
        
        public function get disabledTransporting() : Boolean
        {
            return this._disabledTransporting;
        }
        
        public function set disabledTransporting(param1:Boolean) : void
        {
            this._disabledTransporting = param1;
        }
    }
}
