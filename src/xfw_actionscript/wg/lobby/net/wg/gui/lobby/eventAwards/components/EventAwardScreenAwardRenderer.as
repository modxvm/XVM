package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.gui.lobby.components.AwardItemRendererEx;
    import net.wg.infrastructure.interfaces.IImage;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventAwardScreenAwardRenderer extends AwardItemRendererEx
    {

        public var level:IImage;

        public function EventAwardScreenAwardRenderer()
        {
            super();
        }

        override protected function adjustSize() : void
        {
            if(_hasSize)
            {
                img.x = _rendererWidth - img.width >> 1;
                img.y = _rendererHeight - img.height >> 1;
                highlight.x = overlay.x = EFFECTS_OFFSET_X;
                highlight.y = overlay.y = EFFECTS_OFFSET_Y;
                highlight.alpha = 0;
                starIcon.x = width - starIcon.width + ICONS_OFFSET ^ 0;
                awardObtainedIcon.x = _rendererWidth - awardObtainedIcon.width >> 1;
                awardObtainedIcon.y = _rendererHeight - (awardObtainedIcon.height >> 1) + _data.obtainedImageOffset ^ 0;
            }
            else
            {
                awardObtainedIcon.x = img.x + (img.width - awardObtainedIcon.width >> 1);
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(_data != null && isInvalid(InvalidationType.DATA))
            {
                if(StringUtils.isNotEmpty(_data.levelIcon))
                {
                    this.level.source = _data.levelIcon;
                }
            }
        }

        override protected function onDispose() : void
        {
            this.level.dispose();
            this.level = null;
            super.onDispose();
        }
    }
}
