{theme}:
# Future me note, here's all the subfields for each category!
# {
# foreground
# background
# is_bold
# is_dimmed
# is_italic
# is-underline
# is_blink
# is_reverse
# is_hidden
# is_strikethrough
# is prefix_with_reset}
let
  inherit (theme) hex;
in
{
  filekinds = {
    normal = {
      foreground = hex.fg0;
    };
    directory = {
      foreground = hex.blue;
    };
    symlink = {
      foreground = hex.aqua;
      is_italic = true;
    };
    pipe = {
      foreground = hex.orange;
    };
    block_device = {
      foreground = hex.yellowLight;
      is_underline = true;
    };
    char_device = {
      foreground = hex.red;
    };
    # socket = {};
    # special = {};
    executable = {
      foreground = hex.greenLight;
      is_italic = true;
      is_bold = true;
    };
    # mountpoint = {};
  };

  # Config currently disables this
  # perms = {
  #   user_read = {};
  #   user_write = {};
  #   user_execute_file = {};
  #   group_read = {};
  #   group_write = {};
  #   group_execute = {};
  #   other_read = {};
  #   other_write = {};
  #   other_execute = {};
  #   special_user_file = {};
  #   special_other = {};
  #   attribute = {};
  # };

  # size = {
  #   major = {};
  #   minor = {};
  #   number_byte = {};
  #   number_kilo = {};
  #   number_mega = {};
  #   number_giga = {};
  #   number_huge = {};
  #   unit_byte = {};
  #   unit_kilo = {};
  #   unit_mega = {};
  #   unit_giga = {};
  #   unit_huge = {};
  # };

  users = {
    user_you = {
      foreground = hex.fg0;
    };
    user_root = {
      foreground = hex.red;
    };
    user_other = {
      foreground = hex.yellow;
    };
    group_yours = {
      foreground = hex.fg0;
    };
    group_other = {
      foreground = hex.yellow;
    };
    group_root = {
      foreground = hex.red;
    };
  };

  # links = {
  #   normal = {};
  #   multi_link_file = {};
  # };

  git = {
    new = {
      foreground = hex.greenLight;
      is_bold = true;
    };
    modified = {
      foreground = hex.blueLight;
    };
    deleted = {
      foreground = hex.redLight;
    };
    renamed = {
      foreground = hex.purpleLight;
      is_italic = true;
    };
    ignored = {
      foreground = hex.grayDiff;
    };
    conflicted = {
      foreground = hex.red;
      is_bold = true;
      is_italic = true;
    };
  };

  # git_repo = {
  #   branch_main = {};
  #   branch_other = {};
  #   git_clean = {};
  #   git_dirty = {};
  # };

  # Security Context is not used in NixOS
  # file_type = {
  #   image = {};
  #   video = {};
  #   music = {};
  #   crypto = {};
  #   document = {};
  #   compressed = {};
  #   temp = {};
  #   compiled = {};
  #   build = {};
  #   source = {};
  # };

  # punctuation = {};
  # date = {};
  # inode = {};
  # blocks = {};
  # header = {};
  octal = {
    foreground = hex.yellowDark;
  };
  # flags = {};
  # control_char = {};
  # broken_symlink = {};
  # broken_path_overlay = {};

  # filenames = {};

  # extensions = {};
}
