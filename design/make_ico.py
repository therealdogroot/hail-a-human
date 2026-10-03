"""Pack PNG files into a .ico (PNG-compressed entries). Usage: make_ico.py in1.png [in2.png ...] out.ico"""
import struct, sys

def size(png):
    w, h = struct.unpack(">II", png[16:24])
    return w, h

*ins, out = sys.argv[1:]
pngs = [open(p, "rb").read() for p in ins]
header = struct.pack("<HHH", 0, 1, len(pngs))
offset = 6 + 16 * len(pngs)
entries, data = b"", b""
for png in pngs:
    w, h = size(png)
    entries += struct.pack("<BBBBHHII", w % 256, h % 256, 0, 0, 1, 32, len(png), offset + len(data))
    data += png
open(out, "wb").write(header + entries + data)
