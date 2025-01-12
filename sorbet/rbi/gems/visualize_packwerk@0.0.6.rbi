# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `visualize_packwerk` gem.
# Please instead update this file by running `bin/tapioca gem visualize_packwerk`.

module VisualizePackwerk
  class << self
    sig { params(packages: T::Array[::ParsePackwerk::Package]).void }
    def package_graph!(packages); end

    sig { params(teams: T::Array[::CodeTeams::Team]).void }
    def team_graph!(teams); end
  end
end

module VisualizePackwerk::GraphInterface
  interface!

  sig { abstract.returns(T::Set[::VisualizePackwerk::NodeInterface]) }
  def nodes; end
end

module VisualizePackwerk::NodeInterface
  interface!

  sig { abstract.returns(T::Array[::String]) }
  def dependencies; end

  sig { abstract.params(node_name: ::String).returns(T::Boolean) }
  def depends_on?(node_name); end

  sig { abstract.returns(::String) }
  def group_name; end

  sig { abstract.returns(::String) }
  def name; end

  sig { abstract.returns(T::Hash[::String, ::Integer]) }
  def violations_by_node_name; end
end

class VisualizePackwerk::PackageGraph
  include ::VisualizePackwerk::GraphInterface

  sig { params(package_nodes: T::Set[::VisualizePackwerk::PackageNode]).void }
  def initialize(package_nodes:); end

  sig { override.returns(T::Set[::VisualizePackwerk::NodeInterface]) }
  def nodes; end

  sig { params(name: ::String).returns(::VisualizePackwerk::PackageNode) }
  def package_by_name(name); end

  sig { returns(T::Set[::VisualizePackwerk::PackageNode]) }
  def package_nodes; end

  class << self
    sig { returns(::VisualizePackwerk::PackageGraph) }
    def construct; end
  end
end

class VisualizePackwerk::PackageNode < ::T::Struct
  include ::VisualizePackwerk::NodeInterface

  const :dependencies, T::Set[::String]
  const :name, ::String
  const :team_name, ::String
  const :violations_by_package, T::Hash[::String, ::Integer]

  sig { override.params(node_name: ::String).returns(T::Boolean) }
  def depends_on?(node_name); end

  sig { override.returns(::String) }
  def group_name; end

  sig { override.returns(T::Hash[::String, ::Integer]) }
  def violations_by_node_name; end

  class << self
    def inherited(s); end
  end
end

class VisualizePackwerk::PackageRelationships
  sig { params(packages: T::Array[::ParsePackwerk::Package], show_all_nodes: T::Boolean).void }
  def create_graph!(packages, show_all_nodes: T.unsafe(nil)); end

  sig { params(packages: T::Array[::ParsePackwerk::Package]).void }
  def create_package_graph!(packages); end

  sig { params(teams: T::Array[::CodeTeams::Team]).void }
  def create_package_graph_for_teams!(teams); end

  sig { params(teams: T::Array[::CodeTeams::Team], show_all_teams: T::Boolean).void }
  def create_team_graph!(teams, show_all_teams: T.unsafe(nil)); end

  sig do
    params(
      graph: ::VisualizePackwerk::GraphInterface,
      node_names: T::Array[::String],
      show_all_nodes: T::Boolean
    ).void
  end
  def draw_graph!(graph, node_names, show_all_nodes: T.unsafe(nil)); end
end

VisualizePackwerk::PackageRelationships::OUTPUT_FILENAME = T.let(T.unsafe(nil), String)

class VisualizePackwerk::TeamGraph
  include ::VisualizePackwerk::GraphInterface

  sig { params(team_nodes: T::Set[::VisualizePackwerk::TeamNode]).void }
  def initialize(team_nodes:); end

  sig { override.returns(T::Set[::VisualizePackwerk::NodeInterface]) }
  def nodes; end

  class << self
    sig { params(package_graph: ::VisualizePackwerk::PackageGraph).returns(::VisualizePackwerk::TeamGraph) }
    def from_package_graph(package_graph); end
  end
end

class VisualizePackwerk::TeamNode < ::T::Struct
  include ::VisualizePackwerk::NodeInterface

  const :dependencies, T::Set[::String]
  const :name, ::String
  const :violations_by_team, T::Hash[::String, ::Integer]

  sig { override.params(node_name: ::String).returns(T::Boolean) }
  def depends_on?(node_name); end

  sig { override.returns(::String) }
  def group_name; end

  sig { override.returns(T::Hash[::String, ::Integer]) }
  def violations_by_node_name; end

  class << self
    def inherited(s); end
  end
end
