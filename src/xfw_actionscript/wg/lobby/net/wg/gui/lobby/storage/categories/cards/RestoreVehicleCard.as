package net.wg.gui.lobby.storage.categories.cards
{
    import flash.text.TextField;
    import net.wg.gui.components.controls.Image;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.controls.VO.PriceVO;
    import net.wg.gui.components.controls.IconText;
    import net.wg.data.Colors;

    public class RestoreVehicleCard extends BaseCard
    {

        public var timerTF:TextField;

        public var timerImage:Image;

        public function RestoreVehicleCard()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.timerTF = null;
            this.timerImage.dispose();
            this.timerImage = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            sellButton.label = STORAGE.BUTTONLABEL_RESTORE;
            this.timerTF.autoSize = TextFieldAutoSize.LEFT;
        }

        override protected function draw() : void
        {
            var _loc1_:VehicleCardVO = null;
            super.draw();
            if(_data && isInvalid(InvalidationType.DATA))
            {
                sellButton.visible = true;
                sellButton.enabled = _data.enabled;
                _loc1_ = VehicleCardVO(_data);
                if(_loc1_.timerText)
                {
                    this.timerTF.text = _loc1_.timerText;
                    this.timerTF.visible = true;
                    this.timerImage.source = _loc1_.timerIcon;
                    this.timerImage.visible = true;
                }
                else
                {
                    this.timerTF.visible = false;
                    this.timerImage.visible = false;
                }
            }
        }

        override protected function drawPrice() : void
        {
            var _loc1_:PriceVO = _data.price?_data.price.price.getPriceVO():null;
            if(_loc1_)
            {
                price.text = App.utils.locale.integer(_loc1_.value);
                price.textColor = _data.isMoneyEnough?IconText.BASE_COLOR:Colors.ERROR_COLOR;
                price.icon = _loc1_.name;
                price.visible = true;
                price.invalidatePosition();
                price.validateNow();
            }
            else
            {
                price.visible = false;
            }
        }
    }
}
