package net.wg.gui.lobby.profile 
{
    import flash.display.*;
    import net.wg.data.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class ProfileTabNavigator extends net.wg.infrastructure.base.meta.impl.ProfileTabNavigatorMeta implements net.wg.infrastructure.base.meta.IProfileTabNavigatorMeta
    {
        public function ProfileTabNavigator()
        {
            this._sectionsDataUtil = new net.wg.gui.lobby.profile.SectionsDataUtil();
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this.btnTemplate) 
            {
                if (this.btnTemplate.parent) 
                {
                    this.btnTemplate.parent.removeChild(this.btnTemplate);
                }
                this.btnTemplate = null;
            }
            if (this.templatesHolder) 
            {
                if (this.templatesHolder.parent) 
                {
                    this.templatesHolder.parent.removeChild(this.templatesHolder);
                }
                this.templatesHolder = null;
            }
            this.viewStack.cache = true;
            this.bar.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onTabBarIndexChanged, false, 0, true);
            this.viewStack.addEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.onSectionViewShowed, false, 0, true);
            return;
        }

        internal function onSectionViewShowed(arg1:net.wg.gui.events.ViewStackEvent):void
        {
            var loc1:*=this._sectionsDataUtil.getAliasByLinkage(arg1.linkage);
            if (!isFlashComponentRegisteredS(loc1)) 
            {
                registerFlashComponentS(net.wg.infrastructure.interfaces.IDAAPIModule(arg1.view), loc1);
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            super.draw();
            if (isInvalid(INIT_DATA_INV) && this.initData) 
            {
                loc1 = this.initData.sectionsData;
                loc2 = loc1.length;
                loc3 = [];
                loc5 = -1;
                loc6 = 0;
                while (loc6 < loc2) 
                {
                    loc4 = loc1[loc6];
                    loc3.push({"label":loc4.label, "alias":loc4.alias, "linkage":this._sectionsDataUtil.register(loc4.alias), "tooltip":loc4.tooltip});
                    if (loc4.alias == net.wg.data.Aliases.PROFILE_AWARDS) 
                    {
                        loc5 = loc6;
                    }
                    ++loc6;
                }
                this.bar.dataProvider = new scaleform.clik.data.DataProvider(loc3);
                this.bar.selectedIndex = loc5;
                this.bar.selectedIndex = 0;
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                invalidate(OFFSET_INVALID);
            }
            if (isInvalid(OFFSET_INVALID)) 
            {
                this.bar.x = Math.round(_width / 2 - this._centerOffset);
                this.viewStack.centerOffset = this._centerOffset;
            }
            return;
        }

        internal function onTabBarIndexChanged(arg1:scaleform.clik.events.IndexEvent):void
        {
            this.viewStack.show(this._sectionsDataUtil.getLinkageByAlias(arg1.data.alias));
            return;
        }

        public function as_setInitData(arg1:Object):void
        {
            this.initData = new net.wg.gui.lobby.profile.ProfileMenuInfoVO(arg1);
            invalidate(INIT_DATA_INV);
            return;
        }

        protected override function onDispose():void
        {
            if (this.initData) 
            {
                this.initData.dispose();
                this.initData = null;
            }
            super.onDispose();
            this.viewStack.dispose();
            return;
        }

        public function setAvailableSize(arg1:Number, arg2:Number):void
        {
            this.viewStack.setAvailableSize(arg1, arg2 - this.viewStack.y);
            setSize(arg1, arg2);
            return;
        }

        public function set centerOffset(arg1:int):void
        {
            this._centerOffset = arg1;
            invalidate(OFFSET_INVALID);
            return;
        }

        internal static const OFFSET_INVALID:String="layoutInv";

        internal static const INIT_DATA_INV:String="initDataInv";

        public var btnTemplate:scaleform.clik.controls.Button;

        public var templatesHolder:flash.display.MovieClip;

        public var bar:net.wg.gui.components.advanced.ButtonBarEx;

        public var viewStack:net.wg.gui.lobby.profile.components.ResizableViewStack;

        internal var initData:net.wg.gui.lobby.profile.ProfileMenuInfoVO;

        internal var _sectionsDataUtil:net.wg.gui.lobby.profile.SectionsDataUtil;

        internal var _centerOffset:int=0;
    }
}
