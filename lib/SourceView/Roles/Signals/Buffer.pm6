use v6.c;

use GLib::Object::Supplyish;

role SourceView::Roles::Signals::Buffer {
  has %!signals-sb;

  # GtkSourceBuffer *buffer,  GtkTextIter *start,  GtkTextIter *end
  method connect-highlight-updated (
     $obj,
     $signal = 'highlight-updated',
     &handler?,
    :$raw                         = False
  ) {
    my $hid;
    %!signals-sb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-highlight-updated($obj, $signal,
        -> $, $s is copy, $e is copy, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          ($s, $e) = ( GTK::Text::Iter.new($s), GTK::Text::Iter.new($e) )
            unless $raw;

          𝒮.emit( [self, $s, $e, $ud] );
        },
        Pointer, 0
      );
      [ create-signals-supply(𝒮.Supply, $obj, $signal), $obj, $hid ];
    };
    %!signals-sb{$signal}[0].tap(&handler) with &handler;
    %!signals-sb{$signal}[0];
  }

  # GtkSourceBuffer *buffer,  GtkTextMark $mark, gpointer
  method connect-source-mark-updated (
     $obj,
     $signal = 'source-mark-updated',
     &handler?,
    :$raw                            = False
  ) {
    my $hid;
    %!signals-sb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-source-mark-updated($obj, $signal,
        -> $, $m is copy, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          $m = GTK::Text::Mark.new($m) unless $raw;

          𝒮.emit( [self, $m, $ud] );
        },
        Pointer, 0
      );
      [ create-signals-supply(𝒮.Supply, $obj, $signal), $obj, $hid ];
    };
    %!signals-sb{$signal}[0].tap(&handler) with &handler;
    %!signals-sb{$signal}[0];
  }

  #  GtkTextIter *iter,  GtkSourceBracketMatchType state --> void
  method connect-bracket-matched (
     $obj,
     $signal = 'bracket-matched',
     &handler?,
    :$raw                         = False
  ) {
    my $hid;
    %!signals-sb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-bracket-matched($obj, $signal,
        -> $, $i is copy, $s, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          unless $raw {
            $i = GTK::Text::Iter.new($i)
            $s = GtkSourceBracketMatchTypeEnum($s);
          }
          𝒮.emit( [self, $i, $s, $ud] );
        },
        Pointer, 0
      );
      [ create-signals-supply(𝒮.Supply, $obj, $signal), $obj, $hid ];
    };
    %!signals-sb{$signal}[0].tap(&handler) with &handler;
    %!signals-sb{$signal}[0];
  }

}

# GtkSourceBuffer *buffer,  GtkTextIter *start,  GtkTextIter *end
sub g-connect-highlight-updated (
  Pointer $app,
  Str     $name,
          &handler (
            Pointer,
            GtkTextIter,
            GtkTextIter,
            gpointer
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }

# GtkSourceBuffer *buffer,  GtkTextIter *iter,  GtkSourceBracketMatchType state
sub g-connect-bracket-matched (
  Pointer $app,
  Str     $name,
          &handler (
            Pointer,
            GtkTextIter,
            GtkSourceBracketMatchType,
            gpointer
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }
