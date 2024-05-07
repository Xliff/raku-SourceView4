use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<4>;
use SourceView::Raw::Definitions:ver<4>;

unit package SourceView::Raw::Structs:ver<4>;

class GtkSourceRegionIter is repr<CStruct> is export {
	has gpointer $!dummy1;
	has guint32  $.dummy2 is rw;
	has gpointer $!dummy3;
}

class GtkSourceSnippetInfo is repr<CStruct> is export {
	has int  $.identifier  is rw;
	has Str $!group      ;
	has Str $!name       ;
	has Str $!trigger    ;
	has Str $!language   ;
	has Str $!description;
	has Str $!text       ;
}

class GtkSourceCompletionSnippetsProposal is repr<CStruct> is export {
	has GObject                $!parent_instance;
	has GtkSourceSnippetBundle $!bundle         ;
	has GtkSourceSnippetInfo   $!info           ;
}

class GtkSourceStyleInfo is repr<CStruct> is export {
	has Str $!name  ;
	has Str $!map_to;
}

class GtkSourceViewAssistants is repr<CStruct> is export {
	has GtkSourceView $!view ;
	has GQueue        $!queue;
}

class GtkSourceViewSnippets is repr<CStruct> is export {
	has GtkSourceView        $!view                             ;
	has GtkSourceBuffer      $!buffer                           ;
	has gpointer             $!snippet_signals                  ; #= GSignalGroup
	has GtkSourceInformative $!informative                      ;
	has GQueue               $!queue                            ;
	has gulong               $!buffer_insert_text_handler       ;
	has gulong               $!buffer_insert_text_after_handler ;
	has gulong               $!buffer_delete_range_handler      ;
	has gulong               $!buffer_delete_range_after_handler;
	has gulong               $!buffer_cursor_moved_handler      ;
}
