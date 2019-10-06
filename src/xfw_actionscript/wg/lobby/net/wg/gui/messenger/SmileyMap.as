package net.wg.gui.messenger
{
    import net.wg.gui.utils.ImageSubstitution;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;

    public class SmileyMap extends Object
    {

        private var map:Vector.<ImageSubstitution> = null;

        public function SmileyMap()
        {
            super();
            var _loc1_:Number = 11;
            var _loc2_:* = "smiley_happy";
            var _loc3_:* = "smiley_hmm";
            var _loc4_:* = "smiley_mad";
            var _loc5_:* = "smiley_madah";
            var _loc6_:* = "smiley_norm";
            var _loc7_:* = "smiley_oh";
            var _loc8_:* = "smiley_sad";
            var _loc9_:* = "smiley_tongue";
            var _loc10_:* = "smiley_wink";
            var _loc11_:* = "smiley_kiss";
            this.map = Vector.<ImageSubstitution>([new ImageSubstitution(":)",_loc2_,_loc1_,16,16,true),new ImageSubstitution("=)",_loc2_,_loc1_,16,16,true),new ImageSubstitution(":-)",_loc2_,_loc1_,16,16,true),new ImageSubstitution(":\\",_loc3_,_loc1_,16,16,true),new ImageSubstitution("=\\",_loc3_,_loc1_,16,16,true),new ImageSubstitution(":-\\",_loc3_,_loc1_,16,16,true),new ImageSubstitution("=/",_loc3_,_loc1_,16,16,true),new ImageSubstitution(":-/",_loc3_,_loc1_,16,16,true),new ImageSubstitution(">:|",_loc4_,_loc1_,16,16,true),new ImageSubstitution(">=|",_loc4_,_loc1_,16,16,true),new ImageSubstitution(">:-|",_loc4_,_loc1_,16,16,true),new ImageSubstitution(">:O",_loc5_,_loc1_,16,16,true),new ImageSubstitution(">=O",_loc5_,_loc1_,16,16,true),new ImageSubstitution(">:-O",_loc5_,_loc1_,16,16,true),new ImageSubstitution(">:o",_loc5_,_loc1_,16,16,true),new ImageSubstitution(">=o",_loc5_,_loc1_,16,16,true),new ImageSubstitution(">:-o",_loc5_,_loc1_,16,16,true),new ImageSubstitution(">:0",_loc5_,_loc1_,16,16,true),new ImageSubstitution(">=0",_loc5_,_loc1_,16,16,true),new ImageSubstitution(">:-0",_loc5_,_loc1_,16,16,true),new ImageSubstitution(":|",_loc6_,_loc1_,16,16,true),new ImageSubstitution("=|",_loc6_,_loc1_,16,16,true),new ImageSubstitution(":-|",_loc6_,_loc1_,16,16,true),new ImageSubstitution(":O",_loc7_,_loc1_,16,16,true),new ImageSubstitution("=O",_loc7_,_loc1_,16,16,true),new ImageSubstitution(":-O",_loc7_,_loc1_,16,16,true),new ImageSubstitution(":o",_loc7_,_loc1_,16,16,true),new ImageSubstitution("=o",_loc7_,_loc1_,16,16,true),new ImageSubstitution(":-o",_loc7_,_loc1_,16,16,true),new ImageSubstitution("=0",_loc7_,_loc1_,16,16,true),new ImageSubstitution(":-0",_loc7_,_loc1_,16,16,true),new ImageSubstitution(":(",_loc8_,_loc1_,16,16,true),new ImageSubstitution("=(",_loc8_,_loc1_,16,16,true),new ImageSubstitution(":-(",_loc8_,_loc1_,16,16,true),new ImageSubstitution(":P",_loc9_,_loc1_,16,16,true),new ImageSubstitution("=P",_loc9_,_loc1_,16,16,true),new ImageSubstitution(":-P",_loc9_,_loc1_,16,16,true),new ImageSubstitution(":*",_loc11_,_loc1_,16,16,true),new ImageSubstitution("=*",_loc11_,_loc1_,16,16,true),new ImageSubstitution(":-*",_loc11_,_loc1_,16,16,true),new ImageSubstitution(";)",_loc10_,_loc1_,16,16,true),new ImageSubstitution(";-)",_loc10_,_loc1_,16,16,true)]);
        }

        public function mapText(param1:TextField) : void
        {
            var _loc2_:ImageSubstitution = null;
            for each(_loc2_ in this.map)
            {
                TextFieldEx.setImageSubstitutions(param1,_loc2_);
            }
        }
    }
}
