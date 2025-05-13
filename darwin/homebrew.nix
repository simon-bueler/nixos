{...}: {
  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      "fuse-t"
      "cryptomator"
    ];
    masApps = {
      #"Name" = AppStoreID; --> mas search NAME
      "WireGuard" = 1451685025;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
