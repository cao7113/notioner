defmodule Notioner.ReqClient do
  @moduledoc """

  Custom Req Client based on Req & Finch & Mint

  todo:
  - split into hex package: req-helper
  - disable proxy when need

  - Req high level API, user friendly, maintained actively, with great STEPs!
    https://github.com/wojtekmach/req
  - Finch performance with connections POOL! built on top of Mint and NimblePool.
    https://github.com/sneako/finch
  - Mint Functional, low-level http client
    https://github.com/elixir-mint/mint

  - Req.new(options \\[]) # options is keyword list
  - req = Req.new(); req.options # is a map
  - Req.run_finch options https://github.com/wojtekmach/req/blob/main/lib/req/finch.ex#L353
    @default_finch_options Req.Finch.pool_options(%{})
    just usded in docs, can customize in Req.new(options[:connect_options])
    Learn by test https://github.com/wojtekmach/req/blob/main/test/req/finch_test.exs#L42
  - More about mint options: https://hexdocs.pm/mint/Mint.HTTP.html#connect/4
  """

  require Logger

  # [:patch]
  # |> Enum.each(fn m ->
  #   m = "#{m}!" |> String.to_atom()

  #   def unquote(m)(url, opts \\ []) do
  #     info = new(opts)
  #     apply(Req, unquote(m), [info, url: url])
  #   end
  # end)

  def patch!(url, opts \\ []) do
    new(opts)
    |> Req.patch!(url: url)
  end

  def get!(url, opts \\ []) do
    new(opts)
    |> Req.get!(url: url)
  end

  def post!(url, opts \\ []) do
    new(opts)
    |> Req.post!(url: url)
  end

  def new(opts \\ []) do
    default_opts()
    |> Keyword.merge(opts)
    |> Req.new()
    |> attach_env_proxy()
    |> Req.Request.append_request_steps(
      debug_url: fn request ->
        [url: URI.to_string(request.url), headers: request.headers]
        |> inspect()
        |> Logger.debug()

        request
      end
    )
  end

  def default_opts() do
    [
      # timeout in milliseconds
      receive_timeout: 15_000,
      pool_timeout: 5_000,
      connect_options: [
        timeout: 30_000
      ]
    ]
  end

  def finch_default_options(opts \\ %{}), do: Req.Finch.pool_options(opts)

  @conn_opts :connect_options

  ## Env Proxy Support

  @doc """
  Attach proxy connect_options from env settings

  [connect_options: [proxy: {:http, "127.0.0.1", 1087, []}]]
  """
  def attach_env_proxy(request \\ Req.new()) do
    conn_opts = request.options[@conn_opts] || []
    proxy = Keyword.get(conn_opts, :proxy)

    conn_opts =
      cond do
        proxy ->
          conn_opts

        true ->
          get_env_proxy()
          |> case do
            nil ->
              conn_opts

            proxy ->
              Logger.debug("use env proxy: #{proxy |> inspect}")
              Keyword.put(conn_opts, :proxy, proxy)
          end
      end

    opts = request.options |> Map.put(@conn_opts, conn_opts)
    %{request | options: opts}
  end

  def get_env_proxy(),
    do: System.get_env("http_proxy", System.get_env("HTTP_PROXY")) |> parse_proxy()

  def parse_proxy(nil), do: nil
  def parse_proxy("http" <> _ = url), do: URI.parse(url) |> parse_proxy()

  def parse_proxy(%URI{host: host, port: port, scheme: scheme}) do
    {scheme |> String.to_atom(), host, port, []}
  end
end
