use v6.c;

unit package SourceView::Raw::Exports:ver<4>;

our @sv4-exports is export;

BEGIN {
  @sv4-exports = <
    SourceView::Raw::Definitions
    SourceView::Raw::Enums
    SourceView::Raw::Structs
  >;
}
