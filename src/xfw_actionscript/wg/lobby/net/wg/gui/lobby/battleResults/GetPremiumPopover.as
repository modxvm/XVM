package net.wg.gui.lobby.battleResults
{
    import net.wg.infrastructure.base.meta.impl.GetPremiumPopoverMeta;
    import net.wg.infrastructure.base.meta.IGetPremiumPopoverMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.assets.data.SeparatorConstants;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Errors;
    import flash.display.DisplayObject;

    public class GetPremiumPopover extends GetPremiumPopoverMeta implements IGetPremiumPopoverMeta
    {

        private static const DEFAULT_HEIGHT:int = 254;

        private static const ICONS_NUMBER:int = 2;

        private static const ICON_OFFSET:int = 5;

        private static const ICON_DEFAULT_WIDTH:int = 16;

        public var headerTF:TextField = null;

        public var creditsTF:TextField = null;

        public var creditsIcon:UILoaderAlt = null;

        public var xpTF:TextField = null;

        public var xpIcon:UILoaderAlt = null;

        public var descriptionTF:TextField = null;

        public var actionBtn:SoundButtonEx = null;

        public var separator:ISeparatorAsset = null;

        private var _iconsLoaded:int = 0;

        private var _arenaUniqueID:Number = -1;

        public function GetPremiumPopover()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.creditsIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
            this.creditsIcon.removeEventListener(UILoaderEvent.IOERROR,this.onIconLoadIOErrorHandler);
            this.xpIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
            this.xpIcon.removeEventListener(UILoaderEvent.IOERROR,this.onIconLoadIOErrorHandler);
            this.actionBtn.removeEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            this.headerTF = null;
            this.creditsTF = null;
            this.creditsIcon.dispose();
            this.creditsIcon = null;
            this.xpTF = null;
            this.xpIcon.dispose();
            this.xpIcon = null;
            this.descriptionTF = null;
            this.actionBtn.dispose();
            this.actionBtn = null;
            this.separator.dispose();
            this.separator = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            height = DEFAULT_HEIGHT;
            this.actionBtn.autoSize = TextFieldAutoSize.CENTER;
            this.separator.setMode(SeparatorConstants.SCALE_MODE);
            this.separator.setCenterAsset(Linkages.SEPARATOR_BIG_ROTATED_CENTER);
            this.creditsTF.autoSize = TextFieldAutoSize.RIGHT;
            this.xpTF.autoSize = TextFieldAutoSize.RIGHT;
            this.creditsIcon.autoSize = false;
            this.xpIcon.autoSize = false;
            this.creditsIcon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
            this.creditsIcon.addEventListener(UILoaderEvent.IOERROR,this.onIconLoadIOErrorHandler);
            this.xpIcon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
            this.xpIcon.addEventListener(UILoaderEvent.IOERROR,this.onIconLoadIOErrorHandler);
            this.actionBtn.addEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA) && this._iconsLoaded >= ICONS_NUMBER)
            {
                this.layoutTextIcon(this.creditsTF,this.creditsIcon);
                this.layoutTextIcon(this.xpTF,this.xpIcon);
            }
        }

        public function as_setData(param1:Object) : void
        {
            this.assertFlag(param1 != null,"Data for apply" + Errors.CANT_NULL);
            this.tryToApplyData(this,param1);
        }

        private function assertFlag(param1:Boolean, param2:String) : void
        {
            App.utils.asserter.assert(param1,param2);
        }

        private function layoutTextIcon(param1:TextField, param2:UILoaderAlt) : void
        {
            param1.x = width - (param1.width + ICON_OFFSET + ICON_DEFAULT_WIDTH) >> 1;
            App.utils.commons.moveDsiplObjToEndOfText(param2,param1,ICON_OFFSET);
        }

        private function tryToApplyData(param1:DisplayObject, param2:Object) : void
        {
            var _loc3_:String = null;
            var _loc4_:* = undefined;
            var _loc5_:DisplayObject = null;
            for(_loc3_ in param2)
            {
                _loc4_ = param2[_loc3_];
                this.assertFlag(param1.hasOwnProperty(_loc3_),"Can not find property \'" + _loc3_ + "\' in " + param1 + " for data binding!");
                if(typeof _loc4_ == "object")
                {
                    _loc5_ = DisplayObject(param1[_loc3_]);
                    this.tryToApplyData(_loc5_,_loc4_);
                }
                else
                {
                    param1[_loc3_] = _loc4_;
                }
            }
        }

        public function get arenaUniqueID() : Number
        {
            return this._arenaUniqueID;
        }

        public function set arenaUniqueID(param1:Number) : void
        {
            this._arenaUniqueID = param1;
        }

        private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
        {
            this._iconsLoaded++;
            if(this._iconsLoaded >= ICONS_NUMBER)
            {
                invalidateData();
            }
        }

        private function onIconLoadIOErrorHandler(param1:UILoaderEvent) : void
        {
            this._iconsLoaded++;
            param1.target.visible = false;
            if(this._iconsLoaded >= ICONS_NUMBER)
            {
                invalidateData();
            }
        }

        private function onActionBtnClickHandler(param1:ButtonEvent) : void
        {
            onActionBtnClickS(this._arenaUniqueID);
        }
    }
}
