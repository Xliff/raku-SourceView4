use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use SourceView::Raw::Types:ver<4>;

use GTK::Widget:ver<4>;
use SourceView::View:ver<4>;

class SourceView::Map:ver<4> is GTK::Widget:ver<4> {
  has GtkSourceMap $!svm;

  multi method new ( *%a ) {
    my $gtk-source-map = gtk_source_map_new();

    my $o = $gtk-source-map ?? self.bless( :$gtk-source-map ) !! Nil;
    $o.setAttributes(%a) if $o +%a;
    $o;
  }

  method view ( :$raw = False ) is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_view( :$raw ) }
      STORE => -> $, \v { self.set_view(v)       };
  }

  method get_view ( :$raw = False ) {
    propReturnObject(
      gtk_source_map_get_view($!svm),
      $raw,
      |SourceView::View.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_map_get_type, $n, $t );
  }

  method set_view (GtkSourceView() $view) {
    gtk_source_map_set_view($!svm, $view);
  }

}


### /usr/src/gtksourceview/gtksourceview/gtksourcemap.h

sub gtk_source_map_get_view (GtkSourceMap $map)
  returns GtkSourceView
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_map_new
  returns GtkWidget
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_map_set_view (
  GtkSourceMap  $map,
  GtkSourceView $view
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_map_get_type
  returns GType
  is      native(sourceview)
  is      export
{ * }
