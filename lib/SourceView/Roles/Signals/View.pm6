use v6.c;

use NativeCall;

use SourceView::Raw::Types:ver<4>;

use SourceView::Snippet:ver<4>;
use GTK::Text::Iter:ver<4>;

role SourceView::Roles::Signals::View {
  has %!signals-sv

  #  GtkSourceSnippet *snippet,  GtkTextIter *location --> void
  method connect-push-snippet (
     $obj,
     $signal    = 'push-snippet',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-sv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-push-snippet($obj, $signal,
        -> $, $ss, $loc, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $ss  = Source::Snippet.new($ss);
            $loc = GTK::Text::Iter.new($loc);
          }

          𝒮.emit( [self, $ss, $loc, $ud] );
        },
        Pointer, 0
      );
      [ create-signals-supply(𝒮.Supply, $object, $signal), $obj, $hid ];
    };
    %!signals-sv{$signal}[0].tap(&handler) with &handler;
    %!signals-sv{$signal}[0];
  }

  #  GtkTextIter *iter,  guint button,  GdkModifierType state,  gint n_presses --> void
  method connect-line-mark-activated (
     $obj,
     $signal    = 'line-mark-activated',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-sv{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-line-mark-activated($obj, $signal,
        -> $, $i is copy, $g, $s is copy, $n {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $i = GTK::Text::Iter.new($t);
            $s = GdkModifierTypeEnum($s);
          }

          𝒮.emit( [self, $i, $g, $s, $n] );
        },
        Pointer, 0
      );
      [ create-signals-supply(𝒮.Supply, $obj, $signal), $obj, $hid ];
    };
    %!signals-sv{$signal}[0].tap(&handler) with &handler;
    %!signals-sv{$signal}[0];
  }

}


# GtkSourceView *view,  GtkSourceSnippet *snippet,  GtkTextIter *location
sub g-connect-push-snippet (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GtkSourceSnippet, GtkTextIter, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }


# GtkSourceView *view,  GtkTextIter *iter,  guint button,  GdkModifierType state,  gint n_presses
sub g-connect-line-mark-activated (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GtkTextIter, guint, GdkModifierType, gint),
  Pointer $data,
  uint32  $flags
)
returns uint64
is native(gobject)
is symbol('g_signal_connect_object')
{ * }
