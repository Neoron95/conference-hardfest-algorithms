"""Embed the installed, exact static Aptos/Montserrat faces in a PPTX package.

Usage: python3 embed_fonts.py INPUT OUTPUT [FONT_DIRECTORY]
Font files are unmodified inside uncompressed EOT 2.1 wrappers. No slide,
media, timing, or notes part is rewritten. See fonts.md for download sources.
EOT format: https://www.w3.org/submissions/2008/SUBM-EOT-20080305/
"""
import struct
import sys
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
from lxml import etree as E

P = 'http://schemas.openxmlformats.org/presentationml/2006/main'
R = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships'
PK = 'http://schemas.openxmlformats.org/package/2006/relationships'

def eot(path):
    data = path.read_bytes()
    assert data[:4] == b'\x00\x01\x00\x00', path
    tables = {}
    for i in range(struct.unpack_from('>H', data, 4)[0]):
        tag, _, offset, size = struct.unpack_from('>4sIII', data, 12 + 16 * i)
        tables[tag.decode()] = data[offset:offset + size]
    os2 = tables['OS/2']
    rights = struct.unpack_from('>H', os2, 8)[0]
    assert not rights & 0x202 and (rights & 0xF) in (0, 8), (path, rights)
    names = tables['name']
    string_offset = struct.unpack_from('>H', names, 4)[0]
    english = {}
    for i in range(struct.unpack_from('>H', names, 2)[0]):
        platform, _, language, name_id, size, offset = struct.unpack_from('>6H', names, 6 + 12 * i)
        if platform == 3 and language == 1033:
            english[name_id] = names[string_offset + offset:string_offset + offset + size].decode('utf-16-be')
    header = struct.pack('<IIII10sBBIHH7I4I',
        0, len(data), 0x00020001, 0, os2[32:42], 1,
        struct.unpack_from('>H', os2, 62)[0] & 1,
        struct.unpack_from('>H', os2, 4)[0], rights, 0x504C,
        *struct.unpack_from('>4I', os2, 42),
        *struct.unpack_from('>2I', os2, 78),
        struct.unpack_from('>I', tables['head'], 8)[0], 0, 0, 0, 0)
    for name_id in (1, 2, 5, 4):
        name = english[name_id].encode('utf-16-le')
        header += struct.pack('<HH', 0, len(name)) + name
    header += struct.pack('<HH', 0, 0)  # padding and empty RootString
    result = struct.pack('<I', len(header) + len(data)) + header[4:] + data
    assert result[-len(data):] == data
    return result, english[1]

def embed_fonts(source, output, directory):
    with ZipFile(source) as z:
        parts = {n: z.read(n) for n in z.namelist()}
    pres = E.fromstring(parts['ppt/presentation.xml'])
    rels = E.fromstring(parts['ppt/_rels/presentation.xml.rels'])
    fonts = pres.find(f'{{{P}}}embeddedFontLst')
    assert fonts is not None
    replacements = {
        'Montserrat': ['Montserrat-Regular.ttf', 'Montserrat-Bold.ttf', 'Montserrat-Italic.ttf', 'Montserrat-BoldItalic.ttf'],
        'Montserrat SemiBold': ['Montserrat-SemiBold.ttf', 'Montserrat-SemiBold.ttf', 'Montserrat-SemiBoldItalic.ttf', 'Montserrat-SemiBoldItalic.ttf'],
        'Montserrat ExtraBold': ['Montserrat-ExtraBold.ttf', 'Montserrat-ExtraBold.ttf', 'Montserrat-ExtraBoldItalic.ttf', 'Montserrat-ExtraBoldItalic.ttf'],
        'Aptos': ['Aptos.ttf', 'Aptos-Bold.ttf', 'Aptos-Italic.ttf', 'Aptos-Bold-Italic.ttf'],
    }
    removed_ids = set()
    for font in list(fonts):
        if font.find(f'{{{P}}}font').get('typeface') in replacements:
            removed_ids.update(n.get(f'{{{R}}}id') for n in font if n.get(f'{{{R}}}id'))
            fonts.remove(font)
    for rel in list(rels):
        if rel.get('Id') in removed_ids:
            part = rel.get('Target').lstrip('/')
            if not part.startswith('ppt/'):
                part = 'ppt/' + part
            parts.pop(part, None)
            rels.remove(rel)
    cache = {}
    for family, files in replacements.items():
        font = E.SubElement(fonts, f'{{{P}}}embeddedFont')
        E.SubElement(font, f'{{{P}}}font', typeface=family)
        for style, filename in zip(('regular', 'bold', 'italic', 'boldItalic'), files):
            if filename not in cache:
                blob, actual_family = eot(directory / filename)
                assert actual_family == family, (family, actual_family)
                part = 'ppt/fonts/' + Path(filename).stem + '-full.fntdata'
                rid = 'rIdExactFont' + str(len(cache) + 1)
                assert not any(x.get('Id') == rid for x in rels)
                parts[part] = blob
                E.SubElement(rels, f'{{{PK}}}Relationship', Id=rid, Type=R + '/font', Target='/' + part)
                cache[filename] = rid
            E.SubElement(font, f'{{{P}}}' + style).set(f'{{{R}}}id', cache[filename])
    pres.set('embedTrueTypeFonts', '1')
    pres.set('saveSubsetFonts', '0')
    for part, root in [('ppt/presentation.xml', pres), ('ppt/_rels/presentation.xml.rels', rels)]:
        parts[part] = E.tostring(root, encoding='UTF-8', xml_declaration=True, standalone=True)
    with ZipFile(output, 'w', ZIP_DEFLATED) as z:
        for n, content in parts.items():
            z.writestr(n, content)
    print(f'Embedded {len(cache)} exact static faces in {output}')

if __name__ == '__main__':
    embed_fonts(Path(sys.argv[1]), Path(sys.argv[2]), Path(sys.argv[3]) if len(sys.argv) > 3 else Path.home() / 'Library/Fonts')
