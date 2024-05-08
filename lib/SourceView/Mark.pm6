use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use SourceView::Raw::Types;

use GTK::Text::Mark:ver<4>;

use GLib::Roles::Implementor;

our subset GtkSourceMarkAncestry is export of Mu
  where GtkSourceMark | GtkTextMarkAncestry;

class SourceView::Mark:ver<4> is GTK::Text::Mark:ver<4> {
  has GtkSourceMark $!sm is implementor;

  submethod BUILD ( :$gtk-source-mark ) {
    self.setGtkSourceMark($gtk-source-mark) if $gtk-source-mark
  }

  method setGtkSourceMark (GtkSourceMarkAncestry $_) {
    my $to-parent;

    $!sm = do {
      when GtkSourceMark {
        $to-parent = cast(GtkTextMark, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceMark, $_);
      }
    }
    self.setGtkTextMark($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceMark
    is also<GtkSourceMark>
  { $!sm }

  multi method new (
    $gtk-source-mark where * ~~ GtkSourceMarkAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-mark;

    my $o = self.bless( :$gtk-source-mark );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name, Str() $category, *%a) {
    my $gtk-source-mark = gtk_source_mark_new($name, $category);

    my $o = $gtk-source-mark ?? self.bless( :$gtk-source-mark ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  # Type: string
  method category is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('category', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('category', $gv);
      }
    );
  }

  method get_category ( :$raw = False ) is also<get-category> {
    gtk_source_mark_get_category($!sm);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_mark_get_type, $n, $t );
  }

  method next (Str() $category = Str, :$raw = False) {
    propReturnObject(
      gtk_source_mark_next($!sm, $category),
      $raw,
      |self.getTypePair
    );
  }

  method prev (Str() $category = Str, :$raw = False) {
    propReturnObject(
      gtk_source_mark_prev($!sm, $category),
      $raw,
      |self.getTypePair
    );
  }

}

### /usr/src/gtksourceview/gtksourceview/gtksourcemark.h

sub gtk_source_mark_get_category (GtkSourceMark $mark)
  returns Str
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_new (
  Str $name,
  Str $category
)
  returns GtkSourceMark
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_next (
  GtkSourceMark $mark,
  Str           $category
)
  returns GtkSourceMark
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_prev (
  GtkSourceMark $mark,
  Str           $category
)
  returns GtkSourceMark
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_mark_get_type ()
  returns GType
  is      native(sourceview)
  is      export
{ * }
