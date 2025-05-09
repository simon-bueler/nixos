{...}: {
  services.aerospace = {
    enable = true;
    settings = {
      mode.main.binding = {
        ctrl-t = "exec-and-forget wezterm start";

        cmd-h = []; # Disable "hide application"
        cmd-ctrl-h = []; # Disable "hide others"

        ctrl-f = "fullscreen";
        # See: https://nikitabobko.github.io/AeroSpace/commands#layout
        ctrl-shift-period = "layout tiles horizontal vertical";
        ctrl-shift-comma = "layout accordion horizontal vertical";

        # See: https://nikitabobko.github.io/AeroSpace/commands#focus
        ctrl-h = "focus left";
        ctrl-j = "focus down";
        ctrl-k = "focus up";
        ctrl-l = "focus right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move
        ctrl-shift-h = "move left";
        ctrl-shift-j = "move down";
        ctrl-shift-k = "move up";
        ctrl-shift-l = "move right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#resize
        ctrl-up = "resize smart -50";
        ctrl-down = "resize smart +50";

        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
        ctrl-1 = "workspace 1";
        ctrl-2 = "workspace 2";
        ctrl-3 = "workspace 3";
        ctrl-4 = "workspace 4";
        ctrl-5 = "workspace 5";
        ctrl-6 = "workspace 6";
        ctrl-7 = "workspace 7";
        ctrl-8 = "workspace 8";
        ctrl-9 = "workspace 9";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
        ctrl-shift-1 = "move-node-to-workspace 1";
        ctrl-shift-2 = "move-node-to-workspace 2";
        ctrl-shift-3 = "move-node-to-workspace 3";
        ctrl-shift-4 = "move-node-to-workspace 4";
        ctrl-shift-5 = "move-node-to-workspace 5";
        ctrl-shift-6 = "move-node-to-workspace 6";
        ctrl-shift-7 = "move-node-to-workspace 7";
        ctrl-shift-8 = "move-node-to-workspace 8";
        ctrl-shift-9 = "move-node-to-workspace 9";

        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
        ctrl-tab = "workspace-back-and-forth";
        # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
        ctrl-shift-tab = "move-workspace-to-monitor --wrap-around next";

        # See: https://nikitabobko.github.io/AeroSpace/commands#mode
        ctrl-shift-s = "mode service";
      };
      # "service" binding mode declaration.
      # See: https://nikitabobko.github.io/AeroSpace/guide#binding-modes
      mode.service.binding = {
        esc = ["reload-config" "mode main"];
        r = ["flatten-workspace-tree" "mode main"]; # reset layout
        f = ["layout floating tiling" "mode main"]; # Toggle between floating and tiling layout
        backspace = ["close-all-windows-but-current" "mode main"];

        # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
        #s = ["layout sticky tiling", "mode main"]

        ctrl-shift-h = ["join-with left" "mode main"];
        ctrl-shift-j = ["join-with down" "mode main"];
        ctrl-shift-k = ["join-with up" "mode main"];
        ctrl-shift-l = ["join-with right" "mode main"];
      };
    };
  };
}
