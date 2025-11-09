# Nano Editor Configuration

This directory contains configuration for the Nano text editor, styled with a VS Code-inspired dark theme that works well on macOS. The configuration provides a modern, user-friendly editing experience while maintaining Nano's simplicity.

## Features

### Visual Enhancements
- VS Code-inspired dark color scheme
- Line numbers enabled by default
- Syntax highlighting for various programming languages
- Custom color scheme for UI elements:
  - Title bar: bright white text on blue background
  - Status bar: bright white text on black background
  - Selected text: black text on white background
  - Line numbers: cyan color

### Editor Behavior
- Soft text wrapping enabled
- 4-space tab width
- Automatic indentation
- Mouse support enabled
- Syntax highlighting for multiple file types

## Installation

1. Copy the `.nanorc` file to your home directory:
```bash
cp .nanorc ~/.nanorc
```

2. Create a directory for syntax definitions:
```bash
mkdir -p ~/.nano
```

3. Install syntax highlighting files (if not included):
```bash
# You can get these from https://github.com/scopatz/nanorc
# or use your package manager
```

## Configuration Details

### Basic Settings
```ini
set linenumbers      # Show line numbers
set softwrap         # Enable soft text wrapping
set tabsize 4        # Set tab width to 4 spaces
set autoindent       # Enable automatic indentation
set mouse           # Enable mouse support
```

### Color Scheme
```ini
set titlecolor brightwhite,blue    # Title bar colors
set statuscolor brightwhite,black  # Status bar colors
set selectedcolor black,white      # Selected text colors
set numbercolor cyan               # Line number colors
```

## Terminal Requirements
- Use a dark terminal theme (recommended: "Pro" or "Tango Dark")
- Ensure your terminal supports 256 colors

## Usage Tips

### Common Shortcuts
- `Ctrl+G`: Get help
- `Ctrl+X`: Exit nano
- `Ctrl+O`: Save file
- `Ctrl+W`: Search in file
- `Ctrl+K`: Cut line
- `Ctrl+U`: Paste line
- `Ctrl+C`: Show cursor position
- `Ctrl+_`: Go to line number

### Navigation
- Use mouse scrolling and clicking (enabled by default)
- Arrow keys for cursor movement
- `Ctrl+Space` or `Alt+Space`: Next word
- `Ctrl+A`: Beginning of line
- `Ctrl+E`: End of line

## Customization

You can customize the configuration by editing `~/.nanorc`. Some common modifications:

1. Change tab size:
```ini
set tabsize 2  # Or any other number
```

2. Disable line numbers:
```ini
# Comment out or remove the 'set linenumbers' line
```

3. Change color scheme:
```ini
set titlecolor [color],[background]
set statuscolor [color],[background]
set selectedcolor [color],[background]
set numbercolor [color]
```

Available colors:
- white, black, red, blue, green, yellow, magenta, cyan
- Add 'bright' prefix for lighter versions (e.g., brightwhite)

## Troubleshooting

1. Syntax highlighting not working:
   - Ensure syntax files are properly installed in `~/.nano/`
   - Check if the file extension is supported

2. Colors look wrong:
   - Verify your terminal supports 256 colors
   - Try a different terminal theme
   - Ensure you're using a dark terminal background

3. Mouse support not working:
   - Check if your terminal emulator supports mouse events
   - Try running `export TERM=xterm-256color` before starting nano