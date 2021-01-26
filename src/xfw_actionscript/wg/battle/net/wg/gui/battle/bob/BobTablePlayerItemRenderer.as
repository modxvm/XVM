package net.wg.gui.battle.bob
{
    import net.wg.gui.battle.random.battleloading.renderers.RandomPlayerItemRenderer;
    import net.wg.data.constants.UserTags;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import net.wg.gui.battle.bob.data.BobDAAPIVehicleInfoVO;
    import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;

    public class BobTablePlayerItemRenderer extends RandomPlayerItemRenderer
    {

        public function BobTablePlayerItemRenderer(param1:BaseRendererContainer, param2:int, param3:Boolean)
        {
            super(param1,param2,param3);
            if(param3)
            {
                selfBg = BobRendererContainer(param1).selfBgsEnemy[param2];
            }
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            if(this.isBlogger)
            {
                this.setBloggerBG();
            }
        }

        override protected function setSelfBG() : void
        {
            if(selfBg != null)
            {
                selfBg.visible = this.isBlogger || UserTags.isCurrentPlayer(model.userTags);
                if(selfBg.visible)
                {
                    if(this.isBlogger)
                    {
                        this.setBloggerBG();
                    }
                    else
                    {
                        selfBg.imageName = BATTLEATLAS.BOB_SELF_BG;
                    }
                }
            }
        }

        private function setBloggerBG() : void
        {
            if(selfBg)
            {
                selfBg.imageName = BATTLEATLAS.BLOGGER;
                selfBg.transform.colorTransform = App.colorSchemeMgr.getTransform("blogger_" + this.bloggerID);
            }
        }

        private function get isBlogger() : Boolean
        {
            return BobDAAPIVehicleInfoVO(model).isBlogger;
        }

        private function get bloggerID() : int
        {
            return BobDAAPIVehicleInfoVO(model).bloggerID;
        }
    }
}
