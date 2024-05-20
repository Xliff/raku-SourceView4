use v6.c;

use SourceView::Raw::Types;
use SourceView::Raw::File;

use GLib::Roles::Object;
use GLib::Roles::Implementor;

class SourceView::File {
  also does GLib::Roles::Object;

  has GtkSourceFile $!sf is implementor;

  multi method new {
    my $gtk-source-file = gtk_source_file_new();

    $gtk-source-file ?? self.bless( :$gtk-source-file ) !! Nil
  }

  # Type: GtkSourceTypeCompressionType
  method compression-type ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Enums::CompressionType.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('compression-type', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkSourceCompressionTypeEnum($t);
      },
      STORE => -> $,  $val is copy {
        warn 'compression-type does not allow writing'
      }
    );
  }

  # Type: GtkSourceTypeEncoding
  method encoding ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Encoding.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('encoding', $gv);
        propReturnObject(
          $gv.boxed,
          $raw,
          |SourceView::Encoding.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'encoding does not allow writing'
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
  method newline-type ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( SourceView::Enums::NewlineType.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('newline-type', $gv);
        my $t = $gv.enum;
        return $t unless $enum;
        GtkSourceNewlineTypeEnum($t)
      },
      STORE => -> $,  $val is copy {
        warn 'newline-type does not allow writing'
      }
    );
  }

  # Type: boolean
  method read-only is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('read-only', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'read-only does not allow writing'
      }
    );
  }

  method check_file_on_disk {
    gtk_source_file_check_file_on_disk($!sf);
  }

  method get_compression_type ( :$enum = True ) {
    my $e = gtk_source_file_get_compression_type($!sf);
    return $e unless $enum;
    GtkSourceCompressionTypeEnum($e);
  }

  method get_encoding ( :$raw = False ) {
    propReturnObject(
      gtk_source_file_get_encoding($!sf),
      $raw,
      |SourceView::Encoding.getTypePair
    );

  }

  method get_location ( :$raw = False ) {
    propReturnObject(
      gtk_source_file_get_location($!sf),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_newline_type ( :$enum = True ) {
    my $t = gtk_source_file_get_newline_type($!sf);
    return $t unless $enum;
    GtkSourceNewlineTypeEnum($t);
  }

  method is_deleted {
    so gtk_source_file_is_deleted($!sf);
  }

  method is_externally_modified {
    so gtk_source_file_is_externally_modified($!sf);
  }

  method is_local {
    so gtk_source_file_is_local($!sf);
  }

  method is_readonly {
    so gtk_source_file_is_readonly($!sf);
  }

  method set_location (GFile() $location) {
    gtk_source_file_set_location($!sf, $location);
  }

  method set_mount_operation_factory (
             &callback,
    gpointer $user_data,
             &notify     = gpointer
  ) {
    gtk_source_file_set_mount_operation_factory(
      $!sf,
      &callback,
      $user_data,
      &notify
    );
  }

}
