use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use SourceView::Raw::Types;
use SourceView::Raw::File::Saver;

use SourceView::Buffer;
use SourceView::File;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::GFile;

our subset GtkSourceFileSaverAncestry is export of Mu
  where GtkSourceFileSaver | GObject;

class SourceView::File::Saver {
  also does GLib::Roles::Object;

  has GtkSourceFileSaver $!sfs is implementor;

  submethod BUILD ( :$gtk-file-saver ) {
    self.setGtkSourceFileSaver($gtk-file-saver)
      if $gtk-file-saver
  }

  method setGtkSourceFileSaver (GtkSourceFileSaverAncestry $_) {
    my $to-parent;

    $!sfs = do {
      when GtkSourceFileSaver {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceFileSaver, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceFileSaver
    is also<GtkSourceFileSaver>
  { $!sfs }

  multi method new (
    $gtk-file-saver where * ~~ GtkSourceFileSaverAncestry,

    :$ref = True
  ) {
    return unless $gtk-file-saver;

    my $o = self.bless( :$gtk-file-saver );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkSourceBuffer() $buffer, GtkSourceFile() $file, *%a) {
    my $gtk-file-saver = gtk_source_file_saver_new($buffer, $file);

    my $o = $gtk-file-saver ?? self.bless( :$gtk-file-saver ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

  method new_with_target (
    GtkSourceBuffer() $buffer,
    GtkSourceFile()   $file,
    GFile()           $target_location,
                      *%a
  )
    is also<new-with-target>
  {
    my $gtk-file-saver = gtk_source_file_saver_new_with_target(
      $buffer,
      $file,
      $target_location
    );

    my $o = $gtk-file-saver ?? self.bless( :$gtk-file-saver ) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
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
        )
      },
      STORE => -> $, GtkSourceBuffer() $val is copy {
        $gv.object = $val;
        self.prop_set('buffer', $gv);
      }
    );
  }

  # Type: GtkSourceTypeCompressionType
  method compression-type ( :$enum = True )
    is rw
    is g-property
    is also<compression_type>
  {
    my $gv = GLib::Value.new( SourceView::Enums::Compression.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('compression-type', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkSourceCompressionTypeEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSourceCompressionType) = $val;
        self.prop_set('compression-type', $gv);
      }
    );
  }

  # Type: GtkSourceEncoding
  method encoding ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Encoding.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('encoding', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |SourceView::Encoding.getTypePair
        );
      },
      STORE => -> $, GtkSourceEncoding() $val is copy {
        $gv.object = $val;
        self.prop_set('encoding', $gv);
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
        )
      },
      STORE => -> $, GtkSourceFile() $val is copy {
        $gv.object = $val;
        self.prop_set('file', $gv);
      }
    );
  }

  # Type: GtkSourceFileSaverFlags
  method flags ( :enum(:$flags) = True ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Enum::FileSaverFlags.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('flags', $gv);
        my $f = $gv.flags;
        return $f unless $flags;
        getFlags(GtkSourceFileSaverFlags, $f);
      },
      STORE => -> $, $val is copy {
        $gv.valueFromEnum(GtkSourceFileSaverFlags) = $val;
        self.prop_set('flags', $gv);
      }
    );
  }

  # Type: GFile
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
      STORE => -> $, GFile() $val is copy {
        $gv.object = $val;
        self.prop_set('location', $gv);
      }
    );
  }

  # Type: GtkSourceTypeNewlineType
  method newline-type ( :$enum = True )
    is rw
    is g-property
    is also<newline_type>
  {
    my $gv = GLib::Value.new( SourceView::Enums::NewlineType.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('newline-type', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkSourceNewlineTypeEnum($t);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSourceNewlineType) = $val;
        self.prop_set('newline-type', $gv);
      }
    );
  }

  method eror_quark is static is also<eror-quark> {
    gtk_source_file_saver_error_quark();
  }

  method get_buffer (:$raw = False ) is also<get-buffer> {
    propReturnObject(
      gtk_source_file_saver_get_buffer($!sfs),
      $raw,
      |SourceView::Buffer.getTypePair
    );
  }

  method get_compression_type ( :$enum = False )
    is also<get-compression-type>
  {
    my $t = gtk_source_file_saver_get_compression_type($!sfs);
    return $t unless $enum;
    GtkSourceCompressionTypeEnum($t);
  }

  method get_encoding ( :$raw = False ) is also<get-encoding> {
    propReturnObject(
      gtk_source_file_saver_get_encoding($!sfs),
      $raw,
      |SourceView::Encoding.getTypePair
    )
  }

  method get_file ( :$raw = False ) is also<get-file> {
    propReturnObject(
      gtk_source_file_saver_get_file($!sfs),
      $raw,
      |SourceView::File.getTypePair
    );
  }

  method get_flags ( :enum(:$flags) ) is also<get-flags> {
    my $f = gtk_source_file_saver_get_flags($!sfs);
    return $f unless $flags;
    getFlags(GtkSourceFileSaverFlags, $f);
  }

  method get_location ( :$raw = False ) is also<get-location> {
    propReturnObject(
      gtk_source_file_saver_get_location($!sfs),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_newline_type ( :$enum = True ) is also<get-newline-type> {
    my $t = gtk_source_file_saver_get_newline_type($!sfs);
    return $t unless $enum;
    GtkSourceNewlineTypeEnum($t);
  }

  my %DC := %DEFAULT-CALLBACKS;

  proto method save_async (|)
    is also<save-async>
  { * }

  multi method save_async (
     &callback,
     $user_data                = gpointer,
    :$io_priority              = G_PRIORITY_DEFAULT,
    :$cancellable              = GCancellable,
    :&progress_callback        = Callable,
    :$progress_callback_data   = gpointer,
    :&progress_callback_notify = %DC<GDestroyNotify>
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
  multi method save_async (
    Int()          $io_priority,
    GCancellable() $cancellable,
                   &progress_callback,
    gpointer       $progress_callback_data,
                   &progress_callback_notify,
                   &callback,
    gpointer       $user_data                = gpointer
  ) {
    my gint $i = $io_priority;

    gtk_source_file_saver_save_async(
      $!sfs,
      $i,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      &progress_callback_notify,
      &callback,
      $user_data
    );
  }

  method save_finish (
    GAsyncResult()            $result,
    CArray[Pointer[GError]]   $error   = gerror
  )
    is also<save-finish>
  {
    clear_error;
    my $rv = gtk_source_file_saver_save_finish($!sfs, $result, $error);
    set_error($error);
    $rv;
  }

  method set_compression_type (Int() $compression_type)
    is also<set-compression-type>
  {
    my GtkSourceCompressionType $c = $compression_type;

    gtk_source_file_saver_set_compression_type($!sfs, $c);
  }

  method set_encoding (Int() $encoding) is also<set-encoding> {
    my GtkSourceEncoding  $e = $encoding;

    gtk_source_file_saver_set_encoding($!sfs, $e);
  }

  method set_flags (Int() $flags) is also<set-flags> {
    my GtkSourceFileSaverFlags $f = $flags;

    gtk_source_file_saver_set_flags($!sfs, $f);
  }

  method set_newline_type (Int() $newline_type) is also<set-newline-type> {
    my GtkSourceNewlineType $n = $newline_type;

    gtk_source_file_saver_set_newline_type($!sfs, $n);
  }
}
