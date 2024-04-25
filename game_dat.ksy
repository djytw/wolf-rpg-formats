meta:
  id: game_dat
  endian: le
  imports:
  - common
types:
  record_u8_settings:
    seq:
    - id: tile_size
      type: u1
      enum: common::tile_size
    - id: character_directions_image
      type: u1
      enum: common::character_directions
    - id: character_directions_move
      type: u1
      enum: common::character_directions
    - id: guruguru_enabled
      type: u1
      enum: common::venable
    - id: fps
      type: u1
      enum: common::fps
    - id: character_shadow
      type: u1
      enum: common::venable
    - id: midi_source
      type: u1
      enum: common::midi_source
    - id: character_animation_patterns
      type: u1
      enum: common::character_animation_patterns
    - id: character_movement_width
      type: u1
      enum: common::character_movement_width
    - id: character_movement_hitbox
      type: u1
      enum: common::character_movement_width
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
      enum: common::anti_aliasing
    - id: move_speed_event
      type: u1
      enum: common::move_speed
    - id: move_speed_hero_allies
      type: u1
      enum: common::move_speed
    - id: in_game_language
      type: u1
      enum: common::language
    - id: image_scaling_method
      type: u1
      enum: common::image_scale
    - id: inactive_window_behavior
      type: u1
      enum: common::inactive_behavior
    - id: system_language
      type: u1
      enum: common::system_language
    - id: unknown_2
      type: u1
      if: _io.size == 35
    - id: pro_enable_f4
      type: u1
      enum: common::venable
      if: _io.size == 35
    - id: pro_enable_f5
      type: u1
      enum: common::venable
      if: _io.size == 35
    - id: pro_enable_f8
      type: u1
      enum: common::venable
      if: _io.size == 35
    - id: pro_enable_f11
      type: u1
      enum: common::venable
      if: _io.size == 35
    - id: pro_enable_f12
      type: u1
      enum: common::venable
      if: _io.size == 35
    - id: pro_enable_prtscr
      type: u1
      enum: common::venable
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
      enum: common::screen_scale
      if: _io.size == 35
    - id: pro_loading_fadein
      type: u1
      enum: common::venable
      if: _io.size == 35
    - id: pro_loading_fadeout
      type: u1
      enum: common::venable
      if: _io.size == 35
  record_string_settings_v3:
    seq:
    - id: game_title
      type: common::t_str
    - id: serial
      type: common::t_str
    - id: encryption_key
      type: common::t_str
    - id: font_base
      type: common::t_str
    - id: font_sub1
      type: common::t_str
    - id: font_sub2
      type: common::t_str
    - id: font_sub3
      type: common::t_str
    - id: starting_hero_graphic
      type: common::t_str
    - id: game_subtitle
      type: common::t_str
    - id: pro_game_loadingpic
      type: common::t_str
    - id: pro_game_loading_gauge
      type: common::t_str
    - id: pro_title_during_loading
      type: common::t_str
    - id: pro_title_during_gameplay
      type: common::t_str
  record_string_settings_v2:
    seq:
    - id: game_title
      type: common::t_str_sjis
    - id: serial
      type: common::t_str_sjis
    - id: encryption_key
      type: common::t_str_sjis
    - id: font_base
      type: common::t_str_sjis
    - id: font_sub1
      type: common::t_str_sjis
    - id: font_sub2
      type: common::t_str_sjis
    - id: font_sub3
      type: common::t_str_sjis
    - id: starting_hero_graphic
      type: common::t_str_sjis
    - id: unknown
      type: common::t_str
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
    enum: common::version_header
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
        common::version_header::v3: record_string_settings_v3
        common::version_header::v2: record_string_settings_v2
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
    enum: common::version_footer
