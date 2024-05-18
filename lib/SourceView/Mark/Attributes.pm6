use v6.c;

use GLib::Raw::Traits;
use GDK::Pixbuf::Raw::Definitions;
use SourceView::Raw::Types;
use SourceView::Raw::Mark::Attributes;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class SourceView::Mark::Attributes {
  also does GLib::Roles::Object;

  has GtkSourceMarkAttributes $!sma is implementor;

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
  method icon-name is rw  is g-property {
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
    my $gv = GLib::Value.new( GDK::Pixbuf.getTypePair );
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

  method get_background (GdkRGBA() $background) {
    gtk_source_mark_attributes_get_background($!sma, $background);
  }

  method get_gicon ( :$raw = False ) {
    propReturnObject(
      gtk_source_mark_attributes_get_gicon($!sma),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_icon_name ( :$raw = False ) {
    propReturnObject(
      gtk_source_mark_attributes_get_icon_name($!sma),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_pixbuf  ( :$raw = False ) {
    propReturnObject(
      gtk_source_mark_attributes_get_pixbuf($!sma),
      $raw,
      |GDK::Pixbuf.getTypePair
    );
  }

  method get_tooltip_markup (GtkSourceMark() $mark) {
    gtk_source_mark_attributes_get_tooltip_markup($!sma, $mark);
  }

  method get_tooltip_text (GtkSourceMark() $mark) {
    gtk_source_mark_attributes_get_tooltip_text($!sma, $mark);
  }

  method render_icon (GtkWidget() $widget, Int() $size) {
    my gint $s = $size;

    gtk_source_mark_attributes_render_icon($!sma, $widget, $s);
  }

  method set_background (GdkRGBA() $background) {
    gtk_source_mark_attributes_set_background($!sma, $background);
  }

  method set_gicon (GIcon() $gicon) {
    gtk_source_mark_attributes_set_gicon($!sma, $gicon);
  }

  method set_icon_name (Str() $icon_name) {
    gtk_source_mark_attributes_set_icon_name($!sma, $icon_name);
  }

  method set_pixbuf (GdkPixbuf() $pixbuf) {
    gtk_source_mark_attributes_set_pixbuf($!sma, $pixbuf);
  }

}
