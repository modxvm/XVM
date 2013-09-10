package net.wg.gui.lobby.profile.pages.technique 
{
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.profile.components.*;
    import scaleform.clik.constants.*;
    
    public class TechniqueAchievementsBlock extends net.wg.gui.lobby.profile.components.AwardsTileListBlock
    {
        public function TechniqueAchievementsBlock()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            tileList.direction = scaleform.clik.constants.DirectionMode.VERTICAL;
            tileList.columnWidth = getBigRendererWidth();
            tileList.columnCount = this.MIN_ITEMS_COUNT;
            tileList.itemRenderer = getClass(net.wg.data.constants.Linkages.ACHIEVEMENT_COMMON_VEHICLE);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            return;
        }

        public static function getBigRendererWidth():Number
        {
            if (defaultIR_smallWidth == -1) 
            {
                defaultIR_smallWidth = getDefaultWidth(net.wg.data.constants.Linkages.ACHIEVEMENT_COMMON);
            }
            return defaultIR_smallWidth;
        }

        internal static function getDefaultWidth(arg1:String):uint
        {
            var loc1:*=getClass(arg1);
            var loc2:*=new loc1();
            return loc2.width;
        }

        internal static function getClass(arg1:String):Class
        {
            if (App.utils) 
            {
                return App.utils.classFactory.getClass(arg1);
            }
            return flash.utils.getDefinitionByName(arg1) as Class;
        }

        
        {
            defaultIR_smallWidth = -1;
            defaultIR_bigWidth = -1;
        }

        internal const MIN_ITEMS_COUNT:uint=5;

        internal static var defaultIR_smallWidth:int=-1;

        internal static var defaultIR_bigWidth:int=-1;
    }
}
