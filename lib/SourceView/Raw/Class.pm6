

class GtkSourceFileClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
	has gpointer     $!_reserved   ;
}

class GtkSourceGutterRendererPixbufClass is repr<CStruct> is export {
	has GtkSourceGutterRendererClass $!parent_class;
	has gpointer                     $!_reserved   ;
}

class GtkSourceGutterRendererTextClass is repr<CStruct> is export {
	has GtkSourceGutterRendererClass $!parent_class;
	has gpointer                     $!_reserved   ;
}

class GtkSourceInformativeClass is repr<CStruct> is export {
	has GtkSourceAssistantClass $!parent_class;
}

class GtkSourceMapClass is repr<CStruct> is export {
	has GtkSourceViewClass $!parent_class;
	has gpointer           $!_reserved   ;
}

class GtkSourceMarkClass is repr<CStruct> is export {
	has GtkTextMarkClass $!parent_class;
	has gpointer         $!_reserved   ;
}

class GtkSourcePrintCompositorClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
	has gpointer     $!_reserved   ;
}

class GtkSourceRegionClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
	has gpointer     $!_reserved   ;
}

class GtkSourceSearchSettingsClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
	has gpointer     $!_reserved   ;
}

class GtkSourceStyleSchemeChooserButtonClass is repr<CStruct> is export {
	has GtkButtonClass $!parent   ;
	has gpointer       $!_reserved;
}

class GtkSourceStyleSchemeChooserWidgetClass is repr<CStruct> is export {
	has GtkWidgetClass $!parent   ;
	has gpointer       $!_reserved;
}

class GtkSourceTagClass is repr<CStruct> is export {
	has GtkTextTagClass $!parent_class;
	has gpointer        $!_reserved   ;
}

class GtkSourceCompletionSnippetsClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
	has gpointer     $!_reserved   ;
}

class GtkSourceCompletionWordsClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
	has gpointer     $!_reserved   ;
}

class GtkSourceCompletionWordsLibraryClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
}
