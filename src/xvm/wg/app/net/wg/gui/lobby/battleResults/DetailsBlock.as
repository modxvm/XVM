package net.wg.gui.lobby.battleResults 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class DetailsBlock extends scaleform.clik.core.UIComponent
    {
        public function DetailsBlock()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            this._data = null;
            this.detailedReportBtn.dispose();
            super.dispose();
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            this._data = arg1;
            this._dataDirty = true;
            invalidate();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.noPremTitleLbl.text = BATTLE_RESULTS.COMMON_DETAILS_NOPREMTITLE;
            this.premTitleLbl.text = BATTLE_RESULTS.COMMON_DETAILS_PREMTITLE;
            this.ctreditsTitle.text = BATTLE_RESULTS.COMMON_DETAILS_CREDITSTITLE;
            this.progressTF.text = BATTLE_RESULTS.COMMON_DETAILS_PROGRESS;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this._dataDirty) 
            {
                this.noPremTitleLbl.alpha = this.data.isPremium ? 0.25 : 1;
                this.premTitleLbl.alpha = this.data.isPremium ? 0.25 : 1;
                this.creditsLbl.alpha = this.data.isPremium ? 0.25 : 1;
                this.xpLbl.alpha = this.data.isPremium ? 0.25 : 1;
                this.premTitleLbl.alpha = this.data.isPremium ? 1 : 0.25;
                this.premCreditsLbl.alpha = this.data.isPremium ? 1 : 0.25;
                this.premXpLbl.alpha = this.data.isPremium ? 1 : 0.25;
                this.xpTitleLbl.text = this.data.xpTitleStr;
                this.xpLbl.htmlText = this.data.xpNoPremStr;
                this.premXpLbl.htmlText = this.data.xpPremStr;
                this.creditsLbl.htmlText = this.data.creditsNoPremStr;
                this.premCreditsLbl.htmlText = this.data.creditsPremStr;
                this._dataDirty = false;
            }
            return;
        }

        public var noPremTitleLbl:flash.text.TextField;

        public var premTitleLbl:flash.text.TextField;

        public var creditsTitleLbl:flash.text.TextField;

        public var creditsLbl:flash.text.TextField;

        public var premCreditsLbl:flash.text.TextField;

        public var xpTitleLbl:flash.text.TextField;

        public var xpLbl:flash.text.TextField;

        public var premXpLbl:flash.text.TextField;

        public var detailedReportBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var progressTF:flash.text.TextField;

        public var ctreditsTitle:flash.text.TextField;

        internal var _data:Object;

        internal var _dataDirty:Boolean=false;
    }
}
