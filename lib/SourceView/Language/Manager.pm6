use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use SourceView::Raw::Types;
use SourceView::Raw::Language::Manager;

use GLib::Object::Types;
use SourceView::Language;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GtkSourceLanguageManagerAncestry is export of Mu
  where GtkSourceLanguageManager | GObject;

class SourceView::Language::Manager {
  also does GLib::Roles::Object;

  has GtkSourceLanguageManager $!slm is implementor;

  submethod BUILD ( :$gtk-lang-man ) {
    self.setGtkSourceLanguageManager($gtk-lang-man) if $gtk-lang-man
  }

  method setGtkSourceLanguageManager (GtkSourceLanguageManagerAncestry $_) {
    my $to-parent;

    $!slm = do {
      when GtkSourceLanguageManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceLanguageManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceLanguageManager
    is also<GtkSourceLanguageManager>
  { $!slm }

  multi method new (
    $gtk-lang-man where * ~~ GtkSourceLanguageManagerAncestry,

    :$ref = True
  ) {
    return unless $gtk-lang-man;

    my $o = self.bless( :$gtk-lang-man );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-lang-man = gtk_source_language_manager_new();

    $gtk-lang-man ?? self.bless( :$gtk-lang-man ) !! Nil;
  }

  method get_default is also<get-default> {
    my $gtk-lang-man = gtk_source_language_manager_get_default();

    $gtk-lang-man ?? self.bless( :$gtk-lang-man ) !! Nil;
  }

  # Type: GtkSourceStrv
  method language-ids ( :$raw = False ) is rw  is g-property is also<language_ids> {
    my $gv = GLib::Value.new(  GLib::StringV.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('language-ids', $gv);
        my $ca = cast(CArray[Str], $gv.boxed);
        return $ca if $raw;
        CStringArrayToArray($ca);
      },
      STORE => -> $,  $val is copy {
        warn 'language-ids does not allow writing'
      }
    );
  }

  # Type: GtkSourceStrv
  method search-path ( :$raw = False )
    is rw
    is g-property
    is also<search_path>
  {
    my $gv = GLib::Value.new( GLib::StringV.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('search-path', $gv);
        my $ca = cast(CArray[Str], $gv.boxed);
        return $ca if $raw;
        CStringArrayToArray($ca);
      },
      STORE => -> $, $val is copy {
        if $val !~~ CArray[Str] {
          $val = do given $val {
            when Array {
              $_ = newCArray(Str, $_);
            }

            when Pointer {
              $_ = cast(CArray[Str], $_);
            }

            default {
              X::GLib::InvalidType.new(
                message => "Value must be compatible to a CArray[Str]!"
              ).throw;
            }
          }
        }
        $gv.pointer = $val;
        self.prop_set('search-path', $gv);
      }
    );
  }
  method append_search_path (Str() $path) is also<append-search-path> {
    gtk_source_language_manager_append_search_path($!slm, $path);
  }

  method get_language (Str() $id, :$raw = False) is also<get-language> {
    propReturnObject(
      gtk_source_language_manager_get_language($!slm, $id),
      $raw,
      |SourceView::Language.getTypePair
    );
  }

  method get_language_ids ( :$raw = False ) is also<get-language-ids> {
    my $ca = gtk_source_language_manager_get_language_ids($!slm);
    return $ca if $raw;
    CStringArrayToArray($ca);
  }

  method get_search_path ( :$raw = False ) is also<get-search-path> {
    my $ca = gtk_source_language_manager_get_search_path($!slm);
    return $ca if $raw;
    CStringArrayToArray($ca);
  }

  method guess_language (Str() $filename, Str() $content_type, :$raw = False)
    is also<guess-language>
  {
    propReturnObject(
      gtk_source_language_manager_guess_language(
        $!slm,
        $filename,
        $content_type
      ),
      $raw,
      |SourceView::Language.getTypePair
    );
  }

  method prepend_search_path (Str() $path) is also<prepend-search-path> {
    gtk_source_language_manager_prepend_search_path($!slm, $path);
  }

  method set_search_path (CArray[Str] $dirs) is also<set-search-path> {
    gtk_source_language_manager_set_search_path($!slm, $dirs);
  }

}
