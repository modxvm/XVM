package net.wg.gui.battle.views.staticMarkers.epic.sectorWarning
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import flash.text.TextField;

    public class SectorWarningMarker extends Sprite implements IDisposable
    {

        public var marker:MovieClip = null;

        public var txtLabel:TextField = null;

        public function SectorWarningMarker()
        {
            super();
            this.marker.visible = true;
            this.txtLabel.visible = false;
        }

        public function clearCountdown() : void
        {
            this.txtLabel.visible = false;
        }

        public final function dispose() : void
        {
            this.marker = null;
            this.txtLabel = null;
        }

        public function setCountdown(param1:String) : void
        {
            if(!this.txtLabel.visible)
            {
                this.txtLabel.visible = true;
            }
            this.txtLabel.text = param1;
        }

        public function showWarning(param1:String) : void
        {
            this.marker.gotoAndStop(param1);
        }
    }
}
