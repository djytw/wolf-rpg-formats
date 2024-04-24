meta:
  id: game_dat
  endian: le
enums:
  version_header:
    0: 'v2'
    0x55: 'v3'
  version_footer:
    0xc2: 'v2'
    0xc3: 'v3_0'
    0xc4: 'v3_3'
  fps:
    30: 'f30'
    60: 'f60'
  tile_size:
    16: 't16x16' 
    32: 't32x32' 
    40: 't40x40' 
    48: 't48x48'
  midi_source:
    0: 'hardware'
    1: 'software'
    2: 'disabled'
  venable:
    0: 'disabled'
    1: 'enabled'
  character_directions:
    4: 'd4'
    8: 'd8'
  character_animation_patterns:
    3: 'p3'
    5: 'p5'
  character_animation:
    0: 'back_and_forth'
    1: 'loop'
  character_movement_width:
    0: 'square0_5'
    1: 'square1'
  anti_aliasing:
    0: 'enabled'
    1: 'disabled'
    2: 'disabled_double_width'
  move_speed:
    4: 'speed_1x'
    5: 'speed_1_25x'
    6: 'speed_1_5x'
    7: 'speed_1_75x'
    8: 'speed_2x'
    9: 'custom'
  language:
    1: 'japanese'
    2: 'hangul'
    3: 'traditional_chinese'
    4: 'simplified_chinese'
    5: 'english'
    6: 'western_european'
  image_scale:
    0: 'rough'
    1: 'smooth'
  inactive_behavior:
    0: 'pause'
    1: 'running'
  system_language:
    0: 'japanese'
    1: 'english'
  screen_scale:
    1: 'scale_1x'
    2: 'scale_2x'
    3: 'scale_3x'
