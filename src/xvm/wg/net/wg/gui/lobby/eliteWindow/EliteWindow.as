package net.wg.gui.lobby.eliteWindow 
{
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.data.gui_items.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class EliteWindow extends net.wg.infrastructure.base.meta.impl.EliteWindowMeta implements net.wg.infrastructure.base.meta.IEliteWindowMeta
    {
        public function EliteWindow()
        {
            super();
            isCentered = true;
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.useBottomBtns = true;
            window.title = DIALOGS.ELITE_TITLE;
            return;
        }

        protected override function onDispose():void
        {
            this.icon.dispose();
            this.closeBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            this.closeBtn.dispose();
            this.closeBtn = null;
            if (constraints) 
            {
                constraints.removeAllElements();
                constraints = null;
            }
            super.onDispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints = new scaleform.clik.utils.Constraints(this);
            this.infoTF.text = DIALOGS.ELITE_MESSAGE;
            this.closeBtn.label = DIALOGS.ELITE_CANCEL;
            this.closeBtn.soundType = net.wg.data.constants.SoundTypes.CANCEL_BTN;
            this.closeBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            constraints.addElement("closeBtn", this.closeBtn, scaleform.clik.utils.Constraints.CENTER_H);
            return;
        }

        public function as_setVehTypeCompDescr(arg1:int):void
        {
            var loc1:*=new net.wg.data.gui_items.Vehicle(arg1);
            this.vName = loc1.userName;
            this.vType = loc1.type;
            this.closeBtn.soundType = net.wg.data.constants.SoundTypes.CANCEL_BTN;
            invalidate(this.INVALIDATE_TANK_DATA);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(this.INVALIDATE_TANK_DATA)) 
            {
                if (this.vType && this.vType.length > 0) 
                {
                    this.icon.source = "../maps/icons/elitewindow/" + this.vType + ".png";
                }
                if (this.vName && this.vName.length > 0) 
                {
                    this.titleTF.text = App.utils.locale.makeString(DIALOGS.ELITE_HEADER, {"name":this.vName});
                }
            }
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            App.utils.focusHandler.setFocus(this.closeBtn);
            return;
        }

        internal function onClose(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal const INVALIDATE_TANK_DATA:String="invTankData";

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var titleTF:flash.text.TextField;

        public var infoTF:flash.text.TextField;

        public var closeBtn:net.wg.gui.components.controls.SoundButtonEx;

        internal var vName:String="";

        internal var vType:String="";
    }
}
