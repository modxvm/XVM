package net.wg.gui.battle.views.staticMarkers.epic.sectorbase
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import flash.text.TextField;

    public class SectorBaseMarker extends Sprite implements IDisposable
    {

        private static const SELECTED_STATE:String = "selected";

        private static const UNSELECTED_STATE:String = "unselected";

        private static const ACTIVE_ICON_SCALE:Number = 0.75;

        private static const INACTIVE_ICON_SCALE:Number = 0.7;

        private static const INACTIVE_ALPHA_VALUE:Number = 0.75;

        private static const ACTIVE_Y_OFFSET:Number = 50;

        public const markerType:String = "base";

        public var marker:SectorBaseIcon = null;

        public var arrow:MovieClip = null;

        public var txtLabel:TextField = null;

        private var _alphaVal:Number = 1;

        public function SectorBaseMarker()
        {
            super();
            this.marker.visible = true;
            this.marker.targetHighlight.visible = false;
            this.arrow.visible = false;
            this.txtLabel.visible = true;
        }

        public final function dispose() : void
        {
            this.marker.dispose();
            this.marker = null;
            this.arrow = null;
            this.txtLabel = null;
        }

        public function notifyVehicleInCircle(param1:Boolean) : void
        {
            if(param1)
            {
                this.alpha = 0;
            }
            else
            {
                this.alpha = this._alphaVal;
            }
        }

        public function setCapturePoints(param1:Number) : void
        {
            this.marker.setCapturePoints(param1);
        }

        public function setActive(param1:Boolean) : void
        {
            if(param1)
            {
                this.arrow.gotoAndStop(SELECTED_STATE);
                this.marker.setInternalIconScale(ACTIVE_ICON_SCALE);
                this.marker.targetHighlight.visible = true;
                this._alphaVal = 1;
                this.alpha = this._alphaVal;
                this.txtLabel.y = ACTIVE_Y_OFFSET;
                this.txtLabel.visible = true;
            }
            else
            {
                this.arrow.gotoAndStop(UNSELECTED_STATE);
                this.marker.setInternalIconScale(INACTIVE_ICON_SCALE);
                this.marker.targetHighlight.visible = false;
                this._alphaVal = INACTIVE_ALPHA_VALUE;
                this.alpha = this._alphaVal;
                this.txtLabel.visible = false;
            }
        }

        public function setIdentifier(param1:int) : void
        {
            this.marker.setBaseId(param1);
        }

        public function setOwningTeam(param1:Boolean) : void
        {
            this.marker.setOwningTeam(param1);
        }
    }
}
