use v6.c;

use GLib::Raw::Definitions;

unit package SourceView::Raw::Enums:ver<4>;

constant GtkSourceBackgroundPatternType is export := guint32;
our enum GtkSourceBackgroundPatternTypeEnum is export <
  GTK_SOURCE_BACKGROUND_PATTERN_TYPE_NONE
  GTK_SOURCE_BACKGROUND_PATTERN_TYPE_GRID
>;

constant GtkSourceBracketMatchType is export := guint32;
our enum GtkSourceBracketMatchTypeEnum is export <
  GTK_SOURCE_BRACKET_MATCH_NONE
  GTK_SOURCE_BRACKET_MATCH_OUT_OF_RANGE
  GTK_SOURCE_BRACKET_MATCH_NOT_FOUND
  GTK_SOURCE_BRACKET_MATCH_FOUND
>;

constant GtkSourceChangeCaseType is export := guint32;
our enum GtkSourceChangeCaseTypeEnum is export <
  GTK_SOURCE_CHANGE_CASE_LOWER
  GTK_SOURCE_CHANGE_CASE_UPPER
  GTK_SOURCE_CHANGE_CASE_TOGGLE
  GTK_SOURCE_CHANGE_CASE_TITLE
>;

constant GtkSourceCompletionActivation is export := guint32;
our enum GtkSourceCompletionActivationEnum is export <
  GTK_SOURCE_COMPLETION_ACTIVATION_NONE
  GTK_SOURCE_COMPLETION_ACTIVATION_INTERACTIVE
  GTK_SOURCE_COMPLETION_ACTIVATION_USER_REQUESTED
>;

constant GtkSourceCompletionColumn is export := guint32;
our enum GtkSourceCompletionColumnEnum is export <
  GTK_SOURCE_COMPLETION_COLUMN_ICON
  GTK_SOURCE_COMPLETION_COLUMN_BEFORE
  GTK_SOURCE_COMPLETION_COLUMN_TYPED_TEXT
  GTK_SOURCE_COMPLETION_COLUMN_AFTER
  GTK_SOURCE_COMPLETION_COLUMN_COMMENT
  GTK_SOURCE_COMPLETION_COLUMN_DETAILS
>;

constant GtkSourceCompressionType is export := guint32;
our enum GtkSourceCompressionTypeEnum is export <
  GTK_SOURCE_COMPRESSION_TYPE_NONE
  GTK_SOURCE_COMPRESSION_TYPE_GZIP
>;

constant GtkSourceContextFlags is export := guint32;
our enum GtkSourceContextFlagsEnum is export <
  GTK_SOURCE_CONTEXT_EXTEND_PARENT
  GTK_SOURCE_CONTEXT_END_PARENT
  GTK_SOURCE_CONTEXT_END_AT_LINE_END
  GTK_SOURCE_CONTEXT_FIRST_LINE_ONLY
  GTK_SOURCE_CONTEXT_ONCE_ONLY
  GTK_SOURCE_CONTEXT_STYLE_INSIDE
>;

constant GtkSourceContextRefOptions is export := guint32;
our enum GtkSourceContextRefOptionsEnum is export <
  GTK_SOURCE_CONTEXT_IGNORE_STYLE
  GTK_SOURCE_CONTEXT_OVERRIDE_STYLE
  GTK_SOURCE_CONTEXT_REF_ORIGINAL
>;

constant GtkSourceEncodingDuplicates is export := guint32;
our enum GtkSourceEncodingDuplicatesEnum is export <
  GTK_SOURCE_ENCODING_DUPLICATES_KEEP_FIRST
  GTK_SOURCE_ENCODING_DUPLICATES_KEEP_LAST
>;

constant GtkSourceFileLoaderError is export := guint32;
our enum GtkSourceFileLoaderErrorEnum is export <
  GTK_SOURCE_FILE_LOADER_ERROR_TOO_BIG
  GTK_SOURCE_FILE_LOADER_ERROR_ENCODING_AUTO_DETECTION_FAILED
  GTK_SOURCE_FILE_LOADER_ERROR_CONVERSION_FALLBACK
>;

constant GtkSourceFileSaverError is export := guint32;
our enum GtkSourceFileSaverErrorEnum is export <
  GTK_SOURCE_FILE_SAVER_ERROR_INVALID_CHARS
  GTK_SOURCE_FILE_SAVER_ERROR_EXTERNALLY_MODIFIED
