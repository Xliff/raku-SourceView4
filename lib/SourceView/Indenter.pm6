use v6.c;

use Method::Also;

use NativeCall;

use SourceView::Raw::Types;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceIndenterAncestry is export of Mu
  where GtkSourceIndenter | GObject;

class SourceView::Indenter {
  also does GLib::Roles::Object;

  has GtkSourceIndenter $!si is implementor;

  submethod BUILD ( :$gtk-source-indent ) {
    self.setGtkSourceIndenter($gtk-source-indent) if $gtk-source-indent
  }

  method setGtkSourceIndenter (GtkSourceIndenterAncestry $_) {
    my $to-parent;

    $!si = do {
      when GtkSourceIndenter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceIndenter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceIndenter
    is also<GtkSourceIndenter>
  { $!si }

  multi method new (
    $gtk-source-indent where * ~~ GtkSourceIndenterAncestry,

    :$ref = True
  ) {
    return unless $gtk-source-indent;

    my $o = self.bless( :$gtk-source-indent );
    $o.ref if $ref;
    $o;
  }

  method indent (GtkSourceView() $view, GtkTextIter() $iter) {
    gtk_source_indenter_indent($!si, $view, $iter);
  }

  method is_trigger (
    GtkSourceView() $view,
    GtkTextIter()   $location,
    Int()           $state,
    Int()           $keyval
  )
    is also<is-trigger>
  {
    my GdkModifierType $s = $state;
    my guint           $k = $keyval;

    gtk_source_indenter_is_trigger($!si, $view, $location, $s, $k);
  }

}

### /usr/src/gtksourceview/gtksourceview/gtksourceindenter.h

sub gtk_source_indenter_indent (
  GtkSourceIndenter $self,
  GtkSourceView     $view,
  GtkTextIter       $iter
)
  is      native(sourceview)
  is      export
{ * }

sub gtk_source_indenter_is_trigger (
  GtkSourceIndenter $self,
  GtkSourceView     $view,
  GtkTextIter       $location,
  GdkModifierType   $state,
  guint             $keyval
)
  returns uint32
  is      native(sourceview)
  is      export
{ * }