types:
  vstr:
    seq:
      - id: len
        type: u4
      - id: str
        type: strz
        size: len
        encoding: 'UTF-8'
  vstr_sjis:
    seq:
      - id: len
        type: u4
      - id: str
        type: strz
        size: len
        encoding: 'Shift-JIS'
  record_u8_settings:
    seq:
    - id: tile_size
      type: u1
      enum: tile_size
    - id: character_directions_image
      type: u1
      enum: character_directions
    - id: character_directions_move
      type: u1
      enum: character_directions
    - id: guruguru_enabled
      type: u1
      enum: venable
    - id: fps
      type: u1
      enum: fps
    - id: character_shadow
      type: u1
      enum: venable
    - id: midi_source
      type: u1
      enum: midi_source
    - id: character_animation_patterns
      type: u1
      enum: character_animation_patterns
    - id: character_movement_width
      type: u1
      enum: character_movement_width
    - id: character_movement_hitbox
      type: u1
      enum: character_movement_width
    - id: text_horizontal_padding
      type: u1
    - id: text_line_spacing
      type: u1
    - id: choice_line_spacing
      type: u1
    - id: unknown
      type: u1
    - id: anti_aliasing
      type: u1
      enum: anti_aliasing
    - id: move_speed_event
      type: u1
      enum: move_speed
    - id: move_speed_hero_allies
      type: u1
      enum: move_speed
    - id: in_game_language
      type: u1
      enum: language
    - id: image_scaling_method
      type: u1
      enum: image_scale
    - id: inactive_window_behavior
      type: u1
      enum: inactive_behavior
    - id: system_language
      type: u1
      enum: system_language
    - id: unknown_2
      type: u1
      if: _io.size == 35
    - id: pro_enable_f4
      type: u1
      enum: venable
      if: _io.size == 35
    - id: pro_enable_f5
      type: u1
      enum: venable
      if: _io.size == 35
    - id: pro_enable_f8
      type: u1
      enum: venable
      if: _io.size == 35
    - id: pro_enable_f11
      type: u1
      enum: venable
      if: _io.size == 35
    - id: pro_enable_f12
      type: u1
      enum: venable
      if: _io.size == 35
    - id: pro_enable_prtscr
      type: u1
      enum: venable
      if: _io.size == 35
    - id: unknown_3
      type: u1
      if: _io.size == 35
    - id: unknown_4
      type: u1
      if: _io.size == 35
    - id: unknown_5
      type: u1
      if: _io.size == 35
    - id: unknown_6
      type: u1
      if: _io.size == 35
    - id: pro_screen_scale
      type: u1
      enum: screen_scale
      if: _io.size == 35
    - id: pro_loading_fadein
      type: u1
      enum: venable
      if: _io.size == 35
    - id: pro_loading_fadeout
      type: u1
      enum: venable
      if: _io.size == 35
  record_string_settings_v3:
    seq:
    - id: game_title
      type: vstr
    - id: serial
      type: vstr
    - id: encryption_key
      type: vstr
    - id: font_base
      type: vstr
    - id: font_sub1
      type: vstr
    - id: font_sub2
      type: vstr
    - id: font_sub3
      type: vstr
    - id: starting_hero_graphic
      type: vstr
    - id: game_subtitle
      type: vstr
    - id: pro_game_loadingpic
      type: vstr
    - id: pro_game_loading_gauge
      type: vstr
    - id: pro_title_during_loading
      type: vstr
    - id: pro_title_during_gameplay
      type: vstr
  record_string_settings_v2:
    seq:
    - id: game_title
      type: vstr_sjis
    - id: serial
      type: vstr_sjis
    - id: encryption_key
      type: vstr_sjis
    - id: font_base
      type: vstr_sjis
    - id: font_sub1
      type: vstr_sjis
    - id: font_sub2
      type: vstr_sjis
    - id: font_sub3
      type: vstr_sjis
    - id: starting_hero_graphic
      type: vstr_sjis
    - id: unknown
      type: vstr
  record_u16_settings:
    seq:
    - id: len
      type: u4
    - id: unknown
      type: u2
    - id: custom_move_speed_hero_allies_0
      type: u2
    - id: custom_move_speed_events_0
      type: u2
    - id: custom_move_speed_hero_allies_1
      type: u2
    - id: custom_move_speed_events_1
      type: u2
    - id: custom_move_speed_hero_allies_2
      type: u2
    - id: custom_move_speed_events_2
      type: u2
    - id: custom_move_speed_hero_allies_3
      type: u2
    - id: custom_move_speed_events_3
      type: u2
    - id: custom_move_speed_hero_allies_4
      type: u2
    - id: custom_move_speed_events_4
      type: u2
    - id: custom_move_speed_hero_allies_5
      type: u2
    - id: custom_move_speed_events_5
      type: u2
    - id: custom_move_speed_hero_allies_6
      type: u2
    - id: custom_move_speed_events_6
      type: u2
    - id: unknown_2
      type: u2
    - id: screen_dimensions_w
      type: u2
    - id: screen_dimensions_h
      type: u2
    - id: wolf_rpg_version
      type: u2
    - id: pro_loading_gauge_x
      type: u2
      if: len > 19
    - id: pro_loading_gauge_y
      type: u2
      if: len > 20
    - id: unknown_3
      type: u2
      if: len > 21
    - id: pro_default_screen_scale
      type: u2
      if: len > 22
  static_randoms:
    doc: |
      pre-generated random numbers. It changes every time when save the game.dat file.
      Two 32-bit numbers at the begining and then 28000+ 8-bit 0~127(include) randoms.
      The randoms are generated consecutively so it's possible to predict later randoms by providing first few bytes.
      See game_dat_random.c for details. Provide the position of this block and first few bytes.
    seq:
    - id: r1
      type: u4
    - id: r2
      type: u4
    - id: randoms
      type: u1
      repeat: eos
seq:
  - id: magic
    contents: [0, 'W', 0, 0, 'O', 'L', 0, 'F', 'M']
  - id: version_header
    type: u1
    enum: version_header
  - id: u8_settings_len
    type: u4
  - id: u8_settings
    type: record_u8_settings
    size: u8_settings_len
  - id: string_settings_len
    type: u4
  - id: string_settings
    type:
      switch-on: version_header
      cases:
        version_header::v3: record_string_settings_v3
        version_header::v2: record_string_settings_v2
  - id: filesize
    type: u4
    valid: _io.size - 1
    doc: |
      `filesize == _io.size - 1` should be guaranteed.
      Also, it's suggested to make `filesize == _io.pos + 29000` by adjusting size of "static randoms" setion according to the official editor's behavior. 
  - id: unknown3
    type: u4
  - id: u16_settings
    type: record_u16_settings
  - id: static_randoms
    size: filesize - _io.pos
    type: static_randoms
  - id: footer
    type: u1
    enum: version_footer
