package net.wg.gui.messenger 
{
    import __AS3__.vec.*;
    import flash.text.*;
    import net.wg.gui.utils.*;
    import scaleform.gfx.*;
    
    public class SmileyMap extends Object
    {
        public function SmileyMap()
        {
            super();
            this.map = Vector.<net.wg.gui.utils.ImageSubstitution>([new net.wg.gui.utils.ImageSubstitution(":)", this.s_happy, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution("=)", this.s_happy, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":-)", this.s_happy, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":\\", this.s_hmm, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution("=\\", this.s_hmm, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":-\\", this.s_hmm, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":/", this.s_hmm, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution("=/", this.s_hmm, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":-/", this.s_hmm, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">:|", this.s_mad, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">=|", this.s_mad, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">:-|", this.s_mad, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">:O", this.s_madah, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">=O", this.s_madah, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">:-O", this.s_madah, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">:o", this.s_madah, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">=o", this.s_madah, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">:-o", this.s_madah, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">:0", this.s_madah, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">=0", this.s_madah, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(">:-0", this.s_madah, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":|", this.s_norm, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution("=|", this.s_norm, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":-|", this.s_norm, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":O", this.s_oh, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution("=O", this.s_oh, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":-O", this.s_oh, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":o", this.s_oh, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution("=o", this.s_oh, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":-o", this.s_oh, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution("=0", this.s_oh, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":-0", this.s_oh, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":(", this.s_sad, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution("=(", this.s_sad, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":-(", this.s_sad, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":P", this.s_tongue, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution("=P", this.s_tongue, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(":-P", this.s_tongue, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(";)", this.s_wink, this.smiley_offset, 16, 16, true), new net.wg.gui.utils.ImageSubstitution(";-)", this.s_wink, this.smiley_offset, 16, 16, true)]);
            return;
        }

        public function mapText(arg1:flash.text.TextField):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.map;
            for each (loc1 in loc3) 
                scaleform.gfx.TextFieldEx.setImageSubstitutions(arg1, loc1);
            return;
        }

        internal var map:__AS3__.vec.Vector.<net.wg.gui.utils.ImageSubstitution>=null;

        internal var smiley_offset:Number=11;

        internal var s_happy:String="smiley_happy";

        internal var s_hmm:String="smiley_hmm";

        internal var s_mad:String="smiley_mad";

        internal var s_madah:String="smiley_madah";

        internal var s_norm:String="smiley_norm";

        internal var s_oh:String="smiley_oh";

        internal var s_sad:String="smiley_sad";

        internal var s_tongue:String="smiley_tongue";

        internal var s_wink:String="smiley_wink";
    }
}
