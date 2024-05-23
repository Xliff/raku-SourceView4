use v6.c;

use GLib::Object::Type;

use SourceView::TypeManifest;

unit package SourceView::Builder:ver<4>;

INIT {
  REGISTER-GOBJECT-TYPES( SourceView::TypeManifest.manifest )
}
