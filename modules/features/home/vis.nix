{
  self,
  ...
}: {
  flake.homeModules.vis = {
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      vis
      wl-clipboard # Enables vis-clipboard under Wayland
      fzf # Fuzzy finder (Telescope / Harpoon picker)
      ripgrep # Project grep
    ];

    # Rose-Pine Theme for Vis (with transparent background)
    xdg.configFile."vis/themes/rose-pine.lua".text = ''
      local lexers = vis.lexers

      lexers.STYLE_DEFAULT = 'fore:#e0def4'
      lexers.STYLE_NOTHING = ""
      lexers.STYLE_CLASS = 'fore:#9ccfd8'
      lexers.STYLE_COMMENT = 'fore:#6e6a86'
      lexers.STYLE_CONSTANT = 'fore:#ebbcba'
      lexers.STYLE_DEFINITION = 'fore:#ebbcba,bold'
      lexers.STYLE_ERROR = 'fore:#eb6f92,bold'
      lexers.STYLE_FUNCTION = 'fore:#ebbcba'
      lexers.STYLE_KEYWORD = 'fore:#31748f,bold'
      lexers.STYLE_LABEL = 'fore:#9ccfd8'
      lexers.STYLE_NUMBER = 'fore:#f6c177'
      lexers.STYLE_OPERATOR = 'fore:#908caa'
      lexers.STYLE_REGEX = 'fore:#ebbcba'
      lexers.STYLE_STRING = 'fore:#f6c177'
      lexers.STYLE_PREPROCESSOR = 'fore:#c4a7e7'
      lexers.STYLE_TAG = 'fore:#9ccfd8'
      lexers.STYLE_TYPE = 'fore:#9ccfd8'
      lexers.STYLE_VARIABLE = 'fore:#e0def4'
      lexers.STYLE_WHITESPACE = ""
      lexers.STYLE_EMBEDDED = 'fore:#c4a7e7'
      lexers.STYLE_IDENTIFIER = ""

      lexers.STYLE_LINENUMBER = 'fore:#6e6a86'
      lexers.STYLE_LINENUMBER_CURSOR = 'fore:#e0def4,bold'
      lexers.STYLE_CURSOR = 'back:#524f67,keep_attribute'
      lexers.STYLE_CURSOR_PRIMARY = 'fore:#191724,back:#ebbcba,bold,keep_attribute'
      lexers.STYLE_CURSOR_LINE = 'back:#21202e,keep_attribute'
      lexers.STYLE_COLOR_COLUMN = 'back:#21202e'
      lexers.STYLE_SELECTION = 'back:#403d52'
      lexers.STYLE_STATUS = 'back:#1f1d2e,fore:#908caa'
      lexers.STYLE_STATUS_FOCUSED = 'back:#26233a,fore:#e0def4,bold'
      lexers.STYLE_SEPARATOR = ""
      lexers.STYLE_INFO = 'fore:#f6c177'
      lexers.STYLE_EOF = 'fore:#403d52'
    '';

    # Vis editor configuration (~/.config/vis/visrc.lua)
    xdg.configFile."vis/visrc.lua".text = ''
      require('vis')

      -- Minimal Harpoon implementation for Vis
      local harpoon = { marks = {} }

      function harpoon:add()
        local win = vis.win
        if not win or not win.file or not win.file.name then return end
        local name = win.file.name
        for _, p in ipairs(self.marks) do
          if p == name then
            vis:info("Harpoon: already added " .. name)
            return
          end
        end
        table.insert(self.marks, name)
        vis:info("Harpoon: added " .. name .. " [#" .. #self.marks .. "]")
      end

      function harpoon:select(idx)
        local target = self.marks[idx]
        if target then
          vis:command(string.format('e %q', target))
        else
          vis:info("Harpoon: slot " .. idx .. " is empty")
        end
      end

      function harpoon:menu()
        if #self.marks == 0 then
          vis:info("Harpoon: list is empty")
          return
        end
        local list = table.concat(self.marks, "\n")
        local status, out = vis:pipe(list, "vis-menu -b -p 'Harpoon >'", false)
        if status == 0 and out and #out > 0 then
          local choice = out:gsub('[\r\n]', "")
          vis:command(string.format('e %q', choice))
        end
      end

      -- Telescope-style Fuzzy Finders
      local function fzf_find_files()
        local status, out = vis:pipe('fzf', true)
        if status == 0 and out and #out > 0 then
          local path = out:gsub('[\r\n]', "")
          vis:command(string.format('e %q', path))
        end
      end

      local function fzf_live_grep()
        local status, out = vis:pipe('rg --column --line-number --no-heading --color=always --smart-case "" | fzf --ansi --delimiter : --preview "bat --style=numbers --color=always {1} --highlight-line {2} 2>/dev/null || cat {1}"', true)
        if status == 0 and out and #out > 0 then
          local file, line = out:match("^([^:]+):(%d+)")
          if file then
            vis:command(string.format('e %q', file))
            if line and vis.win then
              vis.win.selection:to(vis.win.file:offset_from_line_column(tonumber(line), 1))
              vis:feedkeys('<vis-window-redraw-center>')
            end
          end
        end
      end

      vis.events.subscribe(vis.events.INIT, function()
        local leader = '<Space>'

        -- Theme
        vis:command('set theme rose-pine')

        -- Quick save / quit
        vis:map(vis.modes.NORMAL, leader .. 'w', ':w<Enter>')
        vis:map(vis.modes.NORMAL, leader .. 'q', ':q<Enter>')

        -- Project View (<leader>pv -> :e .)
        vis:map(vis.modes.NORMAL, leader .. 'pv', ':e .<Enter>')

        -- Telescope equivalents (<leader>pf, <C-p>, <leader>ps)
        vis:map(vis.modes.NORMAL, leader .. 'pf', fzf_find_files)
        vis:map(vis.modes.NORMAL, '<C-p>', fzf_find_files)
        vis:map(vis.modes.NORMAL, leader .. 'ps', fzf_live_grep)

        -- Harpoon mappings
        vis:map(vis.modes.NORMAL, leader .. 'a', function() harpoon:add() end)
        vis:map(vis.modes.NORMAL, '<C-e>', function() harpoon:menu() end)
        vis:map(vis.modes.NORMAL, '<C-h>', function() harpoon:select(1) end)
        vis:map(vis.modes.NORMAL, '<C-t>', function() harpoon:select(2) end)
        vis:map(vis.modes.NORMAL, '<C-n>', function() harpoon:select(3) end)
        vis:map(vis.modes.NORMAL, '<C-s>', function() harpoon:select(4) end)

        -- Centered scrolling & search
        vis:map(vis.modes.NORMAL, '<C-d>', '<vis-window-halfpage-down><vis-window-redraw-center>')
        vis:map(vis.modes.NORMAL, '<C-u>', '<vis-window-halfpage-up><vis-window-redraw-center>')
        vis:map(vis.modes.NORMAL, 'n', '<vis-motion-search-repeat-forward><vis-window-redraw-center>')
        vis:map(vis.modes.NORMAL, 'N', '<vis-motion-search-repeat-backward><vis-window-redraw-center>')

        -- Void register operations
        vis:map(vis.modes.NORMAL, leader .. 'd', '"_d')
        vis:map(vis.modes.VISUAL, leader .. 'd', '"_d')
        vis:map(vis.modes.VISUAL, leader .. 'p', '"_dP')

        -- System Clipboard (Wayland / wl-clipboard integration)
        vis:map(vis.modes.VISUAL, leader .. 'y', ':> vis-clipboard --copy<Enter>')
        vis:map(vis.modes.VISUAL_LINE, leader .. 'y', ':> vis-clipboard --copy<Enter>')
        vis:map(vis.modes.NORMAL, leader .. 'p', ':< vis-clipboard --paste<Enter>')
        vis:map(vis.modes.NORMAL, leader .. 'Y', function()
          local win = vis.win
          if win and win.file then
            local line = win.file.lines[win.selection.line]
            if line then
              vis:pipe(line .. '\n', "vis-clipboard --copy")
              vis:info("Yanked line to clipboard")
            end
          end
        end)

        -- Move lines in Visual mode (ThePrimeagen J and K)
        vis:map(vis.modes.VISUAL, 'J', function()
          local win = vis.win
          if not win or not win.file then return end
          local line = win.selection.line
          if line < #win.file.lines then
            local tmp = win.file.lines[line]
            win.file.lines[line] = win.file.lines[line + 1]
            win.file.lines[line + 1] = tmp
            win.selection:to(win.file:offset_from_line_column(line + 1, win.selection.col))
          end
        end)

        vis:map(vis.modes.VISUAL, 'K', function()
          local win = vis.win
          if not win or not win.file then return end
          local line = win.selection.line
          if line > 1 then
            local tmp = win.file.lines[line]
            win.file.lines[line] = win.file.lines[line - 1]
            win.file.lines[line - 1] = tmp
            win.selection:to(win.file:offset_from_line_column(line - 1, win.selection.col))
          end
        end)

        -- Make file executable (<leader>x)
        vis:map(vis.modes.NORMAL, leader .. 'x', function()
          local win = vis.win
          if win and win.file and win.file.name then
            os.execute('chmod +x ' .. win.file.name)
            vis:info("chmod +x " .. win.file.name)
          end
        end)

        -- Escaping from insert mode
        vis:map(vis.modes.INSERT, '<C-c>', '<Escape>')
      end)

      vis.events.subscribe(vis.events.WIN_OPEN, function(win)
        -- Window options
        vis:command('set numbers')
        vis:command('set relativenumbers')
        vis:command('set tabwidth 4')
        vis:command('set expandtab')
        vis:command('set autoindent')
        vis:command('set cursorline')
        vis:command('set colorcolumn 80')
        vis:command('set ignorecase')
      end)
    '';
  };
}
