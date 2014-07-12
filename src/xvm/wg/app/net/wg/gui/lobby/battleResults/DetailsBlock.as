package net.wg.gui.lobby.battleResults
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    
    public class DetailsBlock extends UIComponent
    {
        
        public function DetailsBlock() {
            super();
        }
        
        public var noPremTitleLbl:TextField;
        
        public var premTitleLbl:TextField;
        
        public var creditsTitleLbl:TextField;
        
        public var creditsLbl:TextField;
        
        public var premCreditsLbl:TextField;
        
        public var xpTitleLbl:TextField;
        
        public var xpLbl:TextField;
        
        public var premXpLbl:TextField;
        
        public var resTitleLbl:TextField;
        
        public var resLbl:TextField;
        
        public var premResLbl:TextField;
        
        public var detailedReportBtn:SoundButtonEx;
        
        public var progressTF:TextField;
        
        public var ctreditsTitle:TextField;
        
        private var _data:Object;
        
        private var _dataDirty:Boolean = false;
        
        override protected function onDispose() : void {
            this._data = null;
            this.detailedReportBtn.dispose();
            super.onDispose();
        }
        
        public function get data() : Object {
            return this._data;
        }
        
        public function set data(param1:Object) : void {
            this._data = param1;
            this._dataDirty = true;
            invalidate();
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.noPremTitleLbl.text = BATTLE_RESULTS.COMMON_DETAILS_NOPREMTITLE;
            this.premTitleLbl.text = BATTLE_RESULTS.COMMON_DETAILS_PREMTITLE;
            this.ctreditsTitle.text = BATTLE_RESULTS.COMMON_DETAILS_CREDITSTITLE;
            this.progressTF.text = BATTLE_RESULTS.COMMON_DETAILS_PROGRESS;
        }
        
        override protected function draw() : void {
            super.draw();
            if(this._dataDirty)
            {
                this.noPremTitleLbl.alpha = this.data.isPremium?0.25:1;
                this.premTitleLbl.alpha = this.data.isPremium?0.25:1;
                this.creditsLbl.alpha = this.data.isPremium?0.25:1;
                this.xpLbl.alpha = this.data.isPremium?0.25:1;
                this.premTitleLbl.alpha = this.data.isPremium?1:0.25;
                this.premCreditsLbl.alpha = this.data.isPremium?1:0.25;
                this.premXpLbl.alpha = this.data.isPremium?1:0.25;
                if(this.resTitleLbl)
                {
                    this.resTitleLbl.text = BATTLE_RESULTS.COMMON_DETAILS_RESOURCE;
                    this.resLbl.alpha = this.data.isPremium?0.25:1;
                    this.premResLbl.alpha = this.data.isPremium?1:0.25;
                    this.resLbl.htmlText = this.data.resStr;
                    this.premResLbl.htmlText = this.data.resPremStr;
                }
                this.xpTitleLbl.text = this.data.xpTitleStr;
                this.xpLbl.htmlText = this.data.xpNoPremStr;
                this.premXpLbl.htmlText = this.data.xpPremStr;
                this.creditsLbl.htmlText = this.data.creditsNoPremStr;
                this.premCreditsLbl.htmlText = this.data.creditsPremStr;
                this._dataDirty = false;
            }
        }
    }
}
