package net.wg.gui.messenger
{
   import __AS3__.vec.Vector;
   import net.wg.gui.utils.ImageSubstitution;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;


   public class SmileyMap extends Object
   {
          
      public function SmileyMap() {
         super();
         this.map = Vector.<ImageSubstitution>([new ImageSubstitution(":)",this.s_happy,this.smiley_offset,16,16,true),new ImageSubstitution("=)",this.s_happy,this.smiley_offset,16,16,true),new ImageSubstitution(":-)",this.s_happy,this.smiley_offset,16,16,true),new ImageSubstitution(":\\",this.s_hmm,this.smiley_offset,16,16,true),new ImageSubstitution("=\\",this.s_hmm,this.smiley_offset,16,16,true),new ImageSubstitution(":-\\",this.s_hmm,this.smiley_offset,16,16,true),new ImageSubstitution(":/",this.s_hmm,this.smiley_offset,16,16,true),new ImageSubstitution("=/",this.s_hmm,this.smiley_offset,16,16,true),new ImageSubstitution(":-/",this.s_hmm,this.smiley_offset,16,16,true),new ImageSubstitution(">:|",this.s_mad,this.smiley_offset,16,16,true),new ImageSubstitution(">=|",this.s_mad,this.smiley_offset,16,16,true),new ImageSubstitution(">:-|",this.s_mad,this.smiley_offset,16,16,true),new ImageSubstitution(">:O",this.s_madah,this.smiley_offset,16,16,true),new ImageSubstitution(">=O",this.s_madah,this.smiley_offset,16,16,true),new ImageSubstitution(">:-O",this.s_madah,this.smiley_offset,16,16,true),new ImageSubstitution(">:o",this.s_madah,this.smiley_offset,16,16,true),new ImageSubstitution(">=o",this.s_madah,this.smiley_offset,16,16,true),new ImageSubstitution(">:-o",this.s_madah,this.smiley_offset,16,16,true),new ImageSubstitution(">:0",this.s_madah,this.smiley_offset,16,16,true),new ImageSubstitution(">=0",this.s_madah,this.smiley_offset,16,16,true),new ImageSubstitution(">:-0",this.s_madah,this.smiley_offset,16,16,true),new ImageSubstitution(":|",this.s_norm,this.smiley_offset,16,16,true),new ImageSubstitution("=|",this.s_norm,this.smiley_offset,16,16,true),new ImageSubstitution(":-|",this.s_norm,this.smiley_offset,16,16,true),new ImageSubstitution(":O",this.s_oh,this.smiley_offset,16,16,true),new ImageSubstitution("=O",this.s_oh,this.smiley_offset,16,16,true),new ImageSubstitution(":-O",this.s_oh,this.smiley_offset,16,16,true),new ImageSubstitution(":o",this.s_oh,this.smiley_offset,16,16,true),new ImageSubstitution("=o",this.s_oh,this.smiley_offset,16,16,true),new ImageSubstitution(":-o",this.s_oh,this.smiley_offset,16,16,true),new ImageSubstitution("=0",this.s_oh,this.smiley_offset,16,16,true),new ImageSubstitution(":-0",this.s_oh,this.smiley_offset,16,16,true),new ImageSubstitution(":(",this.s_sad,this.smiley_offset,16,16,true),new ImageSubstitution("=(",this.s_sad,this.smiley_offset,16,16,true),new ImageSubstitution(":-(",this.s_sad,this.smiley_offset,16,16,true),new ImageSubstitution(":P",this.s_tongue,this.smiley_offset,16,16,true),new ImageSubstitution("=P",this.s_tongue,this.smiley_offset,16,16,true),new ImageSubstitution(":-P",this.s_tongue,this.smiley_offset,16,16,true),new ImageSubstitution(";)",this.s_wink,this.smiley_offset,16,16,true),new ImageSubstitution(";-)",this.s_wink,this.smiley_offset,16,16,true)]);
      }

      private var map:Vector.<ImageSubstitution> = null;

      private var smiley_offset:Number = 11;

      private var s_happy:String = "smiley_happy";

      private var s_hmm:String = "smiley_hmm";

      private var s_mad:String = "smiley_mad";

      private var s_madah:String = "smiley_madah";

      private var s_norm:String = "smiley_norm";

      private var s_oh:String = "smiley_oh";

      private var s_sad:String = "smiley_sad";

      private var s_tongue:String = "smiley_tongue";

      private var s_wink:String = "smiley_wink";

      public function mapText(param1:TextField) : void {
         var _loc2_:ImageSubstitution = null;
         for each (_loc2_ in this.map)
         {
            TextFieldEx.setImageSubstitutions(param1,_loc2_);
         }
      }
   }

}