package net.wg.gui.components.tooltips 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.managers.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.helpers.*;
    
    public class ToolTipRSSNews extends net.wg.gui.components.tooltips.ToolTipSpecial
    {
        public function ToolTipRSSNews()
        {
            super();
            contentMargin.top = 8;
            contentMargin.bottom = 17;
            contentMargin.left = 18;
            this.initControls();
            return;
        }

        public function get utils():net.wg.gui.components.tooltips.helpers.Utils
        {
            return net.wg.gui.components.tooltips.helpers.Utils.instance;
        }

        public override function build(arg1:Object, arg2:net.wg.data.managers.ITooltipProps):void
        {
            var loc1:*=arg1 as Array;
            var loc2:*={"data":{"header":loc1[0], "description":loc1[1]}};
            super.build(loc2, arg2);
            return;
        }

        protected override function redraw():void
        {
            var loc2:*=null;
            topPosition = bgShadowMargin.top + contentMargin.top;
            blockResults = new Vector.<net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO>();
            seaprators = new Vector.<net.wg.gui.components.tooltips.Separator>();
            var loc1:*=_data.header;
            loc2 = _data.description;
            this.headerTF.htmlText = this.utils.htmlWrapper(loc1, this.utils.COLOR_HEADER, 16, "$TitleFont", false);
            this.headerTF.width = MAX_WIDTH - contentMargin.left;
            this.headerTF.height = this.headerTF.textHeight + 5;
            this.headerTF.x = bgShadowMargin.left + contentMargin.left;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + GAP);
            this.separator = this.utils.createSeparate(content);
            this.separator.y = topPosition;
            this.whiteBg.y = topPosition;
            topPosition = topPosition + GAP;
            if (loc2) 
            {
                this.descriptionTF.defaultTextFormat.leading;
                this.descriptionTF.htmlText = this.utils.htmlWrapper(loc2, this.utils.COLOR_NORMAL, 12, "$TextFont", false);
                this.descriptionTF.width = MAX_WIDTH - contentMargin.left;
                this.descriptionTF.height = this.descriptionTF.textHeight + 5;
                this.descriptionTF.x = bgShadowMargin.left + contentMargin.left;
                this.descriptionTF.y = topPosition;
            }
            else 
            {
                this.descriptionTF.width = 0;
                this.descriptionTF.visible = false;
                this.separator.visible = false;
                this.whiteBg.y = 0;
                this.whiteBg.visible = false;
                contentMargin.bottom = 9;
            }
            super.redraw();
            return;
        }

        protected override function updateSize():void
        {
            background.width = content.width + contentMargin.right + bgShadowMargin.right | 0;
            background.height = content.height + contentMargin.bottom + bgShadowMargin.bottom | 0;
            this.whiteBg.width = content.width + bgShadowMargin.horizontal;
            this.whiteBg.height = content.height - this.whiteBg.y + contentMargin.bottom;
            return;
        }

        internal function initControls():void
        {
            this.headerTF = content.headerTF;
            this.descriptionTF = content.descriptionTF;
            this.whiteBg = content.whiteBg;
            return;
        }

        internal static const MAX_WIDTH:Number=283;

        internal static const GAP:Number=13;

        internal var headerTF:flash.text.TextField;

        internal var descriptionTF:flash.text.TextField;

        internal var whiteBg:flash.display.Sprite;

        internal var separator:net.wg.gui.components.tooltips.Separator;
    }
}
