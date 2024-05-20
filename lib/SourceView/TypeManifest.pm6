use v6.c;

use GLib::Raw::Traits;

class SourceView::TypeManifest does TypeManifest {

  method manifest {
    %(
      GtkSourceBuffer             => 'SourceView::Buffer',
      GtkSourceCompletion         => 'SourceView::Source::Completion',
      GtkSourceCompletionCell     => 'SourceView::Source::Completion::Cell',
      GtkSourceCompletionWords    => 'SourceView::Source::Completion::Provider::Words',
      GtkSourceFile               => 'SourceView::File',
      GtkSourceGutter             => 'SourceView::Gutter',
      GtkSourceGutterLines        => 'SourceView::Gutter::Lines',
      GtkSourceMap                => 'SourceView::Map',
      GtkSourceMark               => 'SourceView::Mark',
      GtkSourceMarkAttributes     => 'SourceView::Mark::Attributes',
      GtkSourceRegion             => 'SourceView::Region',
      GtkSourceSearchContext      => 'SourceView::Search::Context',
      GtkSourceSearchSettings     => 'SourceView::Search::Settings',
      GtkSourceSnippet            => 'SourceView::Snippet',
      GtkSourceSnippetChunk       => 'SourceView::Snippet::Chunk',
      GtkSourceSnippetContext     => 'SourceView::Snippet::Context',
      GtkSourceSnippetManager     => 'SourceView::Snippet::Manager',
      GtkSourceSpaceDrawer        => 'SourceView::SpaceDrawer',
      GtkSourceStyle              => 'SourceView::Style',
      GtkSourceStyleScheme        => 'SourceView::Style::Scheme',
      GtkSourceStyleSchemeManager => 'SourceView::Style::Scheme::Manager',
      GtkSourceStyleSchemePreview => 'SourceView::Style::Scheme::Preview',
      GtkSourceTag                => 'SourceView::Tag',
      GtkSourceView               => 'SourceView::View'
    );
  }

  method mro {
    %(
      GtkSourceBuffer             => ['SourceView::Buffer', 'GTK::Text::Buffer', 'Any', 'Mu'],
      GtkSourceCompletion         => ['SourceView::Source::Completion', 'Any', 'Mu'],
      GtkSourceCompletionCell     => ['SourceView::Source::Completion::Cell', 'GTK::Widget', 'Any', 'Mu'],
      GtkSourceCompletionWords    => ['SourceView::Source::Completion::Provider::Words', 'Any', 'Mu'],
      GtkSourceFile               => ['SourceView::File', 'Any', 'Mu'],
      GtkSourceGutter             => ['SourceView::Gutter', 'GTK::Widget', 'Any', 'Mu'],
      GtkSourceGutterLines        => ['SourceView::Gutter::Lines', 'Any', 'Mu'],
      GtkSourceMap                => ['SourceView::Map', 'GTK::Widget', 'Any', 'Mu'],
      GtkSourceMark               => ['SourceView::Mark', 'GTK::Text::Mark', 'Any', 'Mu'],
      GtkSourceMarkAttributes     => ['SourceView::Mark::Attributes', 'Any', 'Mu'],
      GtkSourceRegion             => ['SourceView::Region', 'Any', 'Mu'],
      GtkSourceSearchContext      => ['SourceView::Search::Context', 'Any', 'Mu'],
      GtkSourceSearchSettings     => ['SourceView::Search::Settings', 'Any', 'Mu'],
      GtkSourceSnippet            => ['SourceView::Snippet', 'Any', 'Mu'],
      GtkSourceSnippetChunk       => ['SourceView::Snippet::Chunk', 'Any', 'Mu'],
      GtkSourceSnippetContext     => ['SourceView::Snippet::Context', 'Any', 'Mu'],
      GtkSourceSnippetManager     => ['SourceView::Snippet::Manager', 'Any', 'Mu'],
      GtkSourceSpaceDrawer        => ['SourceView::SpaceDrawer', 'Any', 'Mu'],
      GtkSourceStyle              => ['SourceView::Style', 'Any', 'Mu'],
      GtkSourceStyleScheme        => ['SourceView::Style::Scheme', 'Any', 'Mu'],
      GtkSourceStyleSchemeManager => ['SourceView::Style::Scheme::Manager', 'Any', 'Mu'],
      GtkSourceStyleSchemePreview => ['SourceView::Style::Scheme::Preview', 'GTK::Widget', 'Any', 'Mu'],
      GtkSourceTag                => ['SourceView::Tag', 'GTK::Text::Tag', 'Any', 'Mu'],
      GtkSourceView               => ['SourceView::View', 'GTK::Text::View', 'GTK::Widget', 'Any', 'Mu']
    );
  }

  method roles {
    %(
      GtkSourceBuffer             => ['SourceView::Roles::Signals::Buffer', 'GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceCompletion         => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceCompletionCell     => ['GTK::Roles::Constraint::Target', 'GTK::Roles::Buildable', 'GTK::Roles::Accessible', 'GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceCompletionWords    => ['SourceView::Roles::Source::Completion::Provider', 'GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceFile               => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceGutter             => ['GTK::Roles::Constraint::Target', 'GTK::Roles::Buildable', 'GTK::Roles::Accessible', 'GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceGutterLines        => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceMap                => ['GTK::Roles::Constraint::Target', 'GTK::Roles::Buildable', 'GTK::Roles::Accessible', 'GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceMark               => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceMarkAttributes     => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceRegion             => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceSearchContext      => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceSearchSettings     => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceSnippet            => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Positional'],
      GtkSourceSnippetChunk       => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceSnippetContext     => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceSnippetManager     => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceSpaceDrawer        => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceStyle              => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceStyleScheme        => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceStyleSchemeManager => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Positional', 'Iterable'],
      GtkSourceStyleSchemePreview => ['GTK::Roles::Constraint::Target', 'GTK::Roles::Buildable', 'GTK::Roles::Accessible', 'GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceTag                => ['GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic'],
      GtkSourceView               => ['GTK::Roles::Signals::TextView', 'GTK::Roles::Signals::Generic', 'GTK::Roles::Scrollable', 'GTK::Roles::Constraint::Target', 'GTK::Roles::Buildable', 'GTK::Roles::Accessible', 'GLib::Roles::Object', 'GLib::Roles::Protection', 'GLib::Roles::Implementor', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic']
    );
  }

}
