package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import net.wg.gui.components.tooltips.VO.HistoricalModulesVO;
    import net.wg.gui.components.tooltips.VO.ModuleVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.data.constants.Linkages;
    
    public class ToolTipHistoricalModules extends ToolTipSpecial
    {
        
        public function ToolTipHistoricalModules()
        {
            this.moduleItems = [];
            super();
            this.headerTF = content.headerTF;
            this.descriptionTF = content.descriptionTF;
            contentMargin.bottom = 17;
        }
        
        public var headerTF:TextField;
        
        public var descriptionTF:TextField;
        
        private var model:HistoricalModulesVO;
        
        private var moduleItems:Array;
        
        override protected function redraw() : void
        {
            var _loc1_:Separator = null;
            var _loc3_:ModuleItem = null;
            var _loc4_:ModuleVO = null;
            this.disposeModel();
            this.model = new HistoricalModulesVO(_data);
            separators = new Vector.<Separator>();
            var _loc2_:String = App.utils.locale.makeString(TOOLTIPS.HISTORICALBATTLES_MODULES_TITLE,{"tankName":this.model.tankName});
            this.headerTF.autoSize = TextFieldAutoSize.LEFT;
            this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc2_,Utils.instance.COLOR_HEADER,18,"$TitleFont");
            this.headerTF.x = bgShadowMargin.left + contentMargin.left;
            this.headerTF.y = topPosition;
            topPosition = topPosition + (this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK);
            _loc1_ = Utils.instance.createSeparate(content);
            _loc1_.y = topPosition ^ 0;
            separators.push(_loc1_);
            topPosition = topPosition + Utils.instance.MARGIN_AFTER_SEPARATE;
            this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
            this.descriptionTF.x = bgShadowMargin.left + contentMargin.left;
            this.descriptionTF.y = topPosition;
            this.descriptionTF.htmlText = Utils.instance.htmlWrapper(App.utils.locale.makeString(TOOLTIPS.HISTORICALBATTLES_MODULES_SUBTITLE),Utils.instance.COLOR_BLOCK_HEADER,14,"$TitleFont");
            topPosition = topPosition + (this.descriptionTF.textHeight + Utils.instance.MARGIN_AFTER_SUBHEADER);
            var _loc5_:* = 0;
            while(_loc5_ < this.model.modules.length)
            {
                _loc4_ = this.model.modules[_loc5_];
                _loc3_ = App.utils.classFactory.getComponent(Linkages.MODULE_ITEM,ModuleItem);
                _loc3_.setData(_loc4_);
                _loc3_.validateNow();
                _loc3_.y = topPosition;
                _loc3_.x = bgShadowMargin.left + contentMargin.left;
                content.addChild(_loc3_);
                topPosition = topPosition + _loc3_.height;
                _loc5_++;
            }
            super.redraw();
        }
        
        override protected function onDispose() : void
        {
            this.disposeModel();
            this.clearModules();
            super.onDispose();
        }
        
        private function clearModules() : void
        {
            var _loc1_:ModuleItem = null;
            if(this.moduleItems)
            {
                for each(_loc1_ in this.moduleItems)
                {
                    _loc1_.dispose();
                    _loc1_ = null;
                }
            }
        }
        
        private function disposeModel() : void
        {
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
        }
    }
}
