package net.wg.gui.battle.views.postmortemPanel
{
    import net.wg.infrastructure.base.meta.impl.PostmortemPanelMeta;
    import net.wg.infrastructure.base.meta.IPostmortemPanelMeta;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import flash.text.TextField;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import scaleform.gfx.TextFieldEx;

    public class PostmortemPanel extends PostmortemPanelMeta implements IPostmortemPanelMeta
    {

        public var bg:BattleAtlasSprite = null;

        public var observerModeTitleTF:TextField = null;

        public var observerModeDescTF:TextField = null;

        public var exitToHangarTitleTF:TextField = null;

        public var exitToHangarDescTF:TextField = null;

        public function PostmortemPanel()
        {
            super();
            mouseChildren = false;
            mouseEnabled = false;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.bg.imageName = BATTLEATLAS.POSTMORTEM_TIPS_BG;
            this.observerModeTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_LABEL;
            this.observerModeDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_TEXT;
            this.exitToHangarTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_LABEL;
            this.exitToHangarDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_TEXT;
            TextFieldEx.setVerticalAutoSize(deadReasonTF,TextFieldEx.VALIGN_BOTTOM);
            updatePlayerInfoPosition();
        }

        override protected function onDispose() : void
        {
            this.bg = null;
            this.observerModeTitleTF = null;
            this.observerModeDescTF = null;
            this.exitToHangarTitleTF = null;
            this.exitToHangarDescTF = null;
            super.onDispose();
        }

        public function as_setPlayerInfo(param1:String) : void
        {
            setPlayerInfo(param1);
        }

        public function as_showDeadReason() : void
        {
            showDeadReason();
        }
    }
}
