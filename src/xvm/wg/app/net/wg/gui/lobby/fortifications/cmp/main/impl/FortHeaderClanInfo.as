package net.wg.gui.lobby.fortifications.cmp.main.impl
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.fortifications.cmp.main.IFortHeaderClanInfo;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.ClanEmblem;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.data.FortificationVO;
    import flash.text.TextFieldAutoSize;
    
    public class FortHeaderClanInfo extends UIComponentEx implements IFortHeaderClanInfo
    {
        
        public function FortHeaderClanInfo()
        {
            super();
            this.toolTipArea.addEventListener(MouseEvent.ROLL_OVER,onRollOverHandler);
            this.toolTipArea.addEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
        }
        
        private static function onRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showSpecial(Tooltips.CLAN_INFO,null,null);
        }
        
        private static function onRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var levelText:TextField = null;
        
        public var clanName:TextField = null;
        
        public var clanEmblem:ClanEmblem = null;
        
        public var toolTipArea:MovieClip = null;
        
        public function applyClanData(param1:FortificationVO) : void
        {
            this.clanName.htmlText = param1.clanName;
            this.clanEmblem.setImage(param1.clanIconId);
            this.levelText.text = param1.levelTitle;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.clanName.autoSize = TextFieldAutoSize.LEFT;
        }
        
        override protected function onDispose() : void
        {
            this.levelText = null;
            this.toolTipArea.removeEventListener(MouseEvent.ROLL_OVER,onRollOverHandler);
            this.toolTipArea.removeEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
            this.toolTipArea = null;
            this.clanName = null;
            this.clanEmblem.dispose();
            this.clanEmblem = null;
            super.onDispose();
        }
    }
}
