use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use SourceView::Raw::Types;

use SourceView::Gutter::Lines;

role SourceView::Roles::Signals::Gutter::Renderer {
  has %!signals-sgr;

  #  GtkTextIter *iter,  GdkRectangle *area,  guint button,  GdkModifierType state,  gint n_presses --> void
  method connect-activate (
     $obj,
     $signal    = 'activate',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-sgr{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-activate($obj, $signal,
        -> $, $gti, $gr, $g, $gmt1, $g2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $gti  = GTK::Text::Iter.new($gti);
            $gr   = GDK::Rectangle.new($gr);
            $gmt1 = GdkModifierTypeEnum($gmt1);
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gti, $gr, $g, $gmt1, $g2, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-sgr{$signal}[0].tap(&handler) with &handler;
    %!signals-sgr{$signal}[0];
  }

  #  GtkTextIter *iter,  GdkRectangle *area --> gboolean
  method connect-query-activatable (
     $obj,
     $signal    = 'query-activatable',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-sgr{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-query-activatable($obj, $signal,
        -> $, $gti is copy, $gr is copy {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $gti = GTK::Text::Iter.new($gti);
            $gr  = GDK::Rectangle.new($gr);
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gti, $gr, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-sgr{$signal}[0].tap(&handler) with &handler;
    %!signals-sgr{$signal}[0];
  }

  #  GtkSourceGutterLines *lines, guint line --> void
  method connect-query-data (
     $obj,
     $signal     = 'query-data',
     &handler?,
    :$raw        = False
  ) {
    my $hid;
    %!signals-sgr{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-query-data($obj, $signal,
        -> $, $gsg1 is copy, $g {
          CATCH {
            default {
              .message.say;
              𝒮.note($_);
            }

          }
          
          $gsg1 = SourceView::Gutter::Lines.new($gsg1, :!ref) unless $raw;

          𝒮.emit( [self, $gsg1, $g] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-sgr{$signal}[0].tap(&handler) with &handler;
    %!signals-sgr{$signal}[0];
  }

}

# GtkSourceGutterRenderer *renderer,  GtkTextIter *iter,  GdkRectangle *area,  guint button,  GdkModifierType state,  gint n_presses
sub g-connect-activate (
  Pointer $app,
  Str     $name,
          &handler (
            Pointer,
            GtkTextIter,
            GdkRectangle,
            guint,
            GdkModifierType,
            gint
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkSourceGutterRenderer *renderer,  GtkTextIter *iter,  GdkRectangle *area --> gboolean
sub g-connect-query-activatable (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GtkTextIter, GdkRectangle --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkSourceGutterRenderer *renderer,  GtkSourceGutterLines *lines,  guint line, gpointer
sub g-connect-query-data (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GtkSourceGutterLines, guint),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }
