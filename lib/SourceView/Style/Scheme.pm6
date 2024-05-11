use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use SourceView::Raw::Types:ver<4>;
use SourceView::Raw::Style::Scheme:ver<4>;

use SourceView::Style:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceStyleSchemeAncestry is export of Mu
  where GtkSourceStyleScheme | GObject;

class SourceView::Style::Scheme:ver<4> {
  also does GLib::Roles::Object;

  has GtkSourceStyleScheme $!sss is implementor;

  submethod BUILD ( :$gtk-source-scheme ) {
    self.setGtkSourceStyleScheme($gtk-source-scheme) if $gtk-source-scheme
  }

  method setGtkSourceStyleScheme (GtkSourceStyleSchemeAncestry $_) {
    my $to-parent;

    $!sss = do {
      when GtkSourceStyleScheme {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceStyleScheme, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceStyleScheme
    is also<GtkSourceStyleScheme>
  { $!sss }

  multi method new (
    $gtk-source-scheme where * ~~ GtkSourceStyleSchemeAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-scheme;

    my $o = self.bless( :$gtk-source-scheme );
    $o.ref if $ref;
    $o;
  }

  # Type: string
  method description is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('description', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'description does not allow writing'
      }
    );
  }

  # Type: string
  method filename is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('filename', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'filename does not allow writing'
      }
    );
  }

  # Type: string
  method id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('id', $gv);
      }
    );
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'name does not allow writing'
      }
    );
  }

  method get_authors is also<get-authors> {
    gtk_source_style_scheme_get_authors($!sss);
  }

  method get_description is also<get-description> {
    gtk_source_style_scheme_get_description($!sss);
  }

  method get_filename is also<get-filename> {
    gtk_source_style_scheme_get_filename($!sss);
  }

  method get_id is also<get-id> {
    gtk_source_style_scheme_get_id($!sss);
  }

  method get_metadata (Str() $name) is also<get-metadata> {
    gtk_source_style_scheme_get_metadata($!sss, $name);
  }

  method get_name is also<get-name> {
    gtk_source_style_scheme_get_name($!sss);
  }

  method get_style (Str() $style_id, :$raw = False) is also<get-style> {
    propReturnObject(
      gtk_source_style_scheme_get_style($!sss, $style_id),
      $raw,
      |SourceView::Style::Scheme.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_style_scheme_get_type, $n, $t );
  }

}
