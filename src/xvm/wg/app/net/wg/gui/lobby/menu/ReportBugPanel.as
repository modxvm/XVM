package net.wg.gui.lobby.menu
{
    import net.wg.infrastructure.base.meta.impl.ReportBugPanelMeta;
    import net.wg.infrastructure.base.meta.IReportBugPanelMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.events.TextEvent;
    
    public class ReportBugPanel extends ReportBugPanelMeta implements IReportBugPanelMeta
    {
        
        public function ReportBugPanel()
        {
            super();
            visible = false;
            tabEnabled = false;
            tabChildren = false;
        }
        
        public var reportBugLink:TextField;
        
        public var background:UILoaderAlt;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.background.source = RES_ICONS.MAPS_ICONS_LOBBY_REPORT_BUG_BACKGROUND;
            App.utils.styleSheetManager.setLinkStyle(this.reportBugLink);
            this.reportBugLink.addEventListener(TextEvent.LINK,this.onReportBugLinkClick);
        }
        
        override protected function onDispose() : void
        {
            this.reportBugLink.removeEventListener(TextEvent.LINK,this.onReportBugLinkClick);
            this.reportBugLink.styleSheet = null;
            this.reportBugLink = null;
            this.background.dispose();
            this.background = null;
            super.onDispose();
        }
        
        public function as_setHyperLink(param1:String) : void
        {
            this.reportBugLink.htmlText = param1;
            visible = true;
        }
        
        private function onReportBugLinkClick(param1:TextEvent) : void
        {
            reportBugS();
        }
    }
}
