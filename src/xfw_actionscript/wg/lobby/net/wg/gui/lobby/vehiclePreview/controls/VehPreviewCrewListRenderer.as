package net.wg.gui.lobby.vehiclePreview.controls
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.gui.components.controls.Image;
    import flash.text.TextField;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewCrewListRendererVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.components.controls.constants.ToolTipShowType;
    import flash.text.TextFieldAutoSize;
    import flash.events.MouseEvent;
    import org.idmedia.as3commons.util.StringUtils;

    public class VehPreviewCrewListRenderer extends SoundListItemRenderer
    {

        private static const INVALIDATE_DATA:String = "invalidateData";

        public var icon:Image;

        public var nameTf:TextField;

        private var _rendererData:VehPreviewCrewListRendererVO;

        private var _toolTipMgr:ITooltipMgr;

        private var _tooltip:String = null;

        private var _tooltipData:String = null;

        private var _tooltipType:ToolTipShowType;

        public function VehPreviewCrewListRenderer()
        {
            this._toolTipMgr = App.toolTipMgr;
            this._tooltipType = ToolTipShowType.SPECIAL;
            super();
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            if(param1 != null)
            {
                this._rendererData = VehPreviewCrewListRendererVO(param1);
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._rendererData && isInvalid(INVALIDATE_DATA))
            {
                this.icon.source = this._rendererData.icon;
                this.nameTf.htmlText = this._rendererData.name;
                this._tooltip = this._rendererData.tooltip;
                this._tooltipData = this._rendererData.role;
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.nameTf.autoSize = TextFieldAutoSize.LEFT;
            buttonMode = false;
            enabled = false;
            mouseEnabledOnDisabled = true;
        }

        override protected function onDispose() : void
        {
            this.icon.dispose();
            this.icon = null;
            this.nameTf = null;
            this._toolTipMgr = null;
            this._tooltipType = null;
            this._rendererData = null;
            super.onDispose();
        }

        public function set tooltipType(param1:ToolTipShowType) : void
        {
            this._tooltipType = param1;
        }

        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            super.handleMouseRollOver(param1);
            if(StringUtils.isNotEmpty(this._tooltip))
            {
                if(this._tooltipType == ToolTipShowType.SPECIAL)
                {
                    this._toolTipMgr.showSpecial(this._tooltip,null,this._tooltipData);
                }
                else
                {
                    this._toolTipMgr.showComplex(this._tooltip);
                }
            }
        }

        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            super.handleMouseRollOut(param1);
            this._toolTipMgr.hide();
        }
    }
}