>;

constant GtkSourceFileSaverFlags is export := guint32;
our enum GtkSourceFileSaverFlagsEnum is export <
  GTK_SOURCE_FILE_SAVER_FLAGS_NONE
  GTK_SOURCE_FILE_SAVER_FLAGS_IGNORE_INVALID_CHARS
  GTK_SOURCE_FILE_SAVER_FLAGS_IGNORE_MODIFICATION_TIME
  GTK_SOURCE_FILE_SAVER_FLAGS_CREATE_BACKUP
>;

constant GtkSourceGutterRendererAlignmentMode is export := guint32;
our enum GtkSourceGutterRendererAlignmentModeEnum is export <
  GTK_SOURCE_GUTTER_RENDERER_ALIGNMENT_MODE_CELL
  GTK_SOURCE_GUTTER_RENDERER_ALIGNMENT_MODE_FIRST
  GTK_SOURCE_GUTTER_RENDERER_ALIGNMENT_MODE_LAST
>;

constant GtkSourceNewlineType is export := guint32;
our enum GtkSourceNewlineTypeEnum is export <
  GTK_SOURCE_NEWLINE_TYPE_LF
  GTK_SOURCE_NEWLINE_TYPE_CR
  GTK_SOURCE_NEWLINE_TYPE_CR_LF
>;

constant GtkSourceSmartHomeEndType is export := guint32;
our enum GtkSourceSmartHomeEndTypeEnum is export <
  GTK_SOURCE_SMART_HOME_END_DISABLED
  GTK_SOURCE_SMART_HOME_END_BEFORE
  GTK_SOURCE_SMART_HOME_END_AFTER
  GTK_SOURCE_SMART_HOME_END_ALWAYS
>;

constant GtkSourceSortFlags is export := guint32;
our enum GtkSourceSortFlagsEnum is export <
  GTK_SOURCE_SORT_FLAGS_NONE
  GTK_SOURCE_SORT_FLAGS_CASE_SENSITIVE
  GTK_SOURCE_SORT_FLAGS_REVERSE_ORDER
  GTK_SOURCE_SORT_FLAGS_REMOVE_DUPLICATES
>;

constant GtkSourceSpaceLocationFlags is export := guint32;
our enum GtkSourceSpaceLocationFlagsEnum is export <
  GTK_SOURCE_SPACE_LOCATION_NONE
  GTK_SOURCE_SPACE_LOCATION_LEADING
  GTK_SOURCE_SPACE_LOCATION_INSIDE_TEXT
  GTK_SOURCE_SPACE_LOCATION_TRAILING
  GTK_SOURCE_SPACE_LOCATION_ALL
>;

constant GtkSourceSpaceTypeFlags is export := guint32;
our enum GtkSourceSpaceTypeFlagsEnum is export <
  GTK_SOURCE_SPACE_TYPE_NONE
  GTK_SOURCE_SPACE_TYPE_SPACE
  GTK_SOURCE_SPACE_TYPE_TAB
  GTK_SOURCE_SPACE_TYPE_NEWLINE
  GTK_SOURCE_SPACE_TYPE_NBSP
  GTK_SOURCE_SPACE_TYPE_ALL
>;

constant GtkSourceViewGutterPosition is export := gint32;
our enum GtkSourceViewGutterPositionEnum is export <
  GTK_SOURCE_VIEW_GUTTER_POSITION_LINES
  GTK_SOURCE_VIEW_GUTTER_POSITION_MARKS
>;

constant GtkSourceVimInsertAt is export := guint32;
our enum GtkSourceVimInsertAtEnum is export <
  GTK_SOURCE_VIM_INSERT_HERE
  GTK_SOURCE_VIM_INSERT_AFTER_CHAR
  GTK_SOURCE_VIM_INSERT_AFTER_CHAR_UNLESS_BOF
  GTK_SOURCE_VIM_INSERT_AFTER_CHAR_UNLESS_SOL
>;

constant GtkSourceVimVisualMode is export := guint32;
our enum GtkSourceVimVisualModeEnum is export <
  GTK_SOURCE_VIM_VISUAL_CHAR
  GTK_SOURCE_VIM_VISUAL_LINE
  GTK_SOURCE_VIM_VISUAL_BLOCK
>;
