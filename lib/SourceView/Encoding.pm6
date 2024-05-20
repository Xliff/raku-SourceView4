use v6.c;

use Method::Also;

use SourceView::Raw::Types;
use SourceView::Raw::Encoding;

use GLib::GSList;

use GLib::Roles::Implementor;

# BOXED

class SourceView::Encoding {
  also does GLib::Roles::Implementor;

  has GtkSourceEncoding $!se is implementor;

  submethod BUILD ( :$gtk-source-char ) {
    $!se = $gtk-source-char if $gtk-source-char;
  }

  method SourceView::Raw::Definitions::GtkSourceEncoding
  { $!se }

  method new (GtkSourceEncoding $gtk-source-char) {
    return Nil unless $gtk-source-char;

    self.bless(:$gtk-source-char);
  }

  method get_current is also<get-current> {
    my $gtk-source-char = gtk_source_encoding_get_current();

    $gtk-source-char ?? self.bless( :$gtk-source-char ) !! Nil
  }

  method get_from_charset (Str() $charset) is also<get-from-charset> {
    my $gtk-source-char = gtk_source_encoding_get_from_charset($charset);

    $gtk-source-char ?? self.bless( :$gtk-source-char ) !! Nil
  }

  method get_utf8 is also<get-utf8> {
    my $gtk-source-char = gtk_source_encoding_get_utf8();

    $gtk-source-char ?? self.bless( :$gtk-source-char ) !! Nil
  }

  method copy {
    gtk_source_encoding_copy($!se);
  }

  method free {
    gtk_source_encoding_free($!se);
  }

  method get_all ( :$raw = False, :glist(:$gslist) = False )
    is also<get-all>
  {
    returnGSList(
      gtk_source_encoding_get_all(),
      $raw,
      $gslist,
      |self.getTypePair
    );
  }

  method get_charset is also<get-charset> {
    gtk_source_encoding_get_charset($!se);
  }

  method get_default_candidates ( :$raw = False, :glist(:$gslist) = False )
    is also<get-default-candidates>
  {
    returnGSList(
      gtk_source_encoding_get_default_candidates(),
      $raw,
      $gslist,
      |self.getTypePair
    );
  }

  method get_name is also<get-name> {
    gtk_source_encoding_get_name($!se);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_encoding_get_type, $n, $t );
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    gtk_source_encoding_to_string($!se);
  }

}
