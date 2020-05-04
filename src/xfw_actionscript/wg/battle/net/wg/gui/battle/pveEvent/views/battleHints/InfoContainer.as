package net.wg.gui.battle.pveEvent.views.battleHints
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.battle.pveEvent.views.battleHints.data.HintInfoVO;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.bootcamp.battleTopHint.constants.HINT_LABELS;

    public class InfoContainer extends MovieClip implements IDisposable
    {

        private static const DEFAULT_COLOR:uint = 16777215;

        public var txtMessage:TextContainer = null;

        public var icon:Image = null;

        public function InfoContainer()
        {
            super();
        }

        public function showHint(param1:String, param2:HintInfoVO) : void
        {
            if(StringUtils.isNotEmpty(param2.iconSource))
            {
                this.icon.source = param2.iconSource;
                this.icon.visible = true;
            }
            else
            {
                this.icon.visible = false;
            }
            this.txtMessage.setText(param2.message,DEFAULT_COLOR);
            gotoAndPlay(HINT_LABELS.SHOW_LABEL);
        }

        public function hideHint() : void
        {
            gotoAndPlay(HINT_LABELS.OUT_SHOW_LABEL);
        }

        public function closeHint() : void
        {
            gotoAndStop(1);
        }

        public function dispose() : void
        {
            this.txtMessage.dispose();
            this.txtMessage = null;
            this.icon.dispose();
            this.icon = null;
        }
    }
}
