package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.data.OrderInfoVO;
    import net.wg.data.constants.Values;
    import net.wg.gui.utils.ComplexTooltipHelper;
    
    public class OrderInfoCmp extends MovieClip implements IDisposable
    {
        
        public function OrderInfoCmp()
        {
            super();
            this._descrRightMargin = this.description.x + this.description.width;
            this.infoIcon.visible = false;
            this.alertIcon.visible = false;
            this.alertIcon.addEventListener(MouseEvent.ROLL_OVER,showAlertTooltip);
            this.alertIcon.addEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
        }
        
        private static var TEXT_OFFSET_NO_ICON:int = 10;
        
        private static var TEXT_OFFSET_ICON:int = 6;
        
        private static function onRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private static function showAlertTooltip(param1:MouseEvent) : void
        {
            if(!App.globalVarsMgr.isFortificationBattleAvailableS())
            {
                App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_ORDERPOPOVER_USEORDERBTN_NOTAVAILABLE);
            }
            else
            {
                App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_ORDERPOPOVER_USEORDERBTN_DEFENCEHOURDISABLED);
            }
        }
        
        public var infoIcon:UILoaderAlt;
        
        public var title:TextField;
        
        public var resourceIcon:OrderInfoIconCmp;
        
        public var description:TextField;
        
        public var alertIcon:MovieClip;
        
        private var model:OrderInfoVO;
        
        private var _tooltipText:String = "";
        
        private var _descrRightMargin:Number;
        
        public function dispose() : void
        {
            this.resourceIcon.dispose();
            this.resourceIcon = null;
            this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER,showAlertTooltip);
            this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
            this.alertIcon = null;
            this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
            this.infoIcon.dispose();
            this.infoIcon = null;
            this.description = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
        }
        
        public function setData(param1:OrderInfoVO) : void
        {
            this.model = param1;
            if(this.model.iconSource != Values.EMPTY_STR)
            {
                this.title.htmlText = this.model.title;
                this.resourceIcon.setSource(this.model.iconSource);
                this.resourceIcon.setLevels(this.model.iconLevel);
                this.resourceIcon.setResourceCount(this.model.ordersCount);
                this.resourceIcon.visible = true;
                this.description.x = this.resourceIcon.x + this.resourceIcon.width + TEXT_OFFSET_ICON;
            }
            else
            {
                this.resourceIcon.visible = false;
                this.description.x = this.resourceIcon.x + TEXT_OFFSET_NO_ICON;
            }
            this.description.width = this._descrRightMargin - this.description.x;
            this.description.htmlText = this.model.description;
            this.alertIcon.visible = this.model.showAlertIcon;
            if(!(this.model.infoIconSource == Values.EMPTY_STR) && !(this.model.infoIconSource == null))
            {
                this.infoIcon.source = this.model.infoIconSource;
                this.infoIcon.visible = true;
                this.infoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                this.infoIcon.addEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
                this.prepareToolTipMessage();
            }
            else
            {
                this.infoIcon.visible = false;
            }
            App.utils.commons.moveDsiplObjToEndOfText(this.alertIcon,this.title);
        }
        
        protected function prepareToolTipMessage() : void
        {
            this._tooltipText = new ComplexTooltipHelper().addHeader(this.model.infoIconToolTipData["header"]).addBody(this.model.infoIconToolTipData["body"]).addNote("",false).make();
        }
        
        private function onRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(this._tooltipText);
        }
    }
}
