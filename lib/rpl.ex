defmodule Rpl do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Rpl.Worker, [arg1, arg2, arg3])
    ]

  # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
  # for other strategies and supported options
  opts = [strategy: :one_for_one, name: Rpl.Supervisor]
  dispatch = :cowboy_router.compile([
    {:_, [
        {'/', Rpl2, []},
        {'/asd', Rpl2, []}
         ]
    }])
IO.inspect dispatch
{:ok, _} = :cowboy.start_http(:http, 100, [{:port, 8080}], [
  {:env, [{:dispatch, dispatch}]}
])
Supervisor.start_link(children, opts)
  end
end
defmodule Rpl2 do
  def init(req, opts)do
    method = :cowboy_req.method(req)
    echop = :cowboy_req.match_qs([:echo], req)
    req2 = echo(method, echop, req)
    {:ok, req2, opts}
  end
  def echo(<<"GET">>, e, req) do
    IO.inspect e[:echo]
    {rr, []} = Code.eval_string e[:echo],[]
    IO.inspect rr
    :cowboy_req.reply(200, [],:jiffy.encode(rr) , req)
  end
end

