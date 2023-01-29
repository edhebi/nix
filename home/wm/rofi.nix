{ pkgs, config, ... }:

{
	programs.rofi = {
		enable = true;

		extraConfig = {
			"modes" = "window,run,drun,filebrowser";
		};

		theme = let
			lit = config.lib.formats.rasi.mkLiteral;
			deepMapAttrs = f: builtins.mapAttrs (k: v: 
				if builtins.isAttrs v then deepMapAttrs f v else f v
			);
			colors = deepMapAttrs lit pkgs.rose-pine.dawn;
			at = var: lit "@${var}";
			px = x: lit "${toString x}px";
		in {
			"*" = {
				highlight = lit "bold";
				scrollbar = true;

				background                  = colors.base;
				background-color            = at "background";
				foreground                  = colors.text;
				border-color                = colors.subtle;
				separatorcolor              = at "border-color";
				scrollbar-handle            = at "border-color";

				normal-background           = at "background";
				normal-foreground           = at "foreground";
				active-background           = colors.pine;
				active-foreground           = at "background";
				urgent-background           = colors.love;
				urgent-foreground           = at "background";

				normal-normal-background    = at "normal-background";
				normal-normal-foreground    = at "normal-foreground";
				alternate-normal-background = colors.highlight.low;
				alternate-normal-foreground = at "foreground";
				selected-normal-background  = colors.pine;
				selected-normal-foreground  = at "background";

				normal-active-background    = at "active-background";
				normal-active-foreground    = at "active-foreground";
				alternate-active-background = at "active-background";
				alternate-active-foreground = at "active-foreground";
				selected-active-background  = at "active-background";
				selected-active-foreground  = at "active-foreground";

				normal-urgent-background    = at "urgent-background";
				normal-urgent-foreground    = at "urgent-foreground";
				alternate-urgent-background = at "urgent-background";
				alternate-urgent-foreground = at "urgent-foreground";
				selected-urgent-background  = at "urgent-background";
				selected-urgent-foreground  = at "urgent-foreground";
			};

			window = {
				background-color = at "background";
				border           = 2;
				padding          = 2;
			};

			mainbox = {
				border  = 0;
				padding = 0;
			};

			message = {
				border       = lit "2px 0 0";
				border-color = at "separatorcolor";
				padding      = px 1;
			};

			textbox = {
				highlight  = at "highlight";
				text-color = at "foreground";
			};

			listview = {
				border       = lit "2px solid 0 0";
				padding      = lit "2px 0 0";
				border-color = at "separatorcolor";
				spacing      = px 2;
				scrollbar    = at "scrollbar";
			};

			scrollbar = {
				width         = px 4;
				border        = px 0;
				handle-color  = at "scrollbar-handle";
				handle-width  = px 8;
				padding       = px 0;
			};

			mode-switcher = {
				border       = lit "2px 0 0";
				border-color = at "separatorcolor";
			};

			inputbar = {
				spacing    = px 0;
				text-color = at "normal-foreground";
				padding    = px 2;
				children   = map lit [
					"prompt" "textbox-prompt-sep" "entry" "case-indicator"
				];
			};

			"button.selected" = {
				background-color = at "selected-normal-background";
				text-color       = at "selected-normal-foreground";
			};

			textbox-prompt-sep = {
				expand     = false;
				str        = ":";
				text-color = at "normal-foreground";
				margin     = lit "0 0.3em 0 0";
			};

			"case-indicator, entry, prompt, button" = {
				spacing    = 0;
				text-color = at "normal-foreground";
			};

			element = {
				border  = px 0;
				padding = px 2;
			};

			"element-text, element-icon" = {
				background-color = lit "inherit";
				text-color       = lit "inherit";
			};
		} // (let
			kinds = [ "normal" "alternate" "selected" ];
			statuses = [ "normal" "urgent" "active" ];
			combinations = f: builtins.concatMap (k: map (f k) statuses) kinds;
		in builtins.foldl' (a: b: a // b) {} (combinations (kind: status: {
			"element.${kind}.${status}" = {
				background-color = at "${kind}-${status}-background";
				text-color       = at "${kind}-${status}-foreground";
			};
		})));
	};
}
