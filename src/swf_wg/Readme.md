### XFW Framework ###
##### Modified lobby.swf file #####

## Replacement map ##
```
lobby.tcarousel.patch
  /net/wg/gui/components/controls/Carousel.class.asasm:
    PrivateNamespace(null, "net.wg.gui.components.controls:Carousel/instance#0"), "scopeWidth") => ProtectedNamespace("net.wg.gui.components.controls:Carousel"), "scopeWidth")
    PrivateNamespace(null, "net.wg.gui.components.controls:Carousel/instance#0"), "courseFactor") => ProtectedNamespace("net.wg.gui.components.controls:Carousel"), "courseFactor")
    PrivateNamespace(null, "net.wg.gui.components.controls:Carousel/instance#0"), "getCurrentFirstRendererOnAnim") => ProtectedNamespace("net.wg.gui.components.controls:Carousel"), "getCurrentFirstRendererOnAnim")
    PrivateNamespace(null, "net.wg.gui.components.controls:Carousel/instance#0"), "arrowSlide") => ProtectedNamespace("net.wg.gui.components.controls:Carousel"), "arrowSlide")
  /net/wg/gui/lobby/hangar/tcarousel/TankCarousel.class.asasm:
    PrivateNamespace(null, "net.wg.gui.lobby.hangar.tcarousel:TankCarousel/instance#0"), "_slotForBuySlot") => ProtectedNamespace("net.wg.gui.lobby.hangar.tcarousel:TankCarousel"), "_slotForBuySlot")
    PrivateNamespace(null, "net.wg.gui.lobby.hangar.tcarousel:TankCarousel/instance#0"), "_slotForBuyVehicle") => ProtectedNamespace("net.wg.gui.lobby.hangar.tcarousel:TankCarousel"), "_slotForBuyVehicle")
    PrivateNamespace(null, "net.wg.gui.lobby.hangar.tcarousel:TankCarousel/instance#0"), "showHideFilters") => ProtectedNamespace("net.wg.gui.lobby.hangar.tcarousel:TankCarousel"), "showHideFilters")
lobby.svcmsg.patch
  /net/wg/gui/notification/NotificationPopUpViewer.class.asasm
    PrivateNamespace(null, "net.wg.gui.notification:NotificationPopUpViewer/instance#0"), "popupClass") => PackageNamespace(""), "popupClass")
lobby.profile.patch
  /net/wg/gui/lobby/header/LobbyHeader.class.asasm
    PrivateNamespace(null, "net.wg.gui.lobby.header:LobbyHeader/instance"), "_headerButtonsHelper") => PackageNamespace(""), "_headerButtonsHelper")
  /net/wg/gui/lobby/profile/ProfileTabNavigator.class.asasm
    PrivateNamespace(null, "net.wg.gui.lobby.profile:ProfileTabNavigator"), "initData") => PackageNamespace(""), "initData")
lobby.Tankman.patch
  see diff
lobby.comments.patch
  see diff
```