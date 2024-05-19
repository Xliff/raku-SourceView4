use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use SourceView::Raw::Types;
use SourceView::Raw::Language;

use GLib::Roles::Implementor;
use GLib::Roles::Object;


our subset GtkSourceLanguageAncestry is export of Mu
  where GtkSourceLanguage | GObject;

class SourceView::Language {
  also does GLib::Roles::Object;

  has GtkSourceLanguage $!sl is implementor;

  submethod BUILD ( :$gtk-source-lang ) {
    self.setGtkSourceLanguage($gtk-source-lang) if $gtk-source-lang
  }

  method setGtkSourceLanguage (GtkSourceLanguageAncestry $_) {
    my $to-parent;

    $!sl = do {
      when GtkSourceLanguage {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceLanguage, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceLanguage
    is also<GtkSourceLanguage>
  { $!sl }

  multi method new (
    $gtk-source-lang where * ~~ GtkSourceLanguageAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-lang;

    my $o = self.bless( :$gtk-source-lang );
    $o.ref if $ref;
    $o;
  }

  # Type: boolean
  method hidden is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('hidden', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'hidden does not allow writing'
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
        warn 'id does not allow writing'
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

  # Type: string
  method section is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('section', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'section does not allow writing'
      }
    );
  }

  method get_globs ( :$raw = False ) is also<get-globs> {
    my $ca = gtk_source_language_get_globs($!sl);
    return $ca if $raw;
    CStringArrayToArray($ca);
  }

  method get_hidden is also<get-hidden> {
    gtk_source_language_get_hidden($!sl);
  }

  method get_id is also<get-id> {
    gtk_source_language_get_id($!sl);
  }

  method get_metadata (Str() $name) is also<get-metadata> {
    gtk_source_language_get_metadata($!sl, $name);
  }

  method get_mime_types ( :$raw = False ) is also<get-mime-types> {
    my $ca = gtk_source_language_get_mime_types($!sl);
    return $ca if $raw;
    CStringArrayToArray($ca);
  }

  method get_name is also<get-name> {
    gtk_source_language_get_name($!sl);
  }

  method get_section is also<get-section> {
    gtk_source_language_get_section($!sl);
  }

  method get_style_fallback (Str() $style_id) is also<get-style-fallback> {
    gtk_source_language_get_style_fallback($!sl, $style_id);
  }

  method get_style_ids ( :$raw = False ) is also<get-style-ids> {
    my $ca = gtk_source_language_get_style_ids($!sl);
    return $ca if $raw;
    CStringArrayToArray($ca);
  }

  method get_style_name (Str() $style_id) is also<get-style-name> {
    gtk_source_language_get_style_name($!sl, $style_id);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_language_get_type, $n, $t );
  }

}
