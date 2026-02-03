# NEXTV Channel Logos

A centralized repository of TV channel logos for the NEXTV streaming platform.

## Usage

### Direct URL Access
```
https://raw.githubusercontent.com/kalimanfresh/nextvapp-channel-logos/main/logos/{channel-name}.png
```

### API Endpoint
```
GET /api/logos/search?q={channel-name}
```

## Logo Naming Convention

- All lowercase
- Spaces replaced with hyphens (`-`)
- No special characters (only `a-z`, `0-9`, `-`)
- Remove quality suffixes (HD, SD, FHD, etc.)

### Examples
| Channel Name | File Name |
|-------------|-----------|
| ESPN | `espn.png` |
| Fox Sports | `fox-sports.png` |
| HBO Max | `hbo-max.png` |
| CNN en Español | `cnn-en-espanol.png` |
| BeIN Sports 1 | `bein-sports-1.png` |

## Directory Structure

```
channel-logos/
├── logos/           # All logo files
│   ├── espn.png
│   ├── fox-sports.png
│   └── ...
├── index.json       # Logo index with metadata
├── categories.json  # Category mappings
└── README.md
```

## Supported Formats

- PNG (preferred - supports transparency)
- SVG (vector logos)
- WebP (modern format)
- JPG (photos/complex logos)

## Contributing

1. Fork this repository
2. Add your logo to the `/logos` directory
3. Follow the naming convention
4. Submit a pull request

## Logo Requirements

- Minimum resolution: 256x256 pixels
- Transparent background (when possible)
- Clean, recognizable design
- No watermarks or artifacts

## License

These logos are trademarks of their respective owners and are used for identification purposes only.
