package net.wg.gui.lobby.profile.pages.technique 
{
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    import scaleform.gfx.*;
    
    public class ProfileSortingButton extends net.wg.gui.components.advanced.InteractiveSortingButton
    {
        public function ProfileSortingButton()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            mcDescendingIcon.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.sortingIconLoadingCompleteHandler);
            scaleform.gfx.TextFieldEx.setVerticalAlign(this.labelField, flash.text.TextFieldAutoSize.CENTER);
            return;
        }

        protected override function sortingIconLoadingCompleteHandler(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            var loc1:*=net.wg.gui.components.controls.UILoaderAlt(arg1.target);
            if (arg1.target == mcAscendingIcon) 
                loc1.y = _height - loc1.height;
            loc1.x = (_width - loc1.width) / 2;
            isSortIconLoadingCompete = true;
            invalidate();
            return;
        }

        public override function set data(arg1:Object):void
        {
            var loc1:*=null;
            super.data = arg1;
            if (arg1 is net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo) 
            {
                loc1 = net.wg.gui.lobby.profile.pages.technique.ProfileSortingBtnInfo(arg1);
                bg.visible = loc1.showSeparator;
                if (loc1.label) 
                {
                    _label = loc1.label;
                    invalidateData();
                }
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                if (upperBg) 
                {
                    upperBg.width = bg.visible ? _width - 2 : _width;
                    upperBg.height = _height;
                }
                this.labelField.width = _width;
                this.labelField.height = _height;
            }
            if (scaleform.clik.constants.InvalidationType.DATA) 
                if (!(_label == null) && !(_label == "") && !(this.labelField == null)) 
                    this.labelField.text = _label;
                else 
                    this.labelField.text = "";
            return;
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            this.labelField.width = _width;
            this.labelField.height = _height;
            return;
        }

        public var labelField:flash.text.TextField;
    }
}
