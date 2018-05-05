defmodule Anka.Application do
    # See https://hexdocs.pm/elixir/Application.html
    # for more information on OTP Applications
    @moduledoc false

    use Application

    def start(_type, _args) do
        # List all child processes to be supervised
        children = [
            # Starts a worker by calling: Anka.Worker.start_link(arg)
            # {Anka.Worker, arg},
        ]

        # See https://hexdocs.pm/elixir/Supervisor.html
        # for other strategies and supported options
        opts = [
            name: Anka.Supervisor,
            strategy: :one_for_one,
        ]
        Supervisor.start_link(children, opts)
    end

end
