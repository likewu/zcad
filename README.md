# ZCAD
[→ Download ←](https://github.com/zamtmn/zcad/releases)
## Overview
ZCAD is simple CAD program, written in Lazarus / FPC.

License: mLGPLv2

Features:
* Fast OpenGL rendering
* Fast GDI rendering
* Crossplatform (Windows x86/x64, Linux x86/x64 - gtk/qt)
* DXF fileformat
* SHX, TTF font support
* true DXF linetypes
* POINT, LINE, CIRCLE, POLYLINE,  LWPOLYLINE, ARC, ELLIPSE, INSERT, TEXT, MTEXT, 3DFACE, SOLID, SPLINE entities support
* Polar tracking, Object snap

ToDo:
* ~~Dimensional entities~~ (partially done)
* ~~Line type~~
* More entities
* ~~Separate graphics engine from the CAD implementation~~ (partially done)
* ~~GDI and canvas render backends~~
* DX render backend
* ~~Printing~~

## Build from source
Requirements:

* **Lazarus 2.0.10 (or trunk)**
* **FPC 3.2 (or trunk)**

Build ZCAD:

* install zcad packages from '**cad_sources/components**' to lazarus
* install third party packages from '**cad_sources/other**' to lazarus:
  * cad_source\other\AGraphLaz\lazarus\ *.lpk
  * cad_source\other\laz.virtualtreeview_package\laz.virtualtreeview_package.lpk
  * cad_source\other\uniqueinstance\uniqueinstance_package.lpk
* check whether the **PATH** variable includes path to lazbuild binary
* if need set **PATH** variable: `$ export PATH="$PATH:/your/patch/to/lazarus/"`
* run `$ ./zcad.sh` (or zcadelectrotech.sh) file
* open zcad.lpi in lazarus and compile
