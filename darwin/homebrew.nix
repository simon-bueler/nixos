{ pkgs, inputs, config, ... }: {
  homebrew = {
    enable =true;
    brews = [
      "mas"
    ];
    casks = [
      # "Name"
    ];
    masApps = {
      #"Name" = AppStoreID; --> mas search NAME
    };
    onActivation.cleanup = "zap";
  };
}
