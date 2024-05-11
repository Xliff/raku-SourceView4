use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use SourceView::Raw::Types;

use Pango::Enums;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceStyleAncestry is export of Mu
  where GtkSourceStyle | GObject;

class SourceView::Style {
  also does GLib::Roles::Object;

  has GtkSourceStyle $!ss is implementor;

  submethod BUILD ( :$gtk-source-style ) {
    self.setGtkSourceStyle($gtk-source-style) if $gtk-source-style
  }

  method setGtkSourceStyle (GtkSourceStyleAncestry $_) {
    my $to-parent;

    $!ss = do {
      when GtkSourceStyle {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceStyle, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceStyle
    is also<GtkSourceStyle>
  { $!ss }

  multi method new (
    $gtk-source-style where * ~~ GtkSourceStyleAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-style;

    my $o = self.bless( :$gtk-source-style );
    $o.ref if $ref;
    $o;
  }

  # Type: string
  method background is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('background', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('background', $gv);
      }
    );
  }

  # Type: boolean
  method background-set is rw  is g-property is also<background_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('background-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('background-set', $gv);
      }
    );
  }

  # Type: boolean
  method bold is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('bold', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('bold', $gv);
      }
    );
  }

  # Type: boolean
  method bold-set is rw  is g-property is also<bold_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('bold-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('bold-set', $gv);
      }
    );
  }

  # Type: string
  method foreground is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('foreground', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('foreground', $gv);
      }
    );
  }

  # Type: boolean
  method foreground-set is rw  is g-property is also<foreground_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('foreground-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('foreground-set', $gv);
      }
    );
  }

  # Type: boolean
  method italic is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('italic', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('italic', $gv);
      }
    );
  }

  # Type: boolean
  method italic-set is rw  is g-property is also<italic_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('italic-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('italic-set', $gv);
      }
    );
  }

  # Type: string
  method line-background is rw  is g-property is also<line_background> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('line-background', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('line-background', $gv);
      }
    );
  }

  # Type: boolean
  method line-background-set
    is rw
    is g-property
    is also<line_background_set>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('line-background-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('line-background-set', $gv);
      }
    );
  }

  # Type: PangoUnderline
  method pango-underline ( :$enum = True )
    is rw
    is g-property
    is also<pango_underline>
  {
    my $gv = GLib::Value.new( Pango::Enums::Underline.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pango-underline', $gv);
        my $u = $gv.enum;
        return $u unless $enum;
        PangoUnderlineEnum($u);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoUnderline) = $val;
        self.prop_set('pango-underline', $gv);
      }
    );
  }

  # Type: string
  method scale is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scale', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('scale', $gv);
      }
    );
  }

  # Type: boolean
  method scale-set is rw  is g-property is also<scale_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scale-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('scale-set', $gv);
      }
    );
  }

  # Type: boolean
  method strikethrough is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('strikethrough', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('strikethrough', $gv);
      }
    );
  }

  # Type: boolean
  method strikethrough-set is rw  is g-property is also<strikethrough_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('strikethrough-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('strikethrough-set', $gv);
      }
    );
  }

  # Type: string
  method underline-color is rw  is g-property is also<underline_color> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('underline-color', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('underline-color', $gv);
      }
    );
  }

  # Type: boolean
  method underline-color-set
    is rw
    is g-property
    is also<underline_color_set>
  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('underline-color-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('underline-color-set', $gv);
      }
    );
  }

  # Type: boolean
  method underline-set is rw  is g-property is also<underline_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('underline-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('underline-set', $gv);
      }
    );
  }

  # Type: PangoWeight
  method weight ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( Pango::Enums::Weight.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('weight', $gv);
        my $w = $gv.enum;
        return $w unless $enum;
        PangoWeightEnum($w);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoWeight) = $val;
        self.prop_set('weight', $gv);
      }
    );
  }

  # Type: boolean
  method weight-set is rw  is g-property is also<weight_set> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('weight-set', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('weight-set', $gv);
      }
    );
  }

  method apply (GtkTextTag() $tag) {
    gtk_source_style_apply($!ss, $tag);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gtk_source_style_copy($!ss),
      $raw,
      |self.getTypePair
    );
  }

}


### /usr/src/gtksourceview/gtksourceview/gtksourcestyle.h

sub gtk_source_style_apply (
  GtkSourceStyle $style,
  GtkTextTag     $tag
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_style_copy (GtkSourceStyle $style)
  returns GtkSourceStyle
  is      native(sourceview)
  is      export
{ * }
