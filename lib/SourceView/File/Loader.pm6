use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use SourceView::Raw::Types;
use SourceView::Raw::File::Loader;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceFileLoaderAncestry is export of Mu
  where GtkSourceFileLoader | GObject;

class SourceView::File::Loader {
  also does GLib::Roles::Object;

  has GtkSourceFileLoader $!sfl is implementor;

  submethod BUILD ( :$gtk-file-loader ) {
    self.setGtkSourceFileLoader($gtk-file-loader) if $gtk-file-loader
  }

  method setGtkSourceFileLoader (GtkSourceFileLoaderAncestry $_) {
    my $to-parent;

    $!sfl = do {
      when GtkSourceFileLoader {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceFileLoader, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceFileLoader
    is also<GtkSourceFileLoader>
  { $!sfl }

  multi method new (
    $gtk-file-loader where * ~~ GtkSourceFileLoaderAncestry,

    :$ref = True
  ) {
    return unless $gtk-file-loader;

    my $o = self.bless( :$gtk-file-loader );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkSourceBuffer() $buffer, GtkSourceFile() $file) {
    my $gtk-file-loader = gtk_source_file_loader_new($buffer, $file);

    $gtk-file-loader ?? self.bless( :$gtk-file-loader ) !! Nil;
  }

  method new_from_stream (
    GtkSourceBuffer() $buffer,
    GtkSourceFile()   $file,
    GInputStream()    $stream
  )
    is also<new-from-stream>
  {
    my $gtk-file-loader = gtk_source_file_loader_new_from_stream(
      $buffer,
      $file,
      $stream
    );

    $gtk-file-loader ?? self.bless( :$gtk-file-loader ) !! Nil;
  }

  # Type: GtkSourceTypeBuffer
  method buffer ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Buffer.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('buffer', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::Buffer.getTypePair
        );
      },
      STORE => -> $, GtkSourceBuffer() $val is copy {
        $gv.object = $val;
        self.prop_set('buffer', $gv);
      }
    );
  }

  # Type: GtkSourceTypeFile
  method file ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::File.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('file', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::File.getTypePair
        );
      },
      STORE => -> $, GtkSourceFile() $val is copy {
        $gv.object = $val;
        self.prop_set('file', $gv);
      }
    );
  }

  # Type: GtkSourceInputStream
  method input-stream ( :$raw = False )
    is rw
    is g-property
    is also<input_stream>
  {
    my $gv = GLib::Value.new( GIO::InputStream.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('input-stream', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::InputStream.getTypePair
        );
      },
      STORE => -> $, GInputStream() $val is copy {
        $gv.object = $val;
        self.prop_set('input-stream', $gv);
      }
    );
  }

  # Type: GtkSourceFile
  method location ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::File.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('location', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::File.getTypePair
        );
      },
      STORE => -> $, GFile $val is copy {
        $gv.object = $val;
        self.prop_set('location', $gv);
      }
    );
  }

  method error_quark is static is also<error-quark> {
    gtk_source_file_loader_error_quark();
  }

  method get_buffer ( :$raw = False ) is also<get-buffer> {
    propReturnObject(
      gtk_source_file_loader_get_buffer($!sfl),
      $raw,
      |SourceView::Buffer.getTypePair
    );
  }

  method get_compression_type ( :$enum = True )
    is also<get-compression-type>
  {
    my $t = gtk_source_file_loader_get_compression_type($!sfl);
    return $t unless $enum;
    GtkSourceCompressionTypeEnum($t);
  }

  method get_encoding ( :$raw = False ) is also<get-encoding> {
    propReturnObject(
      gtk_source_file_loader_get_encoding($!sfl),
      $raw,
      |SourceView::Encoding.getTypePair
    );
  }

  method get_file ( :$raw = False ) is also<get-file> {
    propReturnObject(
      gtk_source_file_loader_get_file($!sfl),
      $raw,
      |SourceView::File.getTypePair
    );
  }

  method get_input_stream ( :$raw = False ) is also<get-input-stream> {
    propReturnObject(
      gtk_source_file_loader_get_input_stream($!sfl),
      $raw,
      |GIO::InputStream.getTypePair
    );
  }

  method get_location ( :$raw = False ) is also<get-location> {
    propReturnObject(
      gtk_source_file_loader_get_location($!sfl),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_newline_type ( :$enum = True ) is also<get-newline-type> {
    my $t = gtk_source_file_loader_get_newline_type($!sfl);
    return $t unless $enum;
    GtkSourceNewlineTypeEnum($t);
  }

  my %DC := %DEFAULT-CALLBACKS;

  proto method load_async (|)
    is also<load-async>
  { * }

  multi method load_async (
                    &callback,
    gpointer        $user_data                 = gpointer,
    Int()          :$io_priority               = G_PRIORITY_DEFAULT,
    GCancellable() :$cancellable               = GCancellable,
                   :&progress_callback         = Callable,
    gpointer       :$progress_callback_data    = gpointer,
                   :&progress_callback_notify  = %DC<GDestroyNotify>
  ) {
    samewith(
      $io_priority,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      &progress_callback_notify,
      &callback,
      $user_data
    );
  }
  multi method load_async (
    Int()           $io_priority,
    GCancellable()  $cancellable,
                    &progress_callback,
    gpointer        $progress_callback_data,
                    &progress_callback_notify,
                    &callback,
    gpointer        $user_data                  = gpointer
  ) {
    my gint $i = $io_priority;

    gtk_source_file_loader_load_async(
      $!sfl,
      $i,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      &progress_callback_notify,
      &callback,
      $user_data
    );
  }

  method load_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error    = gerror
  )
    is also<load-finish>
  {
    clear_error;
    my $rv = gtk_source_file_loader_load_finish($!sfl, $result, $error);
    set_error($error);
  }

  proto method set_candidate_encodings (|)
    is also<set-candidate-encodings>
  { * }

  multi method set_candidate_encodings (@encodings) {
    samewith( GLib::GSList.new(@encodings, typed => GtkSourceEncoding) )
  }
  multi method set_candidate_encodings (GSList() $candidate_encodings) {
    gtk_source_file_loader_set_candidate_encodings(
      $!sfl,
      $candidate_encodings
    );
  }

}
