{ systemSettings, ... }:
let
    loc = systemSettings.locale;
in
{
    i18n.defaultLocale = loc;
}
