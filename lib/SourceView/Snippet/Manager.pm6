use v6.c;

use Method::Also;
use NativeCall;

use SourceView::Raw::Types;
use SourceView::Raw::Snippet::Manager;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::ListModel;

our subset GtkSourceSnippetManagerAncestry is export of Mu
  where GtkSourceSnippetManager | GObject;

class SourceView::Snippet::Manager {
  also does GLib::Roles::Object;

  has GtkSourceSnippetManager $!gssm is implementor;

  submethod BUILD ( :$gtk-snippet-mgr ) {
    self.setGtkSourceSnippetManager($gtk-snippet-mgr) if $gtk-snippet-mgr
  }

  method setGtkSourceSnippetManager (GtkSourceSnippetManagerAncestry $_) {
    my $to-parent;

    $!gssm = do {
      when GtkSourceSnippetManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceSnippetManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceView::Raw::Definitions::GtkSourceSnippetManager
    is also<GtkSourceSnippetManager>
  { $!gssm }

  multi method new (
    $gtk-snippet-mgr where * ~~ GtkSourceSnippetManagerAncestry,

    $ref = True
  ) {
    return unless $gtk-snippet-mgr;

    my $o = self.bless( :$gtk-snippet-mgr );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    self.get_default
  }

  method get_default ( :$raw = False ) is static is also<get-default> {
    propReturnObject(
      gtk_source_snippet_manager_get_default(),
      $raw,
      |self.getTypePair
    );
  }

  method get_search_path ( :$raw = False ) is also<get-search-path> {
    my $ca = gtk_source_snippet_manager_get_search_path($!gssm);
    return $ca if $raw;
    CStringArrayToArray($ca);
  }

  method get_snippet (
    Str()  $group,
    Str()  $language_id,
    Str()  $trigger,
          :$raw          = False
  )
    is also<get-snippet>
  {
    propReturnObject(
      gtk_source_snippet_manager_get_snippet(
        $!gssm,
        $group,
        $language_id,
        $trigger
      ),
      $raw,
      |SourceView::Snippet.getTypePair
    );
  }

  method list_all ( :$raw = False ) is also<list-all> {
    propReturnObject(
      gtk_source_snippet_manager_list_all($!gssm),
      $raw,
      |GIO::ListModel.getTypePair,
      role => GLib::Roles::TypedArray[
        $raw,
        |SourceView::Snippet.getTypedPair
      ]
    );
  }

  method list_groups ( :$raw = False ) is also<list-groups> {
    propReturnObject(
      gtk_source_snippet_manager_list_groups($!gssm),
      $raw,
      |GIO::ListModel.getTypePair.
      role => GLib::Roles::TypedArray[
        $raw,
        |SourceView::Snippet.getTypedPair
      ]
    );
  }

  method list_matching (
    Str() $group,
    Str() $language_id,
    Str() $trigger_prefix
  )
    is also<list-matching>
  {
    gtk_source_snippet_manager_list_matching(
      $!gssm,
      $group,
      $language_id,
      $trigger_prefix
    );
  }

  proto method set_search_path (|)
    is also<set-search-path>
  { * }

  multi method set_search_path (@paths) {
    samewith( newCArray(Str, @paths, :null) );
  }
  multi method set_search_path (CArray[Str] $dirs) {
    gtk_source_snippet_manager_set_search_path($!gssm, $dirs);
  }

}
