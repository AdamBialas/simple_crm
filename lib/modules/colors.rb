require 'digest'

module Colors
  PALETTES = %i[google iwanthue custom]

  GOOGLE_COLORS = [
    [226, 95, 81], # A
    [242, 96, 145], # B
    [187, 101, 202], # C
    [149, 114, 207], # D
    [120, 132, 205], # E
    [91, 149, 249], # F
    [72, 194, 249], # G
    [69, 208, 226], # H
    [72, 182, 172], # I
    [82, 188, 137], # J
    [155, 206, 95], # K
    [212, 227, 74], # L
    [254, 218, 16], # M
    [247, 192, 0], # N
    [255, 168, 0], # O
    [255, 138, 96], # P
    [194, 194, 194], # Q
    [143, 164, 175], # R
    [162, 136, 126], # S
    [163, 163, 163], # T
    [175, 181, 226], # U
    [179, 155, 221], # V
    [194, 194, 194], # W
    [124, 222, 235], # X
    [188, 170, 164], # Y
    [173, 214, 125] # Z
  ].freeze

  IWANTHUE_COLORS = [
    [198, 125, 40],
    [61, 155, 243],
    [74, 243, 75],
    [238, 89, 166],
    [52, 240, 224],
    [177, 156, 155],
    [240, 120, 145],
    [111, 154, 78],
    [237, 179, 245],
    [237, 101, 95],
    [89, 239, 155],
    [43, 254, 70],
    [163, 212, 245],
    [65, 152, 142],
    [165, 135, 246],
    [181, 166, 38],
    [187, 229, 206],
    [77, 164, 25],
    [179, 246, 101],
    [234, 93, 37],
    [225, 155, 115],
    [142, 140, 188],
    [223, 120, 140],
    [249, 174, 27],
    [244, 117, 225],
    [137, 141, 102],
    [75, 191, 146],
    [188, 239, 142],
    [164, 199, 145],
    [173, 120, 149],
    [59, 195, 89],
    [222, 198, 220],
    [68, 145, 187],
    [236, 204, 179],
    [159, 195, 72],
    [188, 121, 189],
    [166, 160, 85],
    [181, 233, 37],
    [236, 177, 85],
    [121, 147, 160],
    [234, 218, 110],
    [241, 157, 191],
    [62, 200, 234],
    [133, 243, 34],
    [88, 149, 110],
    [59, 228, 248],
    [183, 119, 118],
    [251, 195, 45],
    [113, 196, 122],
    [197, 115, 70],
    [80, 175, 187],
    [103, 231, 238],
    [240, 72, 133],
    [228, 149, 241],
    [180, 188, 159],
    [172, 132, 85],
    [180, 135, 251],
    [236, 194, 58],
    [217, 176, 109],
    [88, 244, 199],
    [186, 157, 239],
    [113, 230, 96],
    [206, 115, 165],
    [244, 178, 163],
    [230, 139, 26],
    [241, 125, 89],
    [83, 160, 66],
    [107, 190, 166],
    [197, 161, 210],
    [198, 203, 245],
    [238, 117, 19],
    [228, 119, 116],
    [131, 156, 41],
    [145, 178, 168],
    [139, 170, 220],
    [233, 95, 125],
    [87, 178, 230],
    [157, 200, 119],
    [237, 140, 76],
    [229, 185, 186],
    [144, 206, 212],
    [236, 209, 158],
    [185, 189, 79],
    [34, 208, 66],
    [84, 238, 129],
    [133, 140, 134],
    [67, 157, 94],
    [168, 179, 25],
    [140, 145, 240],
    [151, 241, 125],
    [67, 162, 107],
    [200, 156, 21],
    [169, 173, 189],
    [226, 116, 189],
    [133, 231, 191],
    [194, 161, 63],
    [241, 77, 99],
    [241, 217, 53],
    [123, 204, 105],
    [210, 201, 119],
    [229, 108, 155],
    [240, 91, 72],
    [187, 115, 210],
    [240, 163, 100],
    [178, 217, 57],
    [179, 135, 116],
    [204, 211, 24],
    [186, 135, 57],
    [223, 176, 135],
    [204, 148, 151],
    [116, 223, 50],
    [95, 195, 46],
    [123, 160, 236],
    [181, 172, 131],
    [142, 220, 202],
    [240, 140, 112],
    [172, 145, 164],
    [228, 124, 45],
    [135, 151, 243],
    [42, 205, 125],
    [192, 233, 116],
    [119, 170, 114],
    [158, 138, 26],
    [73, 190, 183],
    [185, 229, 243],
    [227, 107, 55],
    [196, 205, 202],
    [132, 143, 60],
    [233, 192, 237],
    [62, 150, 220],
    [205, 201, 141],
    [106, 140, 190],
    [161, 131, 205],
    [135, 134, 158],
    [198, 139, 81],
    [115, 171, 32],
    [101, 181, 67],
    [149, 137, 119],
    [37, 142, 183],
    [183, 130, 175],
    [168, 125, 133],
    [124, 142, 87],
    [236, 156, 171],
    [232, 194, 91],
    [219, 200, 69],
    [144, 219, 34],
    [219, 95, 187],
    [145, 154, 217],
    [165, 185, 100],
    [127, 238, 163],
    [224, 178, 198],
    [119, 153, 120],
    [124, 212, 92],
    [172, 161, 105],
    [231, 155, 135],
    [157, 132, 101],
    [122, 185, 146],
    [53, 166, 51],
    [70, 163, 90],
    [150, 190, 213],
    [210, 107, 60],
    [166, 152, 185],
    [159, 194, 159],
    [39, 141, 222],
    [202, 176, 161],
    [95, 140, 229],
    [168, 142, 87],
    [93, 170, 203],
    [159, 142, 54],
    [14, 168, 39],
    [94, 150, 149],
    [187, 206, 136],
    [157, 224, 166],
    [235, 158, 208],
    [109, 232, 216],
    [141, 201, 87],
    [208, 124, 118],
    [142, 125, 214],
    [19, 237, 174],
    [72, 219, 41],
    [234, 102, 111],
    [168, 142, 79],
    [188, 135, 35],
    [95, 155, 143],
    [148, 173, 116],
    [223, 112, 95],
    [228, 128, 236],
    [206, 114, 54],
    [195, 119, 88],
    [235, 140, 94],
    [235, 202, 125],
    [233, 155, 153],
    [214, 214, 238],
    [246, 200, 35],
    [151, 125, 171],
    [132, 145, 172],
    [131, 142, 118],
    [199, 126, 150],
    [61, 162, 123],
    [58, 176, 151],
    [215, 141, 69],
    [225, 154, 220],
    [220, 77, 167],
    [233, 161, 64],
    [130, 221, 137],
    [81, 191, 129],
    [169, 162, 140],
    [174, 177, 222],
    [236, 174, 47],
    [233, 188, 180],
    [69, 222, 172],
    [71, 232, 93],
    [118, 211, 238],
    [157, 224, 83],
    [218, 105, 73],
    [126, 169, 36]
  ].freeze

  def for(username)
    public_send("with_#{LetterAvatar.colors_palette}", username)
  end

  def with_iwanthue(username)
    aa = iwanthue[
      ::Digest::MD5.hexdigest(username)[0...15].to_i(16) % iwanthue.length
    ]
    tt = { red: aa[0], green: aa[1], blue: aa[2] }
    color_value = '#' + %i[red green blue].map { |c| tt[c].to_i.to_s(16).rjust(2, '0') }.join
  end

  def with_google(username)
   # char = username[0].upcase

    # if /[A-Z]/ =~ char
    # 65 is 'A' ord
    #   idx = char.ord - 65
    #   aa = google[idx]
    # elsif /\d/ =~ char
    #   aa = google[char.to_i]
    # else
    aa = google[::Digest::MD5.hexdigest(username)[0...15].to_i(16) % google.length]
    # end
    tt = { red: aa[0], green: aa[1], blue: aa[2] }
    color_value = '#' + %i[red green blue].map { |c| tt[c].to_i.to_s(16).rjust(2, '0') }.join
  end

  def with_custom(username)
    custom_palette = LetterAvatar.custom_palette
    custom_palette[::Digest::MD5.hexdigest(username)[0...15].to_i(16) % custom_palette.length]
  end

  def valid_custom_palette?(palette)
    return false unless palette.is_a?(Array)

    palette.all? do |color|
      false unless color.is_a?(Array)
      color.all? { |i| i.is_a?(Integer) }
    end
  end

  # Colors form Google Inbox
  # https://inbox.google.com
  def google
    GOOGLE_COLORS
  end

  # palette of optimally disctinct colors
  # cf. http://tools.medialab.sciences-po.fr/iwanthue/index.php
  # parameters used:
  #   - H: 0 - 360
  #   - C: 0 - 2
  #   - L: 0.75 - 1.5
  def iwanthue
    IWANTHUE_COLORS
  end
end