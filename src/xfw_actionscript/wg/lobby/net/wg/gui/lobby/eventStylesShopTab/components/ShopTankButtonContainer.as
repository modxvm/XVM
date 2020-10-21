package net.wg.gui.lobby.eventStylesShopTab.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.eventStylesTrade.data.SkinVO;

    public class ShopTankButtonContainer extends Sprite implements IDisposable
    {

        public var contentNormal:ShopTankButton = null;

        public var contentTiny:ShopTankButton = null;

        public function ShopTankButtonContainer()
        {
            super();
            this.contentTiny.visible = false;
        }

        public function setIsMin(param1:Boolean) : void
        {
            this.contentNormal.visible = !param1;
            this.contentTiny.visible = param1;
        }

        public function setData(param1:SkinVO, param2:int) : void
        {
            this.contentNormal.setData(param1,param2);
            this.contentTiny.setData(param1,param2);
        }

        public final function dispose() : void
        {
            this.contentNormal.dispose();
            this.contentNormal = null;
            this.contentTiny.dispose();
            this.contentTiny = null;
        }
    }
}
