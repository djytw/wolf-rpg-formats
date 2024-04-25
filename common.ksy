
meta:
  id: common
  endian: le
types:
  t_str:
    seq:
      - id: len
        type: u4
      - id: str
        type: strz
        size: len
        encoding: 'UTF-8'
  t_str_sjis:
    seq:
      - id: len
        type: u4
      - id: str
        type: strz
        size: len
        encoding: 'Shift-JIS'
  t_str_array:
    seq:
      - id: len
        type: u4
      - id: str
        type: t_str
        repeat: expr
        repeat-expr: len
  t_u4_array:
    seq:
      - id: len
        type: u4
      - id: data
        type: u4
        repeat: expr
        repeat-expr: len
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
  data_id_method:
    0: 'manual'
    1: 'same_as_first_string_data'
    2: 'same_as_preceding_type_data_id'
    10000: 'from_type_in_db'
  special_function_type:
    0: 'disabled'
    1: 'load_from_file'
    2: 'load_from_database'
    3: 'manual'