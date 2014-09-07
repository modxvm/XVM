package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortDeclarationOfWarWindowMeta;
    import net.wg.infrastructure.base.meta.IFortDeclarationOfWarWindowMeta;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.cmp.clan.impl.ClanInfoCmp;
    import net.wg.gui.lobby.fortifications.cmp.drctn.impl.DirectionRadioRenderer;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.utils.Padding;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.fortifications.data.ClanInfoVO;
    import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
    import flash.events.Event;
    
    public class FortDeclarationOfWarWindow extends FortDeclarationOfWarWindowMeta implements IFortDeclarationOfWarWindowMeta
    {
        
        public function FortDeclarationOfWarWindow()
        {
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
            this.allRenderers = [this.direction0,this.direction1,this.direction2,this.direction3];
        }
        
        public var titleTF:TextField;
        
        public var descriptionTF:TextField;
        
        public var myClanInfo:ClanInfoCmp;
        
        public var enemyClanInfo:ClanInfoCmp;
        
        public var direction0:DirectionRadioRenderer;
        
        public var direction1:DirectionRadioRenderer;
        
        public var direction2:DirectionRadioRenderer;
        
        public var direction3:DirectionRadioRenderer;
        
        public var submitButton:SoundButtonEx;
        
        public var cancelButton:SoundButtonEx;
        
        private var allRenderers:Array;
        
        private var selectedRenderer:DirectionRadioRenderer;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.enemyClanInfo.isMyClan = false;
            this.submitButton.label = FORTIFICATIONS.FORTDECLARATIONOFWARWINDOW_BUTTON_SUBMIT;
            this.cancelButton.label = FORTIFICATIONS.FORTDECLARATIONOFWARWINDOW_BUTTON_CANCEL;
            this.submitButton.addEventListener(ButtonEvent.CLICK,this.onSubmitClick);
            this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelClick);
            this.setupRenderers();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.useBottomBtns = true;
            window.title = FORTIFICATIONS.FORTDECLARATIONOFWARWINDOW_TITLE;
            var _loc1_:Padding = window.contentPadding as Padding;
            _loc1_.bottom = 12;
            window.contentPadding = _loc1_;
        }
        
        override protected function onDispose() : void
        {
            this.submitButton.removeEventListener(ButtonEvent.CLICK,this.onSubmitClick);
            this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelClick);
            this.submitButton.dispose();
            this.cancelButton.dispose();
            this.submitButton = null;
            this.cancelButton = null;
            this.myClanInfo.dispose();
            this.myClanInfo = null;
            this.enemyClanInfo.dispose();
            this.enemyClanInfo = null;
            this.selectedRenderer = null;
            this.disposeRenderers();
            super.onDispose();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.submitButton);
        }
        
        public function as_setupHeader(param1:String, param2:String) : void
        {
            this.titleTF.htmlText = param1;
            this.descriptionTF.htmlText = param2;
        }
        
        public function as_setupClans(param1:Object, param2:Object) : void
        {
            this.myClanInfo.model = new ClanInfoVO(param1);
            this.enemyClanInfo.model = new ClanInfoVO(param2);
        }
        
        public function as_setDirections(param1:Array) : void
        {
            var _loc2_:DirectionRadioRenderer = null;
            var _loc3_:ConnectedDirectionsVO = null;
            var _loc4_:* = 0;
            while(_loc4_ < param1.length)
            {
                _loc3_ = new ConnectedDirectionsVO(param1[_loc4_]);
                _loc2_ = this.allRenderers[_loc4_];
                _loc2_.setData(_loc3_);
                _loc4_++;
            }
            while(_loc4_ < this.allRenderers.length)
            {
                _loc2_ = this.allRenderers[_loc4_];
                _loc2_.setData(null);
                _loc4_++;
            }
        }
        
        public function as_selectDirection(param1:int) : void
        {
            var _loc2_:DirectionRadioRenderer = null;
            this.submitButton.enabled = !(param1 == -1);
            for each(_loc2_ in this.allRenderers)
            {
                if((_loc2_.model) && _loc2_.model.leftDirection.uid == param1)
                {
                    this.selectDirection(_loc2_);
                    return;
                }
            }
        }
        
        private function setupRenderers() : void
        {
            var _loc1_:DirectionRadioRenderer = null;
            for each(_loc1_ in this.allRenderers)
            {
                _loc1_.addEventListener(Event.SELECT,this.onRendererSelect);
            }
        }
        
        private function disposeRenderers() : void
        {
            var _loc1_:DirectionRadioRenderer = null;
            for each(_loc1_ in this.allRenderers)
            {
                _loc1_.removeEventListener(Event.SELECT,this.onRendererSelect);
                _loc1_.dispose();
                _loc1_ = null;
            }
            this.allRenderers.splice(0);
            this.allRenderers = null;
        }
        
        public function selectDirection(param1:DirectionRadioRenderer) : void
        {
            if(this.selectedRenderer == param1)
            {
                return;
            }
            if(this.selectedRenderer)
            {
                this.selectedRenderer.selected = false;
            }
            this.selectedRenderer = param1;
            this.selectedRenderer.selected = true;
        }
        
        private function onRendererSelect(param1:Event) : void
        {
            var _loc2_:DirectionRadioRenderer = param1.currentTarget as DirectionRadioRenderer;
            this.selectDirection(_loc2_);
            onDirectionSelectedS();
        }
        
        private function onCancelClick(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }
        
        private function onSubmitClick(param1:ButtonEvent) : void
        {
            assertNotNull(this.selectedRenderer,"selectedRenderer");
            assertNotNull(this.selectedRenderer.model,"selectedRenderer.model");
            assertNotNull(this.selectedRenderer.model.leftDirection,"selectedRenderer.model.leftDirection");
            var _loc2_:int = this.selectedRenderer.model.leftDirection.uid;
            onDirectonChosenS(_loc2_);
        }
    }
}
