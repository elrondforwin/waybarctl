# waybarctl

``waybarctl`` is a simple bash script that makes Waybar theme switching easier through terminal commands.

### Installation

Installation script for most distros. Requires ``curl``
```
curl -fsSL https://raw.githubusercontent.com/elrondforwin/waybarctl/refs/heads/main/install-waybarctl.sh | bash
```

### Updating
Run the install script again. It will update it.
```
curl -fsSL https://raw.githubusercontent.com/elrondforwin/waybarctl/refs/heads/main/install-waybarctl.sh | bash
```
### Uninstallation
```
rm ~/.local/bin/waybarctl
```

### Usage

``waybarctl reload`` - reload Waybar.

``waybarctl theme <themename>`` - set a waybar theme.

``waybarctl theme list`` - list all available themes.

``waybarctl theme remove`` - deactivate the current theme and fallback to Waybar default.

You can create themes in ``~/.config/waybar/themes`` directory.
You have to create a directory for each theme and place the configs and styles inside the directory.

### Example file structure
```
~/.config/waybar/
└── themes/
    ├── gruvbox/
    │   ├── config.jsonc
    │   └── style.css
    │
    ├── nord/
    │   ├── config.jsonc
    │   └── style.css
    │
    └── catppuccin/
        ├── config.jsonc
        └── style.css
```
In this case, ``waybarctl theme gruvbox`` command will apply ``gruvbox`` theme to waybar and automatically reload it.
