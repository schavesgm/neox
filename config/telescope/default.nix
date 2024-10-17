{ lib, config, ... }: {
  # Allow the user to use this module if wanted
  options = {
    telescope.enable = lib.mkEnableOption "Enable telescope plugin";
  };

  # Set the configuration of telescope
  config = lib.mkIf config.telescope.enable {
     plugins.telescope = {
       enable = true;
       extensions = {
         fzf-native = {
           enable = true;
           settings = {
             fuzzy = true;
             override_generic_sorter = true;
             override_file_sorter = true;
             case_mode = "smart_case";
           };
        };
        ui-select = {
          enable = true;
          settings = {
            specific_opts = {
              codeactions = true;
            };
          };
        };
      };
      settings = {
        defaults = {
	  mappings = {
	    i = {
	      "<C-k>" = { 
	        __raw = ''require("telescope.actions").move_selection_previous'';
	      };
	      "<C-j>" = { 
	        __raw = ''require("telescope.actions").move_selection_next'';
	      };
	    };
	  };
	};
	layout_config = {
	  horizontal = {
	    prompt_position = "top";
            preview_width = 0.55;
            results_width = 0.8;
   	  };
          width = 0.87;
          height = 0.80;
	};
        pickers = {
          colorscheme = {
            enable_preview = true;
          };
          find_files = {
            theme = "ivy";
	    hidden = true;
          };
        };
      };
      keymaps = {
        # Mappings to instantiate Telescope
        "<leader>tf" = {
	  mode = "n";
	  action = "find_files";
	  options.desc = "Find files inside the project";
	};
        "<leader>tg" = {
	  mode = "n";
	  action = "live_grep";
	  options.desc = "Perform fuzzy grep in the project";
	};
        "<leader>tr" = {
	  mode = "n";
	  action = "resume";
	  options.desc = "Resume telescope session";
	};
      };
    };
  };
}
