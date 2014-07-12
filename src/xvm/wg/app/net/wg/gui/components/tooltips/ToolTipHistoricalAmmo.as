package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import net.wg.gui.components.advanced.ShellsSet;
    import flash.display.Sprite;
    import net.wg.gui.lobby.hangar.maintenance.data.HistoricalAmmoVO;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import flash.text.TextFieldAutoSize;
    
    public class ToolTipHistoricalAmmo extends ToolTipSpecial
    {
        
        public function ToolTipHistoricalAmmo() {
            super();
            this.headerTF = content.headerTF;
            this.descriptionTF = content.descriptionTF;
            this.noteTF = content.noteTF;
            this.priceLabelTF = content.priceLabelTF;
            this.priceTF = content.priceTF;
            this.shellsSet = content.shellsSet;
            this.whiteBg = content.whiteBg;
            contentMargin.bottom = 18;
            contentMargin.right = 0;
        }
        
        private static var AMMO_BLOCK_PADDING:Number = 20;
        
        private static var PRICE_GAP:Number = 8;
        
        public var headerTF:TextField;
        
        public var descriptionTF:TextField;
        
        public var noteTF:TextField;
        
        public var priceLabelTF:TextField;
        
        public var priceTF:TextField;
        
        public var shellsSet:ShellsSet;
        
        private var whiteBg:Sprite;
        
        private var model:HistoricalAmmoVO;
        
        override protected function redraw() : void {
            var _loc1_:Separator = null;
            this.disposeModel();
            this.model = new HistoricalAmmoVO(_data);
            this.updateStaticTexts();
            this.shellsSet.setData(this.model.shells);
            this.shellsSet.validateNow();
            separators = new Vector.<Separator>();
            this.headerTF.x = bgShadowMargin.left + contentMargin.left;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
            this.descriptionTF.x = bgShadowMargin.left + contentMargin.left;
            this.descriptionTF.y = topPosition;
            this.descriptionTF.height = this.descriptionTF.textHeight + 5;
            topPosition = topPosition + (this.descriptionTF.height + Utils.instance.MARGIN_AFTER_BLOCK);
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition ^ 0;
            this.whiteBg.y = topPosition ^ 0;
            separators.push(_loc1_);
            topPosition = topPosition + AMMO_BLOCK_PADDING;
            this.shellsSet.y = topPosition ^ 0;
            topPosition = topPosition + (this.shellsSet.height + Utils.instance.MARGIN_AFTER_BLOCK);
            this.priceLabelTF.y = topPosition ^ 0;
            this.priceLabelTF.x = bgShadowMargin.left + contentMargin.left;
            this.priceTF.autoSize = TextFieldAutoSize.LEFT;
            this.priceTF.htmlText = this.model.price;
            this.priceTF.y = this.priceLabelTF.y;
            topPosition = topPosition + (this.priceLabelTF.textHeight + AMMO_BLOCK_PADDING);
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition ^ 0;
            this.whiteBg.height = topPosition - this.whiteBg.y;
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_BLOCK;
            this.noteTF.x = bgShadowMargin.left + contentMargin.left;
            this.noteTF.y = topPosition ^ 0;
            this.noteTF.height = this.noteTF.textHeight + 5;
            this.updatePositions();
            super.redraw();
        }
        
        override protected function updatePositions() : void {
            super.updatePositions();
            this.shellsSet.x = content.width - this.shellsSet.actualWidth >> 1;
            var _loc1_:Number = this.priceLabelTF.width + PRICE_GAP + this.priceTF.width;
            this.priceLabelTF.x = content.width - _loc1_ >> 1;
            this.priceTF.x = this.priceLabelTF.x + this.priceLabelTF.width + PRICE_GAP;
        }
        
        override protected function onDispose() : void {
            this.disposeModel();
            this.shellsSet.dispose();
            this.shellsSet = null;
            super.onDispose();
        }
        
        private function disposeModel() : void {
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
        }
        
        private function updateStaticTexts() : void {
            this.priceLabelTF.autoSize = TextFieldAutoSize.LEFT;
            this.headerTF.htmlText = Utils.instance.htmlWrapper(App.utils.locale.makeString(HISTORICAL_BATTLES.AMMOPRESET_HEADER),Utils.instance.COLOR_HEADER,18,"$TitleFont");
            this.descriptionTF.htmlText = Utils.instance.htmlWrapper(App.utils.locale.makeString(HISTORICAL_BATTLES.AMMOPRESET_DESCRIPTION),Utils.instance.COLOR_NORMAL,14,"$FieldFont");
            this.noteTF.htmlText = Utils.instance.htmlWrapper(App.utils.locale.makeString(HISTORICAL_BATTLES.AMMOPRESET_NOTE),Utils.instance.COLOR_NOTE,14,"$FieldFont");
            this.priceLabelTF.htmlText = Utils.instance.htmlWrapper(App.utils.locale.makeString(HISTORICAL_BATTLES.AMMOPRESET_PRICELABEL),Utils.instance.COLOR_LABEL,13,"$TitleFont");
        }
    }
}
