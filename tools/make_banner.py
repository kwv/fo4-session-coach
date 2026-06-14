from PIL import Image, ImageDraw, ImageFont
import math

W, H = 1920, 1080

# Colours — FO4 Pip-Boy amber palette
BG          = (10, 10, 10)
AMBER       = (255, 176, 0)
AMBER_DIM   = (180, 120, 0)
AMBER_FAINT = (40, 28, 0)
OFF_WHITE   = (230, 220, 200)
DIM_TEXT    = (140, 130, 110)

img  = Image.new("RGB", (W, H), BG)
draw = ImageDraw.Draw(img)

# --- subtle scanline texture ---
for y in range(0, H, 3):
    draw.line([(0, y), (W, y)], fill=(15, 14, 12), width=1)

# --- vignette (radial darkening at edges) ---
vignette = Image.new("RGB", (W, H), (0, 0, 0))
vd = ImageDraw.Draw(vignette)
cx, cy = W // 2, H // 2
steps = 30
for i in range(steps, 0, -1):
    alpha = int(180 * (1 - i / steps) ** 2)
    rx = int(cx * (i / steps) * 1.6)
    ry = int(cy * (i / steps) * 1.6)
    vd.ellipse([cx - rx, cy - ry, cx + rx, cy + ry],
               fill=(0, 0, 0, 0) if i > 1 else (0, 0, 0))
img = Image.blend(img, vignette, alpha=0.45)
draw = ImageDraw.Draw(img)

# --- amber glow strip — left edge ---
for x in range(0, 6):
    alpha = int(255 * (1 - x / 6))
    draw.line([(x, 80), (x, H - 80)], fill=AMBER, width=1)

# --- top / bottom amber rules ---
draw.rectangle([80, 70, W - 80, 74], fill=AMBER)
draw.rectangle([80, H - 74, W - 80, H - 70], fill=AMBER)

# --- fonts ---
FONT_DIR = "/usr/share/fonts/truetype"
def font(path, size):
    try:
        return ImageFont.truetype(path, size)
    except Exception:
        return ImageFont.load_default()

f_title    = font(f"{FONT_DIR}/liberation/LiberationSans-Bold.ttf",    96)
f_subtitle = font(f"{FONT_DIR}/liberation/LiberationSans-Regular.ttf", 34)
f_label    = font(f"{FONT_DIR}/dejavu/DejaVuSansMono.ttf",    22)
f_quote    = font(f"{FONT_DIR}/liberation/LiberationSans-Regular.ttf", 30)
f_quote_b  = font(f"{FONT_DIR}/liberation/LiberationSans-Bold.ttf",    30)
f_small    = font(f"{FONT_DIR}/dejavu/DejaVuSansMono.ttf",    19)

# --- title ---
title = "LUDOTRACE"
draw.text((120, 110), title, font=f_title, fill=AMBER)

# --- amber underline under title ---
bbox = draw.textbbox((120, 110), title, font=f_title)
draw.rectangle([120, bbox[3] + 8, bbox[2], bbox[3] + 11], fill=AMBER_DIM)

# --- subtitle ---
draw.text((124, bbox[3] + 24), "Session black box for Fallout 4", font=f_subtitle, fill=DIM_TEXT)

# --- divider before quotes ---
div_y = 340
draw.rectangle([120, div_y, W - 120, div_y + 1], fill=AMBER_DIM)

# --- "EXAMPLE OUTPUT" label ---
draw.text((120, div_y + 16), "EXAMPLE  AI  OUTPUT", font=f_label, fill=AMBER_DIM)

# --- quote lines ---
# Each entry: (bold_prefix, normal_suffix)
quotes = [
    (
        "You have 14 Mini Nukes",
        " and fought a Legendary\nAlpha Deathclaw for 37 minutes without using one.",
    ),
    (
        "Perception knocked to 1 three times",
        " — DLC mole rat\ndisease stacking. Visit a doctor before next session.",
    ),
    (
        "912 Plasma Cartridges, zero used.",
        " With INT 8 you\nhave Science! ranks. Plasma shreds armored targets.",
    ),
]

def draw_mixed(draw, x, y, bold_text, normal_text, f_bold, f_normal, fill_bold, fill_normal, line_h):
    """Draw a bold prefix then normal text, wrapping at newlines."""
    # bold part
    bw = draw.textlength(bold_text, font=f_bold)
    draw.text((x, y), bold_text, font=f_bold, fill=fill_bold)
    cx = x + bw

    # normal part — split on \n and render line by line
    parts = normal_text.split("\n")
    for i, part in enumerate(parts):
        if i == 0:
            draw.text((cx, y), part, font=f_normal, fill=fill_normal)
        else:
            y += line_h
            cx = x
            draw.text((cx, y), part, font=f_normal, fill=fill_normal)
    return y

LINE_H = 38
qy = div_y + 60
BULLET_AMBER = (255, 176, 0)

for bold, normal in quotes:
    draw.text((120, qy + 4), "▸", font=f_label, fill=AMBER)
    end_y = draw_mixed(draw, 148, qy, bold, normal, f_quote_b, f_quote,
                       AMBER, OFF_WHITE, LINE_H)
    qy = end_y + 52

# --- right panel: log snippet ---
panel_x = 1100
panel_w = W - panel_x - 80

# vertical divider
draw.rectangle([panel_x - 30, div_y, panel_x - 28, H - 80], fill=AMBER_DIM)

# label
draw.text((panel_x, div_y + 16), "SESSION  LOG  (JSONL)", font=f_label, fill=AMBER_DIM)

log_lines = [
    '{"type":"session_start","level":40,"name":"Rhea",',
    ' "special":{"S":11,"P":7,"E":4,"C":7,"I":8,"A":6,"L":7},',
    ' "bobbleheads":["Charisma","Intelligence","Strength"],',
    ' "ammo":{"Mini Nuke":14,"Plasma Cartridge":912,...}}',
    '',
    '{"type":"location","name":"Vault 88","time":"18:17"}',
    '{"type":"kill","target":"Mole Rat Brood Mother",',
    ' "killer":"Rhea","time":"18:40"}',
    '{"type":"av_change","av":"Perception",',
    ' "from":4,"to":1,"time":"19:04"}',
    '{"type":"kill","target":"Legendary Alpha Deathclaw",',
    ' "killer":"Rhea","time":"22:38"}',
    '{"type":"stat","stat":"Stimpaks Taken",',
    ' "value":187,"time":"22:38"}',
    '',
    '{"type":"session_end","level":40,',
    ' "ammo":{"Mini Nuke":14,"Plasma Cartridge":912,...}}',
]

f_log = font(f"{FONT_DIR}/dejavu/DejaVuSansMono.ttf", 20)
ly = div_y + 60
for line in log_lines:
    color = AMBER if line.startswith('{"type":"session') else \
            (AMBER_DIM if line.startswith(' ') else OFF_WHITE)
    if line == '':
        ly += 10
        continue
    draw.text((panel_x, ly), line, font=f_log, fill=color)
    ly += 28

# --- bottom tagline ---
tagline = "Logs kills · quests · locations · inventory · combat events · SPECIAL changes"
draw.text((120, H - 110), tagline, font=f_small, fill=DIM_TEXT)

# --- github url bottom right ---
url = "github.com/ludotrace/fallout4"
uw = draw.textlength(url, font=f_small)
draw.text((W - 120 - uw, H - 110), url, font=f_small, fill=AMBER_DIM)

# --- save ---
out = "docs/nexus_banner.png"
img.save(out, "PNG")
print(f"Saved {out}  ({W}x{H})")
