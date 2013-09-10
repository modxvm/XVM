package net.wg.gui.components.tooltips 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.tooltips.finstats.*;
    
    public class IgrQuestProgressBlock extends flash.display.MovieClip
    {
        public function IgrQuestProgressBlock()
        {
            super();
            return;
        }

        public function setData(arg1:String, arg2:Array):void
        {
            var loc2:*=0;
            this.headerTF.htmlText = arg1;
            var loc1:*=arg2.length;
            var loc3:*="";
            var loc4:*="";
            var loc5:*=null;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (loc2 > 0) 
                {
                    loc3 = loc3 + "<br/>";
                    loc4 = loc4 + "<br/>";
                }
                loc5 = arg2[loc2];
                loc3 = loc3 + ("<b>" + loc5[0] + "</b>/" + loc5[1]);
                loc4 = loc4 + loc5[2];
                ++loc2;
            }
            this.valuesBlock.setData(loc3, loc4);
            return;
        }

        public var headerTF:flash.text.TextField;

        public var valuesBlock:net.wg.gui.components.tooltips.finstats.EfficiencyBlock;
    }
}
