package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.data.constants.Errors;
   
   public class HangarMeta extends AbstractView
   {
      
      public function HangarMeta() {
         super();
      }
      
      public var onEscape:Function = null;
      
      public var checkMoney:Function = null;
      
      public var showHelpLayout:Function = null;
      
      public var closeHelpLayout:Function = null;
      
      public var toggleGUIEditor:Function = null;
      
      public function onEscapeS() : void {
         App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
         this.onEscape();
      }
      
      public function checkMoneyS() : void {
         App.utils.asserter.assertNotNull(this.checkMoney,"checkMoney" + Errors.CANT_NULL);
         this.checkMoney();
      }
      
      public function showHelpLayoutS() : void {
         App.utils.asserter.assertNotNull(this.showHelpLayout,"showHelpLayout" + Errors.CANT_NULL);
         this.showHelpLayout();
      }
      
      public function closeHelpLayoutS() : void {
         App.utils.asserter.assertNotNull(this.closeHelpLayout,"closeHelpLayout" + Errors.CANT_NULL);
         this.closeHelpLayout();
      }
      
      public function toggleGUIEditorS() : void {
         App.utils.asserter.assertNotNull(this.toggleGUIEditor,"toggleGUIEditor" + Errors.CANT_NULL);
         this.toggleGUIEditor();
      }
   }
}
