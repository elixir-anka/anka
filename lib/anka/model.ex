defmodule Anka.Model do
  @moduledoc """
  Anka models are used by Anka generators to derive new structures from them.

  A model simply must have `spec/0`, `spec/1` and `spec/2` functions
  to provide information about its definition, specially for Anka generators
  to derive new structures by using these definitions.

  The structure of a model definition may change based on needs of
  generators will be used by developers.

  Developers are able to implement their own `spec` functions while defining
  their models, but unless otherwise required, it is highly recommended to use
  `Anka.Model.__using__/1` macro instead.

  ## Examples

  ```elixir
  defmodule Document do
    use Anka.Model, [
      name: [
        singular: :document,
        plural: :documents,
      ],
      struct: [
        fields: [
          :id,
          content: [
            opts: [
              default: ""
            ]
          ]
        ]
      ]
    ]
  end
  ```
  """
  @moduledoc since: "0.1.1"

  @typedoc since: "0.1.1"
  @type t :: module() | __MODULE__.container()

  @typedoc since: "0.1.1"
  @type container :: keyword() | map() | struct() | any()

  @typedoc since: "0.1.1"
  @type path :: [any(), ...] | any()

  @typedoc since: "0.1.1"
  @type value :: any()

  @doc ~S"""
  Should return definition of the model.
  """
  @doc since: "0.1.1"
  @callback spec() :: __MODULE__.container()

  @doc ~S"""
  Should return the value stored under `path` in the model definition.
  """
  @doc since: "0.1.1"
  @callback spec(path :: __MODULE__.path()) :: __MODULE__.value()

  @doc ~S"""
  Should return the value stored under `path` in the model definition.

  Options that are recommended to support:

    - `default`: If value is `nil`, default value will be
    returned in its place. (Default: `nil`)

  """
  @doc since: "0.1.1"
  @callback spec(path :: any(), opts :: keyword) :: any()

  @doc ~S"""
  Returns definition of `model`.

  ## Examples

      iex> Anka.Model.spec(Model.Document)
      [
        name: [
          singular: :document,
          plural: :documents
        ],
        struct: [
          fields: [
            :id,
            content: [
              opts: [
                default: ""
              ]
            ]
          ]
        ]
      ]

      iex> Anka.Model.spec(Model.Document) == Model.Document.spec()
      true

  """
  @doc since: "0.1.1"
  @spec spec(__MODULE__.t()) :: __MODULE__.container()
  def spec(model)

  def spec(model)
      when is_atom(model) do
    apply(model, :spec, [])
  end

  def spec(model)
      when is_list(model) do
    model
  end

  @doc ~S"""
  Returns the value stored under `path` in the `model` definition.

  Options:

    - `default`: If value is `nil`, default value will be
    returned in its place. (Default: `nil`)

  ## Examples

      iex> Anka.Model.spec(Model.Document, :name, default: [])
      [singular: :document, plural: :documents]

      iex> Anka.Model.spec([singular: :document, plural: :documents], :singular)
      :document

      iex> Anka.Model.spec(Model.Document, [:struct, :fields, Access.at(0)])
      :id

  """
  @doc since: "0.1.1"
  @spec spec(__MODULE__.t(), __MODULE__.path(), keyword) :: any()
  def spec(model, path, opts \\ [])

  def spec(model, path, opts)
      when is_atom(model) do
    apply(model, :spec, [path, opts])
  end

  def spec(model, path, opts)
      when is_list(model) do
    path = List.wrap(path)
    default_value = Keyword.get(opts, :default, nil)

    value =
      model
      |> get_in(path)

    case is_nil(value) do
      true ->
        default_value

      false ->
        value
    end
  end

  @doc ~S"""
  Embeds default `spec/0`, `spec/1` and `spec/2` functions into the caller module
  with given model definition `opts`.
  """
  @doc since: "0.1.1"
  defmacro __using__(opts \\ []) do
    quote do
      @behaviour unquote(__MODULE__)

      @impl unquote(__MODULE__)
      def spec() do
        unquote(opts)
      end

      @impl unquote(__MODULE__)
      def spec(path, opts \\ []) do
        Anka.Model.spec(spec(), path, opts)
      end

      defoverridable spec: 0,
                     spec: 1,
                     spec: 2
    end
  end
end
