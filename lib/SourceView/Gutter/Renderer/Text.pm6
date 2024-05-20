use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use SourceView::Raw::Types:ver<4>;
use SourceView::Raw::Gutter::Renderer::Text:ver<4>;

use SourceView::Gutter::Renderer:ver<4>;

use GLib::Roles::Implementor;

our subset GtkSourceGutterRendererTextAncestry is export of Mu
  where GtkSourceGutterRendererText | GtkSourceGutterRendererAncestry;

class SourceView::Gutter::Renderer::Text:ver<4>
  is SourceView::Gutter::Renderer:ver<4>
{
  has GtkSourceGutterRendererText $!sgrt is implementor;

  submethod BUILD ( :$gtk-renderer-txt ) {
    self.setGtkSourceGutterRendererText($gtk-renderer-txt) if $gtk-renderer-txt
  }

  method setGtkSourceGutterRendererText (GtkSourceGutterRendererTextAncestry $_) {
    my $to-parent;

    $!sgrt = do {
      when GtkSourceGutterRendererText {
        $to-parent = cast(GtkSourceGutterRenderer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceGutterRendererText, $_);
      }
    }
    self.setGtkSourceGutterRenderer($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceGutterRendererText
    is also<GtkSourceGutterRendererText>
  { $!sgrt }

  multi method new (
    $gtk-renderer-txt where * ~~ GtkSourceGutterRendererTextAncestry,

    :$ref = True
  ) {
    return unless $gtk-renderer-txt;

    my $o = self.bless( :$gtk-renderer-txt );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $gtk-renderer-txt = gtk_source_gutter_renderer_text_new();

    my $o = $gtk-renderer-txt ?? self.bless( :$gtk-renderer-txt ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: string
  method markup is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('markup', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('markup', $gv);
      }
    );
  }

  # Type: string
  method text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  multi method measure ($text) {
    samewith($text, $, $);
  }
  multi method measure (Str() $text, $width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_source_gutter_renderer_text_measure($!sgrt, $text, $width, $height);
    ($width, $height) = ($w, $h);
  }

  proto method measure_markup (|)
    is also<measure-markup>
  { * }

  multi method measure_markup ($markup) {
    samewith($markup, $, $);
  }
  multi method measure_markup (Str() $markup, $width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_source_gutter_renderer_text_measure_markup($!sgrt, $markup, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method set_markup (Str() $markup, Int() $length = -1) is also<set-markup> {
    my gint $l = $length;

    gtk_source_gutter_renderer_text_set_markup($!sgrt, $markup, $l);
  }

  method set_text (Str() $text, Int() $length = -1) is also<set-text> {
    my gint $l = $length;

    gtk_source_gutter_renderer_text_set_text($!sgrt, $text, $l);
  }

}
