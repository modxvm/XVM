package net.wg.gui.lobby.techtree.controls
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.techtree.data.ResearchPageVO;

    public class PremiumLayout extends Sprite implements IDisposable
    {

        public var benefit1:BenefitRenderer = null;

        public var benefit2:BenefitRenderer = null;

        public var benefit3:BenefitRenderer = null;

        public function PremiumLayout()
        {
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function setData(param1:ResearchPageVO) : void
        {
            this.benefit1.setData(param1.benefit1IconSrc,param1.benefit1LabelStr);
            this.benefit2.setData(param1.benefit2IconSrc,param1.benefit2LabelStr);
            this.benefit3.setData(param1.benefit3IconSrc,param1.benefit3LabelStr);
        }

        protected function onDispose() : void
        {
            this.benefit1.dispose();
            this.benefit1 = null;
            this.benefit2.dispose();
            this.benefit2 = null;
            this.benefit3.dispose();
            this.benefit3 = null;
        }
    }
}
