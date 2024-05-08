use v6.c;

use NativeCall;

use SourceView::Raw::Types;

use GLib::Object::Supplyish;

role SourceView::Roles::Signals::Source::Completion {
  has %!signals-sc;

  #  GtkSourceProvider, gpointer --> void
  method connect-provider (
     $obj,
     $signal,
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-sc{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-provider($obj, $signal,
        -> $, $p, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          $p = SourceView::Source::Completion::Provider.new($p)
            unless $raw;

          𝒮.emit( [self, $p, $ud] );
        },
        Pointer, 0
      );
      [ create-signal-supply(𝒮.Supply, $obj, $signal), $obj, $hid ];
    };
    %!signals-sc{$signal}[0].tap(&handler) with &handler;
    %!signals-sc{$signal}[0];
  }

}

#  GtkSourceProvider, gpointer --> void
sub g-connect-provider (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GtkSourceCompletionProvider, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }
