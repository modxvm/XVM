package net.wg.gui.lobby.fortifications.cmp.impl
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.TextFieldShort;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.utils.ILocale;
   
   public class FortWelcomeCommanderContent extends UIComponent
   {
      
      public function FortWelcomeCommanderContent() {
         super();
         var _loc1_:ILocale = App.utils.locale;
         this.title1.text = _loc1_.makeString(FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION1_TITLE);
         this.titleDescr1.text = _loc1_.makeString(FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION1_DESCR);
         this.title2.text = _loc1_.makeString(FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION2_TITLE);
         this.titleDescr2.text = _loc1_.makeString(FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION2_DESCR);
         this.title3.text = _loc1_.makeString(FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION3_TITLE);
         this.titleDescr3.text = _loc1_.makeString(FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_OPTION3_DESCR);
         this.button.label = _loc1_.makeString(FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_BUTTON_LABEL);
      }
      
      public var windowTitle:TextFieldShort;
      
      public var title1:TextField;
      
      public var title2:TextField;
      
      public var title3:TextField;
      
      public var titleDescr1:TextField;
      
      public var titleDescr2:TextField;
      
      public var titleDescr3:TextField;
      
      public var button:SoundButtonEx;
      
      override protected function configUI() : void {
         super.configUI();
         var _loc1_:ILocale = App.utils.locale;
         this.windowTitle.label = _loc1_.makeString(FORTIFICATIONS.FORTWELCOMECOMMANDERVIEW_TITLE);
      }
      
      override protected function onDispose() : void {
         this.windowTitle = null;
         this.title1 = null;
         this.title2 = null;
         this.title3 = null;
         this.titleDescr1 = null;
         this.titleDescr2 = null;
         this.titleDescr3 = null;
         super.onDispose();
      }
   }
}
