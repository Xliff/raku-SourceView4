use v6.c;

use NativeCall;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package SourceView::Raw::Definitions:ver<4>;

constant sourceview is export = 'gtksourceview-5';

class GtkSourceBuffer             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceCompletion         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceCompletionCell     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceCompletionContext  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceCompletionProposal is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceCompletionProvider is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceCompletionWords    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceEncoding           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceFile               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceGutter             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceGutterLines        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceGutterRenderer     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceHover              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceIndenter           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceInformative        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceLanguage           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceLanguageManager    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceMap                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceMark               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceMarkAttributes     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceRegion             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceSearchContext      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceSearchSettings     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceSnippet            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceSnippetBundle      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceSpaceDrawer        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceStyle              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceStyleScheme        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceStyleSchemeManager is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceStyleSchemePreview is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceTag                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceSnippetManager     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceView               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceSnippetContext     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSourceSnippetChunk       is repr<CPointer> does GLib::Roles::Pointers is export { }
