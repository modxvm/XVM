package net.wg.gui.lobby.personalMissions.components.popupComponents
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.personalMissions.data.IconTextRendererVO;

    public class IconTextRenderer extends MovieClip implements IDisposable
    {

        public var labelTf:TextField;

        public var icon:UILoaderAlt;

        public function IconTextRenderer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.labelTf = null;
            this.icon.dispose();
            this.icon = null;
        }

        public function setData(param1:IconTextRendererVO) : void
        {
            this.icon.source = param1.icon;
            this.labelTf.text = param1.label;
        }
    }
}
