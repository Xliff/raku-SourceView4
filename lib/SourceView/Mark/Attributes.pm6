use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Pixbuf::Raw::Definitions;
use SourceView::Raw::Types;
use SourceView::Raw::Mark::Attributes;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceMarkAttributesAncestry is export of Mu
  where GtkSourceMarkAttributes | GObject;

class SourceView::Mark::Attributes {
  also does GLib::Roles::Object;

  has GtkSourceMarkAttributes $!sma is implementor;

  submethod BUILD ( :$gtk-mark-attr ) {
    self.setGtkSourceMarkAttributes($gtk-mark-attr) if $gtk-mark-attr
  }

  method setGtkSourceMarkAttributes (GtkSourceMarkAttributesAncestry $_) {
    my $to-parent;

    $!sma = do {
      when GtkSourceMarkAttributes {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceMarkAttributes, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceMarkAttributes
    is also<GtkSourceMarkAttributes>
  { $!sma }

  multi method new (
    $gtk-mark-attr where * ~~ GtkSourceMarkAttributesAncestry,

    :$ref = True
  ) {
    return unless $gtk-mark-attr;

    my $o = self.bless( :$gtk-mark-attr );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-mark-attr = gtk_source_mark_attributes_new();

    my $o = $gtk-mark-attr ?? self.bless( :$gtk-mark-attr ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: GgkRgba
  method background ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('background', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |GDK::RGBA.getTypePair
        );
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.pointer = $val;
        self.prop_set('background', $gv);
      }
    );
  }

  # Type: GIcon
  method gicon ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::Icon.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gicon', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          GIO::Icon.getTypePair
        );
      },
      STORE => -> $, GIcon() $val is copy {
        $gv.object = $val;
        self.prop_set('gicon', $gv);
      }
    );
  }

  # Type: string
  method icon-name is rw  is g-property is also<icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: GdkPixbuf
  method pixbuf ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Pixbuf.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixbuf', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Pixbuf.getTypePair
        );
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.object = $val;
        self.prop_set('pixbuf', $gv);
      }
    );
  }

  method get_background (GdkRGBA() $background) is also<get-background> {
    gtk_source_mark_attributes_get_background($!sma, $background);
  }

  method get_gicon ( :$raw = False ) is also<get-gicon> {
    propReturnObject(
      gtk_source_mark_attributes_get_gicon($!sma),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_icon_name ( :$raw = False ) is also<get-icon-name> {
    propReturnObject(
      gtk_source_mark_attributes_get_icon_name($!sma),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_pixbuf  ( :$raw = False ) is also<get-pixbuf> {
    propReturnObject(
      gtk_source_mark_attributes_get_pixbuf($!sma),
      $raw,
      |GDK::Pixbuf.getTypePair
    );
  }

  method get_tooltip_markup (GtkSourceMark() $mark) is also<get-tooltip-markup> {
    gtk_source_mark_attributes_get_tooltip_markup($!sma, $mark);
  }

  method get_tooltip_text (GtkSourceMark() $mark) is also<get-tooltip-text> {
    gtk_source_mark_attributes_get_tooltip_text($!sma, $mark);
  }

  method render_icon (GtkWidget() $widget, Int() $size) is also<render-icon> {
    my gint $s = $size;

    gtk_source_mark_attributes_render_icon($!sma, $widget, $s);
  }

  method set_background (GdkRGBA() $background) is also<set-background> {
    gtk_source_mark_attributes_set_background($!sma, $background);
  }

  method set_gicon (GIcon() $gicon) is also<set-gicon> {
    gtk_source_mark_attributes_set_gicon($!sma, $gicon);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    gtk_source_mark_attributes_set_icon_name($!sma, $icon_name);
  }

  method set_pixbuf (GdkPixbuf() $pixbuf) is also<set-pixbuf> {
    gtk_source_mark_attributes_set_pixbuf($!sma, $pixbuf);
  }

}
