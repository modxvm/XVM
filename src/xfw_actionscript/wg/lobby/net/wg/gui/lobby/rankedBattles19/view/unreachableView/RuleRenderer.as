package net.wg.gui.lobby.rankedBattles19.view.unreachableView
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.lobby.rankedBattles19.data.RuleVO;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldAutoSize;

    public class RuleRenderer extends UIComponentEx
    {

        public var icon:UILoaderAlt = null;

        public var descriptionTF:TextField = null;

        private var _data:RuleVO = null;

        public function RuleRenderer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.icon.dispose();
            this.icon = null;
            this.descriptionTF = null;
            this._data = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                visible = Boolean(this._data);
                if(this._data)
                {
                    this.icon.source = this._data.image;
                    this.descriptionTF.htmlText = this._data.description;
                }
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.descriptionTF.autoSize = TextFieldAutoSize.CENTER;
        }

        public function setData(param1:RuleVO) : void
        {
            this._data = param1;
            invalidateData();
        }
    }
}
