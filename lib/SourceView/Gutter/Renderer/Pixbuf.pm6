use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Pixbuf::Raw::Definitions;
use SourceView::Raw::Types;
use SourceView::Raw::Gutter::Renderer::Pixbuf;

use GDK::Pixbuf;
use SourceView::Gutter::Renderer:ver<4>;

use GLib::Roles::Implementor;
use GIO::Roles::Icon;
use GDK::Roles::Paintable:ver<4>;

our subset GtkSourceGutterRendererPixbufAncestry is export of Mu
  where GtkSourceGutterRendererPixbuf | GtkSourceGutterRendererAncestry;

class SourceView::Gutter::Renderer::Pixbuf
  is SourceView::Gutter::Renderer:ver<4>
{
  has GtkSourceGutterRendererPixbuf $!sgrp is implementor;

  submethod BUILD ( :$gtk-gutter-pixbuf ) {
    self.setGtkSourceGutterRendererPixbuf($gtk-gutter-pixbuf)
      if $gtk-gutter-pixbuf
  }

  method setGtkSourceGutterRendererPixbuf (
    GtkSourceGutterRendererPixbufAncestry $_
  ) {
    my $to-parent;

    $!sgrp = do {
      when GtkSourceGutterRendererPixbuf {
        $to-parent = cast(GtkSourceGutterRenderer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceGutterRendererPixbuf, $_);
      }
    }
    self.setGtkSourceGutterRenderer($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceGutterRendererPixbuf
    is also<GtkSourceGutterRendererPixbuf>
  { $!sgrp }

  multi method new (
    $gtk-gutter-pixbuf where * ~~ GtkSourceGutterRendererPixbufAncestry,

    :$ref = True
  ) {
    return unless $gtk-gutter-pixbuf;

    my $o = self.bless( :$gtk-gutter-pixbuf );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-gutter-pixbuf = gtk_source_gutter_renderer_pixbuf_new();

    my $o = $gtk-gutter-pixbuf ?? self.bless( :$gtk-gutter-pixbuf ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: GtkSourceIcon
  method gicon ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::Icon.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gicon', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::Icon.getTypePair
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

  # Type: GtkSourcePaintable
  method paintable ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Paintable.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('paintable', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Paintable.getTypePair
        );
      },
      STORE => -> $, GdkPaintable() $val is copy {
        $gv.object = $val;
        self.prop_set('paintable', $gv);
      }
    );
  }

  # Type: GtkSourcePixbuf
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

  method get_gicon ( :$raw = False ) is also<get-gicon> {
    propReturnObject(
      gtk_source_gutter_renderer_pixbuf_get_gicon($!sgrp),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_icon_name is also<get-icon-name> {
    gtk_source_gutter_renderer_pixbuf_get_icon_name($!sgrp);
  }

  method get_paintable ( :$raw = False ) is also<get-paintable> {
    propReturnObject(
      gtk_source_gutter_renderer_pixbuf_get_paintable($!sgrp),
      $raw,
      |GDK::Paintable.getTypePair
    );
  }

  method get_pixbuf ( :$raw = False ) is also<get-pixbuf> {
    propReturnObject(
      gtk_source_gutter_renderer_pixbuf_get_pixbuf($!sgrp),
      $raw,
      |GDK::Pixubf.getTypePair
    );
  }

  method overlay_paintable (GdkPaintable() $paintable)
    is also<overlay-paintable>
  {
    gtk_source_gutter_renderer_pixbuf_overlay_paintable($!sgrp, $paintable);
  }

  method set_gicon (GIcon() $icon) is also<set-gicon> {
    gtk_source_gutter_renderer_pixbuf_set_gicon($!sgrp, $icon);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    gtk_source_gutter_renderer_pixbuf_set_icon_name($!sgrp, $icon_name);
  }

  method set_paintable (GdkPaintable() $paintable) is also<set-paintable> {
    gtk_source_gutter_renderer_pixbuf_set_paintable($!sgrp, $paintable);
  }

  method set_pixbuf (GdkPixbuf() $pixbuf) is also<set-pixbuf> {
    gtk_source_gutter_renderer_pixbuf_set_pixbuf($!sgrp, $pixbuf);
  }

}
